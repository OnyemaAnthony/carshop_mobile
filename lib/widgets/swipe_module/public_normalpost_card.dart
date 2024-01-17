import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/swipe_posts/swipe_bloc.dart';
import 'package:carshop_mobile/screens/comment_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/change_bottom_sheet.dart';
import 'package:carshop_mobile/widgets/shared_widgets/dayno_loading_indicator.dart';
import 'package:carshop_mobile/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class PublicNormalPostCard extends StatelessWidget {
  final PublicNormalPostDescriptor normalPost;

  const PublicNormalPostCard({super.key, required this.normalPost});

  @override
  Widget build(BuildContext context) {
    final swipBloc = BlocProvider.of<SwipeBloc>(context);
    return Card(
      child: BlocBuilder<SwipeBloc, SwipePostState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              swipBloc.add(const RefreshNormalPostEvent());
            },
            child: ListView(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: UserCard(user: normalPost.owner)),
                              Expanded(
                                child: ChangeBottomSheet(
                                  onDelete: (BuildContext sheetContext) {
                                    swipBloc.add(DeleteDeliveryPost(
                                        normalPost.normalPostId));
                                    UiUtilities.pop(sheetContext);
                                  },
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                timeago.format(normalPost.createdAt),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Text(
                                  normalPost.title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Text(normalPost.content,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon: normalPost.isLiked
                                                ? const Icon(Icons.favorite)
                                                : const Icon(
                                                    Icons.favorite_border),
                                            onPressed: () {
                                              swipBloc.add(
                                                  const LikeNormalPostEvent());
                                            }),
                                        Text(normalPost.likesCount
                                            .toInt()
                                            .toString()),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/images/comment.png'),
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              CommentScreen
                                                  .openCommenScreenAsSheet(
                                                context,
                                                normalPostId:
                                                    normalPost.normalPostId,
                                              );
                                            }),
                                        Text(normalPost.commentsCount
                                            .toInt()
                                            .toString()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          icon:
                                              const Icon(Icons.bookmark_border),
                                          onPressed: () {
                                            swipBloc.add(BookmarkNormalPost(
                                                normalPost.normalPostId));
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (state.pageStatus == PageStatus.loading)
                      const DaynoLoadingIndicator(),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
