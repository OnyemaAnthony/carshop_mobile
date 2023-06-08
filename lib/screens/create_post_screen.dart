import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/models/post/post_model.dart';
import 'package:carshop_mobile/repositories/post_repository.dart';
import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/submit_button.dart';
import 'package:carshop_mobile/widgets/textfield_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late PostBloc postBloc;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (BuildContext context) => PostBloc(repository: PostRepository(ApiRequest())),
  child: Scaffold(
      appBar: AppBar(
        title: const Text('Create post'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
          postBloc = BlocProvider.of<PostBloc>(context);
          return BlocBuilder<PostBloc, PostState>(
  builder: (context, state) {
    if(state is PostLoadingState){
      return UiUtilities.showLoader();
    }
    return SafeArea(
            child:SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      TextFieldForm(validateError: 'Title is required',hintText: 'Title',controller: titleController,),
                      const SizedBox(height: 20,),

                      TextFieldForm(validateError: 'Content is required',hintText: 'Content',controller: contentController,maxLine: 10,),
                      const SizedBox(height: 20,),

                      SubmitButton(onPress: ()=>submit(state),),

                    ],
                  ),
                ),
              ),
            ),
          );
  },
);
        }
      ),
    ),
);
  }

   submit(PostState state){
    PostModel post = PostModel(title: titleController.text,content: contentController.text);
    if(_formKey.currentState!.validate()){
      postBloc.add(SavePostEvent(post));

    }


  }

}
