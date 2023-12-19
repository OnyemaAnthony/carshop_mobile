import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/create_delivery_post/create_delivery_post_bloc.dart';
import '../widgets/textfield_form.dart';


class TaskDescription extends StatelessWidget {
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();

  TaskDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        forceMaterialTransparency: true,
        title: Column(
          children: [
            const Text('Task Description',
              style: TextStyle(fontSize: 20,),
            ),
            BlocBuilder<CreateDeliveryPostBloc, CreateDeliveryPostState>(
              builder: (context, state) {
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: state.pageNum ,
                      semanticsValue: state.pageNum.toString() ,
                    ),
                  ],
                );
              },
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
              child:  TextFieldForm(

                controller: taskTitleController ,
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
                controller: taskDescController,
                maxLine : 5,

                hintText: 'Explain in more details*',

              ),
            ),
          ),
          const SizedBox(height: 100,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity, // Make the button expand to the full width
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(width: 100.0,
                height: 50.0,

                child: ElevatedButton(

                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Colors.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),

                          )
                      )
                  ),


                  onPressed: () {
                    BlocProvider.of<CreateDeliveryPostBloc>(context).add(const OpenNextPageEvent(pageNum: 1/4));
                    BlocProvider.of<CreateDeliveryPostBloc>(context).add( new PushDeliveryEvent(context));

                  },
                  child: const Text('Add delivery location',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ),

        ],

      ),
    );

  }
}
