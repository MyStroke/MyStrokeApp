// Import the functions you need from the SDKs you need
import firebase from "firebase/compat/app";
import "firebase/compat/auth";
import "firebase/compat/firestore";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCXDGk7hdQYo5Gf33SGTmoCHp4bh5YThRM",
  authDomain: "yrc-mystroke.firebaseapp.com",
  projectId: "yrc-mystroke",
  storageBucket: "yrc-mystroke.appspot.com",
  messagingSenderId: "571705406104",
  appId: "1:571705406104:web:da00549a27cebb044dd6ed",
  measurementId: "G-9VLQEB8PM2"
};

// Initialize Firebase
if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
}

export { firebase };