import 'package:carshop_mobile/blocs/create_delivery_post/create_delivery_post_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateDeliveryPostBloc>(
      create: (context) => CreateDeliveryPostBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: Column(
            children: [
              Text(
                'Budget',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  LinearProgressIndicator(
                    value: 4 / 4,
                    color: Colors.lightBlue,
                  ),
                ],
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Amount*"),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey, width: 2.0),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter estimated budget in USD',
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text("Open to offers"),
                  Spacer(),
                  Switch(
                    value: true, // Set the initial value as needed
                    onChanged: (value) {
                      // Handle the switch state change
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}