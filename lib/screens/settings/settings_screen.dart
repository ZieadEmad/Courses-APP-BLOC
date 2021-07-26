import 'package:course_app/screens/settings/about_app/about_app_screen.dart';
import 'package:course_app/screens/settings/account_security/account_security_screen.dart';
import 'package:course_app/screens/settings/contact_us/contact_us_screen.dart';
import 'package:course_app/screens/settings/email_notifications/email_notifications_screen.dart';
import 'package:course_app/screens/settings/push_notifications/push_notifications_screen.dart';
import 'package:course_app/screens/settings/questions/questions_screen.dart';
import 'package:course_app/screens/welcome/welcome_screen.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:course_app/shared/network/local/shared_prefrence.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              buildOneCardSettings(
                title: 'Account Settings',
                fisrtText: 'Account Security',
                firstHeroTag: '1',
                firstFunction: (){navigateTo(context,AccountSecurityScreen());},

                secondText: 'Email Notifications',
                secondHeroTag: '2',
                secondFunction: (){navigateTo(context,EmailNotificationsScreen());},
                thirdText: 'Push Notifications',
                thirdHeroTag: '3',
                thirdFunction: (){navigateTo(context,PushNotificationsScreen());},
              ),
              buildOneCardSettings(
                title: 'Support',
                fisrtText: 'About App',
                firstHeroTag: '4',
                firstFunction: (){navigateTo(context,AboutAppScreen());},

                secondText: 'Frequently asked questions',
                secondHeroTag: '5',
                secondFunction: (){navigateTo(context,QuestionsScreen());},
                thirdText: 'Contact Us',
                thirdHeroTag: '6',
                thirdFunction: (){navigateTo(context,ContactUsScreen());},
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          defaultButton(
            text: 'Logout',
            function: () {
              removeToken();
              navigateAndFinish(context, WelcomeScreen());
            },
            background: Colors.red,
            toUpper: true,
            width: 160,
          ),
        ],
      ),
    );
  }
}
