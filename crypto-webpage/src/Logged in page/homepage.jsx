import React, { useEffect } from 'react'
import { Link } from 'react-router-dom'
import { getAuth, onAuthStateChanged } from "firebase/auth";
export default function Homepage() {
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
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Transactions
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Deposits
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
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
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Profile
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "red" }}>
                            <div className="hjkv">
                                Signout
                            </div>
                        </Link>
                        <div className="hjkv">

                        </div>
                    </div>
                </div>
            </div>
        </>
    )
}
