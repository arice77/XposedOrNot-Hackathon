import 'package:flutter/material.dart';
import 'package:xpose/Componenets/feature_button.dart';
import 'package:xpose/Screens/analytics_email_breach.dart';
import 'package:xpose/Screens/data_breaches_screen.dart';
import 'package:xpose/Screens/email_breach_screen.dart';

import 'exposed_password_scren.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.deepPurple,elevation: 10,
        title: const Text('XposedOrNot', style: TextStyle(color: Colors.white),),
        
      ),
       body: const SingleChildScrollView(
         child:  Padding(
           padding: EdgeInsets.all(20.0),
           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
              
         
               FeatureButton(iconData: Icons.search_outlined,featureTtile: "Email Address Breaches", featureDescription: "Check if an email address has been involved in known data breaches. ",routeName: EmailBreachScreen.routeName),
              FeatureButton(iconData: Icons.analytics_outlined, featureTtile: "Analytics for Email Breach", featureDescription: "In-depth analysis of an email address's data  breach history. ",routeName: AnalyticsEmailBreach.routeName,),
              FeatureButton(iconData: Icons.lock_outline, featureTtile: "Exposed Passwords", featureDescription: "Check for exposed passwords anonymously",routeName: ExposedPasswordScreen.routeName,),
              FeatureButton(iconData: Icons.document_scanner_outlined, featureTtile: "All Data Breaches", featureDescription: "Display information loaded in XposedOrNot.",routeName: DataBreachScreen.routeName,),
               
              
             ],
           ),
         ),
       ),
    );
  }
}