import 'package:badges/badges.dart'as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_supplier/color.dart';
import 'package:ms_supplier/main_screens/category.dart';
import 'package:ms_supplier/main_screens/dashboard.dart';
import 'package:ms_supplier/main_screens/home.dart';
import 'package:ms_supplier/main_screens/stores.dart';
import 'package:ms_supplier/main_screens/upload_product.dart';
import 'package:ms_supplier/providers/nav_bar_suppliers_controller.dart';

class SupplierHomeScreen extends StatelessWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);

  final List<Widget> tabs = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),

    UploadProductScreen(),
    DashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(SupplierControllerImplement());
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('deliverystatus', isEqualTo: 'preparing')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(color: AppColor1.primaryColor,),
              ),
            );
          }

          return GetBuilder<SupplierControllerImplement>(
              init: SupplierControllerImplement(),
              builder: (controller)=>Scaffold(
            body: tabs[controller.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              selectedItemColor: Colors.black,
              currentIndex: controller.selectedIndex,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Category',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.shop),
                  label: 'Stores',
                ),

                const BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: 'Upload',
                ),
                BottomNavigationBarItem(
                  icon:badges.Badge(
                      showBadge: snapshot.data!.docs.isEmpty ? false : true,

                      badgeStyle: const badges.BadgeStyle(
                        padding: EdgeInsets.all(2),
                        badgeColor: Colors.yellow,
                      ),
                      badgeContent: Text(
                        snapshot.data!.docs.length.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      child: const Icon(Icons.dashboard)),
                  label: 'Dashboard',
                ),
              ],
              onTap: (index) {
               controller.next(index);
              },
            ),
          ));
        });
  }
}
