import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/comment/comment_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../blocs/comment/comment_bloc.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});

  final _textController = TextEditingController();

  final _scrollController = ScrollController();

  late CommentBloc commentBloc;
  String temp = 'b1476c87-0b10-47ba-956a-22041d994707';

  void addComment(String text) {
    CreateCommentDto commentDto = CreateCommentDto(
      parentCommentId: temp,
      content: text,
      location: const Coordination(lng: 12.0, lat: 8.0),
    );

    commentBloc.add(CreateCommentEvent(commentDto));

    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          CommentBloc()..add(GetAllCommentsEvent(temp)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext context) {
          commentBloc = BlocProvider.of<CommentBloc>(context);

          return BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoadedState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent);
                });
                return _buildComments(state.comments);
              } else if (state is CommentLoadingState) {
                return UiUtilities.showMainLoader();
              } else if (state is CommentErrorState) {
                UiUtilities.showErrorMessage(state.errorMessage);
              }
              return Container();
            },
          );
        }),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 30,
                  child: const Text(
                    "J",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: TextFormField(
                      controller: _textController,
                      maxLines: null,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Add a Comment ',
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addComment(_textController.text);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Text(
                      'Comment',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComments(PublicCommentsDescriptor? comments) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: comments!.comments.length,
              itemBuilder: (context, index) {
                PublicCommentDescriptor comment = comments.comments[index];
                return CommentListItem(
                  onAction: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ListTile(
                                title: GestureDetector(
                                  onTap: () {
                                    commentBloc.add(
                                      DeleteCommentEvent(
                                          comment.commentId, comments),
                                    );
                                    UiUtilities.pop(context);
                                  },
                                  child: Text(
                                    "Delete",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                leading: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.1),
                                      shape: BoxShape.circle),
                                  padding: const EdgeInsets.all(10),
                                  child: const ImageIcon(
                                      AssetImage('assets/icons/delete.png')),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  commentText: comment.content,
                  userName: "Anthony",
                  timeAgo: timeago.format(comment.createdAt),
                  reply: () {
                    UiUtilities.push(context, CommentScreen());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
