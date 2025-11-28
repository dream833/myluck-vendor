import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/config/appcolor.dart';
import 'package:url_launcher/url_launcher.dart'; // 👈 import added
import '../controllers/contactus_controller.dart';

class ContactusView extends GetView<ContactusController> {
  const ContactusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolor.secondary,
        centerTitle: true,
        title: const Text(
          "Contact Us",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.companyName.isEmpty &&
            controller.email.isEmpty &&
            controller.phone.isEmpty &&
            controller.address.isEmpty) {
          return const Center(
            child: Text(
              "No contact details found.",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Get in Touch",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "We’d love to hear from you. Reach out to us anytime using the contact details below.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 25),

              _contactItem("🏢 Company", controller.companyName.value),
              _contactItem("📧 Email", controller.email.value, isEmail: true),
              _contactItem("📞 Phone", controller.phone.value, isPhone: true),
              _contactItem("📍 Address", controller.address.value),

              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  Widget _contactItem(
    String title,
    String value, {
    bool isEmail = false,
    bool isPhone = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),

          GestureDetector(
            onTap: () async {
              if (isEmail) {
                final Uri emailUri = Uri(scheme: 'mailto', path: value);
                await launchUrl(emailUri);
              } else if (isPhone) {
                final Uri phoneUri = Uri(scheme: 'tel', path: value);
                await launchUrl(phoneUri);
              }
            },
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: isEmail || isPhone ? Colors.blue : Colors.black87,
                decoration: isEmail || isPhone
                    ? TextDecoration.underline
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
