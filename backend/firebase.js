var admin = require("firebase-admin");

var serviceAccount = require("./donative-scanner-firebase-adminsdk-h5nbh-a7e68a37f1.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://donative-scanner-default-rtdb.firebaseio.com"
});

const db = admin.firestore();

module.exports = { admin, db };


// adding report test - Kevin Valle
var reportTest = {
    report: {
        idUser: 1,
        date: "21/12/2099",
        donative: [1]
    }
};

db.collection('report').doc('2').set(reportTest);

// adding donative test - Kevin Valle
var donativeTest = {
  donative: {
    idDonative: 1,
    idProduct: 1,
    idUser: 1,
    quantity: 6
  }
}

db.collection('donative').doc('2').set(donativeTest);