import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/modules/edit_profile/controllers/edit_profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.edit, 'title': 'Profile', 'route': '/edit-profile'},
      {
        'icon': Icons.shopping_bag,
        'title': 'Customer Transaction History',
        'route': '/transaction',
      },
      {
        'icon': Icons.history,
        'title': 'Own Purchase History',
        'route': '/own-purchase-history',
      },
      {
        'icon': Icons.account_balance_wallet,
        'title': 'Commission Wallet',
        'route': '/commissionwallet',
      },
      {
        'icon': Icons.security,
        'title': 'Terms & Conditions',
        'route': '/termscondition',
      },
      {
        'icon': Icons.privacy_tip_outlined,
        'title': 'Privacy Policy',
        'route': '/privacypolicy',
      },
      {
        'icon': Icons.person_add,
        'title': 'Invite a Friend',
        'route': '/inviteus',
      },
      {
        'icon': Icons.support_agent_outlined,
        'title': 'Contact Us',
        'route': '/contactus',
      },
      {'icon': Icons.logout_outlined, 'title': 'Logout', 'route': 'logout'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final shopName = controller.shopName.value.isNotEmpty
            ? controller.shopName.value
            : 'Shop Name';
        final shopEmail = controller.email.value.isNotEmpty
            ? controller.email.value
            : 'email@example.com';
        final shopImage = controller.selfPhoto.value.isNotEmpty
            ? controller.selfPhoto.value
            : '';

        return Column(
          children: [
            _buildHeader(shopName, shopEmail, shopImage),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    elevation: 1,
                    margin: EdgeInsets.only(bottom: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    color: Colors.teal.shade50,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(item['icon'], color: Colors.teal),
                      ),
                      title: Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: Colors.teal,
                      ),
                      onTap: () => _handleMenuTap(item['route']),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  // 🔹 Header Section
  Widget _buildHeader(String name, String email, String imageUrl) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 50.h,
        bottom: 20.h,
        left: 16.w,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.w),
          bottomRight: Radius.circular(20.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔸 Profile avatar + info
          Row(
            children: [
              CircleAvatar(
                radius: 28.sp,
                backgroundColor: Colors.white,
                backgroundImage: imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : null,
                child: imageUrl.isEmpty
                    ? Icon(Icons.person, size: 35.w, color: Colors.teal)
                    : null,
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    email,
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),

          // 🔸 Active Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_user, color: Colors.greenAccent),
                SizedBox(width: 6.w),
                Text(
                  "Active",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Handle navigation
  void _handleMenuTap(String route) {
    switch (route) {
      case '/edit-profile':
        Get.toNamed('/edit-profile');
        break;
      case '/transaction':
        Get.toNamed('/transaction');
        break;
      case '/own-purchase-history':
        Get.toNamed('/own-purchase-history');
        break;
      case '/commissionwallet':
        Get.toNamed('/commissionwallet');
        break;
      case '/termscondition':
        Get.toNamed('/termscondition');
        break;
      case '/privacypolicy':
        Get.toNamed('/privacypolicy');
        break;
      case '/inviteus':
        Get.toNamed('/inviteus');
      case '/contactus':
        Get.toNamed('/contactus');
        break;
      case 'logout':
        _showLogoutDialog();
        break;
    }
  }

  // 🔹 Logout dialog
  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Logout", style: TextStyle(fontSize: 18.sp)),
        content: const Text("Are you sure you want to logout?"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              Get.back();
              Get.offAllNamed('/login');
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
