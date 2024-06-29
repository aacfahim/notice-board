import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/features/bookmark/ui/bookmark_screen.dart';
import 'package:notice_board/features/category/bloc/category_bloc.dart';
import 'package:notice_board/features/category/ui/category_screen.dart';
import 'package:notice_board/features/home/bloc/home_bloc.dart';

import 'package:notice_board/features/home/ui/widgets/categories_tile.dart';
import 'package:notice_board/features/home/ui/widgets/category_tile_shimmer.dart';
import 'package:notice_board/features/home/ui/widgets/preference_widget.dart';
import 'package:notice_board/features/home/ui/widgets/home_appbar.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile_shimmer.dart';
import 'package:notice_board/features/more/ui/preference_list/model/preference_notifier.dart';
import 'package:notice_board/features/notice_detail/bloc/notice_bloc.dart';
import 'package:notice_board/features/notice_detail/ui/all_notice.dart';
import 'package:notice_board/features/notice_detail/ui/categorized_notice.dart';
import 'package:notice_board/features/notice_detail/ui/notice_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/const.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  HomeBloc homeBloc = HomeBloc();
  CategoryBloc categoryBloc = CategoryBloc();
  NoticeBloc noticeBloc = NoticeBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    categoryBloc.add(HomeInitialCategoryFetchEvent());
    noticeBloc.add(HomeInitialNoticeFetchEvent());

    super.initState();
  }

  Future<void> _refreshData() async {
    categoryBloc.add(HomeInitialCategoryFetchEvent());
    noticeBloc.add(HomeInitialNoticeFetchEvent());
  }

  @override
  void dispose() {
    homeBloc.close();
    categoryBloc.close();
    noticeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final preferenceNotifier = Provider.of<PreferenceNotifier>(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffF5F6F7),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeAppBar(subtitle: "National University"),
              Column(
                children: [
                  if (!preferenceNotifier.isPreferenceSaved)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: PreferenceWidget(),
                      ),
                    ),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            homeBloc.add(HomeCategorySeeAllEvent());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryScreen(isBack: true),
                              ),
                            );
                          },
                          child: Text("See all"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  BlocConsumer<CategoryBloc, CategoryState>(
                    bloc: categoryBloc,
                    listener: (context, state) {},
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case HomeCategoryLoadingState:
                          return Container(
                            height: 150,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[100]!,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 20,
                                itemBuilder: (index, context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: CategoryTileShimmer(),
                                  );
                                },
                                separatorBuilder: (index, context) =>
                                    SizedBox(width: 15),
                              ),
                            ),
                          );
                        case HomeCategoryFetchSuccessfulState:
                          final categorySuccessState =
                              state as HomeCategoryFetchSuccessfulState;

                          return Center(
                            child: Container(
                              height: 150,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: categorySuccessState
                                        .categories.length +
                                    (preferenceNotifier.isPreferenceSaved
                                        ? 1
                                        : 0), // Add one for "My Notices" if preference is saved
                                itemBuilder: (context, index) {
                                  if (index == 0 &&
                                      preferenceNotifier.isPreferenceSaved) {
                                    // Render "My Notices" tile if preference is saved
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AllNoticeList(),
                                            ),
                                          );
                                        },
                                        child: CategoryTile(
                                          categorieLogoLink:
                                              "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
                                          title: "My Notices",
                                        ),
                                      ),
                                    );
                                  } else {
                                    final categoryIndex =
                                        preferenceNotifier.isPreferenceSaved
                                            ? index - 1
                                            : index;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          String category = categorySuccessState
                                              .categories[categoryIndex]
                                              .attributes!
                                              .name
                                              .toString();

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategorizedNoticeList(
                                                category: category,
                                                isTypeShown: false,
                                              ),
                                            ),
                                          );
                                        },
                                        child: CategoryTile(
                                          title: categorySuccessState
                                              .categories[categoryIndex]
                                              .attributes!
                                              .name
                                              .toString(),
                                          categorieLogoLink:
                                              categorySuccessState
                                                  .categories[categoryIndex]
                                                  .attributes!
                                                  .categorieLogoLink
                                                  .toString(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  if (index == 0 &&
                                      preferenceNotifier.isPreferenceSaved) {
                                    return SizedBox(width: 15);
                                  } else {
                                    return SizedBox(width: 15);
                                  }
                                },
                              ),
                            ),
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !preferenceNotifier.isPreferenceSaved
                            ? Text(
                                "All Notice",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "My Notice",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                        InkWell(
                          onTap: () {
                            homeBloc.add(HomeNoticeSeeAllEvent());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllNoticeList(),
                              ),
                            );
                          },
                          child: Text("See all"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  BlocConsumer<NoticeBloc, NoticeState>(
                    bloc: noticeBloc,
                    listener: (context, state) {},
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case HomeNoticeLoadingState:
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: height * 0.5,
                              child: ListView.separated(
                                itemBuilder: (index, context) {
                                  return NoticeTileShimmer();
                                },
                                separatorBuilder: (index, context) =>
                                    SizedBox(height: 12),
                                itemCount: 30,
                              ),
                            ),
                          );

                        case HomeNoticeFetchSuccessfulState:
                          final noticeTileState =
                              state as HomeNoticeFetchSuccessfulState;
                          return Container(
                            height: height * 0.5,
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final notice = noticeTileState.notices[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NoticeDetailScreen(
                                                    data: noticeTileState
                                                        .notices[index])),
                                      );
                                    },
                                    child: NoticeTile(
                                      title:
                                          notice.attributes!.title.toString(),
                                      noticeType:
                                          notice.category!.name.toString(),
                                      date: notice.attributes!.dateInNotice
                                          .toString(),
                                    ),
                                  );
                                },
                                separatorBuilder: (index, context) =>
                                    SizedBox(height: 12),
                                itemCount: noticeTileState.notices.length,
                              ),
                            ),
                          );

                        case HomeNoticeErrorState:
                          return Center(child: Text("Something went wrong"));

                        default:
                          return SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
