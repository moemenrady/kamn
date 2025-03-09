import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/helpers/spacer.dart';
import 'package:kamn/core/theme/app_pallete.dart';
import 'package:kamn/core/theme/style.dart';
import 'package:kamn/healthy_food_features/data/models/food_item_model.dart';

class CustomPopularFoodGridCard extends StatelessWidget {
  const CustomPopularFoodGridCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 10.w,
                        mainAxisExtent: 210.h,
                      ),
                      itemCount: trendingFoods.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            
                            // Shadow Container
                            Positioned(
                              bottom: -10.h,
                              //top: 130.h,
                              left: -5,
                              right: -5,
                              child: Container(
                                width: 190.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(40.r),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.1), // Soft shadow
                                      blurRadius: 14.sp, // Spread softly
                                      spreadRadius: 3, // Slightly expands shadow
                                      offset: Offset(0, 0), // Moves shadow downward
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  
                            // Main Container
                            Container(
                              width: 160.w,
                              height: 202.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0x00FFFFFF),
                                    Color(0xFFFFFFFF),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(14.r),
                                  bottomRight: Radius.circular(14.r),
                                ),
                                border: const Border(
                                  bottom: BorderSide(
                                    color: Color(0xffECF0F4),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  verticalSpace(92.h),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        verticalSpace(3.h),
                                        Text(
                                          "🔥${trendingFoods[index].calories} KCal",
                                          style: TextStyles
                                              .fontCircularSpotify8StealGrayRegular,
                                        ),
                                        verticalSpace(2.h),
                                        Text(
                                          trendingFoods[index].name,
                                          style: TextStyles
                                              .fontCircularSpotify14BlackBold,
                                        ),
                                        verticalSpace(2.h),
                                        Text(
                                          trendingFoods[index].tags.toString(),
                                          style: TextStyles
                                              .fontCircularSpotify8StealGrayLight,
                                        ),
                                        verticalSpace(2.h),
                                        Row(
                                          children: [
                                            Text(
                                              trendingFoods[index].price.toString(),
                                              style: TextStyles
                                                  .fontCircularSpotify14BlackBold,
                                            ),
                                            horizontalSpace(1.w),
                                            Text(
                                              "£GP",
                                              style: TextStyles
                                                  .fontCircularSpotify14GreenRegular,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 7.h,
                                right: 7.w,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/images/plus_btn.png",
                                    width: 32.w,
                                    height: 32.h,
                                    color: AppPallete.blackColor,
                                  ),
                                )),
                            Positioned(
                              top: -15.h,
                              child: Container(
                                width: 147.w,
                                height: 147.h,
                                child: Image.asset(
                                  trendingFoods[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
  }
}