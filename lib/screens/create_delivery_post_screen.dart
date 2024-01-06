//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carshop_mobile/blocs/create_delivery_post/create_delivery_post_bloc.dart';





class CreateDeliveryPostScreen extends StatelessWidget {
final _taskTitle = TextEditingController();
final _taskDescription = TextEditingController();

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
                const  SizedBox(height: 20,),
                  Column(
                    children: [
                      LinearProgressIndicator(
                        value: pageNUm,
                        color: Colors.lightBlue,

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
                  child: Text('     Task title*',
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
                    child: TextField(
                      controller: _taskTitle,
                   decoration: const  InputDecoration(
                         hintText: 'What would you need help with?'),
                    style: TextStyle(fontSize: 10),


                      //   controller: taskTitleController ,
                      //hintText: 'What would you need help with?',


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

                    child:  TextField(
                      controller: _taskDescription,
                      decoration:const   InputDecoration(
                          hintText: 'Explain in more details*'),

                      maxLines: 6,
                      style: TextStyle(fontSize: 10),
                      //controller: taskDescController,



                    ),
                  ),
                ),
                const SizedBox(height:188),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(



                    child: ElevatedButton(

                      style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                              Colors.grey),
                          fixedSize:MaterialStatePropertyAll(Size(350, 50)) ,
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),

                              )
                          )
                      ),


                      onPressed: () {
                      String  taskTitle = _taskTitle.text ;
                        String taskDescription= _taskDescription.text;
                        BlocProvider.of<CreateDeliveryPostBloc>(context)
                            .add(
                            const OpenNextPageEvent(pageNum: 1 / 4));
                        BlocProvider.of<CreateDeliveryPostBloc>(context)
                            .add(
                            PushDeliveryEvent(context,taskTitle,taskDescription));

                      },
                      child: const Text('Add delivery location',
                        style: TextStyle(color: Colors.white),),
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



