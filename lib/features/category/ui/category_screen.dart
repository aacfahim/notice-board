import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/features/category/bloc/category_bloc.dart';
import 'package:notice_board/features/category/ui/widgets/category_grid_shimmer.dart';
import 'package:notice_board/features/home/ui/widgets/categories_tile.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/more/ui/preference_list/model/preference_notifier.dart';
import 'package:notice_board/features/notice_detail/ui/all_notice.dart';
import 'package:notice_board/features/notice_detail/ui/categorized_notice.dart';
import 'package:provider/provider.dart';

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
    final preferenceNotifier = Provider.of<PreferenceNotifier>(context);
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
                          itemCount: categoryState.categories.length +
                              (preferenceNotifier.isPreferenceSaved ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == 0 &&
                                preferenceNotifier.isPreferenceSaved) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllNoticeList(),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    String category = categoryState
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
                                    title: categoryState
                                        .categories[categoryIndex]
                                        .attributes!
                                        .name
                                        .toString(),
                                    categorieLogoLink: categoryState
                                        .categories[categoryIndex]
                                        .attributes!
                                        .categorieLogoLink
                                        .toString(),
                                  ),
                                ),
                              );
                            }
                          },
                        );
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
