const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendRideRequestNotification = functions.firestore
    .document("rideRequests/{docId}")
    .onWrite(async (change, context) => {
      const locationData = change.after.data();
      const message = {
        notification: {
        title: "New Ride Request!",
          body: `A new Client Requests a ride to ${locationData.headLocation}`,
        },
        data: {
          "Ride Request": locationData.headLocation,
        },
        topic: "rideRequests",
      };

      try {
        const response = await admin.messaging().send(message);
        console.log(`Successfully sent ride request notification: ${response}`);
      } catch (error) {
        console.error(`Error sending ride request notification: ${error}`);
      }
    });


exports.sendRideResponseNotification = functions.firestore
    .document("rideRequests/{docId}")
    .onUpdate(async (change, context) => {
      const locationData = change.after.data();

      const message = {
        notification: {
        title: "Response to Ride Request!",
          body: `The driver accepted your ride to ${locationData.headLocation}`,
        },
        data: {
          "Ride Location": locationData.headLocation,
        },
        topic: "rideRequests",
      };

      try {
        const response = await admin.messaging().send(message);
        console.log(`Successfully sent ride request notification: ${response}`);
      } catch (error) {
        console.error(`Error sending ride request notification: ${error}`);
      }
    });
