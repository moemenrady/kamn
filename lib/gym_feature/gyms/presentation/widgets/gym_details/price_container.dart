import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/theme/app_pallete.dart';
import 'package:kamn/core/theme/style.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppPallete.shadeOfGray),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
          child: Row(
            spacing: 5,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "10000 £GP/",
                        style:
                            TextStyles.fontCircularSpotify14AccentBlackMedium),
                    TextSpan(
                        text: "month",
                        style:
                            TextStyles.fontCircularSpotify14LightBlackRegular)
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  color: AppPallete.darkVividVioletColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text("60% OFF",
                      style: TextStyles.fontCircularSpotify7GreyMedium.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
