import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notice_board/utils/const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.88,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset("./assets/board_bell_icon.svg",
                    height: MediaQuery.of(context).size.height * 0.16),
                Text("Notice Board", style: TextStyle(fontSize: 30)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("Please Log in",
                            style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("User ID",
                                style: TextStyle(
                                  fontFamily: "Outfit",
                                )),
                            SizedBox(height: 6),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (RegExp(r"\s").hasMatch(value)) {
                                  return 'email can\'t have white spaces';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: false,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffC2C2C2)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Emp. User Id',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Password",
                                style: TextStyle(
                                  fontFamily: "Outfit",
                                )),
                            SizedBox(height: 6),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (RegExp(r"\s").hasMatch(value)) {
                                  return 'password cant have white spaces';
                                }
                                return null;
                              },
                              obscureText: isObscureText,
                              decoration: InputDecoration(
                                hintText: "password",
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffC2C2C2)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {}
                            },
                            child: Text("SIGN IN",
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PRIMARY_COLOR,
                              minimumSize: Size(double.infinity, 50.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
