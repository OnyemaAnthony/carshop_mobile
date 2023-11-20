import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/date_picker.dart';
import 'package:carshop_mobile/widgets/place_search_box.dart';
import 'package:carshop_mobile/widgets/submit_button.dart';
import 'package:carshop_mobile/widgets/textfield_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateDeliveryPostScreen extends StatefulWidget {
  const CreateDeliveryPostScreen({Key? key, required this.currLocation})
      : super(key: key);

  final Coordination currLocation;

  @override
  State<CreateDeliveryPostScreen> createState() => _CreateDeliveryPostScreen();
}

class _CreateDeliveryPostScreen extends State<CreateDeliveryPostScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController startLocationController = TextEditingController();
  TextEditingController endLocationController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  DateTime startDate = DateTime.now().add(const Duration(days: 1));
  DateTime endDate = DateTime.now().add(const Duration(days: 2));

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
            listener: (context, state) {
              if (state is CreatedState) {
                UiUtilities.showToast(
                    message: "Your delivery post is saved",
                    toast: Toast.LENGTH_LONG);
                UiUtilities.pop(context);
              }
            },
            builder: (context, state) {
              if (state is DataLoadingState) {
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
                          PlaceSearchBox(
                            onSuggestionsSelected: (dynamic suggestion) {
                              startLocationController.text =
                                  suggestion["full_address"];
                            },
                            currLocation: widget.currLocation,
                          ),
                          PlaceSearchBox(
                            onSuggestionsSelected: (dynamic suggestion) {
                              endLocationController.text =
                                  suggestion["full_address"];
                            },
                            currLocation: widget.currLocation,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DatePicker(
                            label: 'Select Start Date',
                            initialDate: startDate,
                            onValueChanged: (DateTime start) {
                              startDate = start;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DatePicker(
                            label: 'Select End Date',
                            initialDate: endDate,
                            onValueChanged: (DateTime end) {
                              endDate = end;
                            },
                          ),
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
      CreateDeliveryPost deliveryPost = CreateDeliveryPost(
        rewardInCents: int.parse(rewardController.text).toDouble(),
        post: CreatePostDto(
            title: titleController.text,
            content: contentController.text,
            location: widget.currLocation),
        deliveryStartDate: startDate,
        deliveryEndDate: endDate,
        productName: productNameController.text,
        destination: const Coordination(lat: 10, lng: 10),
        startLocation: const Coordination(
          lat: 10,
          lng: 10,
        ),
      );
      postBloc.add(SaveDeliveryPostEvent(deliveryPost));
    }
  }

  void clear() {
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
