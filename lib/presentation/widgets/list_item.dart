import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_socmed/domain/entities/user.dart';

import '../../core/consts.dart';
import '../../domain/params/profile_param.dart';
import '../pages/profile_page.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.item,
    required this.userName,
  });
  final User item;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(ProfilePage.routeName,
            arguments: ProfileParam(userid: item.id ?? ''));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl: item.picture ?? '',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider),
                  shape: BoxShape.circle,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                placeholder,
                height: 50,
                width: 50,
              ),
              placeholder: (context, url) => Image.asset(
                placeholder,
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(width: 16.0),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
