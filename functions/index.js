const functions = require("firebase-functions");
//const { DataSnapshot } = require("firebase-functions/v1/database");
const admin = require('firebase-admin');
//const { snapshotConstructor } = require("firebase-functions/v1/firestore");

admin.initializeApp();

exports.myFunction = functions.firestore
  .document('chat/{message}')
  //.onCreate((change, context) => { 
    .onCreate((snaphot, context) => { 
    //console.log(change.after.data());/* ... */ 
    //console.log(snaphot.data());/* ... */ 
    return admin
    .messaging()
    .sendToTopic('chat',{
        notification:{
            title:snaphot.data().username,
             body:snapshotConstructor.data.text,
             clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            },
        });
    return;
});

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
