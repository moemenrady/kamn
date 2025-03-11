import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kamn/playground_feature/sports_service_providers/data/repository/service_providers_repository.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/cubit/track_ground_reservations/track_ground_reservations_states.dart';

@injectable
class TrackGroundReservationsCubit extends Cubit<TrackGroundsState> {
  TrackGroundReservationsCubit({required this.repository})
      : super(TrackGroundsState(state: TrackGroundsStatus.initial));
  ServiceProvidersRepository repository;

  Future<void> getPlaygroundsByOwnerId(String ownerId) async {
    emit(TrackGroundsState(state: TrackGroundsStatus.loading));
    final result = await repository.getPlaygroundsByOwnerId(ownerId);
    result.fold((error) {
      emit(TrackGroundsState(
        state: TrackGroundsStatus.failure,
        erorrMessage: error.erorr,
      ));
    }, (success) {
      emit(TrackGroundsState(
        state: TrackGroundsStatus.success,
        playgrounds: success,
      ));
    });
  }
}
