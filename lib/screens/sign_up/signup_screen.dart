import 'package:course_app/screens/login/login_screen.dart';
import 'package:course_app/screens/sign_up/cubit/cubit.dart';
import 'package:course_app/screens/sign_up/cubit/states.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {

  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  var emailController = TextEditingController();

  var passController = TextEditingController();

  var cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
      listener: (context, state) {
        if (state is SignUpStateLoading) {
          return buildProgress(
              context: context,
              text: "please Wait until creating an account.. ");
        }
        if (state is SignUpStateSuccess) {
          return navigateAndFinish(
            context,
            LoginScreen(
              email: emailController.text,
              pass: passController.text,
            ),
          );
        }
        if (state is SignUpStateError) {
          Navigator.pop(context);
          return buildProgress(
            context: context,
            text:  'Your email already used',
            error: true ,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('SignUp'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      child: logo(),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  defualtTextBox(
                    title: "First name",
                    hint: 'Enter your First Name',
                    controller: firstNameController,
                    type: TextInputType.text,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defualtTextBox(
                    title: "Last name",
                    hint: 'Enter your Last Name',
                    controller: lastNameController,
                    type: TextInputType.text,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defualtTextBox(
                    title: "Email",
                    hint: 'Enter your Email',
                    controller: emailController,
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defualtTextBox(
                    title: "Password",
                    hint: '*****************',
                    controller: passController,
                    type: TextInputType.visiblePassword,
                    isPassword: true ,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defualtTextBox(
                    title: "City",
                    hint: 'Enter your City',
                    controller: cityController,
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  defaultButton(
                    function: () {
                      String firstName = firstNameController.text ;
                      String lastName = lastNameController.text ;
                      String email= emailController.text ;
                      String password = passController.text;
                      String city = cityController.text ;
                      if(firstName.isEmpty||
                          lastName.isEmpty||
                          email.isEmpty||
                          password.isEmpty||
                          city.isEmpty)
                        {
                          showToast(text: 'please enter a valid data', error:  true );
                          return ;
                        }
                      SignUpCubit.get(context).register(
                        first: firstName,
                        last: lastName,
                        email: email,
                        password: password,
                        city: city,
                      );
                    },
                    text: "Sign Up",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                    function: () {
                      navigateTo(context, LoginScreen());
                    },
                    text: "Back To Login",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
