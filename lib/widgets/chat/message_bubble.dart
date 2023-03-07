//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {required this.key});

  final Key key; //for updating data in the list
  final String message;
  final String? userName; //for displaying username
  final String userImage;  //for displaying userimage
  bool isMe;

  @override
  Widget build(BuildContext context) {
    //isMe.toString();
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140, //to using width use row widget
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // FutureBuilder(         // worked with not get user name for every chat
                  //   future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
                  //   builder: (context, AsyncSnapshot snapshot) { // worked AsyncSnapshot
                  //     if(snapshot.connectionState==ConnectionState.waiting){
                  //       return Text('Loading......');
                  //     }
                  //     return
                  Text(
                    userName!,
                    //snapshot.data['username'], //for displaying username // worked AsyncSnapshot for future builder
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context)
                              .accentTextTheme
                              .headline1! //instead of title
                              .color,
                    ),
                  ),
                  //}
                  //),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context)
                              .accentTextTheme
                              .headline1! //instead of title
                              .color, //due title/headline1 or use! in headline
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        // Positioned(
        //   top: -10,
        //   left:isMe ? null: 120, //to inline with messege bubble
        //   right:isMe ? 120: null, //to inline with messege bubble
        //   child: CircleAvatar(
        //     backgroundImage: NetworkImage(
        //       userImage,
        //     ),
        //   ),
        // ),
      ],
      clipBehavior:
          Clip.none, //overflow:Overflow.visible also used to avoid overflow
    );
  }
}
