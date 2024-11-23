import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rider/screens/auth/login_screen.dart';
import 'package:rider/screens/home/home_screen.dart';
import 'package:rider/services/auth_services.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';
import 'package:rider/components/text_field.dart';
import 'package:rider/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 1 || value.length > 30) {
      return 'Username must be between 1 and 30 characters';
    }
    if (RegExp(r'^[._]').hasMatch(value) || RegExp(r'[._]$').hasMatch(value)) {
      return 'Username cannot start or end with a period or underscore';
    }
    if (RegExp(r'[\.\.]+').hasMatch(value)) {
      return 'Username cannot have consecutive periods';
    }
    if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, periods, and underscores';
    }
    return null;
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img == null) return;
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String? validation = validator(_usernameController.text);

    if (validation != null) {
      showSnackBar(context, validation);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    String res =
        await AuthMethods().checkAndAddUsername(_usernameController.text);

    print(res);

    if (res != 'success') {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    } else {
      String res = await AuthMethods().signUpUser(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          file: _image);
      setState(() {
        _isLoading = false;
      });
      if (res != 'success') {
        showSnackBar(context, res);
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 2, child: Container()),
          Text(
            'Register on Rider',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 30),
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64, backgroundImage: MemoryImage(_image!))
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('assets/placeholder.jpg'),
                    ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo)))
            ],
          ),
          const SizedBox(height: 30),
          TextFieldInput(
              textEditingController: _usernameController,
              textInputFormatter: LowerCaseTextFormatter(),
              textInputType: TextInputType.text,
              hintText: 'Enter your username'),
          const SizedBox(height: 24),
          TextFieldInput(
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
              hintText: 'Enter your email'),
          const SizedBox(height: 24),
          TextFieldInput(
              textEditingController: _passwordController,
              textInputType: TextInputType.visiblePassword,
              isPass: true,
              hintText: 'Enter your password'),
          const SizedBox(height: 24),
          InkWell(
            onTap: signUpUser,
            child: Container(
              width: double.infinity,
              height: 60,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: AppColors.primary),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const Text(
                      'Signup',
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text('Already have an account?'),
              ),
              GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    )));
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredText = newValue.text.replaceAll(' ', '').toLowerCase();
    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}
