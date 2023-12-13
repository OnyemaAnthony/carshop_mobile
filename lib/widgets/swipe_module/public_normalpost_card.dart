import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/swipe_posts/swipe_bloc.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/change_bottom_sheet.dart';
import 'package:carshop_mobile/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PublicNormalPostCard extends StatelessWidget {
  final PublicNormalPostDescriptor normalPost;

  const PublicNormalPostCard({super.key, required this.normalPost});

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(flex: 5, child: UserCard(user: normalPost.owner)),
                  Expanded(
                    child: ChangeBottomSheet(
                      onDelete: (BuildContext sheetContext) {
                        context
                            .read<SwipeBloc>()
                            .add(DeleteDeliveryPost(normalPost.normalPostId));
                        UiUtilities.pop(sheetContext);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  Text(
                    normalPost.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(normalPost.content),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
