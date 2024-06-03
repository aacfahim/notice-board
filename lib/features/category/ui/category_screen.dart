import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/features/category/bloc/category_bloc.dart';
import 'package:notice_board/features/category/ui/widgets/category_grid_shimmer.dart';
import 'package:notice_board/features/home/ui/widgets/categories_tile.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/notice_detail/ui/categorized_notice.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key, this.isBack = false});
  final bool isBack;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  CategoryBloc categoryBloc = CategoryBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    categoryBloc.add(HomeInitialCategoryFetchEvent());
    super.initState();
  }

  Future<void> _refreshData() async {
    categoryBloc.add(HomeInitialCategoryFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CommonAppBar(text: "Categories", isBack: widget.isBack),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Expanded(
                child: BlocConsumer<CategoryBloc, CategoryState>(
                  bloc: categoryBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case HomeCategoryLoadingState:
                        return CategoryGridShimmer();
                      case HomeCategoryFetchSuccessfulState:
                        final categoryState =
                            state as HomeCategoryFetchSuccessfulState;
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 16.0,
                            ),
                            padding: EdgeInsets.all(6.0),
                            itemCount: categoryState.categories.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  String category = categoryState
                                      .categories[index].attributes!.name
                                      .toString();

                                  // noticeBloc.add(
                                  //     CategorizedNoticeFetchEvent(
                                  //         category));
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
                                  title: categoryState
                                      .categories[index].attributes!.name
                                      .toString(),
                                ),
                              );
                            });
                      default:
                        return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
