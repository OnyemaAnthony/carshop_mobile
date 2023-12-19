//import 'dart:js_util';

//import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/create_delivery_post/create_delivery_post_bloc.dart';
import 'package:carshop_mobile/screens/deliveryLocation.dart';
import 'package:carshop_mobile/screens/taskDescription.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/textfield_form.dart';

//import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'taskDescription.dart';


class CreateDeliveryPostScreen extends StatelessWidget {

  double pageNUm = 1 / 4;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateDeliveryPostBloc(),
      child: BlocBuilder<CreateDeliveryPostBloc, CreateDeliveryPostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(centerTitle: true,
              forceMaterialTransparency: true,
              title: Column(
                children: [
                  const Text('Task Description',
                    style: TextStyle(fontSize: 20,),
                  ),
                  Column(
                    children: [
                      LinearProgressIndicator(
                        value: state.pageNum,

                      ),
                    ],
                  )
                ],
              ),
              backgroundColor: Colors.white,
            ),
            body: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text('     Task title',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey,
                          width: 2.0),
                    ),
                    child: TextFieldForm(


                      //   controller: taskTitleController ,
                      hintText: 'What would you need help with?',


                    ),
                  ),
                ),
                const Text('     Task description*',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),

                    child: TextFieldForm(
                      //controller: taskDescController,
                      maxLine: 5,

                      hintText: 'Explain in more details*',

                    ),
                  ),
                ),
                const SizedBox(height: 100,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    // Make the button expand to the full width
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(width: 100.0,
                      height: 50.0,

                      child: BlocProvider(
                        create: (context) => CreateDeliveryPostBloc(),
                        child: ElevatedButton(

                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Colors.grey),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),

                                  )
                              )
                          ),


                          onPressed: () {
                            BlocProvider.of<CreateDeliveryPostBloc>(context)
                                .add(
                                const OpenNextPageEvent(pageNum: 1 / 4));
                            BlocProvider.of<CreateDeliveryPostBloc>(context)
                                .add(
                                PushDeliveryEvent(context));
                          },
                          child: const Text('Add delivery location',
                            style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                ),

              ],

            ),
          );
        },
      ),
    );
  }
}



