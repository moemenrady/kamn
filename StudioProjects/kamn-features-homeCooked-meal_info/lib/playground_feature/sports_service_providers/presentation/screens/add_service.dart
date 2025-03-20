import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/helpers/spacer.dart';
import 'package:kamn/core/theme/app_pallete.dart';
import 'package:kamn/core/utils/custom_app_bar.dart';

import 'package:kamn/playground_feature/sports_service_providers/presentation/widgets/add_service/custome_finished_button.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/widgets/add_service/custome_ground_image_picker.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/widgets/add_service/custome_ownership_image_picker.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/widgets/add_service/custome_service_info.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/widgets/add_service/custome_text_title.dart';

import '../widgets/add_service/custome_add_services_bloc_listner.dart';

class AddServiceScreen extends StatelessWidget {
  final String type;
  const AddServiceScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return CustomeAddServicesBlocListner(
        type: type,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar.appBar(
            context: context,
            color: AppPallete.whiteColor,
            notificationIconFunction: () {},
            profileFunction: () {},
            badgesIconFunction: () {},
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomeTextTitle(),
                  verticalSpace(19.h),
                  const CustomeGroundImagePicker(),
                  verticalSpace(16.h),
                  const CustomeOwnershipImagePicker(),
                  verticalSpace(7.h),
                  const CustomeServiceInfo(),
                  const CustomeFinishedButton(),
                  verticalSpace(25.h),
                ],
              ),
            ),
          ),
        ));
  }
}
//