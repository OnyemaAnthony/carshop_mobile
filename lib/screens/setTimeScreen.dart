import 'package:flutter/material.dart';


class SetTimeScreen extends StatefulWidget {

  @override
  _SetTimeScreenState createState() => _SetTimeScreenState();
}
DateTime now = DateTime.now();

class _SetTimeScreenState extends State<SetTimeScreen> {
  bool neededAsap = false;

late Future<DateTime> selectedDate;
String? initialDate = now.day.toString()+":"+now.month.toString()+":"+now.year.toString();

  late Future<TimeOfDay> selectedTime;
  String time = "${TimeOfDay.now()}";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        forceMaterialTransparency: true,
        title: const Column(
          children: [
            Text('Schedule ',
              style: TextStyle(fontSize: 20,),
            ),
            Column(
              children: [
                LinearProgressIndicator(
                  value: 3/4,

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
              const  Text(
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
           const  SizedBox(height: 20),
             Row(
              children: [
               const  Text(
                  'Date ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 50,),
                ElevatedButton(onPressed:(){ showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));} ,
                    child: Text ("$initialDate" )
                ),

              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Time ',
              style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 50,),
                ElevatedButton(onPressed:(){
                  showTimePicker(context: context, initialTime: TimeOfDay.now());} ,
                    child: Text (time)
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

}
