import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth{
  signin,
  signup
}

class AuthScreen extends StatefulWidget {
  static const String routeName  = '/Auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();

  final  _emailcontroller = TextEditingController();
  final _passwordcontroller =TextEditingController();
  final _namecontroller = TextEditingController();




@override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void signUpUser(){
    authServices.signUpUser(
      name: _namecontroller.text, 
      email: _emailcontroller.text, 
      password: _passwordcontroller.text, 
      context: context
      );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
               ),
              ),
              ListTile(
                tileColor: _auth == Auth.signup ? GlobalVariable.backgroundColor : GlobalVariable.greyBackgroundCOlor,
                title:  const Text(
                  "Create Account",
                style: TextStyle(
                  fontWeight: 
                  FontWeight.bold),
                  ),
                leading: Radio(
                  activeColor: GlobalVariable.secondaryColor,
                  value: Auth.signup, 
                  groupValue: _auth, 
                  onChanged: (Auth? auth){
                    setState(() {
                      _auth = auth!;
                    });
                  },
                ),
              ),
              if(_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child:  Column(
                      children: [
                        CustomTextField(
                          hintText: "Email",
                          controller: _emailcontroller
                          ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          hintText: "Name",
                          controller: _namecontroller
                          ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          hintText: "Password",
                          controller: _passwordcontroller
                          ),
                        const SizedBox(height: 10,),
                        CustomButton(
                          text: "Sign Up",
                          onTap: (){
                            if(_signUpFormKey.currentState!.validate()){
                              signUpUser();
                            }
                          },
                          ),
                      ],
                    ),
                    ),
                ),
               ListTile(
                tileColor: _auth == Auth.signin?GlobalVariable.backgroundColor:GlobalVariable.greyBackgroundCOlor,
                title:  const Text(
                  "Sign-In.",
                style: TextStyle(
                  fontWeight: 
                  FontWeight.bold
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariable.secondaryColor,
                  value: Auth.signin, 
                  groupValue: _auth, 
                  onChanged: (Auth? auth){
                    setState(() {
                      _auth = auth!;
                    });
                  },
                ),
              ),
              if(_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child:  Column(
                      children: [
                        CustomTextField(
                          hintText: "Email",
                          controller: _emailcontroller
                          ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          hintText: "Password",
                          controller: _passwordcontroller
                          ),
                        const SizedBox(height: 10,),
                        CustomButton(
                          text: "Sign In",
                          onTap: (){},
                          ),
                      ],
                    ),
                    ),
                ),
            ],
          ),
        ),
        ),
    );
  }
}