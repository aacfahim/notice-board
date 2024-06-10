import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile_shimmer.dart';
import 'package:notice_board/features/notice_detail/bloc/notice_bloc.dart';
import 'package:notice_board/features/notice_detail/ui/notice_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class CategorizedNoticeList extends StatefulWidget {
  CategorizedNoticeList(
      {super.key, required this.category, this.isTypeShown = true});
  String category;
  bool isTypeShown;

  @override
  State<CategorizedNoticeList> createState() => _CategorizedNoticeListState();
}

class _CategorizedNoticeListState extends State<CategorizedNoticeList> {
  NoticeBloc noticeBloc = NoticeBloc();
  @override
  void initState() {
    noticeBloc.add(CategorizedNoticeFetchEvent(widget.category));
    super.initState();
  }

  Future<void> _refreshData() async {
    noticeBloc.add(CategorizedNoticeFetchEvent(widget.category));
  }

  String timeAgo(String dateString) {
    // Parse the input string to a DateTime object
    DateTime date = DateTime.parse(dateString);

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return "today";
    } else if (difference.inDays == 1) {
      return "yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 14) {
      return "last week";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else if (difference.inDays < 60) {
      return "last month";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()} months ago";
    } else if (difference.inDays < 730) {
      return "last year";
    } else {
      return "${(difference.inDays / 365).floor()} years ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(text: widget.category),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 8),
            Expanded(
              child: BlocConsumer<NoticeBloc, NoticeState>(
                bloc: noticeBloc,
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case CategorizedNoticeLoadingState:
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.separated(
                          itemCount: 20,
                          itemBuilder: (index, context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: NoticeTileShimmer(),
                            );
                          },
                          separatorBuilder: (index, context) =>
                              SizedBox(width: 15),
                        ),
                      );

                    case CategorizedFetchSuccessfulState:
                      final noticeState =
                          state as CategorizedFetchSuccessfulState;

                      if (noticeState.notices.isEmpty) {
                        return Text("No Notices Found");
                      } else {
                        return ListView.separated(
                            separatorBuilder: (index, context) =>
                                SizedBox(height: 12),
                            itemCount: noticeState.notices.length,
                            itemBuilder: (context, index) {
                              final notice = noticeState.notices[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NoticeDetailScreen(data: notice),
                                    ),
                                  );
                                },
                                child: NoticeTile(
                                  title: noticeState
                                      .notices[index].attributes!.title
                                      .toString(),
                                  date: timeAgo(noticeState
                                      .notices[index].attributes!.dateInNotice
                                      .toString()),
                                  bookmarked: false,
                                  isNoticeTypeShown: widget.isTypeShown,
                                  noticeType: notice.category!.name.toString(),
                                ),
                              );
                            });
                      }

                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
