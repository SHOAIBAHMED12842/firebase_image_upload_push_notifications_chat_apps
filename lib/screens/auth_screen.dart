import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:module_14_firebase_image_upload_push_notifications_chat_apps/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx, //to resolve scaffold error
  ) async {
    UserCredential authResult; //instead of authResult/usercredentials
    try {
      setState(() {
        _isLoading = true; //for loading signup button
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      final ref =FirebaseStorage.instance        //for storing an image
          .ref()
          .child('user_image')
          .child(authResult.user!.uid + 'jpg');

         await ref.putFile(image!).whenComplete; //whencomplete/oncomplete give the future
         final url= await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        //FOR STORING IN DATABASE using set instead of setupdata
        'username': username,
        'email': email,
        'image_url': url,
        //'password':password,
      }); //for unconditionally used USER!    //.add use for dynamic assign id
    } on PlatformException catch (err) {
      String? message = 'An error occured,please check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false; //for loading signup button
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false; //for loading signup button
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading, //for loading signup button
      ),
    );
  }
}
