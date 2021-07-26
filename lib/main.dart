import 'package:course_app/layout/cubit/cubit.dart';
import 'package:course_app/layout/home.dart';
import 'package:course_app/screens/profile/cubit/cubit.dart';
import 'package:course_app/screens/sign_up/cubit/cubit.dart';
import 'package:course_app/screens/welcome/welcome_screen.dart';
import 'package:course_app/shared/colors/colors_common.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:course_app/shared/network/local/shared_prefrence.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()
async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var widget;

  await initpref().then((value)
  {
        if (getToken() != null && getToken().length > 0)
        {
          widget = HomeScreen() ;
        }
        else
          {
            widget = WelcomeScreen() ;
          }
      });
  
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  var widget;

  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {

    initApp();

    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        // BlocProvider(
        //   create: (context) => ProfileCubit(),
        // ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Courses App',
        theme: ThemeData(
          primarySwatch: defaultColor,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        home: widget,
      ),
    );
  }
}
