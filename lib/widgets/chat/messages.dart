//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:module_14_firebase_image_upload_push_notifications_chat_apps/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  final futureuser=Future.value(FirebaseAuth.instance.currentUser);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: futureuser,// Future.value(FirebaseAuth.instance.currentUser), //using of future.value convert user to the future without this is not a future
            builder: (ctx, AsyncSnapshot futureSnapshot) {
              if(futureSnapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                  );
              }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(), //order by use to the corrrect order of the
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        // return FutureBuilder( //move because run again and again
        //     future: Future.value(FirebaseAuth.instance.currentUser), //using of future.value convert user to the future without this is not a future
        //     builder: (ctx, futureSnapshot) {
        //       if(futureSnapshot.connectionState==ConnectionState.waiting){
        //         return Center(
        //           child: CircularProgressIndicator(),
        //           );
        //       }
        //print(futureSnapshot.data.uid);
              return ListView.builder(
                reverse: true, //to reverse the messege list
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['username'], //worked with AsyncSnapshot
                    chatDocs[index]['userImage'],
                     chatDocs[index]['userId'] == futureSnapshot.data.uid, //.uid worked with AsyncSnapshot futureSnapshot
                     key: ValueKey(chatDocs[index].id), //for updating flutter issue //tutorial use documentID
                     ),
                //Text(chatDocs[index]['text']),
              );
            }
            );
      },
    );
  }
}
