import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/widgets/textfield_form.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final ScrollController? controller;
   CommentScreen({Key? key,this.controller}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text("Comments"),),
    body: SingleChildScrollView(
      child: Column(
        children: [
          _buildCommentList([]),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextFieldForm(hintText: "Enter a comment", ),
          )

        ],
      )
    ),
  );
  }

  Widget _buildCommentList(List<Comment> comments){
    return Container();
  }
}
