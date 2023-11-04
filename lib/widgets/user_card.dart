import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final AuthenticatedUserDescriptor? user;

  const UserCard({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Text("${user?.firstName} ${user!.lastName}");
  }
}
