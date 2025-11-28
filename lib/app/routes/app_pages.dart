import 'package:get/get.dart';

import '../modules/BottomNavigationBar/bindings/bottom_navigation_bar_binding.dart';
import '../modules/BottomNavigationBar/views/bottom_navigation_bar_view.dart';
import '../modules/Contactus/bindings/contactus_binding.dart';
import '../modules/Contactus/views/contactus_view.dart';
import '../modules/Leaderboard/bindings/leaderboard_binding.dart';
import '../modules/Leaderboard/views/leaderboard_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/OwnPurchaseHistory/bindings/own_purchase_history_binding.dart';
import '../modules/OwnPurchaseHistory/views/own_purchase_history_view.dart';
import '../modules/Privacypolicy/bindings/privacypolicy_binding.dart';
import '../modules/Privacypolicy/views/privacypolicy_view.dart';
import '../modules/Qrscannerpage/bindings/qrscannerpage_binding.dart';
import '../modules/Qrscannerpage/views/qrscannerpage_view.dart';
import '../modules/Signup/bindings/signup_binding.dart';
import '../modules/Signup/views/signup_view.dart';
import '../modules/Transaction/bindings/transaction_binding.dart';
import '../modules/Transaction/views/transaction_view.dart';
import '../modules/assign_point/bindings/assign_point_binding.dart';
import '../modules/assign_point/views/assign_point_view.dart';
import '../modules/commissionwallet/bindings/commissionwallet_binding.dart';
import '../modules/commissionwallet/views/commissionwallet_view.dart';
import '../modules/duedetails/bindings/duedetails_binding.dart';
import '../modules/duedetails/views/duedetails_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inviteus/bindings/inviteus_binding.dart';
import '../modules/inviteus/views/inviteus_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/termscondition/bindings/termscondition_binding.dart';
import '../modules/termscondition/views/termscondition_view.dart';
import '../modules/walletbalance/bindings/walletbalance_binding.dart';
import '../modules/walletbalance/views/walletbalance_view.dart';
import '../modules/walletpackageview/bindings/walletpackageview_binding.dart';
import '../modules/walletpackageview/views/walletpackageview_view.dart';

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
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ASSIGN_POINT,
      page: () => const AssignPointView(),
      binding: AssignPointBinding(),
    ),
    GetPage(
      name: _Paths.QRSCANNERPAGE,
      page: () => const QrscannerpageView(),
      binding: QrscannerpageBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.WALLETBALANCE,
      page: () => const WalletbalanceView(),
      binding: WalletbalanceBinding(),
    ),
    GetPage(
      name: _Paths.WALLETPACKAGEVIEW,
      page: () => const WalletpackageviewView(),
      binding: WalletpackageviewBinding(),
    ),
    GetPage(
      name: _Paths.DUEDETAILS,
      page: () => const DuedetailsView(),
      binding: DuedetailsBinding(),
    ),
    GetPage(
      name: _Paths.OWN_PURCHASE_HISTORY,
      page: () => const OwnPurchaseHistoryView(),
      binding: OwnPurchaseHistoryBinding(),
    ),
    GetPage(
      name: _Paths.COMMISSIONWALLET,
      page: () => const CommissionwalletView(),
      binding: CommissionwalletBinding(),
    ),
    GetPage(
      name: _Paths.TERMSCONDITION,
      page: () => const TermsconditionView(),
      binding: TermsconditionBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACYPOLICY,
      page: () => const PrivacypolicyView(),
      binding: PrivacypolicyBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTUS,
      page: () => const ContactusView(),
      binding: ContactusBinding(),
    ),
    GetPage(
      name: _Paths.INVITEUS,
      page: () => const InviteusView(),
      binding: InviteusBinding(),
    ),
  ];
}
