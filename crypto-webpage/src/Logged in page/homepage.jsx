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
export default function Homepage() {
    // const value = [1.1, 2.67, -2];
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
    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetch('https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en');
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const result = await response.json();
                setData(result);
                // console.log(result);
            } catch (error) {
                setError(error.message);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);
    const [name, setname] = useState('');
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
                      console.log('Name',docSnap.data()["Name"]);
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
                    <Link>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                    <div className="categories">
                        <Link style={{ textDecoration: "none", color: "yellow" }}>
                            <div className="hjkvd">
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

                <div className="kjdfmdkfm" style={{ paddingTop: '10px' }}>
                    Glad to see you again {name}
                </div>
                <br /><br />
                <div className="kjdfmdkfm">

                    Most Active
                    <br /><br />
                    <div className="kjdef" style={{ color: 'grey', fontWeight: '300', fontSize: '15px' }}>
                        Based on traded values and price variations
                    </div>
                </div>
                <div className="wodklkf" style={{ position: "relative", top: "50px", paddingLeft: '20px', paddingRight: '20px' }}>
                    {
                        data.slice(0,8).map(coin => (
                            <div className="hffndjjhjh">
                                <div className="currencyname">
                                    {coin.name}
                                    <img src={coin.image} alt="" height={40} width={40} />
                                </div>
                                <div className="currencyprice">
                                    ₹{coin.current_price}
                                    <div className="values" style={{ color: coin.price_change_percentage_24h > 0 ? 'green' : 'red', fontWeight: '600' }}>
                                        {coin.price_change_percentage_24h}%
                                    </div>
                                    <div className="currencyprice">

                                    </div>
                                    <div className="currencyprice">

                                    </div>
                                </div>

                            </div>
                        ))
                    }
                </div>
                <br /><br /><br />
                <div className="kjdfmdkfm">
                    New Listing
                    <br /><br />
                    <div className="kjdef" style={{ color: 'grey', fontWeight: '300', fontSize: '15px' }}>
                        Market Launches in the last 15 days
                    </div>
                </div>
                <div className="wodklkf" style={{ position: "relative", top: "50px", paddingLeft: '20px', paddingRight: '20px' }}>
                    {
                        data.slice(8,12).map(coin => (
                            <div className="hffndjjhjh">
                                <div className="currencyname">
                                    {coin.name}
                                    <img src={coin.image} alt="" height={40} width={40} />
                                </div>
                                <div className="currencyprice">
                                    ₹{coin.current_price}
                                    <div className="values" style={{ color: coin.price_change_percentage_24h > 0 ? 'green' : 'red', fontWeight: '600' }}>
                                        {coin.price_change_percentage_24h}%
                                    </div>
                                    <div className="currencyprice">

                                    </div>
                                    <div className="currencyprice">

                                    </div>
                                </div>

                            </div>
                        ))
                    }
                </div>
                <br /><br /><br />
                <div className="kjdfmdkfm">
                    Market
                </div>
                <div className="wodklkf" style={{ position: "relative", top: "50px", paddingLeft: '20px', paddingRight: '20px' }}>
                    {
                        data.slice(10,17).map(coin => (
                            <div className="hffndjjhjh">
                                <div className="currencyname">
                                    {coin.name}
                                    <img src={coin.image} alt="" height={40} width={40} />
                                </div>
                                <div className="currencyprice">
                                    ₹{coin.current_price}
                                    <div className="values" style={{ color: coin.price_change_percentage_24h > 0 ? 'green' : 'red', fontWeight: '600' }}>
                                        {coin.price_change_percentage_24h}%
                                    </div>
                                    <div className="currencyprice">

                                    </div>
                                    <div className="currencyprice">

                                    </div>
                                </div>

                            </div>
                        ))
                    }
                </div>
            </div>
            <br /><br /><br />
            <div className="kjdfmdkfm" style={{ color: "red" }}>
                Lowest Growth Today
                <br /><br />
                <div className="kjdef" style={{ color: 'grey', fontWeight: '300', fontSize: '15px' }}>
                    Lowest in market today in last 24 hours
                </div>
            </div>
            <div className="wodklkf" style={{ position: "relative", top: "50px", paddingLeft: '20px', paddingRight: '20px' }}>
                <div className="hffndjjhjh">
                    <div className="currencyname">
                        {data.map(coin => coin.name)[86]}
                        <img src={data.map(coin => coin.image)[86]} alt="" height={40} width={40} />
                    </div>
                    <div className="currencyprice">
                        ₹{data.map(coin => coin.current_price)[86]}
                        <div className="values" style={{ color: data.map(coin => coin.price_change_percentage_24h)[86] > 0 ? 'green' : 'red', fontWeight: '600' }}>
                            {data.map(coin => coin.price_change_percentage_24h)[86]}%
                        </div>
                        <div className="currencyprice">

                        </div>
                        <div className="currencyprice">

                        </div>
                    </div>
                </div>
                <div className="hffndjjhjh">
                    <div className="currencyname">
                        {data.map(coin => coin.name)[10]}
                        <img src={data.map(coin => coin.image)[10]} alt="" height={40} width={40} />
                    </div>
                    <div className="currencyprice">
                        ₹{data.map(coin => coin.current_price)[10]}
                        <div className="values" style={{ color: data.map(coin => coin.price_change_percentage_24h)[10] > 0 ? 'green' : 'red', fontWeight: '600' }}>
                            {data.map(coin => coin.price_change_percentage_24h)[10]}%
                        </div>
                        <div className="currencyprice">

                        </div>
                        <div className="currencyprice">

                        </div>
                    </div>
                </div>
                <div className="hffndjjhjh">
                    <div className="currencyname">
                        {data.map(coin => coin.name)[97]}
                        <img src={data.map(coin => coin.image)[97]} alt="" height={40} width={40} />
                    </div>
                    <div className="currencyprice">
                        ₹{data.map(coin => coin.current_price)[97]}
                        <div className="values" style={{ color: data.map(coin => coin.price_change_percentage_24h)[97] > 0 ? 'green' : 'red', fontWeight: '600' }}>
                            {data.map(coin => coin.price_change_percentage_24h)[97]}%
                        </div>
                        <div className="currencyprice">

                        </div>
                        <div className="currencyprice">

                        </div>
                    </div>
                </div>
                <div className="hffndjjhjh">
                    <div className="currencyname">
                        {data.map(coin => coin.name)[99]}
                        <img src={data.map(coin => coin.image)[99]} alt="" height={40} width={40} />
                    </div>
                    <div className="currencyprice">
                        ₹{data.map(coin => coin.current_price)[99]}
                        <div className="values" style={{ color: data.map(coin => coin.price_change_percentage_24h)[99] > 0 ? 'green' : 'red', fontWeight: '600' }}>
                            {data.map(coin => coin.price_change_percentage_24h)[99]}%
                        </div>
                        <div className="currencyprice">

                        </div>
                        <div className="currencyprice">

                        </div>
                    </div>
                </div>
            </div>
            <br /><br /><br />
            
        </>
    )
}
