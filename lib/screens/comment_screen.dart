import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/comment/comment_bloc.dart';
import 'package:carshop_mobile/widgets/textfield_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatefulWidget {
  final ScrollController? controller;

  CommentScreen({Key? key, this.controller}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late CommentBloc commentBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CommentBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Comments"),
        ),
        body: Builder(builder: (BuildContext context) {
          commentBloc = BlocProvider.of<CommentBloc>(context);
          return BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  _buildCommentList([]),
                  TextButton(
                      onPressed: () {
                        CreateCommentDto comment = CreateCommentDto(
                            parentId: 'commentId',
                            content: 'this is first comment',
                            location: Coordination(lat: 0.0, lng: 0.0),
                            commentType:
                                CreateCommentDtoCommentType.onDeliveryPost);
                        commentBloc.add(CreateCommentEvent(comment));
                      },
                      child: const Text("Contact")),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextFieldForm(
                      hintText: "Enter a comment",
                      onTap: (input) {
                        CreateCommentDto comment = CreateCommentDto(
                            parentId: '',
                            content: input,
                            location: Coordination(lat: 0.0, lng: 0.0),
                            commentType:
                                CreateCommentDtoCommentType.onDeliveryPost);
                        commentBloc.add(CreateCommentEvent(comment));
                      },
                    ),
                  )
                ],
              ));
            },
          );
        }),
      ),
    );
  }

  Widget _buildCommentList(List<CommentDescriptor> comments) {
    return Container();
  }
}
