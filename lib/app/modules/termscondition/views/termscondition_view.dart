import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/termscondition_controller.dart';

class TermsconditionView extends GetView<TermsconditionController> {
  const TermsconditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.termsText.isEmpty) {
          return const Center(
            child: Text(
              "No Terms & Conditions found.",
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
                "Welcome to Our App!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Please read these terms and conditions carefully before using our application.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 25),

              Text(
                controller.termsText.value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.6,
                ),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 40),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
