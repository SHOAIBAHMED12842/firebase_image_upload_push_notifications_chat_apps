import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller= new TextEditingController();

  void _sendMessage() async{
    FocusScope.of(context).unfocus(); //close keyboard
    final user=await FirebaseAuth.instance.currentUser; //accent to currently login user then use asynce for future use
    final userData= await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();//fetch with new messege
    FirebaseFirestore.instance.collection('chat').add({
      'text':_enteredMessage,
      'createdAt': Timestamp.now(), //for place messege in write order
      'userId': user.uid, //uid is unique so that use 
      'username':userData['username'],//username stored when new messege
      'userImage': userData['image_url'],  
    });//additinally added firebase
    _controller.clear();   //to create the controller
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            //use it because take to much space
            child: TextField(
              controller: _controller, //use to clear text after pressed send button
              textCapitalization: TextCapitalization.sentences,//captalization in sentenes
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,  //for empty messege use trim
          ),
        ],
      ),
    );
  }
}
