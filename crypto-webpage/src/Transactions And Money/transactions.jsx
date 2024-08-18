import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { getAuth, onAuthStateChanged } from 'firebase/auth';
import { getFirestore, doc, getDoc } from 'firebase/firestore';
import { initializeApp } from 'firebase/app';

const firebaseConfig = {
    apiKey: 'AIzaSyCxkw9hq-LpWwGwZQ0APU0ifJ5JQU2T8Vk',
    authDomain: 'cryptobase-admin.firebaseapp.com',
    projectId: 'cryptobase-admin',
    storageBucket: 'cryptobase-admin.appspot.com',
    messagingSenderId: '1090236390686',
    appId: '1:1090236390686:web:856b22fd209b267b89fd0f',
    measurementId: 'G-LTBWYEEF6E',
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

export default function Transactions() {
    const [amount, setAmount] = useState([]);
    const [filteredAmount, setFilteredAmount] = useState([]);
    const [searchQuery, setSearchQuery] = useState('');
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

            const docRef = doc(db, 'Payment Amount', user.uid);

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    const amounts = docSnap.data()['Amount'] || [];
                    setAmount(amounts);
                    setFilteredAmount(amounts);
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
        const unsubscribe = onAuthStateChanged(auth, (user) => {
            if (!user) {
                window.location.replace('/');
            }
        });

        return () => unsubscribe(); // Clean up subscription on component unmount
    }, []);

    useEffect(() => {
        if (searchQuery === '') {
            setFilteredAmount(amount);
        } else {
            const filtered = amount.filter((amt) =>
                amt.toString().includes(searchQuery)
            );
            setFilteredAmount(filtered);
        }
    }, [searchQuery, amount]);

    return (
        <>
            <div className="webbody">
                <div className="jnnvmkjd">
                    <Link to={"/home"}>
                        <img
                            src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0"
                            alt=""
                            className="homelogo"
                        />
                    </Link>
                    <div className="categories">
                        <Link style={{ textDecoration: 'none', color: 'white' }} to={"/home"}>
                            <div className="hjkv">Home</div>
                        </Link>
                        <Link style={{ textDecoration: 'none', color: 'white' }} to={"/portfolio"}>
                            <div className="hjkv">Portfolios</div>
                        </Link>
                        <Link style={{ textDecoration: 'none', color: 'yellow' }}>
                            <div className="hjkv">Transactions</div>
                        </Link>
                        <Link style={{ textDecoration: 'none', color: 'white' }} to={"/withdrawal"}>
                            <div className="hjkv">Withdrawal</div>
                        </Link>
                        <Link style={{ textDecoration: 'none', color: 'white' }}>
                            <div className="hjkv">Help and Support</div>
                        </Link>
                        <Link style={{ textDecoration: 'none', color: 'white' }} to={"/market"}>
                            <div className="hjkv">Market</div>
                        </Link>
                        <Link style={{ textDecoration: 'none', color: 'white' }} to={"/profile"}>
                            <div className="hjkv">Profile</div>
                        </Link>
                        <Link style={{ textDecoration: 'none', color: 'red' }} onClick={logout}>
                            <div className="hjkv">Signout</div>
                        </Link>
                        <div className="hjkv"></div>
                    </div>
                </div>
                <div className="fgfgfgf">
                    <div className="firstpart">
                        <div className="kjdfmdkfm" style={{ paddingTop: '20px' }}>
                            Transactions
                        </div>
                        <div className="kejkfejkfje">
                            <div className="searchbar">
                                <input
                                    type="text"
                                    className="jefekfm"
                                    placeholder="Search for any transactions"
                                    value={searchQuery}
                                    onChange={(e) => setSearchQuery(e.target.value)}
                                />
                            </div>
                            <div className="history">
                                <div className="lfjmrkl">
                                    <div className="dfvd">Status</div>
                                    <div className="dfvd" style={{ marginLeft: '20px' }}>
                                        Amount
                                    </div>
                                    <div className="dfvd">Payment Merchant</div>
                                </div>
                                <div className="rjggkmk" style={{ gap: '10px' }}>
                                    <br />
                                    {filteredAmount.map((amt, index) => (
                                        <div className="lfjmrkl" style={{ paddingBottom: '20px' }} key={index}>
                                            <div className="dfvd" style={{ color: 'green' }}>
                                                Success
                                            </div>
                                            <div className="dfvd">₹{amt}</div>
                                            <div className="dfvd">Razorpay</div>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}