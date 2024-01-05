import 'package:carshop_mobile/blocs/create_delivery_post/create_delivery_post_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import '../widgets/textfield_form.dart';

class DeliveryLocation extends StatefulWidget {
  @override
  State<DeliveryLocation> createState() => _DeliveryLocationState();
}

class _DeliveryLocationState extends State<DeliveryLocation> {
  bool myAdressPick = false;
  bool myAdressDrop= false ;
  String pageName = 'Delivery Location';

  double pageNum = 1/2;

  final _pickUp = TextEditingController() ;

  final _dropOff = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CreateDeliveryPostBloc(),
  child: Scaffold(  appBar: AppBar(centerTitle: true,
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
                  child:  TextField(
                   controller: _pickUp  ,
                    decoration: const  InputDecoration(
                        hintText: 'What would you need help with?'),
                    style: TextStyle(fontSize: 10),


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
                      controller: _dropOff ,
                    decoration: const  InputDecoration(
                        hintText: 'What would you need help with?'),
                    style: TextStyle(fontSize: 10),


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

                      value: myAdressPick,
                      onChanged: (value) {
                        setState(() {
                         if(value==true) {

                          myAdressPick= value ;

                         _pickUp.text = "from the data";
                         }else{myAdressPick=value ;
                           _pickUp.clear();}

                        });
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
                      value: myAdressDrop,

                      
                      onChanged: (value) {
                        setState(() {

                          if(value==true) {

                            myAdressDrop= value ;

                            _dropOff.text = "from the data";
                          }else{myAdressDrop=value ;
                          _dropOff.clear();}
                        });
                      },
                    ),

                  ],
                ),


              ],
            ),
          ),
          const SizedBox(height: 125,),
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
                      fixedSize:MaterialStatePropertyAll(Size(300, 50)) ,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),

                          )
                      )
                  ),


                  onPressed: () {

                    BlocProvider.of<CreateDeliveryPostBloc>(context).add(PushTimeEvent(context));
                  final  String pickUpAdress = _pickUp.text ;
                  final  String dropOffAdress= _dropOff.text;
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