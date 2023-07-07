import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:ms_supplier/color.dart';
import 'package:ms_supplier/providers/supp_order_controller.dart';

class SupplierOrderModel extends StatelessWidget {
  final dynamic order;

  const SupplierOrderModel({Key? key, required this.order}) : super(key: key);

  //Method for showing the date picker
  @override
  Widget build(BuildContext context) {


    return GetBuilder<SuppOrderControllerImplement>(
      init: SuppOrderControllerImplement(context),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color:AppColor1.primaryColor),
                borderRadius: BorderRadius.circular(15)),
            child: ExpansionTile(
              title: Container(
                constraints: const BoxConstraints(maxHeight: 80),
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        constraints:
                            const BoxConstraints(maxHeight: 80, maxWidth: 80),
                        child: Image.network(order['orderimage']),
                      ),
                    ),
                    Flexible(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order['ordername'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(('\$ ') +
                                  (order['orderprice'].toStringAsFixed(2)),style: const TextStyle(
                            color: AppColor1.black
                        ),),
                              Text(('x ') + (order['orderqty'].toString()),style: const TextStyle(
                                  color: AppColor1.black
                              ),)
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('See More ..',style: TextStyle(
                      color: AppColor1.black
                    ),),
                    Text(order['deliverystatus'],style: const TextStyle(
                        color: AppColor1.black
                    ),)
                  ]),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor1.primaryColorWithShadow,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ('Name: ') + (order['custname']),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            ('Phone No.: ') + (order['phone']),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            ('Email Address: ') + (order['email']),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            ('Address: ') + (order['address']),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Row(
                            children: [
                              const Text(
                                ('Payment Status: '),
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                (order['paymentstatus']),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.purple),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                ('Delivery status: '),
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                (order['deliverystatus']),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.green),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                ('Order Date: '),
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                (DateFormat('yyyy-MM-dd')
                                    .format(order['orderdate'].toDate())
                                    .toString()),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.green),
                              ),
                            ],
                          ),
                          order['deliverystatus'] == 'delivered'
                              ? const Text('This order has been already delivered')
                              : Row(
                                  children: [
                                    const Text(
                                      ('Change Delivery Status To: '),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    order['deliverystatus'] == 'preparing'
                                        ? TextButton(
                                            onPressed: () {
                                              controller.pickDateDialog(order);

                                            },
                                            child: const Text('shipping ?'))
                                        : TextButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('orders')
                                                  .doc(order['orderid'])
                                                  .update({
                                                'deliverystatus': 'delivered',
                                              });
                                            },
                                            child: const Text('delivered ?'))
                                  ],
                                ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

// date1.DatePicker(
//   initialDate: DateTime.now(),
//   minDate: DateTime(2021, 1, 1),
//   maxDate: DateTime(2024, 12, 31),
//   onDateChanged: (date)async {
//     await FirebaseFirestore.instance
//         .collection('orders')
//         .doc(order['orderid'])
//         .update({
//       'deliverystatus': 'deliverystatus',
//       'deliverydate': date,
//     });
//   },
// );
// showDatePicker(
//        onDatePickerModeChange: (date)async
//        {
//          await FirebaseFirestore.instance
//              .collection('orders')
//              .doc(order['orderid'])
//              .update({
//            'deliverystatus': 'shipping',
//            'deliverydate': date,
//          });
//        },
//          context: context,
//          initialDate: DateTime.now(),
//          firstDate: DateTime.now(),
//          lastDate: DateTime.now().add(const Duration(days: 365))
//
//      );

// date1.DatePicker.showDatePicker(context,
//     minTime: DateTime.now(),
//     maxTime: DateTime.now().add(
//         const Duration(days: 365)),
//     onConfirm: (date) async {
//   await FirebaseFirestore.instance
//       .collection('orders')
//       .doc(order['orderid'])
//       .update({
//     'deliverystatus': 'shipping',
//     'deliverydate': date,
//   });
// });
