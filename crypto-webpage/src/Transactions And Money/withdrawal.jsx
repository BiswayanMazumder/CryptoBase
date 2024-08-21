import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { getAuth, onAuthStateChanged } from 'firebase/auth';
import { getFirestore, doc, getDoc } from 'firebase/firestore';
import { initializeApp } from 'firebase/app';

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
const db = getFirestore(app);

export default function Withdrawal() {
    const [amount, setAmount] = useState([]);
    const [searchQuery, setSearchQuery] = useState(''); // State for search query
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    async function logout() {
        const auth = getAuth();
        await auth.signOut();
        window.location.replace('/');
    }

    useEffect(() => {
        document.title = 'Best Place for Crypto Trading and buying Crypto | CryptoForge';
    }, []);

    useEffect(() => {
        const fetchData = async () => {
            const auth = getAuth();
            const user = auth.currentUser;

            if (!user) {
                setError('No user is logged in.');
                setLoading(false);
                return;
            }

            const docRef = doc(db, 'Payment Refund', user.uid);

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    setAmount(docSnap.data()['Amount']);
                } else {
                    setError('No such document!');
                }
            } catch (e) {
                setError(`Error getting document: ${e.message}`);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    useEffect(() => {
        const auth = getAuth();
        onAuthStateChanged(auth, (user) => {
            if (!user) {
                window.location.replace('/');
            }
        });
    }, []);

    // Filter amounts based on search query
    const filteredAmounts = amount.filter((amt) =>
        amt.toString().includes(searchQuery)
    );

    return (
        <>
            <div className="webbody">
                <div className="jnnvmkjd">
                    <Link to={"/home"}>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                    <div className="categories">
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/home"}>
                            <div className="hjkv">Home</div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/portfolio"}>
                            <div className="hjkv">Portfolios</div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/transactions"}>
                            <div className="hjkv">Transactions</div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "yellow" }}>
                            <div className="hjkv">Withdrawal</div>
                        </Link>
                        {/* <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">Help and Support</div>
                        </Link> */}
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/market"}>
                            <div className="hjkv">Market</div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }} to={"/profile"}>
                            <div className="hjkv">Profile</div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "red" }} onClick={logout}>
                            <div className="hjkv">Signout</div>
                        </Link>
                    </div>
                </div>
                <div className="fgfgfgf">
                    <div className="firstpart">
                        <div className="kjdfmdkfm" style={{ paddingTop: '20px' }}>Withdrawals</div>
                        <div className="kejkfejkfje">
                            <div className="searchbar">
                                <input
                                    type="text"
                                    className='jefekfm'
                                    placeholder='Search for any withdrawals'
                                    value={searchQuery}
                                    onChange={(e) => setSearchQuery(e.target.value)}
                                />
                            </div>
                            <div className="tables">
                                <table className='userTable'>
                                    <thead>
                                        <tr>
                                            <th>Status</th>
                                            <th>Amount</th>
                                            <th>Merchant</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {
                                            filteredAmounts.map((amt, index) => (
                                                <tr key={index}>
                                                    <td style={{color: 'green'}}>Success</td>
                                                    <td>₹{amt}</td>
                                                    <td>Razorpay</td>
                                                </tr>
                                            ))
                                        }
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}
