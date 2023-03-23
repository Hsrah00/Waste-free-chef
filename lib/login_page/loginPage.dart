import 'package:firebase/signup_page/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../routing/routing.dart';
import 'loginAuthorization.dart';

TextEditingController emailAddress = TextEditingController();
TextEditingController password = TextEditingController();

bool changeButton = false;

// Now login page using Rive animation

// Main Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  // var animationLink = 'images/login.riv';
  // late SMITrigger failTrigger, successTrigger; // Trigger for animation state
  // late SMIBool lookBOOL, closeEyeBOOL; // Boolean for animation state
  // Artboard? artboard; // Artboard for animation state (Rive file)
  // late StateMachineController?
  //     stateMachineController; // State machine controller for animation state which is used to control animation state
  @override
  // void initState() {
  //   super.initState();
  //   initArtboard(); // start animation process
  // }

  // // Start animation process function
  // initArtboard() {
  //   rootBundle.load(animationLink).then((value) {
  //     final file = RiveFile.import(value); // import rive file
  //     final art = file.mainArtboard; // get artboard from rive file
  //     stateMachineController = StateMachineController.fromArtboard(
  //         art, 'StateMachine')!; // get state machine controller from artboard

  //     if (stateMachineController != null) {
  //       art.addController(
  //           stateMachineController!); // add state machine controller to artboard for animation
  //     }
  //     setState(() {
  //       artboard = art; // set artboard for animation
  //     });
  //   });
  // }

  Widget build(BuildContext context) {
    LoginAuthorization loginAuth = Provider.of<LoginAuthorization>(context);
    // MediaQuery for responsive design
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // artboard for animation here

                SizedBox(
                  height: size.width,
                  width: size.height,
                  child: RiveAnimation.asset(
                    "images/login.riv",
                    stateMachines: const ["Login Machine"],
                    onInit: (artboard) {
                      controller = StateMachineController.fromArtboard(
                          artboard, "Login Machine");
                      if (controller == null) return;

                      artboard.addController(controller!);
                      isChecking = controller?.findInput("isChecking");
                      isHandsUp = controller?.findInput("isHandsUp");
                      trigSuccess = controller?.findInput("trigSuccess");
                      trigFail = controller?.findInput("trigFail");
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      SizedBox(height: 30),
                      TextFormField(
                        onChanged: ((value) {
                          if (isHandsUp != null) {
                            isHandsUp!.change(false);
                          }
                          if (isChecking == null) return;

                          isChecking!.change(true);
                        }),
                        style: TextStyle(
                          color: Color.fromARGB(255, 227, 233, 236),
                        ),
                        controller: emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 139, 13, 236),
                            // align the text to the left instead of centered
                          ),
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 139, 13, 236),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 139, 13, 236),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: ((value) {
                          if (isChecking != null) {
                            isChecking!.change(false);
                          }
                          if (isHandsUp == null) return;

                          isHandsUp!.change(true);
                        }),
                        style: TextStyle(
                          color: Color.fromARGB(255, 227, 233, 236),
                        ),
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 139, 13, 236),
                            // align the text to the left instead of centered
                          ),
                          prefixIcon: Icon(
                            Icons.remove_red_eye,
                            color: Color.fromARGB(255, 139, 13, 236),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 139, 13, 236),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 249, 241, 255),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      (loginAuth.loading == false)
                          ? MaterialButton(
                              onPressed: () {
                                //Login button on pressed validation
                                loginAuth.loginValidation(
                                    emailAddress: emailAddress,
                                    password: password,
                                    context: context);
                              },
                              child: Text("Login"),
                              color: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 139, 13, 236),
                              fontSize: 20,
                              // align the text to the left instead of centered
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                RoutingPage.goToNext(
                                    context: context, navigateTo: SignUpPage());
                              },
                              child: Text(' Signup',
                                  style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text("Forgot Password?",
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:firebase/login_page/loginAuthorization.dart';
// import 'package:firebase/signup_page/signUpPage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:rive/rive.dart';

// TextEditingController emailAddress = TextEditingController();
// TextEditingController password = TextEditingController();

// bool changeButton = false;

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   StateMachineController? controller;

//   SMIInput<bool>? isChecking;
//   SMIInput<bool>? isHandsUp;
//   SMIInput<bool>? trigSuccess;
//   SMIInput<bool>? trigFail;
// //
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     LoginAuthorization loginAuth = Provider.of<LoginAuthorization>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               //rive animation
//               SizedBox(
//                 width: size.width,
//                 height: 200,
//                 child: RiveAnimation.asset(
//                   "images/login.riv",
//                   stateMachines: const ["Login Machine"],
//                   onInit: (artboard) {
//                     controller = StateMachineController.fromArtboard(
//                         artboard, "Login Machine");
//                     if (controller == null) return;

//                     artboard.addController(controller!);
//                     isChecking = controller?.findInput("isChecking");
//                     isHandsUp = controller?.findInput("isHandsUp");
//                     trigSuccess = controller?.findInput("trigSuccess");
//                     trigFail = controller?.findInput("trigFail");
//                   },
//                 ),
//               ),

//               const SizedBox(height: 10),
//               TextField(
//                 onChanged: (value) {
//                   if (isHandsUp != null) {
//                     isHandsUp!.change(false);
//                   }
//                   if (isChecking == null) return;

//                   isChecking!.change(true);
//                 },
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   hintText: "E mail",
//                   prefixIcon: const Icon(Icons.mail),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 onChanged: (value) {
//                   if (isChecking != null) {
//                     isChecking!.change(false);
//                   }
//                   if (isHandsUp == null) return;

//                   isHandsUp!.change(true);
//                 },
//                 obscureText: true, // to hide password
//                 decoration: InputDecoration(
//                   hintText: "Password",
//                   prefixIcon: const Icon(Icons.lock),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),

//               SizedBox(
//                 width: size.width,
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SignUpPage(),
//                           ));
//                     },
//                     child: const Text(
//                       "Forgot your password?",
//                       textAlign: TextAlign.right,
//                       style: TextStyle(
//                           decoration: TextDecoration.underline,
//                           color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               (loginAuth.loading == false)
//                   ? MaterialButton(
//                       minWidth: size.width,
//                       height: 50,
//                       color: Colors.purple,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12)),
//                       onPressed: () {
//                         // todo login
//                         //Login button on pressed validation
//                         loginAuth.loginValidation(
//                             emailAddress: emailAddress,
//                             password: password,
//                             context: context);
//                       },
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     )
//                   : CircularProgressIndicator(),
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: size.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Don't you have an account?"),
//                     TextButton(
//                       onPressed: () {
//                         // todo register
//                       },
//                       child: const Text(
//                         "Register",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }