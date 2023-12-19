import 'package:carshop_mobile/blocs/create_delivery_post/create_delivery_post_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/textfield_form.dart';

class DeliveryLocation extends StatelessWidget {
  String pageName = 'Delivery Location';
  double pageNum = 1/2;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CreateDeliveryPostBloc(),
  child: Scaffold(appBar: AppBar(centerTitle: true,
    forceMaterialTransparency: true,
    title: const Column(
      children: [
         Text('Delivery Location',
          style: TextStyle(fontSize: 20,),
        ),
        Column(
          children: [
            LinearProgressIndicator(
              value: 2/4,

            ),
          ],
        )
      ],
    ),
    backgroundColor: Colors.white,
  ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10,10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             const   Text(
                  'Pick-up*',
                  style: TextStyle(fontSize: 18,),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey,
                        width: 2.0),
                  ),
                  child:  TextFieldForm(
                  //  controller: taskTitleController ,
                    hintText: 'Address details',


                  ),
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 32),
                const Text(
                  'Drop-off*',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey,
                        width: 2.0),
                  ),
                  child:  TextFieldForm(
                    //  controller: taskTitleController ,
                    hintText: 'Address details',


                  ),
                ),
               const SizedBox(height: 10,),
              const  Text('Adding your exact location on the map helps find you faster',
                style: TextStyle(color: Colors.grey,fontSize: 12.5), ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Use My Address as Pick-up location',
                      style: TextStyle(fontSize: 16),
                    ),
                    Switch(
                      value: true, // Set initial value based on user preference
                      onChanged: (value) {
                        // Handle switch change
                        // You can implement logic to use or not use the user's address
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Use My Address as Drop-off Location',
                      style: TextStyle(fontSize: 16),
                    ),
                    Switch(
                      value: false, // Set initial value based on user preference
                      onChanged: (bool value) {
                        // Handle switch change
                        // You can implement logic to use or not use the user's address
                      },
                    ),
                  ],
                ),


              ],
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
                  //  BlocProvider.of<CreateDeliveryPostBloc>(context).add(OpenNextPageEvent(pageNum: 1/4));
                    BlocProvider.of<CreateDeliveryPostBloc>(context).add(PushTimeEvent(context));
                  },
                  child: const Text('Select a time',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ),
        ],
      ),

    ),
);
  }
}