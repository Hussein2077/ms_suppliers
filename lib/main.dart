import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ms_supplier/color.dart';
import 'package:ms_supplier/utilities/app_routes.dart';
import 'package:ms_supplier/utilities/routes.dart';

import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform

  );

  runApp(  const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
theme: ThemeData(
  primaryColor: AppColor1.primaryColor,
),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.welcomeScreen,
      routes: routes
    );
  }
}
