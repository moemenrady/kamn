import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/const/constants.dart';
import 'package:kamn/core/helpers/spacer.dart';
import 'package:kamn/core/theme/app_pallete.dart';
import 'package:kamn/core/theme/style.dart';
import 'package:kamn/core/utils/show_snack_bar.dart';

import 'package:kamn/playground_feature/sports_service_providers/presentation/cubit/add_service_provider/add_service_provider_cubit.dart';
import 'package:kamn/playground_feature/sports_service_providers/presentation/cubit/add_service_provider/add_service_provider_state.dart';

class CustomeFinishedButton extends StatelessWidget {
  const CustomeFinishedButton({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AddServiceProviderCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 76.w),
      child: BlocBuilder<AddServiceProviderCubit, AddServiceProviderState>(
        builder: (context, state) {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: state.isLoading
                      ? const EdgeInsets.symmetric(vertical: 10)
                      : null,
                  disabledBackgroundColor: AppPallete.blackColor,
                  backgroundColor: AppPallete.blackColor),
              onPressed: state.isLoading
                  ? null
                  : () {
                      if (cubit.formKey.currentState?.validate() == true) {
                        if (cubit.ownershipSelectedImageList.isNotEmpty) {
                          cubit.addImagesToStorage();
                        } else {
                          showSnackBar(context,
                              "Erorr ownership paper is empty please , sure you add at least one ");
                        }
                      }
                    },
              child: state.isLoading
                  ? const CircularProgressIndicator(
                      color: AppPallete.whiteColor,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline,
                            color: AppPallete.lightGreen),
                        horizontalSpace(7.w),
                        Text(
                          Constants.finish,
                          style: TextStyles.fontInter16WhiteMedium,
                        )
                      ],
                    ));
        },
      ),
    );
  }
}
