import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyNormalPostScreen extends StatefulWidget {
  const MyNormalPostScreen({Key? key}) : super(key: key);

  @override
  State<MyNormalPostScreen> createState() => _MyNormalPostScreen();
}

class _MyNormalPostScreen extends State<MyNormalPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Normal post'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (BuildContext context) => PostBloc()..add(FetchMyPostsEvent()),
        child: Builder(builder: (BuildContext context) {
          return BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is DataLoadingState) {
                return UiUtilities.showMainLoader();
              } else if (state is DataReadyState) {
                return _buildDeliveryPostList(state.posts);
              }
              return Container();
            },
          );
        }),
      ),
    );
  }

  Widget _buildDeliveryPostList(List<NormalPost> normalPosts) {
    return ListView.builder(
      itemCount: normalPosts.length,
      itemBuilder: (context, index) {
        NormalPost normalPost = normalPosts[index];
        return Card(
          child: ListTile(
            title: Text(normalPost.latestContent?.title ?? ""),
            subtitle: Text(normalPost.latestContent?.content ?? ""),
          ),
        );
      },
    );
  }
}
