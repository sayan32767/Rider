import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rider/screens/auth/signup_screen.dart';
import 'package:rider/screens/home/home_screen.dart';
import 'package:rider/services/auth_services.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';
import 'package:rider/components/text_field.dart';
import 'package:rider/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;
    String res =
        await AuthMethods().loginUser(email: email, password: password);
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

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignupScreen()));
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
          Flexible(flex: 1, child: Container()),
          SvgPicture.asset(
            'assets/rider.svg',
            height: 128,
            color: Colors.grey[400],
          ),
          SizedBox(height: 10),
          Text(
            'Rider',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 45),
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
            onTap: loginUser,
            child: Container(
              height: 60,
              width: double.infinity,
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
                      'Login',
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
                child: Text('Don\'t have an account?'),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                onTap: navigateToSignup,
                child: Container(
                  child: Text(
                    'Signup',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                ),
              )
            ],
          )
        ],
      ),
    )));
  }
}
