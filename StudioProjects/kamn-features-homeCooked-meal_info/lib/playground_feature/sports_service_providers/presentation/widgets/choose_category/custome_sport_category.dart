import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kamn/core/helpers/spacer.dart';
import 'package:kamn/core/routing/routes.dart';
import 'package:kamn/core/theme/app_pallete.dart';
import 'package:kamn/core/theme/style.dart';

class CustomeSportCategory extends StatelessWidget {
  final String title;
  final Color color;
  final String? servicesNum;
  const CustomeSportCategory(
      {super.key, required this.title, required this.color, this.servicesNum});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.serviceProviderGroundsScreen,
          arguments: title,
        );
      },
      child: Container(
        height: 100.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: AppPallete.whiteColor,
            borderRadius: BorderRadius.circular(8.h)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(38.h),
                  Text(
                    title,
                    style: TextStyles.fontRoboto16BlackRegular
                        .copyWith(color: color),
                  ),
                  verticalSpace(10.h),
                  if (servicesNum != null)
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/gear.svg'),
                        horizontalSpace(4.w),
                        Text('$servicesNum services open',
                            style: TextStyles
                                .fontCircularSpotify14GrayRegular
                                .copyWith(fontSize: 10)),
                      ],
                    )
                ],
              ),
              SvgPicture.asset(
                'assets/images/${title}_avatar.svg',
                width: 100.w,
                height: 90.h,
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    );
  }
}
