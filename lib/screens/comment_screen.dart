import 'package:carshop_mobile/widgets/comment/comment_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/comment/comment_bloc.dart';

class CommentScreen extends StatefulWidget {
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<CommentListItem> comments = [];
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  late CommentBloc commentBloc;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  void fetchComments() {
    List<CommentListItem> fetchedComments = [
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like thatWhat exactly are you doing with your family in such a dangerous place like that?What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like thatWhat exactly are you doing with your family in such a dangerous place like that?What exactly are you doing with your family in such a dangerous place like that?,,,,,,',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like thatWhat exactly are you doing with your family in such a dangerous place like that?What exactly are you doing with your family in such a dangerous place like that?,,,,,,',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like that?',
      ),
      CommentListItem(
        userName: "Anthony",
        timeAgo: '20hr ago',
        commentText:
            'What exactly are you doing with your family in such a dangerous place like that What exactly are you doing with your family in such a dangerous place like that?',
      ),
    ];

    setState(() {
      comments = fetchedComments;
    });
  }

  void addComment(String text) {
    setState(() {});
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CommentBloc(),
      child: Scaffold(
        body: Builder(builder: (BuildContext context) {
          commentBloc = BlocProvider.of<CommentBloc>(context);
          return BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return comments[index];
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
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
                                if (text.isNotEmpty) {
                                  addComment(text);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
