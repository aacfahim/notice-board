import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notice_board/features/category/ui/widgets/category_grid_shimmer.dart';
import 'package:notice_board/features/common/ui/common_appbar.dart';
import 'package:notice_board/features/tutor/bloc/tutor_bloc.dart';

import 'package:notice_board/features/tutor/widgets/tutor_tile.dart';

class TutorScreen extends StatefulWidget {
  TutorScreen({super.key, this.isBack = false});
  final bool isBack;

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen>
    with AutomaticKeepAliveClientMixin {
  TutorBloc tutorBloc = TutorBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    tutorBloc.add(TutorInitialFetchEvent());
    super.initState();
  }

  Future<void> _refreshData() async {
    tutorBloc.add(TutorInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CommonAppBar(text: "Tutor List", isBack: true),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 9),
              Expanded(
                child: BlocConsumer<TutorBloc, TutorState>(
                  bloc: tutorBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case TutorLoadingState():
                        return CategoryGridShimmer();
                      case TutorFetchSuccessfulState:
                        final tutorState = state as TutorFetchSuccessfulState;

                        return ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 8),
                            padding: EdgeInsets.all(6.0),
                            itemCount: tutorState.tutorList.length,
                            itemBuilder: (context, index) {
                              return TutorTile(
                                tutorName: tutorState
                                    .tutorList[index].attributes!.tutorName
                                    .toString(),
                                subjectSkill: tutorState
                                    .tutorList[index].attributes!.subjectSkill
                                    .toString(),
                                location: tutorState
                                    .tutorList[index].attributes!.location
                                    .toString(),
                                availability: tutorState
                                    .tutorList[index].attributes!.startFrom
                                    .toString(),
                                contact: tutorState
                                    .tutorList[index].attributes!.contact
                                    .toString(),
                                duration: tutorState
                                    .tutorList[index].attributes!.duration
                                    .toString(),
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
