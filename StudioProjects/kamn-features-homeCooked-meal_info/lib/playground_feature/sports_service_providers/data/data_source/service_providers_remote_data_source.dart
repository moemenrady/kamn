//init add_service_provider_to_firebase branch
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:kamn/core/common/class/firebase_storage_services.dart';
import 'package:kamn/core/common/class/firestore_services.dart';
import 'package:kamn/core/const/firebase_collections.dart';
import 'package:kamn/core/utils/try_and_catch.dart';

import 'package:kamn/playground_feature/sports_service_providers/data/model/playground_request_model.dart';
import 'package:path/path.dart';

abstract class ServiceProvidersRemoteDataSource {
  Future<PlaygroundRequestModel> addServiceToFirestore(
      PlaygroundRequestModel playground);
  Future<List<String>> addImagesToStorage(List<File> images);
  Future<bool> deleteImagesFromStorage(List<String> images);
  Future<List<Map<String, dynamic>>> getPlaygroundsByOwnerId(String ownerId);
  Future<List<Map<String, dynamic>>> getPlaygroundsReservationDetailsById(
      String playgroundId);
  Future<List<Map<String, dynamic>>> getPlaygroundsRequests();
  Future<void> addWithTransactionToFirebase(
      PlaygroundRequestModel playgroundModel);
  Future<void> updateState(PlaygroundRequestModel playground, Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> searchByQuery(String query, String type);
  Future<List<Map<String, dynamic>>?> getCurrentOrdersByCategory(
      String category,String userId);
  Future<List<Map<String, dynamic>>?> getFinishedOrdersByCategory(
      String category,String userId);
}

@Injectable(as: ServiceProvidersRemoteDataSource)
class ServiceProvidersRemoteDataSourceImpl
    implements ServiceProvidersRemoteDataSource {
  FirestoreService firestoreServices;
  FirebaseStorageServices storageServies;
  ServiceProvidersRemoteDataSourceImpl(
      {required this.firestoreServices, required this.storageServies});

  @override
  Future<PlaygroundRequestModel> addServiceToFirestore(
      PlaygroundRequestModel playground) async {
    return executeTryAndCatchForDataLayer(() async {
      var collRef = firestoreServices.firestore
          .collection(FirebaseCollections.playgroundsRequests);
      var docRef = collRef.doc();
      playground.playgroundId = docRef.id;
      await docRef.set(playground.toMap());
      return playground;
    });
  }

  @override
  Future<List<String>> addImagesToStorage(List<File> images) async {
    List<String> imagesUrl = [];

    return executeTryAndCatchForDataLayer(() async {
      for (var image in images) {
        Reference firebaseStorageRef =
            storageServies.storage.ref().child(basename(image.path));

        UploadTask uploadTask = firebaseStorageRef.putFile(image);

        TaskSnapshot taskSnapshot =
            await uploadTask.timeout(const Duration(seconds: 100));

        String downloadUrl = await taskSnapshot.ref
            .getDownloadURL()
            .timeout(const Duration(seconds: 30));
        imagesUrl.add(downloadUrl);
      }
      return imagesUrl;
    });
  }

  @override
  Future<bool> deleteImagesFromStorage(List<String> images) async {
    return executeTryAndCatchForDataLayer(() async {
      for (var image in images) {
        Reference firebaseStorageRef = storageServies.storage.refFromURL(image);

        await firebaseStorageRef.delete();
      }
      return true;
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getPlaygroundsRequests() {
    return executeTryAndCatchForDataLayer(() async {
      var querySnapshot = await firestoreServices
          .getData(FirebaseCollections.playgroundsRequests);
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getPlaygroundsByOwnerId(String ownerId) {
    return executeTryAndCatchForDataLayer(() async {
      var querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollections.playgrounds)
          .where('owner.uid', isEqualTo: ownerId)
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Future<void> addWithTransactionToFirebase(
      PlaygroundRequestModel playgroundModel) {
    return executeTryAndCatchForDataLayer(() async {
      await firestoreServices.firestore.runTransaction((transaction) async {
        var deletedDocRef = firestoreServices.firestore
            .collection(FirebaseCollections.playgroundsRequests)
            .doc(playgroundModel.playgroundId);
        var addedDocRef = firestoreServices.firestore
            .collection(FirebaseCollections.playgrounds)
            .doc();
        var userDocRef = firestoreServices.firestore
            .collection(FirebaseCollections.users)
            .doc(playgroundModel.owner?.uid);
        playgroundModel.playgroundId = addedDocRef.id;
        playgroundModel.accpetingState = 'accepted';
        transaction.delete(deletedDocRef);
        transaction.set(addedDocRef, playgroundModel.toMap());
        transaction.update(userDocRef, {
          'type': 'serviceProvider',
        });
      });
    });
  }

  @override
  Future<void> updateState(PlaygroundRequestModel playground, Map<String, dynamic> data) {
    return executeTryAndCatchForDataLayer(() async {
      return await firestoreServices.updateData(
        playground.accpetingState == 'pending' ?  FirebaseCollections.playgroundsRequests:FirebaseCollections.playgrounds, playground.playgroundId!, data);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getPlaygroundsReservationDetailsById(
      String playgroundId) {
    return executeTryAndCatchForDataLayer(() async {
      var querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollections.reservations)
          .where('ground.playgroundId', isEqualTo: playgroundId)
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Future<List<Map<String, dynamic>>> searchByQuery(String query, String type) {
    return executeTryAndCatchForDataLayer(() async {
      List<String> seenIds = [];
      final nameQuery = firestoreServices.firestore
          .collection(FirebaseCollections.playgroundsRequests)
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '$query\uf8ff')
          .get();
      final addressQuery = firestoreServices.firestore
          .collection(FirebaseCollections.playgroundsRequests)
          .where('address', isGreaterThanOrEqualTo: query)
          .where('address', isLessThan: '$query\uf8ff')
          .get();
      final results = await Future.wait([nameQuery, addressQuery]);
      return results.expand((querySnapshot) {
        return querySnapshot.docs
            .where((doc) {
              if (!seenIds.contains(doc.id)) {
                seenIds.add(doc.id);
                return true;
              }
              return false;
            })
            .map((doc) => doc.data())
            .toList();
      }).toList();
    });
  }

  @override
  Future<List<Map<String, dynamic>>?> getCurrentOrdersByCategory(
      String category,String userId) async {
    return executeTryAndCatchForDataLayer(() async {
      final snapshot = await firestoreServices.firestore
          .collection(FirebaseCollections.reservations)
          .where('status', isEqualTo: 'pending') .where('user.uid',isEqualTo: userId)
          .where('ground.type', isEqualTo: category) 
          .get();

      return snapshot.docs.map((element) {
        return element.data();
      }).toList();
    });
  }

  @override
  Future<List<Map<String, dynamic>>?> getFinishedOrdersByCategory(
      String category,String userId) {
    return executeTryAndCatchForDataLayer(() async {
      final snapshot = await firestoreServices.firestore
          .collection('reservation')
          .where('status', isEqualTo: 'pending')  .where('user.uid',isEqualTo: userId)// Filter for finished orders
          .where('ground.type', isEqualTo: category) // Filter by category
          .get();

      // Return results wrapped in Either
      return snapshot.docs.map((element) {
        return element.data();
      }).toList();
    });
  }
}
