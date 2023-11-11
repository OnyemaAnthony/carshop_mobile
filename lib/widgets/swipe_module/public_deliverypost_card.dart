import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/blocs/swipe_posts/swipe_bloc.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/change_bottom_sheet.dart';
import 'package:carshop_mobile/widgets/swipe_module/info_item.dart';
import 'package:carshop_mobile/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carshop_mobile/extensions/public_delivery_post_desc_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PublicDeliverypostCard extends StatelessWidget {
  final PublicDeliveryPostDesc deliveryPost;

  const PublicDeliverypostCard({super.key, required this.deliveryPost});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocConsumer<SwipeBloc, SwipePostState>(
        listener: (context, state) {
          if (state is ActionDoneState) {
            UiUtilities.showToast(
                message: "Action Done", toast: Toast.LENGTH_SHORT);
            UiUtilities.pop(context);
          } else if (state is ActionFailedState) {
            UiUtilities.showErrorMessage(state.errorMessage);
          }
        },
        builder: (context, state) {
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
                      '${deliveryPost.startLocation!.lat}  ${deliveryPost.startLocation!.lng}',
                  title: "Pick Up",
                  icon: Icons.location_on_outlined),
              CustomListItem(
                  info:
                      '${deliveryPost.destination?.lat}  ${deliveryPost.destination?.lng}',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed:
                          deliveryPost.status() != DeliveryPostStatus.ENDED
                              ? () {
                                  context.read<PostBloc>().add(
                                      AcceptDeliveryPostEvent(
                                          deliveryPost.deliveryPostId));
                                }
                              : null,
                      child: Text(
                        'Accept Delivery',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      )),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
