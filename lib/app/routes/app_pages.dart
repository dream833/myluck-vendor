import 'package:get/get.dart';

import '../modules/BottomNavigationBar/bindings/bottom_navigation_bar_binding.dart';
import '../modules/BottomNavigationBar/views/bottom_navigation_bar_view.dart';
import '../modules/Leaderboard/bindings/leaderboard_binding.dart';
import '../modules/Leaderboard/views/leaderboard_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Signup/bindings/signup_binding.dart';
import '../modules/Signup/views/signup_view.dart';
import '../modules/Transaction/bindings/transaction_binding.dart';
import '../modules/Transaction/views/transaction_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION_BAR,
      page: () => BottomNavigationBarView(),
      binding: BottomnavigationbarBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.LEADERBOARD,
      page: () => const LeaderboardView(),
      binding: LeaderboardBinding(),
    ),
  ];
}
