import 'package:flutter/material.dart';
class TextFieldForm extends StatelessWidget {
  String? validateError;
  String? hintText;
  int? maxLine;
  bool? isPassword;
  TextEditingController? controller;
   TextFieldForm({Key? key,this.validateError,this.controller,this.hintText,this.maxLine=1,this.isPassword = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (input)=> input!.isEmpty?validateError:null,
      controller: controller,
      maxLines:maxLine ,
      obscureText: isPassword!,
      decoration:  InputDecoration(
          hintText: hintText,
          border:const  OutlineInputBorder()
      ),
    );
  }
}
