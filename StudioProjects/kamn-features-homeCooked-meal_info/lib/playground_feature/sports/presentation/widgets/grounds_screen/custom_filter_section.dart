import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/helpers/spacer.dart';
import 'package:kamn/core/theme/app_pallete.dart';
import 'package:kamn/core/theme/style.dart';
import 'package:kamn/core/utils/app_images.dart';
import 'package:kamn/playground_feature/sports/presentation/cubits/sports_grounds/sports_ground_cubit.dart';
import 'package:kamn/playground_feature/sports/presentation/widgets/grounds_screen/custom_bottom.dart';
import 'package:kamn/playground_feature/sports/presentation/widgets/grounds_screen/custom_filter_bottom_sheet.dart';
import 'package:kamn/playground_feature/sports/presentation/widgets/grounds_screen/custom_text_form_field.dart';

class CustomFilterSection extends StatelessWidget {
  CustomFilterSection({super.key, required this.title});
  final Debouncer debouncer = Debouncer();
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextFormField(
          onChange: (value) {
            debouncer.debounce(
                duration: const Duration(milliseconds: 800),
                onDebounce: () {
                  context.read<SportsGroundsCubit>().searchByQuery(value,title);
                });
          },
          controller: context
              .read<SportsGroundsCubit>()
              .sportsGroundViewModel
              .searchController!,
        )),
        horizontalSpace(5),
        CustomBottom(
          iconVisible: true,
          iconWidget: Image.asset(
            AppImages.filterImage,
            width: 15.w,
            height: 15.h,
          ),
          onPressed: () {
            filterBottomSheet(context);
          },
          textBottom: 'Filter',
          textStyle: TextStyles.fontCircularSpotify12WhiteRegular,
        ),
      ],
    );
  }

  PersistentBottomSheetController filterBottomSheet(BuildContext context) {
    return showBottomSheet(
        elevation: 100,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        backgroundColor: AppPallete.ofWhiteColor,
        context: context,
        builder: (context) {
          return const CustomFilterBottomSheet();
        });
  }
}
