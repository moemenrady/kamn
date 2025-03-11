import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kamn/core/helpers/spacer.dart';
import 'package:kamn/playground_feature/sports/presentation/cubits/sports_grounds/sports_ground_cubit.dart';
import 'package:kamn/playground_feature/sports/presentation/widgets/grounds_screen/custom_distance_filter.dart';
import 'package:kamn/playground_feature/sports/presentation/widgets/grounds_screen/custom_filter_text_form_field.dart';

class CustomDataFilterSection extends StatelessWidget {
  const CustomDataFilterSection({super.key});
  @override
  Widget build(BuildContext context) {
    final sportsGroundViewModel =
        context.read<SportsGroundsCubit>().sportsGroundViewModel;
    return Column(
      children: [
        CustomFilterTextFormField(
          controller: sportsGroundViewModel.loactionController!,
          sufficIcon: Icons.location_on_outlined,
          hintText: 'Alexandria, Hadra',
          txt: 'Locations',
          textInputType: TextInputType.text,
        ),
        verticalSpace(25.h),
        Row(
          children: [
            Expanded(
              child: CustomFilterTextFormField(
                controller: sportsGroundViewModel.minPriceController!,
                sufficIcon: null,
                textInputType: TextInputType.number,
                hintText: 'min',
                txt: 'Price Range',
              ),
            ),
            horizontalSpace(7.w),
            Expanded(
              child: CustomFilterTextFormField(
                controller: sportsGroundViewModel.maxPriceController!,
                textInputType: TextInputType.number,
                sufficIcon: null,
                hintText: 'max',
                txt: '',
              ),
            ),
          ],
        ),
        verticalSpace(25.h),
        const CustomDistanceFilter(),
      ],
    );
  }
}
