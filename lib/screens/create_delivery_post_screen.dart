import 'package:flutter/material.dart';

class CreateDeliveryPostScreen extends StatefulWidget {
  const CreateDeliveryPostScreen({Key? key}) : super(key: key);

  @override
  State<CreateDeliveryPostScreen> createState() => _CreateDeliveryPostScreenState();
}
//SaveDeliveryPostEvent
// String productName;
// num reward;
// DateTime startDate;
// DateTime endDate;
// Coordination destination;
// Coordination startLocation;
class _CreateDeliveryPostScreenState extends State<CreateDeliveryPostScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Delivery post '),
      centerTitle: true,),
      body: SafeArea(
        child: Column(
          children: [


          ],
        ),
      ),
    );
  }
}
