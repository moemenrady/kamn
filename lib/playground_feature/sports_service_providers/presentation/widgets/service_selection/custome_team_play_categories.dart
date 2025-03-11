import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/const/constants.dart';
import 'package:kamn/core/helpers/spacer.dart';
import 'package:kamn/core/theme/app_pallete.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/widgets/service_selection/custome_sport_category.dart';

class CustomeTeamPlayCategories extends StatelessWidget {
  const CustomeTeamPlayCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: AppPallete.lightGrayColor,
          borderRadius: BorderRadius.circular(20.h)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: Constants.teamSportList.length,
        separatorBuilder: (context, index) => verticalSpace(10.h),
        itemBuilder: (context, index) {
          final category = Constants.teamSportList[index];
          return CustomeSportCategory(
            color: category.color,
            title: category.title,
          );
        },
      ),
    );
  }
}
