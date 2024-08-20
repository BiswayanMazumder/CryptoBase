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
export default function Currencycap() {
    async function logout() {
        const auth = getAuth();
        await auth.signOut();
        window.location.replace('/')
    }
    const currname = localStorage.getItem("Name");
    const currvalue = localStorage.getItem("Value");
    const price = localStorage.getItem("Price");
    const fullname = localStorage.getItem("FullName")
    const low=localStorage.getItem("Low")
    const high=localStorage.getItem("High")
    const volume=localStorage.getItem("Volume")
    const perc_24h=localStorage.getItem("Perc_24h")
    useEffect(() => {
        document.title = `${currname} to INR | Buy ${currname} in India at best price at INR ${currvalue} on CryptoForge`
        // console.log(price);
    })
    // ETH to INR | Buy Ethereum in India at best price at INR 3,03,000.0 on WazirX
    return (
        <>
            <div className="webbody">
                <div className="jnnvmkjd">
                    <Link to={'/home'}>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                    <div className="categories">
                        <Link style={{ textDecoration: "none", color: "yellow" }}>
                            <div className="hjkvd">
                                Home
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/portfolio"}>
                            <div className="hjkv">
                                Portfolios
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/transactions"}>
                            <div className="hjkv">
                                Transactions
                            </div>
                        </Link>
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
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/market"}>
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
                <div className="hgfebfn">
                    <div className="jdnjmndmv">
                        {currname} / INR
                        <div className="dkhdn" style={{backgroundColor:perc_24h>0?'green':'red'}}>
                            {perc_24h}%
                        </div>
                    </div>
                    
                    <br />
                    <div className="jdnjmndmvf">
                        <div className="volume">
                            Vol: {(volume/1000000000).toFixed(2)}B
                        </div>
                        <div className="volume">
                            High: ₹{high}
                        </div>
                        <div className="volume">
                            Low: ₹{low}
                        </div>
                        <div className="volume">
                            
                        </div>
                    </div>
                </div>
            </div>
        </>
    )
}
