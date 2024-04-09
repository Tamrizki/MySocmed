import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_socmed/core/utils.dart';
import 'package:my_socmed/domain/entities/user.dart';
import 'package:my_socmed/presentation/get/home_controller.dart';
import 'package:my_socmed/presentation/widgets/list_item.dart';

class HomePage extends GetView<HomeController> {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MySocmed'),
      ),
      body: SafeArea(
          child: Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              buildSearchSection(context),
              buildSearchResultSection(context),
              Visibility(
                visible: !controller.isSearchMode,
                child: Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.refreshList,
                    child: PagedListView<int, User>(
                      pagingController: controller.pagingController,
                      scrollController: controller.scrollController,
                      builderDelegate: PagedChildBuilderDelegate(
                        firstPageProgressIndicatorBuilder: (context) =>
                            SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 20,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Helper().shimmerAnimation(
                                      height: 50.0, width: 50.0),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                      child: Helper()
                                          .shimmerAnimation(height: 50.0)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        itemBuilder: (context, item, index) {
                          return ListItem(
                            item: item,
                            userName: controller.getUserName(item) ?? '-',
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildSearchResultSection(BuildContext context) {
    return Obx(() {
      final users = controller.filterUser;
      return Visibility(
        visible: controller.isSearchMode,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: 'search result :',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: controller.searchResult,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ])),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.filterUser.length,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    color: Colors.amber.shade100,
                    child: ListItem(
                      item: users[index],
                      userName: controller.getUserName(users[index]) ?? '-',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildSearchSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.onSearchListener,
        decoration: const InputDecoration(
          hintText: "Search Data",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
        ),
      ),
    );
  }
}
