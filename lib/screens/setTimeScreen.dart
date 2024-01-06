import 'package:carshop_mobile/blocs/create_delivery_post/create_delivery_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SetTimeScreen extends StatefulWidget {
  @override
  _SetTimeScreenState createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  bool neededAsap = false;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  late Future<DateTime> selectedDate;
  String? initialDate =
  DateFormat('MMMM dd, yyyy').format(DateTime.now()); // Updated format


  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateDeliveryPostBloc(),
      child: Scaffold(
        appBar: AppBar(centerTitle: true,
          forceMaterialTransparency: true,
          title: const Column(
            children: [
               Text('Schedule',
                style: TextStyle(fontSize: 20,),
              ),
                SizedBox(height: 20,),
              Column(
                children: [
                  LinearProgressIndicator(
                    value: 3/4,
                    color: Colors.lightBlue,

                  ),
                ],
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Needed as Soon as Possible',
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: neededAsap,
                    onChanged: (value) {
                      setState(() {
                        neededAsap = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                const  Text(
                    'Date ',
                    style: TextStyle(fontSize: 16),
                  ),
                 const  Spacer(),
                  Container(
                    color: Colors.grey[100],
                    width: 150, // Adjust the width as needed
                    child: TextField(
                      style: TextStyle(fontSize: 10, color: Colors.black),
                      controller: _dateController,
                      readOnly: true,
                      onTap: () {
                        _selectDate();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              const    Text(
                    'time ',
                    style: TextStyle(fontSize: 16),
                  ),
                const  Spacer(),
                  Container(
                    color: Colors.grey[100],
                    width: 150, // Adjust the width as needed
                    child: TextField(
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                      controller: _timeController,
                      readOnly: true,
                      onTap: () {
                        _selectTime();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 330,),
              Center(
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
                    BlocProvider.of<CreateDeliveryPostBloc>(context)
                        .add(
                        const OpenNextPageEvent(pageNum: 3 / 4));
                    BlocProvider.of<CreateDeliveryPostBloc>(context)
                        .add(
                        PushBudgetEvent(context));
                  },
                  child: const Text('Input your budge',
                    style: TextStyle(color: Colors.white),),
                ),
              ),

            ],

          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      String formattedDate = DateFormat('MMMM dd, yyyy').format(_picked);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null) {
      String formattedTime =
      DateFormat('HH:mm').format(
          DateTime(2022, 1, 1, picked.hour, picked.minute));
      setState(() {
        _timeController.text = formattedTime;
        _timeOfDay = picked;
      });
    }
  }
}

