import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth, signInWithEmailAndPassword,onAuthStateChanged } from "firebase/auth";

const firebaseConfig = {
  apiKey: "AIzaSyCxkw9hq-LpWwGwZQ0APU0ifJ5JQU2T8Vk",
  authDomain: "cryptobase-admin.firebaseapp.com",
  projectId: "cryptobase-admin",
  storageBucket: "cryptobase-admin.appspot.com",
  messagingSenderId: "1090236390686",
  appId: "1:1090236390686:web:856b22fd209b267b89fd0f",
  measurementId: "G-LTBWYEEF6E"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
const auth = getAuth(app);

export default function Homepage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  useEffect(() => {
    document.title = 'Welcome To CryptoBase Admin Panel';
  }, []);
  useEffect(() => {
    onAuthStateChanged(auth, (user) => {
      if (user) {
        // User is signed in, see docs for a list of available properties
        // https://firebase.google.com/docs/reference/js/auth.user
        const uid = user.uid;
        // ...
        window.location.replace('/home');
      } else {
        // User is signed out
        // ...
      }
    });
  })
  const LoginUser = async () => {
    try {
      const userCredential = await signInWithEmailAndPassword(auth, email, password);
      const user = userCredential.user;
      window.location.replace('/home');
    } catch (error) {
      const errorCode = error.code;
      const errorMessage = error.message;
      // Handle errors here
      console.error('Error signing in:', errorCode, errorMessage);
    }
  }

  return (
    <div className='homepage'>
      <img
        src="https://cdn.dribbble.com/userupload/3726865/file/original-332b7cf604fac4578e206989fffe9eee.png?resize=1200x817&vertical=center"
        alt=""
        className='Homepageimg'
      />
      <div className="loginoptions">
        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0"
          alt="image" className='logoimage' />
        <div className="welcometext">
          Welcome Back!!!
        </div>
        <div className="header">
          <h1>Sign In!!!</h1>
        </div>
        <div className="emailtext" >
          Email
        </div>
        <div className="textfields">
          <input 
            type="text" 
            className='emailfield' 
            placeholder='Enter Email' 
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
        </div>
        <div className="passwordtext">
          Password
        </div>
        <div className="textfields" >
          <input 
            type="password" 
            className='emailfield' 
            placeholder='Enter Password' 
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </div>
        <Link  className='linktexts'>
        <div className="siginbutton" onClick={LoginUser}>
          <center>SIGN IN</center>
        </div>
        </Link>
      </div>
    </div>
  );
}
