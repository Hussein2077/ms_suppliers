// import 'dart:math';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_store_app/widgets/yellow_button.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
//
// const textColors = [
//   Colors.yellowAccent,
//   Colors.red,
//   Colors.blueAccent,
//   Colors.green,
//   Colors.purple,
//   Colors.teal
// ];
//
// const textStyle =
//     TextStyle(fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'Acme');
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   bool processing = false;
//   CollectionReference anonymous =
//       FirebaseFirestore.instance.collection('anonymous');
//   late String _uid;
//
//   @override
//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(seconds: 2));
//     _controller.repeat();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('images/inapp/bgimage.jpg'),
//                 fit: BoxFit.cover)),
//         constraints: const BoxConstraints.expand(),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             // crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               AnimatedTextKit(
//                 animatedTexts: [
//                   ColorizeAnimatedText(
//                     'WELCOME',
//                     textStyle: textStyle,
//                     colors: textColors,
//                   ),
//                   ColorizeAnimatedText(
//                     'Duck Store',
//                     textStyle: textStyle,
//                     colors: textColors,
//                   )
//                 ],
//                 isRepeatingAnimation: true,
//                 repeatForever: true,
//               ),
//               const SizedBox(
//                 height: 120,
//                 width: 200,
//                 child: Image(image: AssetImage('images/inapp/logo.jpg')),
//               ),
//               SizedBox(
//                 height: 80,
//                 child: DefaultTextStyle(
//                   style: const TextStyle(
//                       fontSize: 45,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.lightBlueAccent,
//                       fontFamily: 'Acme'),
//                   child: AnimatedTextKit(
//                     animatedTexts: [
//                       RotateAnimatedText('Buy'),
//                       RotateAnimatedText('Shop'),
//                       RotateAnimatedText('Duck Store'),
//                     ],
//                     repeatForever: true,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Container(
//                         decoration: const BoxDecoration(
//                             color: Colors.white38,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(50),
//                                 bottomLeft: Radius.circular(50))),
//                         child: const Padding(
//                           padding: EdgeInsets.all(12.0),
//                           child: Text(
//                             'Suppliers only',
//                             style: TextStyle(
//                                 color: Colors.yellowAccent,
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 6,
//                       ),
//                       Container(
//                         height: 60,
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         decoration: const BoxDecoration(
//                             color: Colors.white38,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(50),
//                                 bottomLeft: Radius.circular(50))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             AnimatedLogo(controller: _controller),
//                             YellowButton(
//                                 label: 'Log In',
//                                 onPressed: () {
//                                   Navigator.pushReplacementNamed(
//                                       context, '/supplier_login');
//                                 },
//                                 width: 0.25),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: YellowButton(
//                                   label: 'Sign Up',
//                                   onPressed: () {
//                                     Navigator.pushReplacementNamed(
//                                         context, '/supplier_signup');
//                                   },
//                                   width: 0.25),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 60,
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     decoration: const BoxDecoration(
//                         color: Colors.white38,
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(50),
//                             bottomRight: Radius.circular(50))),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8),
//                           child: YellowButton(
//                               label: 'Log In',
//                               onPressed: () {
//                                 Navigator.pushReplacementNamed(
//                                     context, '/customer_login');
//                               },
//                               width: 0.25),
//                         ),
//                         YellowButton(
//                             label: 'Sign Up',
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(
//                                   context, '/customer_signup');
//                             },
//                             width: 0.25),
//                         AnimatedLogo(controller: _controller),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 25),
//                 child: Container(
//                   decoration:
//                       BoxDecoration(color: Colors.white38.withOpacity(0.3)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       GoogleFacebookLogIn(
//                         label: 'Google',
//                         onPresssed: () {},
//                         child: const Image(
//                             image: AssetImage('images/inapp/google.jpg')),
//                       ),
//                       GoogleFacebookLogIn(
//                         label: 'Facebook',
//                         onPresssed: () {},
//                         child: const Image(
//                             image: AssetImage('images/inapp/facebook.jpg')),
//                       ),
//                       processing == true
//                           ? const CircularProgressIndicator()
//                           : GoogleFacebookLogIn(
//                               label: 'Guest',
//                               onPresssed: () async {
//                                 setState(() {
//                                   processing = true;
//                                 });
//                                 await FirebaseAuth.instance
//                                     .signInAnonymously()
//                                     .whenComplete(() async {
//                                   _uid = FirebaseAuth.instance.currentUser!.uid;
//                                   await anonymous.doc(_uid).set({
//                                     'name': '',
//                                     'email': '',
//                                     'profileimage': '',
//                                     'phone': '',
//                                     'address': '',
//                                     'cid': _uid
//                                   });
//                                 });
//
//                                 await Future.delayed(
//                                         const Duration(microseconds: 100))
//                                     .whenComplete(() =>
//                                         Navigator.pushReplacementNamed(
//                                             context, '/customer_home'));
//                               },
//                               child: const Icon(
//                                 Icons.person,
//                                 size: 55,
//                                 color: Colors.lightBlueAccent,
//                               ))
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AnimatedLogo extends StatelessWidget {
//   const AnimatedLogo({
//     Key? key,
//     required AnimationController controller,
//   })  : _controller = controller,
//         super(key: key);
//
//   final AnimationController _controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller.view,
//       builder: (context, child) {
//         return Transform.rotate(
//           angle: _controller.value * 2 * pi,
//           child: child,
//         );
//       },
//       child: const Image(image: AssetImage('images/inapp/logo.jpg')),
//     );
//   }
// }
//
// class GoogleFacebookLogIn extends StatelessWidget {
//   final String label;
//   final Function() onPresssed;
//   final Widget child;
//   const GoogleFacebookLogIn(
//       {Key? key,
//       required this.child,
//       required this.label,
//       required this.onPresssed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: InkWell(
//         onTap: onPresssed,
//         child: Column(
//           children: [
//             SizedBox(height: 50, width: 50, child: child),
//             Text(
//               label,
//               style: const TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:ms_supplier/color.dart';
import 'package:ms_supplier/providers/welcome_controller.dart';
import 'package:ms_supplier/utilities/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../widgets/auth_widgets.dart';
import '../widgets/custom_botton.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: AppColor1.black,
//       //   elevation: 0,
//       // ),
//       body: Column(
//         children: [
//           Image.asset(
//             AppImageAsset.welcomeScreenImage,
//           ),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               color: AppColor1.backgroundcolor,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   MyButton(
//                     onPressed: () {
//                       Navigator.pushReplacement<void, void>(
//                         context,
//                         MaterialPageRoute<void>(
//                           builder: (BuildContext context) => const CustomerLogin(),
//                         ),
//                       );
//                     },
//                     buttonText: 'Login',
//                     color: AppColor1.black,
//                     textColor: AppColor1.backgroundcolor,
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   MyButton(
//                     onPressed: () {
//                       Navigator.pushReplacementNamed(context, AppRoutes.supplierRegister);
//                     },
//                     buttonText: 'Register as a Seller',
//                     color: AppColor1.primaryColor,
//                     textColor: Colors.white,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           // Container(
//           //   height: MediaQuery.of(context).size.height * .52,
//           //   color: Colors.black,
//           // )
//         ],
//       ),
//     );
//   }
// }
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final Future<SharedPreferences> _prefs  = SharedPreferences.getInstance();

@override
  void initState() {



  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Get.put(WelcomeControllerImplement());
    double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return GetBuilder<WelcomeControllerImplement>(
      init: WelcomeControllerImplement(),
      builder: (controller) {
        return Scaffold(

          body: Center(
            child: Column(
              children: [
                SizedBox(height: h*.3),
            logo(h*.25),
                SizedBox(height: h*.1),
                CustomButton(label: 'Login as Supplier',onTap: (){
                  // Get.toNamed(AppRoutes.login);
                  // Navigator.pushReplacement<void, void>(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) => const CustomerLogin(),
                  //   ),
                  // );
                  controller.supplierId !=''?  Get.offAllNamed(AppRoutes.supplierHomeScreen):
                  Get.offAllNamed(AppRoutes.supplierLogin);
                },),
                SizedBox(height: h*.01),
                customSignUp(context),
              ],
            ),
          ),
        );
      }
    );
  }
}

Widget customSignUp(BuildContext context) {
  return InkWell(
    onTap: () {
      // Navigator.pushReplacement<void, void>(
      //   context,
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) => const CustomerLogin(),
      //   ),
      // );
      Get.toNamed(AppRoutes.supplierRegister);
    },
    child: Container(
      height: 43,
      width: 282,
      decoration: BoxDecoration(
          color: AppColor1.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor1.primaryColor)),
      child: const Center(
        child: Text(
          'Sign up as a Supplier',
          style: TextStyle(
            fontSize: 16,
            color: AppColor1.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
