import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources_backend/auth.dart';
import 'package:instagram/responsive/Mobileversion.dart';
import 'package:instagram/responsive/Webscreenversion.dart';
import 'package:instagram/responsive/responsive_screen.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utility/storing.dart';
import 'package:instagram/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isLoading = false;
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
    }

    // if (res != 'success') {
    //   showSnackBar(context, res);
    // }
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Responsive(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),

              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.teal,
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://www.w3schools.com/w3images/avatar6.png'),
                          backgroundColor: Colors.teal,
                        ),
                  Positioned(
                      bottom: -19,
                      left: 55,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo)))
                ],
              ),

              //Image.asset('assets/images/insta_logo.png'),

              //svg image
              //username input
              SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
              TextFieldInput(
                hinText: 'Username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
              const SizedBox(height: 10),
              // Flexible(
              //   child: Container(),
              //   flex: 1,
              // ),
              //bio input
              TextFieldInput(
                hinText: 'Email ',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
              const SizedBox(height: 10),
              // Flexible(
              //   child: Container(),
              //   flex: 1,
              // ),
              //
              //input email

              TextFieldInput(
                hinText: 'New Password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
              const SizedBox(height: 10),
              // Flexible(
              //   child: Container(),
              //   flex: 1,
              // ),
              TextFieldInput(
                hinText: 'Bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),

              //input password
              const SizedBox(height: 10),
              //bottom login
              InkWell(
                onTap: signUpUser,
                // onTap: () async {

                // },
                child: Container(
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
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              const SizedBox(height: 10),

              // Container(
              //   child: Text(
              //     'Forgot password?',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Flexible(
                flex: 1,
                child: Container(),
              ),

              GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blue,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),

              //transition
            ],
          ),
        ),
      ),
    );
  }
}
