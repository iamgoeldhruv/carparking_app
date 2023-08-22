import 'package:flutter/material.dart';
import 'package:dash_insta/widgets/text-field-input.dart';
import 'package:dash_insta/UI/login-screen.dart';
import 'package:dash_insta/UI/register-screen.dart';
import 'package:flutter/material.dart';
import 'package:dash_insta/widgets/text-field-input.dart';
import 'package:dash_insta/UI/login-screen.dart';
import 'package:dash_insta/UI/register-screen.dart';
import 'package:dash_insta/database/userauth.dart';
import 'package:dash_insta/utils/utils.dart';
import 'package:dash_insta/UI/dashboard.dart';





class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void loginUser() async{
        setState(() {
      _isLoading = true;
        });
        UserAuth userAuth = UserAuth(); // Create an instance of UserAuth
        String res = await userAuth.loginUser(
         
          email: _emailController.text,
          password: _passwordController.text,
          
          );
          if(res=='success'){
             Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage())
             );

          }
        
          else if(res!='success'){
            showSnackBar(res,context);
          }
          
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginuilogo.avif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFieldInput(
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFieldInput(
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: InkWell(
              onTap:loginUser,
              child: Container(
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromARGB(255, 26, 81, 126),
                ),
              ),
            ),
          ),
          const SizedBox(height: 156),
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
                    
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                    primary: Colors.blue,
                    elevation: 0,
                  ),
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
          // Add other widgets or controls as needed
        ],
      ),
    );
  }
}
