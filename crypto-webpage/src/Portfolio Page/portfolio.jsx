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
export default function Portfolio() {
    async function logout() {
        const auth = getAuth();
        await auth.signOut();
        window.location.replace('/')
    }
    useEffect(() => {
        document.title = 'Best Place for Crypto Trading and buying Crypto | CryptoForge'
    })
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
    const [tradbal, settradbal] = useState(0);
    const [portfoliocurr, setportfoliocurr] = useState([]);
    const [protfoliovol, setportfoliovol] = useState([]);
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
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [portfolioData, setPortfolioData] = useState([]);
    const [apiData, setApiData] = useState([]);
    const [matchedData, setMatchedData] = useState([]);
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

            const docRef = doc(db, "Portfolio Currency", user.uid);

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    // Document found, update state
                    setportfoliocurr(docSnap.data()["Currency"]);
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

            const docRef = doc(db, "Portfolio Currency Volume", user.uid);

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    // Document found, update state
                    setportfoliovol(docSnap.data()["Currency"]);
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
    const [data, setData] = useState([]);
    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetch('https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en');
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const result = await response.json();
                setData(result);
                
                // Print all symbols
                result.forEach(item => {
                    console.log(item.symbol);
                });
            } catch (error) {
                setError(error.message);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);
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
                        <Link style={{ textDecoration: "none", color: "yellow" }}>
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
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/profile"}>
                            <div className="hjkv">
                                Profile
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "red" }} onClick={logout}>
                            <div className="hjkv">
                                Signout
                            </div>
                        </Link>
                        <div className="hjkv">
                        </div>
                    </div>
                </div>
                <div className="iuhkhjjv">
                    <div className="creditcard">
                        <div className="title">
                            Trading Balance
                        </div>
                        <div className="result">
                            ₹{tradbal}
                        </div>
                    </div>
                    <div className="portfoliodetails">
                        <div className="ejjhjknjm">
                        Currency
                            {portfoliocurr.map((item, index) => (
                                <div className="portfoliocurrency">

                            {/* <img src="https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400" alt="" height={40} width={40} /> */}
                                {portfoliocurr[index]}
                            </div>
                            ))}
                            {/* <div className="portfoliovalue">
                                djhfnj
                            </div> */}
                        </div>
                        <div className="ejjhjknjm">
                        Volume
                            {protfoliovol.map((item, index) => (
                                <div className="portfoliocurrency">
                            {/* <img src="https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400" alt="" height={40} width={40} /> */}
                                {protfoliovol[index]}
                            </div>
                            ))}
                            {/* <div className="portfoliovalue">
                                djhfnj
                            </div> */}
                        </div>
                    </div>
                </div>
            </div>
        </>
    )
}
