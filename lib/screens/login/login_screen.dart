import 'package:course_app/layout/home.dart';
import 'package:course_app/screens/Forgot_password/forgotPassword_Screen.dart';
import 'package:course_app/screens/login/cubit/cubit.dart';
import 'package:course_app/screens/login/cubit/states.dart';
import 'package:course_app/screens/sign_up/signup_screen.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:course_app/shared/network/local/shared_prefrence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {

  String email ;
  String pass ;

  LoginScreen({this.email, this.pass});

  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if ( email != null && pass != null){
      emailController.text = email ;
      passController.text = pass;
    }

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state)
          {
        if (state is LoginStateLoading) {
          buildProgress(context: context, text: "please Wait .. ");
        }
        if (state is LoginStateSuccess) {
          Navigator.pop(context);
          saveToken(state.token).then((value)
          {
            if(value){
              showToast(text:'success save token', error: false);
              navigateAndFinish(context ,HomeScreen());
            }
            else{
              showToast(text:'Error while saving a token', error: false);
            }
          });
        }
        if (state is LoginStateError) {
          Navigator.pop(context);
           buildProgress(
            context: context,
            text: "You dont have an account",
            error: true,
          );
        }
      },
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('login'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Container(
                      child: logo(),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  defualtTextBox(
                    title: "Email",
                    hint: 'Enter Your Email',
                    controller: emailController,
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defualtTextBox(
                    title: "Password",
                    hint: '****************',
                    controller: passController,
                    type: TextInputType.visiblePassword,
                    isPassword: true ,
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  defaultButton(
                    function: () {
                      String email = emailController.text ;
                      String pass = passController.text ;
                      if(email.isEmpty||pass.isEmpty)
                      {
                        showToast(text: 'please enter a valid data', error:  true );
                        return ;
                      }
                      LoginCubit.get(context).Login(email: email , password: pass);
                    },
                    text: "Login",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                    function: () {
                      navigateTo(context, SignUpScreen());
                    },
                    text: "Sign Up",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () {
                      navigateTo(context, ForgorPasswordScreen());
                    },
                    child: Text('Forgot your password ?'),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
