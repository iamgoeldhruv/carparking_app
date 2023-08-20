import 'package:flutter/material.dart';
import 'package:dash_insta/widgets/text-field-input.dart';
import 'package:dash_insta/UI/login-screen.dart';
import 'package:dash_insta/UI/register-screen.dart';
import 'package:dash_insta/database/userauth.dart';
import 'package:dash_insta/utils/utils.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _confirmpasswordController = TextEditingController();
  bool _isLoading=false;


 

  @override
  void dispose() {
    super.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
     _confirmpasswordController.dispose();
  }
  void registerUser() async{
        setState(() {
      _isLoading = true;
        });
        UserAuth userAuth = UserAuth(); // Create an instance of UserAuth
        String res = await userAuth.registerUser(
          firstName: _fnameController.text,
          lastName: _lnameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          confirmPassword: _confirmpasswordController.text,
          );
          setState(() {
      _isLoading = true;
        });
          if(res!='success'){
            showSnackBar(res,context);
          }
          
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFieldInput(
              hintText: 'Enter first name',
              textInputType: TextInputType.text,
              textEditingController: _fnameController,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFieldInput(
              hintText: 'Enter last name',
              textInputType: TextInputType.text,
              textEditingController: _lnameController,
              isPass: true,
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
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFieldInput(
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFieldInput(
              hintText: 'Confirm password',
              textInputType: TextInputType.text,
              textEditingController: _confirmpasswordController,
              isPass: true,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25.0),
  child: InkWell(
    onTap: registerUser,
    child: Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color.fromARGB(255, 26, 81, 126),
      ),
      child: !_isLoading
          ? const Text(
              'Register',
              style: TextStyle(fontSize: 18, color: Colors.white),
            )
          : const CircularProgressIndicator(
              color: Colors.white,
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
                  "Already Registered?",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                    primary: Colors.blue,
                    elevation: 0,
                  ),
                  child: const Text('LOG IN'),
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
