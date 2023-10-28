import 'package:carshop_mobile/blocs/my_activities/bloc/my_activities_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyActivitiesScreen extends StatelessWidget {
  const MyActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyActivitiesBloc()..add(const GetMyActivitiesEvent()),
      child: BlocConsumer<MyActivitiesBloc, MyActivitiesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Activities"),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: 0, //state.activities.length,
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text("You created a activity with id:"),
                  subtitle: Text(
                      "doesn't exist lol"), //state.activities[index].postOrCommentId.toString()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
