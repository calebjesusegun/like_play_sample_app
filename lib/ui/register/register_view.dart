import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/components/custom_button_text.dart';
import 'package:likeplay_likeplay_chat_app/components/custom_button.dart';
import 'package:likeplay_likeplay_chat_app/components/custom_textfield_container.dart';
import 'package:likeplay_likeplay_chat_app/constants/app_colors.dart';
import 'package:likeplay_likeplay_chat_app/ui/register/register_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: kGray20,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24, top: 10),
            child: RawMaterialButton(
              onPressed: () => viewModel.goToLoginView(),
              elevation: 0.0,
              fillColor: kSecondaryColor20,
              child: const Icon(
                Icons.chevron_left,
                size: 24.0,
                color: kSecondaryColor,
              ),
              padding: const EdgeInsets.all(4.0),
              shape: const CircleBorder(),
            ),
          ),
          // centerTitle: ,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 50,
                ),
                SizedBox(
                  width: size.width / 1.1,
                  child: const Text(
                    "Sign Up",
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
                    "Register today for free access!",
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
                  icon: Icons.person,
                  labelText: 'Name',
                  onChanged: (String value) {
                    viewModel.setName(name: value);
                  },
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
                            label: 'Create Account',
                            onPressed: () async {
                              await viewModel.createUser();
                              viewModel.isDismiss
                                  ? ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar()
                                  : null;
                              // !viewModel.isLoading
                              //       ? ScaffoldMessenger.of(context)
                              //           .showSnackBar(SnackBar(
                              //           content: const Text(
                              //             'Invalid Login Credentials!',
                              //             style: TextStyle(fontSize: 15),
                              //           ),
                              //           duration: const Duration(seconds: 5),
                              //           backgroundColor: Colors.red.shade600,
                              //           action: SnackBarAction(
                              //             textColor: kWhite,
                              //             label: 'Dismiss',
                              //             onPressed: () {
                              //               // Hide the snackbar before its duration ends
                              //               ScaffoldMessenger.of(context)
                              //                   .hideCurrentSnackBar();
                              //             },
                              //           ),
                              //         ))
                              //       : null;
                            }),
                      ),
                SizedBox(
                  height: size.height / 40,
                ),
                FractionallySizedBox(
                  widthFactor: 0.94,
                  child: ButtonText(
                    label: 'Login',
                    onPressed: () => viewModel.goToLoginView(),
                    style: TextStyle(
                      color: Colors.black54.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () => Navigator.of(context)
                //       .push(MaterialPageRoute(builder: (_) => RegisterView())),
                //   child: const Text(
                //     "Create Account",
                //     style: TextStyle(
                //       color: Colors.blue,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
