
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire_mobile/models/reservation_model/reservation_model.dart';
import 'package:memoire_mobile/modules/classrooms/cubit/add_cubit.dart';
import 'package:memoire_mobile/modules/classrooms/cubit/add_states.dart';
import 'package:memoire_mobile/shared/components/mobile_components.dart';

import '../../shared/components/mobile_constants.dart';

/*class AddReservation extends StatefulWidget {

  @override
  State<AddReservation> createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  //const AddReservation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AddCubit,AddStates>(listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.green,),
        body: SingleChildScrollView(
          padding:const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          'Choose a class name',
                          style: TextStyle(fontSize: 14),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                        buttonHeight: 60,
                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        items:items
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender.';
                          }
                        },
                        onChanged: (value) {
                          print(value);
                          //selectedValue=value.toString();
                        },
                      ),
                      const SizedBox(height: 25.0,),
                      customText(text: '  Goal'),
                      const SizedBox(height: 15,),
                      customTextField(
                        maxLines: 4,
                          controller: reservationGoal,
                          label: '',
                          textInputType: TextInputType.text),
                      verticalSizedBox(15.0),
                      customUpdateItem(context, controller: reservationTime,onPressed: (){
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) =>
                        reservationTime.text = value!.format(context).toString());
                      }),
                      verticalSizedBox(15.0),
                      customUpdateItem(context, controller: reservationDate,onPressed: (){
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050))
                            .then((value) =>
                        reservationDate.text =
                            DateFormat.yMMMd()
                                .format(value!));
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
      },);
  }
}*/
