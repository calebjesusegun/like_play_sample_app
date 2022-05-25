import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/components/custom_button_text.dart';
import 'package:likeplay_likeplay_chat_app/components/custom_button.dart';
import 'package:likeplay_likeplay_chat_app/components/custom_textfield_container.dart';
import 'package:likeplay_likeplay_chat_app/constants/app_colors.dart';
import 'package:likeplay_likeplay_chat_app/ui/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 50,
                  ),
                  SizedBox(
                    width: size.width / 1.1,
                    child: const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 60,
                  ),
                  SizedBox(
                    width: size.width / 1.1,
                    child: Text(
                      "Sign In to Continue!",
                      style: TextStyle(
                        letterSpacing: 1.7,
                        color: Colors.grey[500],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 25,
                  ),
                  RoundedInputField(
                    width: size.width * 0.9,
                    icon: Icons.email,
                    labelText: 'Email',
                    onChanged: (String value) {
                      viewModel.setEmail(email: value);
                    },
                  ),
                  RoundedInputField(
                    width: size.width * 0.9,
                    icon: Icons.lock,
                    labelText: 'Password',
                    onChanged: (String value) {
                      viewModel.setPassword(password: value);
                    },
                  ),
                  SizedBox(
                    height: size.height / 25,
                  ),
                  // viewModel.isLoading
                  viewModel.isBusy
                      ? Center(
                          child: SizedBox(
                            height: size.height / 20,
                            width: size.height / 20,
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      : FractionallySizedBox(
                          widthFactor: 0.94,
                          child: CustomButton(
                              color: kSecondaryColor,
                              label: 'Login',
                              onPressed: () async {
                                await viewModel.loginUser();
                                viewModel.isDismiss
                                    ? ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar()
                                    : null;
                              }),
                        ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.94,
                    child: ButtonText(
                      label: 'Create Account',
                      onPressed: () => viewModel.goToRegisterView(),
                      style: TextStyle(
                        color: Colors.black54.withOpacity(0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: isLoading
//           ? Center(
//               child: SizedBox(
//                 height: size.height / 20,
//                 width: size.height / 20,
//                 child: const CircularProgressIndicator(),
//               ),
//             )
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: size.height / 20,
//                   ),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     width: size.width / 0.5,
//                     child: IconButton(
//                         icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
//                   ),
//                   SizedBox(
//                     height: size.height / 50,
//                   ),
//                   SizedBox(
//                     width: size.width / 1.1,
//                     child: const Text(
//                       "Welcome",
//                       style: TextStyle(
//                         fontSize: 34,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: size.width / 1.1,
//                     child: Text(
//                       "Sign In to Contiue!",
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 25,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height / 10,
//                   ),
//                   Container(
//                     width: size.width,
//                     alignment: Alignment.center,
//                     child: field(size, "email", Icons.account_box, _email),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 18.0),
//                     child: Container(
//                       width: size.width,
//                       alignment: Alignment.center,
//                       child: field(size, "password", Icons.lock, _password),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height / 10,
//                   ),
//                   customButton(size),
//                   SizedBox(
//                     height: size.height / 40,
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (_) => RegistrationScreen())),
//                     child: const Text(
//                       "Create Account",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget customButton(Size size) {
//     return GestureDetector(
//       onTap: () {
//         if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
//           setState(() {
//             isLoading = true;
//           });

//           logIn(_email.text, _password.text).then((user) {
//             if (user != null) {
//               print("Login Sucessfull");
//               setState(() {
//                 isLoading = false;
//               });
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (_) => HomeScreen()));
//             } else {
//               print("Login Failed");
//               setState(() {
//                 isLoading = false;
//               });
//             }
//           });
//         } else {
//           print("Please fill form correctly");
//         }
//       },
//       child: Container(
//           height: size.height / 14,
//           width: size.width / 1.2,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.blue,
//           ),
//           alignment: Alignment.center,
//           child: const Text(
//             "Login",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           )),
//     );
//   }

//   Widget field(
//       Size size, String hintText, IconData icon, TextEditingController cont) {
//     return SizedBox(
//       height: size.height / 14,
//       width: size.width / 1.1,
//       child: TextField(
//         controller: cont,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon),
//           hintText: hintText,
//           hintStyle: const TextStyle(color: Colors.grey),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }