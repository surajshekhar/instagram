import 'package:flutter/material.dart';
import 'package:instagram/responsive/Mobileversion.dart';
import 'package:instagram/responsive/Webscreenversion.dart';
import 'package:instagram/responsive/responsive_screen.dart';
import 'package:instagram/screens/SignUp_screen.dart';
import 'package:instagram/utility/storing.dart';
import 'package:instagram/widgets/text_field.dart';
import 'package:instagram/resources_backend/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool _isLoading = false;

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
    }

    void loginUser() async {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (res == "success") {
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const Responsive(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                ),
              ),
              (route) => false);
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        showSnackBar(context, res);
      }
      setState(() {
        _isLoading = false;
      });
    }

    void navigateToSignup() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Image.asset('assets/images/insta_logo.png'),
              Flexible(
                child: Container(),
                flex: 2,
              ),

              //svg image
              //input email
              TextFieldInput(
                hinText: 'Username,email or mobile number',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(height: 15),
              TextFieldInput(
                hinText: 'Password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //input password
              const SizedBox(height: 15),
              //bottom login
              InkWell(
                onTap: loginUser,
                child: Expanded(
                  child: Container(
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Log in',
                            style: TextStyle(color: Colors.white),
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(17),
                        ),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),

              GestureDetector(
                onTap: navigateToSignup,
                child: Expanded(
                  child: Container(
                    child: Text(
                      'Create new account',
                      style: TextStyle(
                        color: Colors.blue,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(17),
                      ),
                    ),
                  ),
                ),
              ),

              //transition
            ],
          ),
        ),
      ),
    );
  }
}
