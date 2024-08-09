import React, { useEffect, useState } from 'react';
import Sidebar from '../Side Bar/sidebar';
import { getFirestore, getDocs, collection } from "firebase/firestore";
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth } from "firebase/auth";

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
    document.title = 'CryptoBase Admin Panel';
  }, []);

  const [userDetails, setUserDetails] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const querySnapshot = await getDocs(collection(db, "User Details"));
        const details = querySnapshot.docs.map((doc) => {
          const data = doc.data();
          return {
            id: doc.id,
            name: data.Name || '',
            email: data.Email || '',
            profilePic: data['Profile Pic'] || '',
            dateOfRegistration: data['Date Of Registration'] || '',
          };
        });
        setUserDetails(details);
        console.log(details); // Logging details to verify fetched data
      } catch (error) {
        console.error("Error fetching user details:", error);
      }
    };

    fetchData();
  }, []);

  return (
    <div className="pages">
      <Sidebar />
      <div className="detailspage">
        <table className="userTable">
          <thead>
            <tr>
              <th>User ID</th>
              <th>User Name</th>
              <th>User Email</th>
            </tr>
          </thead>
          <tbody>
            {userDetails.map((user) => (
              <tr key={user.id}>
                <td>{user.id}</td>
                <td>{user.name}</td>
                <td>{user.email}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
