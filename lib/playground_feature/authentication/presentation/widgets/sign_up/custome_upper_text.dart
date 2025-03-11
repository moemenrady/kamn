import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/style.dart';

class CustomeUpperText extends StatelessWidget {
  const CustomeUpperText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     Icon(
          //       Icons.location_on_outlined,
          //       size: 24.h,
          //       color: AppPallete.lightBlackColor2,
          //     ),
          //     SizedBox(
          //       width: 11.w,
          //     ),
          //     Text(
          //       "Alexandria, Hadra ",
          //       style: TextStyles.font12lightBlackColor2Bold,
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis,
          //     )
          //   ],
          // ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Getting Started",
            style: TextStyles.fontRoboto24BoldBlack,
          ),
          Text(
            "Create an account to continue!",
            style: TextStyles.font14BlackColorMedium,
          ),
        ],
      ),
    );
  }
}
