import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDeliveryPostScreen extends StatefulWidget {
  const MyDeliveryPostScreen({Key? key}) : super(key: key);

  @override
  State<MyDeliveryPostScreen> createState() => _MyDeliveryPostScreenState();
}

class _MyDeliveryPostScreenState extends State<MyDeliveryPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My delivery post'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            PostBloc()..add(const GetMyDeliveryPostEvent()),
        child: Builder(builder: (BuildContext context) {
          return BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is DeliveryPostLoadingState) {
                return UiUtilities.showMainLoader();
              } else if (state is DeliveryPostLoadedState) {
                return _buildDeliveryPostList(state.deliveryPost);
              }
              return Container();
            },
          );
        }),
      ),
    );
  }

  Widget _buildDeliveryPostList(List<DeliveryPost> deliveryPosts) {
    return ListView.builder(
      itemCount: deliveryPosts.length,
      itemBuilder: (context, index) {
        DeliveryPost deliveryPost = deliveryPosts[index];
        return Card(
          child: ListTile(
            title:
                Text(deliveryPost.latestDeliveryPostContent?.productName ?? ""),
            subtitle:
                Text(deliveryPost.latestDeliveryPostContent?.productName ?? ""),
          ),
        );
      },
    );
  }
}
