
import 'package:flutter/material.dart';
import 'package:ms_supplier/auth/supplier_login.dart';
import 'package:ms_supplier/auth/supplier_signup.dart';
import 'package:ms_supplier/main_screens/supplier_home.dart';
import 'package:ms_supplier/main_screens/welcome_screen.dart';
import 'package:ms_supplier/utilities/routes.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  //auth
  AppRoutes.welcomeScreen:(context)=>const WelcomeScreen(),
  AppRoutes.supplierHomeScreen:(context)=>const SupplierHomeScreen(),
  AppRoutes.supplierRegister:(context)=>const SupplierRegister(),
  AppRoutes.supplierLogin:(context)=>const SupplierLogin(),
};
