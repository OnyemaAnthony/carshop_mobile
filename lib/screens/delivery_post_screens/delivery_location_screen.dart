import 'package:carshop_mobile/blocs/create_delivery_post/create_delivery_post_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryLocation extends StatelessWidget {


  final String pageName = 'Delivery Location';
  final double pageNum = 1/2;


  DeliveryLocation({super.key});

  @override
  Widget build(BuildContext context) {
    CreateDeliveryPostBloc bloc = BlocProvider.of<CreateDeliveryPostBloc>(context) ;


    return BlocConsumer<CreateDeliveryPostBloc, CreateDeliveryPostState>(
    listener: (context, state) {
    },
    builder: (context, state) {

      return Scaffold(appBar: AppBar(centerTitle: true,
      forceMaterialTransparency: true,
      title: const Column(
        children: [
           Text('Delivery Locations',
            style: TextStyle(fontSize: 20,),
          ),
            SizedBox(height: 20,),
          Column(
            children: [
              LinearProgressIndicator(
                value: 2/4,
                color: Colors.lightBlue,
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
    ),
        body: SingleChildScrollView(
          child: Column(
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
                      child:  TextField(
                       controller: state.pickUpAddress  ,

                        decoration: const  InputDecoration(
                            hintText: 'What would you need help with?'),

                      ),
                    ),
                    const SizedBox(height: 48),
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
                      child:  TextField(
                        controller: state.dropOffAddress ,

                        decoration: const  InputDecoration(
                            hintText: 'What would you need help with?'),

                      ),
                    ),
                   const SizedBox(height: 10,),
                  const  Text('Adding your exact location on the map helps find you faster',
                    style: TextStyle(color: Colors.grey,fontSize: 12.5), ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Use My Address as Pick-up location',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: state.useMyAddressPickUp?? false ,
                          onChanged: (value) {
                          bloc.add(SwitchUseMyPickupEvent(newValue: value));
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
                            value: state.useMyAddressDropOff?? false,
                            onChanged: (value) {
                              bloc.add(SwitchUseMyDropOffEvent(newValue: value));
                            },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
bottomNavigationBar:
Padding(
  padding: const EdgeInsets.fromLTRB(15,15,15,30),
  child:   ElevatedButton(
    style: ButtonStyle(

        fixedSize:MaterialStatePropertyAll(Size(300, 50)) ,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )
        )
    ),
    onPressed: () {
      bloc.add(PushTimeEvent(context: context,));
    },
    child: const Text('Select a time',style: TextStyle(color: Colors.white),),
  ),
),
      );
    },
);
  }
}