import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/create_delivery_post/create_delivery_post_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetScreen extends StatelessWidget {
  final _budgetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CreateDeliveryPostBloc bloc =
        BlocProvider.of<CreateDeliveryPostBloc>(context);

    return BlocConsumer<CreateDeliveryPostBloc, CreateDeliveryPostState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              forceMaterialTransparency: true,
              title: const Column(
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
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Amount*"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ),
                        child: TextField(
                          controller: state.budget,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Enter estimated budget in USD',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text("Open to offers"),
                        const Spacer(),
                        Switch(
                          value: state.openToOffers?? false ,
                          onChanged: (value) {
                            bloc.add(SwitchOpenToOffersEvent(newValue: value));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
              child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize: const MaterialStatePropertyAll(Size(350, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  bloc.add(SaveDeliveryPostEvent(CreateDeliveryPost(taskTitle: state.title, taskDescription: state.description,
                    dropOffAddress: state.dropOffAddress.toString(), pickUpAddress: state.pickUpAddress.toString(),
                      time: state.time,date: state.date,budget: state.budget.toString()
                  )
                  )
                  );
                },
                child: const Text(
                  'Share Post',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });
  }
}
