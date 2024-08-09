import React, { useEffect } from 'react'
import Sidebar from '../Side Bar/sidebar'
import { getFirestore,getDocs, collection } from "firebase/firestore";
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth, signInWithEmailAndPassword } from "firebase/auth";

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
const db = getFirestore(app);
export default function Userpage() {
    useEffect(() => {
        document.title = 'CryproBase Admin Panel';
      }, []);
  return (
    <div className="pages">
        <Sidebar />
        <div className="detailspage">
            <div className="tables">
                <li className='ListDetails'>
                    User ID
                </li>
                <li className='ListDetails2'>
                    User Name
                </li>
                <li className='ListDetails2'>
                    User Email
                </li>
                {/* <li className='ListDetails2'>
                    User Name
                </li> */}
                <li className='ListDetails2'>
                    Profile Pic
                </li>
                <li className='ListDetails2'>
                    DoJ
                </li>
            </div>
        </div>
    </div>
  )
}
