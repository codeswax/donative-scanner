var admin = require("firebase-admin");

var serviceAccount = require("./donative-scanner-firebase-adminsdk-h5nbh-a7e68a37f1.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://donative-scanner-default-rtdb.firebaseio.com"
});

const db = admin.firestore();

module.exports = { admin, db };