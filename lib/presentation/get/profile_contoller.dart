import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_socmed/core/data_state.dart';
import 'package:my_socmed/data/datasource/sqlite_service.dart';
import 'package:my_socmed/data/mapper/user_relation_mapper.dart';
import 'package:my_socmed/domain/entities/detail_user.dart';
import 'package:my_socmed/domain/entities/user_relation_state.dart';
import 'package:my_socmed/domain/params/profile_param.dart';

import '../../data/repositories/repositories.dart';

class ProfileController extends GetxController {
  final Repositories _repositories;

  ProfileController({required Repositories repositories})
      : _repositories = repositories;
  final _detailUser = Rx<DataState<DetailUser>?>(DataState.init());
  final _relationState = Rx<UserRelationState?>(null);

  UserRelationState? get relationState => _relationState.value;

  SqlliteService database = SqlliteService();

  DataState<DetailUser>? get detailUser => _detailUser.value;
  DetailUser? get user => detailUser?.data;
  final imageSize = 200.0;
  String? get getUserName =>
      '${user?.title}. ${user?.firstName} ${user?.lastName}'.toUpperCase();

  final _isRegistered = false.obs;
  final _isLike = false.obs;
  final _isBeFriend = false.obs;
  final _userId = ''.obs;

  bool get isLike => _isLike.value;
  bool get isBeFriend => _isBeFriend.value;
  bool? get isRegistered => _isRegistered.value;
  String get id => _userId.value;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    database.database();
    if (arg != null && arg is ProfileParam) {
      _userId.value = arg.userid ?? '';
      _fetchDetailUser(arg.userid!);
    }
  }

  void _fetchRelationState(String userId) async {
    await database.fetchData().then((value) {
      final list = value != null
          ? value.map((model) => UserRelationMapper.toEntity(model))
          : [] as List<UserRelationState>;
      if (list.isNotEmpty) {
        try {
          _relationState.value = list.singleWhere(
            (item) => item.userId == userId,
          );
          _isRegistered.value = true;
        } catch (e) {
          debugPrint('error $e');
        }
        _isLike.value = _relationState.value?.isLike ?? false;
        _isBeFriend.value = _relationState.value?.isBeFriend ?? false;
      }
    });
  }

  void onSaveState({
    required bool like,
    required bool friend,
  }) async {
    if (_isRegistered.value) {
      await database.update({
        'userId': id,
        'likeState': like ? 1 : 0,
        'friendState': friend ? 1 : 0,
      }).then((value) {
        _isLike.value = like;
        _isBeFriend.value = friend;
      });
    } else {
      await database.insert({
        'userId': id,
        'likeState': like ? 1 : 0,
        'friendState': friend ? 1 : 0,
      }).then((value) {
        _isLike.value = like;
        _isBeFriend.value = friend;
      });
    }
    _fetchRelationState(id);
  }

  void _fetchDetailUser(String userId) {
    _detailUser.value = DataState.loading();
    _repositories.getDetailUser(userId).then((value) {
      _detailUser.value = DataState.success(value);
      _fetchRelationState(userId);
    }).onError((error, stackTrace) {
      _detailUser.value = DataState.error(message: error.toString());
    });
  }
}
