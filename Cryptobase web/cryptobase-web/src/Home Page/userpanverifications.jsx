import React, { useEffect, useState } from 'react';
import Sidebar from '../Side Bar/sidebar';
import { getFirestore, getDocs, collection } from "firebase/firestore";
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth } from "firebase/auth";
import { Link } from 'react-router-dom';

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

export default function Userpanverifications() {
  const [userDetails, setUserDetails] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [verificationStatusMap, setVerificationStatusMap] = useState(new Map());

  // Fetch user data
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
          verification: verificationStatusMap.get(doc.id) || false, // Add verification status
        };
      });
      setUserDetails(details);
    } catch (error) {
      console.error("Error fetching user details:", error);
    }
  };

  const fetchVerificationStatus = async () => {
    try {
      const querySnapshot = await getDocs(collection(db, "User Verification"));
      const statusMap = new Map();
      querySnapshot.docs.forEach((doc) => {
        const data = doc.data();
        statusMap.set(doc.id, data.verification || false);
      });
      setVerificationStatusMap(statusMap);
    } catch (error) {
      console.error("Error fetching verification status:", error);
    }
  };

  useEffect(() => {
    // Set the document title
    document.title = 'CryptoBase Admin Panel';

    // Fetch data initially
    fetchVerificationStatus();
    fetchData();
    
    // Set up interval to fetch data every 30 seconds (adjust as needed)
    const interval = setInterval(() => {
      fetchData();
    }, 300000);

    // Clean up interval on component unmount
    return () => clearInterval(interval);
  }, [verificationStatusMap]);

  // Handle the search input change
  const handleSearch = (event) => {
    setSearchTerm(event.target.value);
  };

  // Filter users based on search term
  const filteredUsers = userDetails.filter((user) =>
    user.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Function to download CSV
  const downloadCSV = () => {
    const headers = ["User ID", "User Name", "User Email", "User Profile Pic", "Date of Registration", "Verification Status"];
    const rows = filteredUsers.map(user => [user.name, user.email, user.profilePic, user.dateOfRegistration, user.verification]);
    const csvContent = [
      headers.join(","),
      ...rows.map(row => row.join(","))
    ].join("\n");

    // Create a blob with the CSV data and create a download link
    const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.setAttribute("href", url);
    link.setAttribute("download", "User Verification Status.csv");
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  // Handle row click
  const handleRowClick = (userName) => {
    console.log(userName);
  };

  return (
    <div className="pages">
      <Sidebar />
      <div className="detailspage">
        <div className="header">
          <input
            type="text"
            placeholder="Search by name"
            value={searchTerm}
            onChange={handleSearch}
            style={{ margin: '10px', padding: '8px', width: '300px', fontWeight: '600' }}
          />
          <Link className='exportbutton' onClick={downloadCSV}>
            <div>Export CSV</div>
          </Link>
        </div>
        <table className="userTable">
          <thead>
            <tr>
              <th>User Name</th>
              <th>Verification Status</th>
              <th>Email Address</th>
              {/* <th>Actions</th> */}
            </tr>
          </thead>
          <tbody>
            {filteredUsers.length > 0 ? (
              filteredUsers.map((user) => (
                <tr key={user.id} onClick={() => handleRowClick(user.name)}>
                  <td style={{fontSize:'13px'}}>{user.name}</td>
                  <td style={{ color: user.verification ? 'green' : 'red',fontSize:'13px' }}>{user.verification ? "User Verified" : "User Not Verified"}</td>
                  <td style={{ color: user.verification ? 'green' : 'red' ,fontSize:'13px'}}>{user.email}</td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="3">No users found</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
