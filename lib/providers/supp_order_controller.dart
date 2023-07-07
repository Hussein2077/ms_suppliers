
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class SuppOrderController extends GetxController {
  pickDateDialog(dynamic order);
}
class SuppOrderControllerImplement extends SuppOrderController{

 final BuildContext context;
 SuppOrderControllerImplement(this.context);
  late DateTime selectedDate;
  @override
  void pickDateDialog(dynamic order) async{
    showDatePicker(
        context:context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(2023),
        //what will be the previous supported year in picker
        lastDate: DateTime(2025)) //what will be the up to supported date in picker
        .then((pickedDate) async {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }

      //for rebuilding the ui
      selectedDate = pickedDate;
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(order['orderid'])
          .update({
        'deliverystatus': 'shipping',
        'deliverydate': selectedDate.toString(),
      });
      update();
    });
    update();
  }



}