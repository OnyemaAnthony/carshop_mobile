import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final ScrollController? controller;
   CommentScreen({Key? key,this.controller}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}
final countries = ['Albania', 'Andorra', 'Armenia', 'Austria',
'Azerbaijan', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria',
'Croatia', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus', 'Cyprus'];


class _CommentScreenState extends State<CommentScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 3000,
      child: ListView.builder(
        controller:widget.controller,
        itemCount: countries.length,
        itemBuilder: (context,index){
          return Text(countries[index],style: TextStyle(fontSize: 20),);
        },
      ),
    );
    // return  Stack(
    //   alignment: AlignmentDirectional.topCenter,
    //   clipBehavior: Clip.none,
    //   children: [
    //     Positioned(
    //       top: -12,
    //       child: Container(
    //         width: 60,
    //         height: 5,
    //         margin: const EdgeInsets.only(bottom: 20),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(5),
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //     Column(children: [
    //       const SizedBox(
    //         height: 20,
    //       ),
    //
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       const Center(
    //         child: Text(
    //           'OR',
    //           style: TextStyle(fontSize: 18),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 30,
    //       ),
    //
    //       const SizedBox(
    //         height: 14,
    //       ),
    //
    //     ])
    //   ],
    // );
  }
}
