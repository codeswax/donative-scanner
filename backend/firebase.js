const { initializeApp } = require('firebase/app');
const { getFirestore } = require('firebase/firestore');
const firebaseConfig = {
  apiKey: "AIzaSyAi0xBwA8rK8TyF0ByStq7yHjLJC9lvjRA",
  authDomain: "donative-scanner.firebaseapp.com",
  databaseURL: "https://donative-scanner-default-rtdb.firebaseio.com",
  projectId: "donative-scanner",
  storageBucket: "donative-scanner.appspot.com",
  messagingSenderId: "861188996995",
  appId: "1:861188996995:web:574f3567b55f8997fb80b6",
  measurementId: "G-974NBLC77Z"
};
// Inicializar Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

module.exports = { app, db };