import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/swipe_posts/swipe_bloc.dart';
import 'package:carshop_mobile/extensions/public_delivery_post_desc_extension.dart';
import 'package:carshop_mobile/screens/comment_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/change_bottom_sheet.dart';
import 'package:carshop_mobile/widgets/swipe_module/info_item.dart';
import 'package:carshop_mobile/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicDeliveryPostCard extends StatelessWidget {
  final PublicDeliveryPostDesc deliveryPost;

  const PublicDeliveryPostCard({super.key, required this.deliveryPost});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<SwipeBloc, SwipePostState>(
        builder: (context, state) {
          SwipeBloc swipeBlock = context.read<SwipeBloc>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ChangeBottomSheet(
                    onDelete: (BuildContext sheetContext) {
                      context
                          .read<SwipeBloc>()
                          .add(DeleteDeliveryPost(deliveryPost.deliveryPostId));
                      UiUtilities.pop(sheetContext);
                    },
                  )
                ],
              ),
              UserCard(user: deliveryPost.owner),
              Text(
                deliveryPost.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(deliveryPost.content),
              CustomListItem(
                  info:
                      '${deliveryPost.startLocation.lat}  ${deliveryPost.startLocation.lng}',
                  title: "Pick Up",
                  icon: Icons.location_on_outlined),
              CustomListItem(
                  info:
                      '${deliveryPost.destination.lat}  ${deliveryPost.destination.lng}',
                  title: "Drop Off",
                  icon: Icons.location_on_outlined),
              CustomListItem(
                  info: deliveryPost.dateToText(),
                  title: "Time",
                  icon: Icons.access_time_outlined),
              CustomListItem(
                  info: '${deliveryPost.reward}',
                  title: "Budget",
                  icon: Icons.attach_money_outlined),
              Row(
                children: [Text("${deliveryPost.status()}")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed:
                          deliveryPost.status() != DeliveryPostStatus.ENDED
                              ? () {
                                  swipeBlock.add(AcceptDeliveryPostEvent(
                                      deliveryPost.deliveryPostId));
                                }
                              : null,
                      child: Text(
                        'Accept Delivery',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            swipeBlock.add(LikeDeliveryPostEvent(
                                deliveryPost.deliveryPostId,
                                deliveryPost.isLiked));
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: deliveryPost.isLiked
                                ? Colors.blue
                                : Colors.grey.shade800,
                          )),
                      Text("${deliveryPost.likesCount.toInt()}"),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            UiUtilities.pushNavBar(
                                context,
                                CommentScreen(
                                  deliveryPostId: state
                                      .selectedDeliveryPost!.deliveryPostId,
                                ),
                                false);
                          },
                          icon: const Icon(Icons.comment)),
                      Text("${deliveryPost.commentsCount.toInt()}"),
                    ],
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
