//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:module_14_firebase_image_upload_push_notifications_chat_apps/widgets/chat/messages.dart';
import 'package:module_14_firebase_image_upload_push_notifications_chat_apps/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {      //to stateful using push notification
  //const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  // @override           for ios
  // void initState() {
    //   super.initState();
  //   // TODO: implement initState
  //   final fbm= FirebaseMessaging();
  //   fbm.requestPermission();
  //   fbm.configure(onMessage: (msg){
    //print(msg);
    //return;
//}, onlaunch: (msg){
//  print(msg);
// return;
//},
//onResume: (msg) {
//print(msg);
// return;
//});
//fbm.getTokens();
//fbm.subscribeToTopic('chat);
  
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyChat'),
        actions: [
          DropdownButton(
            underline: Container(),//for border clear on dropdownbox
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(     //because it taking listview and not have a space and scrollable
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),

      // StreamBuilder<QuerySnapshot>(
      //   //length resolve using QuerySnapshop
      //   stream: FirebaseFirestore.instance //live listner
      //       .collection('chats/Qa0SkS3Fbf2uGIuS0Qxw/messages')
      //       .snapshots(),
      //   builder: (ctx, streamSnapshot) {
      //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final documents = streamSnapshot.data!.docs; //solve query snapshot
      //     return ListView.builder(
      //       itemCount: documents.length,
      //       itemBuilder: (ctx, index) => Container(
      //         padding: EdgeInsets.all(8),
      //         child: Text(documents[index]['text']),
      //         //child: Text('This works!'),
      //       ),
      //     );
      //   },
      // ),
      //         ListView.builder(
      //   itemCount: 10,
      //   itemBuilder: (ctx, index) => Container(
      //     padding: EdgeInsets.all(8),
      //     child: Text('This works!'),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
          //Firebase.initializeApp();
          //initializeDefault();
          // FirebaseFirestore.instance   //live listner  //move to streambuilder
          //     .collection('chats/Qa0SkS3Fbf2uGIuS0Qxw/messages')
          //     .snapshots()
          // .listen((data) {
          //  //print(data.docs[0]['text']);
          //  data.docs.forEach((document) {print(document['text']); }); //for every documents
          // });
      //     FirebaseFirestore.instance
      //         .collection('chats/Qa0SkS3Fbf2uGIuS0Qxw/messages')
      //         .add({'text': 'This was added by clicking the button!'});
      //   },
      // ),
    );
  }
}
