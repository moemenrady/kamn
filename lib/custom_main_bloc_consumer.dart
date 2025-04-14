import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamn/core/common/cubit/app_user/app_user_state.dart';
import 'package:kamn/core/routing/app_router.dart';
import 'package:kamn/healthy_food_features/presentation/screens/my_cart_screen.dart';
import 'package:kamn/healthy_food_features/presentation/screens/order_screen.dart';
import 'package:kamn/playground_feature/authentication/presentation/screens/on_boarding_screen.dart';
import 'package:kamn/playground_feature/sports/presentation/cubits/select_category_cubit/select_category_cubit.dart';
import 'package:kamn/playground_feature/sports/presentation/screens/select_category_screen.dart';

import 'core/common/cubit/app_user/app_user_cubit.dart';
import 'core/common/widget/main_loader.dart';
import 'core/di/di.dart';

class CustomMainBlocConsumer extends StatelessWidget {
  const CustomMainBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final appUserCubit = context.read<AppUserCubit>();

    return BlocConsumer<AppUserCubit, AppUserState>(
        listener: (context, state) async {
      ////////////////////
      // if (state.isInstalled()) {
      //   appUserCubit.isUserLoggedIn();
      // } else if (state.isLoggedIn()) {
      //   await appUserCubit.getUser(uid: state.user!.uid);
      // } else if (state.isGettedData()) {
      //   appUserCubit.saveUserData(state.user!);
      // } else if (state.isFailureSaveData()) {
      //   showSnackBar(context, state.errorMessage ?? "UnExpected error");
      //   appUserCubit.signOut();
      // } else if (state.isFailure()) {
      //   showSnackBar(context, state.errorMessage ?? "UnExpected error");
      // } else if (state.isSignOut()) {
      //   appUserCubit.clearUserData();
      // } else if (state.isClearUserData()) {
      //   appUserCubit.isUserLoggedIn();
      // }
    }, builder: (context, state) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: AppRouter.generateRoute,
          home: const MyCartScreen());
    });
    //home: _buildHomeWidget(state, appUserCubit));
  }
}

Widget _buildHomeWidget(AppUserState state, AppUserCubit appUserCubit) {
  if (state.isInitial()) {
    return const MainLoader();
  }
  if (state.isNotInstalled()) {
    return const OnBoardingScreen();
  }
  if (state.isLoggedIn() || state.isGettedData() || state.isSuccess()) {
    return BlocProvider(
      create: (context) => getIt<SelectCategoryCubit>()..getPlaygrounds(),
      child: const SelectCategoryScreen(),
    );
    // return BlocProvider(
    //   create:(context)=> getIt<SelectCategoryCubit>()..getPlaygrounds(),
    //   child: const SelectCategoryScreen(),
    // );
  }
  if (state.isNotLoggedIn() || state.isClearUserData()) {
    return const OrderScreen();
    // return BlocProvider(
    //   create: (context) => getIt<SignInCubit>(),
    //   child: const SignInScreen(),
    // );
  }
  return const MainLoader();
}
