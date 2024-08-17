import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { getAuth, onAuthStateChanged } from "firebase/auth";
import Typewriter from 'typewriter-effect';
import { getFirestore, doc, getDoc, setDoc } from 'firebase/firestore';
import { initializeApp } from "firebase/app";
const firebaseConfig = {
    apiKey: "AIzaSyCxkw9hq-LpWwGwZQ0APU0ifJ5JQU2T8Vk",
    authDomain: "cryptobase-admin.firebaseapp.com",
    projectId: "cryptobase-admin",
    storageBucket: "cryptobase-admin.appspot.com",
    messagingSenderId: "1090236390686",
    appId: "1:1090236390686:web:856b22fd209b267b89fd0f",
    measurementId: "G-LTBWYEEF6E"
};
const app = initializeApp(firebaseConfig);
// Initialize Cloud Firestore and get a reference to the service
const db = getFirestore(app);

export default function Profile() {
    async function logout() {
        const auth = getAuth();
        await auth.signOut();
        window.location.replace('/')
    }
    useEffect(() => {
        const auth = getAuth();
        onAuthStateChanged(auth, (user) => {
            if (user) {
                // User is signed in, see docs for a list of available properties
                // https://firebase.google.com/docs/reference/js/auth.user
                const uid = user.uid;
                // console.log('User is signed in:', uid);
                // ...
            } else {
                // User is signed out
                // console.log('User is not signed')
                window.location.replace('/')
                // ...
            }
        });
    })
    const [name, setname] = useState('');
    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    useEffect(() => {
        const fetchData = async () => {
            const auth = getAuth();
            const db = getFirestore(app);
            const user = auth.currentUser;

            if (!user) {
                setError('No user is logged in.');
                setLoading(false);
                return;
            }

            const docRef = doc(db, "User Details", user.uid);

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    // Document found, update state
                    setname(docSnap.data()["Name"]);
                    //   console.log('Name',docSnap.data()["Name"]);
                } else {
                    setError('No such document!');
                }
            } catch (e) {
                // Handle errors here
                setError(`Error getting document: ${e.message}`);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []); // Add dependencies here if needed
    const [refcode,setrefcode]=useState('');
    useEffect(() => {
        const fetchData = async () => {
            const auth = getAuth();
            const db = getFirestore(app);
            const user = auth.currentUser;

            if (!user) {
                setError('No user is logged in.');
                setLoading(false);
                return;
            }

            const docRef = doc(db, "Referral Codes", user.uid);

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    // Document found, update state
                    setrefcode(docSnap.data()["Referral Code"]);
                    //   console.log('Name',docSnap.data()["Referral Code"]);
                } else {
                    setError('No such document!');
                }
            } catch (e) {
                // Handle errors here
                setError(`Error getting document: ${e.message}`);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []); // Add dependencies here if needed
    const [walletid,setwalletid]=useState('');
    useEffect(() => {
        const fetchData = async () => {
            const auth = getAuth();
            const db = getFirestore(app);
            const user = auth.currentUser;

            if (!user) {
                setError('No user is logged in.');
                setLoading(false);
                return;
            }

            const docRef = doc(db, "Wallet ID", user.uid);

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    // Document found, update state
                    setwalletid(docSnap.data()["Wallet Address"]);
                    //   console.log('Name',docSnap.data()["Referral Code"]);
                } else {
                    setError('No such document!');
                }
            } catch (e) {
                // Handle errors here
                setError(`Error getting document: ${e.message}`);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []); // Add dependencies here if needed
    const [tradbal,settradbal]=useState(0);
    useEffect(() => {
        const fetchData = async () => {
            const auth = getAuth();
            const db = getFirestore(app);
            const user = auth.currentUser;

            if (!user) {
                setError('No user is logged in.');
                setLoading(false);
                return;
            }

            const docRef = doc(db, "Wallet Balance", user.uid);

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    // Document found, update state
                    settradbal(docSnap.data()["Balance"]);
                    //   console.log('Name',docSnap.data()["balance"]);
                } else {
                    setError('No such document!');
                }
            } catch (e) {
                // Handle errors here
                setError(`Error getting document: ${e.message}`);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []); // Add dependencies here if needed
    return (
        <>
            <div className="webbody">
                <div className="jnnvmkjd">
                    <Link to={"/home"}>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                    <div className="categories">
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/home"}>
                            <div className="hjkv">
                                Home
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Portfolios
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/transactions"}>
                            <div className="hjkv">
                                Transactions
                            </div>
                        </Link>
                        {/* <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Deposits
                            </div>
                        </Link> */}
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/withdrawal"}>
                            <div className="hjkv">
                                Withdrawal
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Help and Support
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Market
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "yellow" }}>
                            <div className="hjkv">
                                Profile
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "red" }} onClick={logout}>
                            <div className="hjkv">
                                Signout
                            </div>
                        </Link>
                        
                    </div>
                </div>
                <div className="dnfndfnn">
                            <div className="jfnef0smdkmkf">
                                <div className="title">
                                    User Name
                                </div>
                                <div className="result">
                                    {name}
                                </div>
                            </div>
                            <br /><br />
                            <div className="jfnef0smdkmkf" style={{height:"170px"}}>
                                <div className="title">
                                    Referral Code
                                </div>
                                <div className="result">
                                    {refcode}
                                </div>
                                <div className="title">
                                    Refer to your friend and get 200 INR bonus
                                </div>
                            </div>
                            <br /><br />
                            <div className="jfnef0smdkmkf">
                                <div className="title">
                                    Trading Balance
                                </div>
                                <div className="result">
                                ₹{tradbal}
                                </div>
                            </div>
                            <br /><br />
                            <div className="jfnef0smdkmkf">
                                <div className="title">
                                    Wallet Address
                                </div>
                                <div className="result">
                                    {walletid}
                                </div>
                            </div>
                        </div>
            </div>
        </>
    )
}
