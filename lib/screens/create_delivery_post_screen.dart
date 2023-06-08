import 'package:carshop_mobile/blocs/post/post_bloc.dart';
import 'package:carshop_mobile/models/post/delivery_post.dart';
import 'package:carshop_mobile/models/post/post_model.dart';
import 'package:carshop_mobile/repositories/post_repository.dart';
import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/submit_button.dart';
import 'package:carshop_mobile/widgets/textfield_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class CreateDeliveryPostScreen extends StatefulWidget {
  const CreateDeliveryPostScreen({Key? key}) : super(key: key);

  @override
  State<CreateDeliveryPostScreen> createState() => _CreateDeliveryPostScreen();
}

class _CreateDeliveryPostScreen extends State<CreateDeliveryPostScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController rewardController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  // String? id;
  // String productName;
  // num reward;
  // DateTime startDate;
  // DateTime endDate;
  // Coordination destination;
  // Coordination startLocation;
  final _formKey = GlobalKey<FormState>();
  late PostBloc postBloc;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => PostBloc(repository: PostRepository(ApiRequest())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Delivery post'),
          centerTitle: true,
        ),
        body: Builder(
            builder: (BuildContext context) {
              postBloc = BlocProvider.of<PostBloc>(context);
              return BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if(state is PostLoadingState){
                    return UiUtilities.showLoader();
                  }
                  return SafeArea(
                    child:SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              TextFieldForm(validateError: 'Product name is required',hintText: 'Product name',controller: productNameController,),
                              const SizedBox(height: 20,),

                              TextFieldForm(validateError: 'Reward is required',hintText: 'Reward',controller: rewardController,),
                              const SizedBox(height: 20,),

                              TextFieldForm(validateError: 'End Location is required',hintText: 'End Location',controller: rewardController,),
                              const SizedBox(height: 20,),
                              pickDate('Select Start Date', startDateController, startDate),
                              const SizedBox(height: 20,),

                              pickDate('Select End Date', endDateController, startDate),
                              const SizedBox(height: 20,),
                              SubmitButton(onPress:submit,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
        ),
      ),
    );
  }

  void submit(){
    DeliveryPost deliveryPost = DeliveryPost(productName: productNameController.text, reward: int.parse(rewardController.text), startDate: startDate, endDate: endDate, destination: Coordination(latitude: 10,longitude: 10),);
    if(_formKey.currentState!.validate()){
      postBloc.add(SaveDeliveryPostEvent(deliveryPost));

    }


  }

  Future<Null> _selectDate(BuildContext context,TextEditingController controller,DateTime dateTime) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2022, 1, 1),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2100));

    setState(() {
      if (picked != null && picked != dateTime) {
        dateTime = picked;
        controller.text =
            DateFormat("EEE, MMM d, yyyy").format(dateTime);
      }
    });
  }

  Container pickDate(String hint,TextEditingController controller,DateTime dateTime) {
    return Container(
     // height: 55,
      padding: const EdgeInsets.only(top: 5,bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: GestureDetector(
        onTap: () => _selectDate(context,controller,dateTime),
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

}
