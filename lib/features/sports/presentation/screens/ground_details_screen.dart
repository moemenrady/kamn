// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/features/sports/presentation/widgets/custome_bottom_book.dart';
import 'package:kamn/features/sports/presentation/widgets/custome_image_slide_show.dart';
import 'package:kamn/features/sports/presentation/widgets/custome_play_ground_info.dart';

class GroundDetailsScreen extends StatelessWidget {
  const GroundDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 346.h, // Image height
                child: CustomeImageSlideShow()),
            Positioned(
              bottom: 0, // Start from the bottom
              left: 0,
              right: 0,
              height: 440.h,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: const CustomePlayGroundInfo(),
              ),
            )
          ],
        ),
        bottomNavigationBar: const CustomeBottomBook());
  }
}
