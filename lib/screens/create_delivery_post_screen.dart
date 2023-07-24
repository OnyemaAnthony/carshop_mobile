import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/submit_button.dart';
import 'package:carshop_mobile/widgets/textfield_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CreateDeliveryPostScreen extends StatefulWidget {
  const CreateDeliveryPostScreen({Key? key}) : super(key: key);

  @override
  State<CreateDeliveryPostScreen> createState() => _CreateDeliveryPostScreen();
}

class _CreateDeliveryPostScreen extends State<CreateDeliveryPostScreen> {
  final DateFormat dateFormatter = DateFormat('yMMMEd');

  TextEditingController productNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController endLocationController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  late PostBloc postBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PostBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Delivery post'),
          centerTitle: true,
        ),

        body: Builder(builder: (BuildContext context) {
          postBloc = BlocProvider.of<PostBloc>(context);
          return BlocConsumer<PostBloc, PostState>(
            listener: (context,state){
              if(state is PostDeliveredState){
                UiUtilities.showToast(message: "Your delivery post is saved", toast: Toast.LENGTH_LONG);
                UiUtilities.pop(context);
              }
            },
            builder: (context, state) {
              if (state is PostLoadingState) {
                return UiUtilities.showLoader();
              }
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldForm(
                            validateError: 'Title name is required',
                            hintText: 'Title ',
                            controller: titleController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldForm(
                            validateError: 'Product name is required',
                            hintText: 'Product name',
                            controller: productNameController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldForm(
                            validateError: 'Reward is required',
                            hintText: 'Reward',
                            controller: rewardController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldForm(
                            validateError: 'End Location is required',
                            hintText: 'End Location',
                            controller: endLocationController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          selectDate('Select Start Date', startDateController,
                              startDate),
                          const SizedBox(
                            height: 20,
                          ),
                          selectDate(
                              'Select End Date', endDateController, endDate),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldForm(
                            validateError: 'Content is required',
                            hintText: 'Content',
                            controller: contentController,
                            maxLine: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SubmitButton(
                            text: "Create Delivery Post",
                            onPress: submit,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      CreateDeliveryPostDto deliveryPost = CreateDeliveryPostDto(
          title: titleController.text,
          content: contentController.text,
          location: Coordination(lat: 10, lng: 10),
          productName: productNameController.text,
          reward: int.parse(rewardController.text).toDouble(),
          startDate: startDate,
          endDate: endDate,
          destination: Coordination(lat: 10, lng: 10),
          startLocation: Coordination(lat: 10, lng: 10));
      postBloc.add(SaveDeliveryPostEvent(deliveryPost));
      clear();
    }
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, DateTime dateTime) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2100));

    setState(() {
      if (picked != null && picked != dateTime) {
        dateTime = picked;
        controller.text =dateFormatter.format(dateTime).toString();
      }
    });
  }

  Container selectDate(
      String hint, TextEditingController controller, DateTime dateTime) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: GestureDetector(
        onTap: () => _selectDate(context, controller, dateTime),
        child: AbsorbPointer(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              controller: controller,
              keyboardType: TextInputType.datetime,
            ),
          ),
        ),
      ),
    );
  }

  void clear(){
    productNameController.clear();
    startDateController.clear();
    endDateController.clear();
    rewardController.clear();
    endLocationController.clear();
    contentController.clear();
  }

  @override
  void dispose() {
    productNameController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    rewardController.dispose();
    endLocationController.dispose();
    contentController.dispose();
    super.dispose();
  }
}
