import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/utilities/services.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/submit_button.dart';
import 'package:carshop_mobile/widgets/textfield_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PostBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create post'),
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext context) {
          return BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is CreatedState) {
                UiUtilities.showToast(
                    message: "Your normal post is saved",
                    toast: Toast.LENGTH_LONG);
                UiUtilities.pop(context);
              }
            },
            builder: (context, state) {
              if (state is DataLoadingState) {
                return UiUtilities.showLoader();
              } else if (state is PostErrorState) {
                return const Center(
                  child: Text('There is an error'),
                );
              }
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldForm(
                            validateError: 'Title is required',
                            hintText: 'Title',
                            controller: titleController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldForm(
                            validateError: 'Content is required',
                            hintText: 'Content',
                            controller: contentController,
                            maxLine: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SubmitButton(
                            text: "createPost",
                            onPress: () => submit(state, context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  submit(PostState state, BuildContext context) async {
    final cordination = await Services().getUserCoordination();
    if (_formKey.currentState!.validate()) {
      CreatePostDto post = CreatePostDto(
          title: titleController.text,
          content: contentController.text,
          location: cordination);
      PostBloc postBloc = BlocProvider.of<PostBloc>(context);
      postBloc.add(SavePostEvent(post));
    }
  }
}
