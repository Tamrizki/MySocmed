import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_socmed/core/utils.dart';
import 'package:my_socmed/data/repositories/repositories.dart';
import 'package:my_socmed/domain/entities/user.dart';

import '../../data/datasource/sqlite_service.dart';

class HomeController extends GetxController {
  final Repositories _repositories;
  SqlliteService database = SqlliteService();

  HomeController({
    required Repositories repositories,
  }) : _repositories = repositories;

  static const _initialPage = 0;
  static const _pageSize = 20;

  final pagingController = PagingController<int, User>(
    firstPageKey: _initialPage,
  );
  final _listUser = Rx<List<User>>([]);
  final _filterUser = Rx<List<User>>([]);
  List<User> get listUser => _listUser.value;
  List<User> get filterUser => _filterUser.value;

  final _isSearchMode = false.obs;
  bool get isSearchMode => _isSearchMode.value;

  final scrollController = ScrollController();
  final searchController = TextEditingController();

  String? getUserName(User user) =>
      '${user.title}.${user.firstName} ${user.lastName}';

  final _searchResult = ''.obs;
  String get searchResult => _searchResult.value;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((currentPage) {
      _fetchUsers(currentPage);
    });
  }

  void onSearchListener(String value) {
    _isSearchMode.value = value.isNotEmpty;
    _searchResult.value = value;
    if (value.isNotEmpty) {
      _filterUser.value = [];
      final filterResult = listUser
          .where((user) =>
              (user.firstName ?? '')
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              (user.lastName ?? '').toLowerCase().contains(value.toLowerCase()))
          .toList();

      _filterUser.value.addAll(filterResult);
    }
  }

  Future<void> refreshList() async {
    pagingController.refresh();
    _fetchUsers(_initialPage);
  }

  void _fetchUsers(int page) async {
    _repositories.getUser(page).then((value) {
      final users = value.users;
      if (users.isNotEmpty) {
        var isLastPage = value.users.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(users);
          Helper().showSnackbar('All data has been loaded');
        } else {
          pagingController.appendPage(users, (value.page ?? 0) + 1);
        }
        _listUser.value.addAll(value.users);
      }
    }).catchError((error) {
      debugPrint('cehckcheck error $error');
    });
  }
}
