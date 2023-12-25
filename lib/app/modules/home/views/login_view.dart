import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as models;
import 'package:flipcard_game/app/modules/home/views/home_view.dart';
import 'package:flipcard_game/app/modules/home/views/register_view.dart';
import 'package:flipcard_game/app/modules/home/widgets/my_button.dart';
import 'package:flipcard_game/app/modules/home/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final client = Appwrite.Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6588d8c1031e28eb430e');
final account = Appwrite.Account(client);

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isLoggedIn', value);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  void signUserIn() async {
    final SharedPreferences prefs = await _prefs;
    try {
      final models.Session response = await account.createEmailSession(
        email: emailController.text,
        password: passwordController.text,
      );
      prefs.setString('userId', response.userId);
      final String storedUserId = prefs.getString('userId') ?? "";

      if (response.userId == storedUserId) {
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
        setLoggedIn(true);

        Get.to(() => HomeView());

        Get.snackbar(
          "Login Success",
          "Welcome to the app!",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
      } else {
        print("Result type: ${response.runtimeType}");
        print("Error during login: ${response}");
        Get.snackbar(
          "Login Error",
          "There was an error during login. Please check your Email and Password.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("Error during login: $e");
      Get.snackbar(
        "Login Error",
        "There was an error during login. Please check your Email and Password.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Image(
                    image: AssetImage('lib/app/assets/mc.png'),
                    width: 150.0,
                    height: 200.0,
                  ),
                  Text(
                    'Ayo Segera Main & Belajar Bersama!!',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    key: Key('emailTextField'),
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (!value.contains('@')) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    key: Key('passwordTextField'),
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) => value!.length < 8
                        ? "Password must be at least 8 characters"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyButton(
                    key: Key('loginButton'),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        signUserIn();
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset(
                              "lib/app/assets/google.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Aksi ketika gambar kedua diklik
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset(
                              "lib/app/assets/apple.png",
                              width: 40, // Atur lebar gambar
                              height: 40, // Atur tinggi gambar
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You don't have account yet?",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => RegisterView());
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
