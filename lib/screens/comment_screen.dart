import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/comment/comment_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/comment/comment_bloc.dart';

class CommentScreen extends StatefulWidget {
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<CommentListItem> commentss = [];
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  late CommentBloc commentBloc;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  void fetchComments() {}

  void addComment(String text) {
    CreateCommentDto commentDto = const CreateCommentDto(
        parentId: 'b1476c87-0b10-47ba-956a-22041d994707',
        content: 'First comment',
        location: Coordination(lng: 0, lat: 0),
        commentType: CreateCommentDtoCommentType.onComment);

    commentBloc.add(CreateCommentEvent(commentDto));

    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CommentBloc(),
      child: Scaffold(
        body: Builder(builder: (BuildContext context) {
          commentBloc = BlocProvider.of<CommentBloc>(context)
            ..add(const GetAllCommentsEvent(
                "b1476c87-0b10-47ba-956a-22041d994707"));
          return BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoadedState) {
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
      ),
    );
  }

  Widget _buildComments(CommentsDescriptor comments) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: comments.comments.length,
              itemBuilder: (context, index) {
                CommentDescriptor comment = comments.comments[index];
                return CommentListItem(commentText: comment.content);
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    addComment(_textController.text);
                  },
                  child: CircleAvatar(
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
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    maxLines: null,
                    controller: _textController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Add a comment...'),
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {}
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
