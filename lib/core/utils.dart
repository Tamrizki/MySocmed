import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Helper {
  void showSnackbar(String messgae) {
    Get.showSnackbar(
      GetSnackBar(
        message: messgae,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget shimmerAnimation({double? height, double? width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
