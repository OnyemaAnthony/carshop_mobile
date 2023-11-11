import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/widgets/change_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewDeliveryPost extends StatelessWidget {
  const ViewDeliveryPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          PrivateDeliveryPostDesc deliveryPost =
              state.deliveryPosts[state.deliveryIndex];

          return Column(
            children: [
              Row(
                children: [
                  ChangeBottomSheet(
                    onDelete: (sheetContext) {},
                  )
                ],
              ),
              //   UserCard(
              //       user: context.read<AuthenticationBloc>().state.userModel!),
              Text(deliveryPost.title),
              Text(deliveryPost.content),
              ElevatedButton(
                  onPressed: () {
                    context.read<PostBloc>().add(
                        AcceptDeliveryPostEvent(deliveryPost.deliveryPostId));
                  },
                  child: const Text('Accept Delivery'))
            ],
          );
        },
      ),
    );
  }
}
