import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile.dart';
import 'package:notice_board/features/home/ui/widgets/notice_tile_shimmer.dart';
import 'package:notice_board/features/notice_detail/bloc/notice_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AllNoticeList extends StatefulWidget {
  const AllNoticeList({super.key});

  @override
  State<AllNoticeList> createState() => _AllNoticeListState();
}

class _AllNoticeListState extends State<AllNoticeList> {
  NoticeBloc noticeBloc = NoticeBloc();
  @override
  void initState() {
    noticeBloc.add(HomeInitialNoticeFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(text: "All Notice"),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Notice List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Expanded(
            child: BlocConsumer<NoticeBloc, NoticeState>(
              bloc: noticeBloc,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case HomeNoticeLoadingState:
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.separated(
                        itemCount: 20,
                        itemBuilder: (index, context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: NoticeTileShimmer(),
                          );
                        },
                        separatorBuilder: (index, context) =>
                            SizedBox(width: 15),
                      ),
                    );

                  case HomeNoticeFetchSuccessfulState:
                    final noticeState = state as HomeNoticeFetchSuccessfulState;
                    return ListView.separated(
                        separatorBuilder: (index, context) =>
                            SizedBox(height: 12),
                        itemCount: noticeState.notices.length,
                        itemBuilder: (context, index) {
                          return NoticeTile(
                            title: noticeState.notices[index].attributes!.title
                                .toString(),
                            date: noticeState.notices[index].attributes!.date
                                .toString(),
                            bookmarked: false,
                            noticeType: noticeState
                                .notices[index].attributes!.tag
                                .toString(),
                          );
                        });

                  default:
                    return SizedBox.shrink();
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
