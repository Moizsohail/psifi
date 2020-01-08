const functions = require('firebase-functions');
const admin = require('firebase-admin');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
admin.initializeApp();

const db = admin.database();
const fcm = admin.messaging();

exports.notif = functions.firestore.document('Notifications/{notificationsid}')
    .onCreate(async snapshot => {
        const notif = snapshot.data();

        const payload = admin.messaging.MessagingPayload = {
            notification: {
                title: `${notif.Title}`,
                body: `${notif.Description}`,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        }
        return fcm.sendToTopic('all', payload);
    });