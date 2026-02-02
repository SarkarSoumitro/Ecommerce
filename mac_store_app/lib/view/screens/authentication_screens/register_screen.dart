import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/controller/auth_controller.dart';
import 'package:mac_store_app/view/screens/authentication_screens/login_screen.dart';

// STEP 1: CONVERTED TO A STATEFULWIDGET
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key}); // Added const constructor

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String fullname;
  late String password;
  bool _isloading = false;
  registerUser() async {
    setState(() {
      _isloading = true;
    });
    await _authController
        .signUpUsers(
          context: context,
          email: email,
          fullname: fullname,
          password: password,
        )
        .whenComplete(() {
          _formKey.currentState!.reset();
          setState(() {
            _isloading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register to your account",
                    style: GoogleFonts.getFont(
                      "Lato",
                      fontSize: 23,
                      color: const Color(0xff0d120E),
                      letterSpacing: .02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "To explore the world exclusives",
                    style: GoogleFonts.getFont(
                      "Lato",
                      fontSize: 14,
                      color: const Color(0xff0d120E),
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
                  // STEP 2: CHANGED TO TEXTFORMFIELD
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an email';
                      }
                      return null; // Return null if valid
                    },
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
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Full Name",
                      style: GoogleFonts.getFont(
                        "Nunito Sans",
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      fullname = value;
                    },
                    // CHANGED
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a name';
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
                      labelText: "Enter your name",
                      labelStyle: GoogleFonts.getFont(
                        "Nunito Sans",
                        fontSize: 14,
                        letterSpacing: 0.1,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/icons/user.jpeg",
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    // CHANGED
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
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
                      suffixIcon: const Icon(Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // STEP 3: MADE THE BUTTON CLICKABLE TO TRIGGER VALIDATION
                  GestureDetector(
                    onTap: () {
                      // This is how you use the form key
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, show a success message
                        registerUser();
                        print("registration is success");
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 319,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
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
                                    color: const Color(0XFF103DE5),
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
                                  color: const Color(0XFF2141E5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: _isloading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Sign up",
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
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already an account?",
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
                                return LoginScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF103DE5),
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
      ),
    );
  }
}
