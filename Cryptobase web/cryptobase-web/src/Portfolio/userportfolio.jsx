import React, { useEffect, useState } from 'react';
import Sidebar from '../Side Bar/sidebar';
import { getFirestore, getDocs, collection, doc, getDoc } from 'firebase/firestore';
import { initializeApp } from 'firebase/app';
import { getAnalytics } from 'firebase/analytics';
import { getAuth } from 'firebase/auth';
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

export default function Userportfolio() {
    const [userDetails, setUserDetails] = useState([]);
    const [balance, setBalance] = useState([]);

    const fetchBalance = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "Wallet Balance"));
            const balanceData = querySnapshot.docs.map(doc => ({
                id: doc.id,
                balance: doc.data()['Balance'] || 0,
            }));
            setBalance(balanceData);

            // Fetch user details with the IDs from balanceData
            fetchUserDetails(balanceData.map(b => b.id));
        } catch (error) {
            console.error("Error fetching balance data:", error);
        }
    };

    const fetchUserDetails = async (ids) => {
        try {
            const userDetailsPromises = ids.map(id => getDoc(doc(db, "User Details", id)));
            const userDetailsSnapshots = await Promise.all(userDetailsPromises);

            const userDetailsData = userDetailsSnapshots.map(snapshot => {
                if (snapshot.exists()) {
                    const data = snapshot.data();
                    return {
                        id: snapshot.id,
                        name: data['Name'] || 'No Name',
                        email: data['Email'] || 'No Email',
                    };
                } else {
                    return {
                        id: snapshot.id,
                        name: 'No Name',
                        email: 'No Email',
                    };
                }
            });

            setUserDetails(userDetailsData);

            // Combine balance and user details
            combineAndPrintData(userDetailsData);
        } catch (error) {
            console.error("Error fetching user details:", error);
        }
    };

    const combineAndPrintData = (userDetailsData) => {
        userDetailsData.forEach(user => {
            const userBalance = balance.find(b => b.id === user.id)?.balance || 0;
            console.log(`Name: ${user.name}, Email: ${user.email}, Balance: ${userBalance}`);
        });
    };

    useEffect(() => {
        // Set the document title
        document.title = 'CryptoBase Admin Panel';

        // Fetch balance data initially
        fetchBalance();
    }, []);
    const [searchTerm, setSearchTerm] = useState('');
    const handleSearch = (event) => {
        setSearchTerm(event.target.value);
    };

    // Filter users based on search term
    const filteredUsers = userDetails.filter((user) =>
        user.name.toLowerCase().includes(searchTerm.toLowerCase())
    );

    // Function to download CSV
    const downloadCSV = () => {
        const headers = ["User ID", "User Name", "User Email", "User Profile Pic", "Date of Registration"];
        const rows = filteredUsers.map(user => [user.id, user.name, user.email, user.profilePic, user.dateOfRegistration]);
        const csvContent = [
            headers.join(","),
            ...rows.map(row => row.join(","))
        ].join("\n");

        // Create a blob with the CSV data and create a download link
        const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
        const url = URL.createObjectURL(blob);
        const link = document.createElement("a");
        link.setAttribute("href", url);
        link.setAttribute("download", "Registered Users.csv");
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };
    return (
        <>
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
                                <th>User ID</th>
                                <th>User Name</th>
                                <th>User Email</th>
                                <th>Wallet Balance</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredUsers.length > 0 ? (
                                filteredUsers.map((user) => (
                                    <tr key={user.id}>
                                        <td style={{ fontSize: '13px' }}>{user.id}</td>
                                        <td style={{ fontSize: '13px' }}>{user.name}</td>
                                        <td style={{ fontSize: '13px' }}>{user.email}</td>
                                        <td style={{ fontSize: '13px' }}>{balance.find(b => b.id === user.id)?.balance || 0}</td>
                                    </tr>
                                ))
                            ) : (
                                <tr>
                                    <td colSpan="3">No users found</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                    {/* <div className="user-details">
                        {userDetails.length > 0 ? (
                            <ul>
                                {userDetails.map(user => (
                                    <li key={user.id}>
                                        <strong>Name:</strong> {user.name} <br />
                                        <strong>Email:</strong> {user.email} <br />
                                        <strong>Balance:</strong> {balance.find(b => b.id === user.id)?.balance || 0}
                                    </li>
                                ))}
                            </ul>
                        ) : (
                            <p>No user details available.</p>
                        )}
                    </div> */}
                </div>
            </div>
        </>
    );
}
