import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/controller/auth_controller.dart';
import 'package:mac_store_app/view/screens/authentication_screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String password;
  bool isLoading = false;
  loginUser() async {
    setState(() {
      isLoading = true;
    });
    await _authController
        .signInUsers(context: context, email: email, password: password)
        .whenComplete(() {
          _formkey.currentState!.reset();
          setState(() {
            isLoading = false;
          });
        });
  }

  // Added constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login your account",
                  style: GoogleFonts.getFont(
                    "Lato",
                    fontSize: 23,
                    color: Color(0xff0d120E),
                    letterSpacing: .02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "To explore the world exclusives",
                  style: GoogleFonts.getFont(
                    "Lato",
                    fontSize: 14,
                    color: Color(0xff0d120E),
                    letterSpacing: .02,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Image.asset('assets/images/Illustration.png'),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: GoogleFonts.getFont(
                      "Nunito Sans",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                // FIXED THE SYNTAX ERROR HERE
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  // Changed to TextFormField
                  validator: (value) {
                    // Added a valid (but empty) validator function
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  }, // Added comma
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: "Enter your email",
                    labelStyle: GoogleFonts.getFont(
                      "Nunito Sans",
                      fontSize: 14,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/icons/email.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Password",
                    style: GoogleFonts.getFont(
                      "Nunito Sans",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                // ALSO FIXED FOR THE SECOND FIELD
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  // Changed to TextFormField
                  validator: (value) {
                    // Added a valid (but empty) validator function
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: "Enter your password",
                    labelStyle: GoogleFonts.getFont(
                      "Nunito Sans",
                      fontSize: 14,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/icons/password.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    suffixIcon: Icon(Icons.visibility),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      loginUser();
                      print("Login successfully");
                    } else {
                      print("Failed");
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 319,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 270,
                          top: 18,
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              height: 60,
                              width: 60,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 12,
                                  color: Color(0XFF103DE5),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 260,
                          top: 29,
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              height: 10,
                              width: 10,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                border: Border.all(width: 3),
                                color: Color(0XFF2141E5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Sign in",
                                  style: GoogleFonts.getFont(
                                    "Lato",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Need an account?",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.roboto(
                          color: Color(0xFF103DE5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
