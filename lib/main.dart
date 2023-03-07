import 'package:flutter/material.dart';
import 'package:module_14_firebase_image_upload_push_notifications_chat_apps/screens/auth_screen.dart';
import 'package:module_14_firebase_image_upload_push_notifications_chat_apps/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:module_14_firebase_image_upload_push_notifications_chat_apps/screens/splash_screen.dart';
import 'firebase_options.dart';
//import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterChat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      //home: AuthScreen(),  //simple authentication instead using streambuilder
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (ctx, userSnapshot){   //all things will be notified such as token sigin signup etc
        if(userSnapshot.connectionState==ConnectionState.waiting){
          return SplashScreen();
        }
        if(userSnapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      }),  //instead of using onAuthStateChanged/authstatechanges() is used
    );
  }
}
