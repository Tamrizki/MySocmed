import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_socmed/core/data_state.dart';
import 'package:my_socmed/core/utils.dart';
import 'package:my_socmed/presentation/get/profile_contoller.dart';

import '../../core/consts.dart';

class ProfilePage extends GetView<ProfileController> {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        switch (controller.detailUser?.status) {
          case Status.success:
            return buildSuccessBody(context);
          default:
            return buildLoadingBody(context);
        }
      })),
    );
  }

  Widget buildLoadingBody(BuildContext context) {
    return Column(
      children: [
        Helper().shimmerAnimation(
          height: 200.0,
          width: double.infinity,
        )
      ],
    );
  }

  Widget buildSuccessBody(BuildContext context) {
    final size = controller.imageSize;

    final detailUser = controller.detailUser?.data;
    return Obx(
      () => Stack(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueGrey,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(24.0),
                  bottomLeft: Radius.circular(24.0),
                )),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: detailUser?.picture ?? '',
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: size,
                        width: size,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle),
                      );
                    },
                    errorWidget: (context, url, error) => Image.asset(
                      placeholder,
                      height: size,
                      width: size,
                    ),
                    placeholder: (context, url) => Image.asset(
                      placeholder,
                      height: size,
                      width: size,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    controller.getUserName ?? '-',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contact : ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            controller.user?.email ?? '-',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          const Text(
                            'Country : ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            controller.user?.location ?? '-',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          controller.onSaveState(
                            friend: !controller.isBeFriend,
                            like: controller.isLike,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.isBeFriend
                                  ? Colors.greenAccent
                                  : Colors.grey,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Image.asset(
                            addFriend,
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.onSaveState(
                              like: !controller.isLike,
                              friend: controller.isBeFriend,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: Icon(
                              Icons.favorite,
                              color:
                                  controller.isLike ? Colors.red : Colors.grey,
                              size: 40.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
