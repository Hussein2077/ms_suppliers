import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_supplier/color.dart';
import 'package:ms_supplier/dashboard_components/edit_business.dart';
import 'package:ms_supplier/dashboard_components/manage_products.dart';
import 'package:ms_supplier/dashboard_components/supplier_balance.dart';
import 'package:ms_supplier/dashboard_components/supplier_orders.dart';
import 'package:ms_supplier/dashboard_components/supplier_statics.dart';
import 'package:ms_supplier/imageassets.dart';
import 'package:ms_supplier/minor_screens/visit_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auht_repo.dart';
import '../widgets/alert_dialog.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics'
];

List<IconData> icons = [
  Icons.store,
  Icons.shopping_bag,
  Icons.edit,
  Icons.settings,
  Icons.attach_money_outlined,
  Icons.show_chart,
  Icons.logout,
];

List<Widget> pages = [
  VisitStore(suppId: FirebaseAuth.instance.currentUser!.uid),
  const SupplierOrders(),
  const EditBusiness(),
  ManageProducts(),
  const Balance(),
  const Statics(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .35,
                  ),
                  Image.asset(
                    AppImageAsset.logo2,
                  ),
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {
                      MyAlertDilaog.showMyDialog(
                          context: context,
                          title: 'Log Out',
                          content: 'Are you sure to log out ?',
                          tabNo: () {
                            Navigator.pop(context);
                          },
                          tabYes: () async {
                            await AuthRepo.logOut();
                            final SharedPreferences pref = await prefs;
                            pref.setString('supplierid', '');
                            await Future.delayed(
                                    const Duration(microseconds: 100))
                                .whenComplete(() {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                  context, '/welcome_screen');
                            });
                          });
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Log out',
                          style: TextStyle(
                            color: AppColor1.black,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.logout,
                          color: AppColor1.black,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 40,
                  crossAxisSpacing: 40,
                  crossAxisCount: 2,
                  children: List.generate(pages.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => pages[index]));
                          },
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              backgroundColor: AppColor1.primaryColor,
                              radius: 35,
                              // elevation: 20,
                              // shadowColor: Colors.purpleAccent.shade200,
                              // color: Colors.blueGrey.withOpacity(0.7),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    icons[index],
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  // Text(
                                  //   label[index].toUpperCase(),
                                  //   style: const TextStyle(
                                  //       fontSize: 16,
                                  //       color: Colors.yellowAccent,
                                  //       fontWeight: FontWeight.w600,
                                  //       letterSpacing: 2,
                                  //       fontFamily: 'Acme'),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          maxLines: 1,
                          label[index].toUpperCase(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
