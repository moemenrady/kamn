import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/helpers/spacer.dart';
import 'package:kamn/core/theme/app_pallete.dart';
import 'package:kamn/gym_feature/gyms/presentation/widgets/gym/custom_gym_appbar.dart';
import 'package:kamn/gym_feature/gyms/presentation/widgets/gym/custom_gym_fit_list.dart';
import 'package:kamn/gym_feature/gyms/presentation/widgets/gym/custom_gym_head_title.dart';
import 'package:kamn/gym_feature/gyms/presentation/widgets/gym/custom_gym_rated_list.dart';

class GymsScreen extends StatelessWidget {
  const GymsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.lightWiteColor,
      appBar: const CustomGymAppbar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              CustomGymHeadTitle(
                title: 'Find Your Fit',
                onTap: () {},
              ),
              verticalSpace(10.h),
              const CustomGymFitList(),
              verticalSpace(32.h),
              CustomGymHeadTitle(
                title: 'Top Rated',
                onTap: () {},
              ),
              const CustomGymRatedList(),
            ],
          ),
        ),
      ),
    );
  }
}
