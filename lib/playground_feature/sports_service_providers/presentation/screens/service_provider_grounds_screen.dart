
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/routing/routes.dart';
import 'package:kamn/core/utils/custom_app_bar.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/cubit/service_provider_grounds/service_provider_grounds_cubit.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/cubit/service_provider_grounds/service_provider_grounds_state.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/widgets/service_provider_grounds/custome_grounds_bloc_listner.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/theme/style.dart';
import '../../../../core/utils/app_images.dart';
import '../widgets/service_provider_grounds/custom_bottom_service_provider.dart';
import '../widgets/service_provider_grounds/custom_ground_item_service_provider.dart';
import '../widgets/service_provider_grounds/custom_text_form_field_service_provider.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

class ServiceProviderGroundsScreen extends StatelessWidget {
  final String type;
  ServiceProviderGroundsScreen({super.key, required this.type});
  final Debouncer debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ServiceProviderGroundsCubit>();
    TextEditingController controller = TextEditingController();
    return CustomeGroundsBlocListner(
      child: Scaffold(
        backgroundColor: AppPallete.whiteColor,
        appBar: CustomAppBar.appBar(
            context: context,
            color: AppPallete.whiteColor,
            notificationIconFunction: () {},
            profileFunction: () {},
            badgesIconFunction: () {},
          ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyles.font32BlackColormedium,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomTextFormField(
                    onChange: (value) {
                      debouncer.debounce(
                          duration: const Duration(milliseconds: 800),
                          onDebounce: () {
                            cubit.searchByQuery(value, type);
                          });
                    },
                    controller: controller,
                  )),
                  horizontalSpace(5),
                  CustomBottomServiceProvider(
                    iconVisible: true,
                    iconWidget: Image.asset(
                      AppImages.filterImage,
                      width: 15.w,
                      height: 15.h,
                    ),
                    onPressed: () {},
                    textBottom: 'Filter',
                    textStyle: TextStyles.font12WhiteColorW400,
                  ),
                ],
              ),
              // verticalSpace(10),
              // SizedBox(
              //   height: 30.h,
              //   child: ListView.separated(
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return CustomFilterItemServiceProvider(
              //             icon: Icons.location_on_outlined,
              //             text: "Alexandria, Hadra",
              //             onPressed: () {});
              //       },
              //       separatorBuilder: (context, index) {
              //         return horizontalSpace(5);
              //       },
              //       itemCount: 5),
              // ),
              verticalSpace(20),
              Expanded(
                child: Container(
                  width: 335.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: AppPallete.lightGrayColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: BlocBuilder<ServiceProviderGroundsCubit,
                      ServiceProviderGroundsState>(
                    buildWhen: (previous, current) => current.isSuccess,
                    builder: (context, state) {
                      if (state.isInitial || state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final playgrounds = state.playgrounds![type] ?? [];

                      if (playgrounds.isEmpty) {
                        return const Center(
                            child: Text('no such data for this category'));
                      }
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }

                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context,
                                    Routes.serviceProviderGroundDetailsScreen,
                                    arguments: playgrounds[index]);
                              },
                              child: CustomGroundItemServiceProvider(
                                playgroundRequest: playgrounds[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return verticalSpace(17.89);
                          },
                          itemCount: playgrounds.length);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
