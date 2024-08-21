import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { getAuth } from "firebase/auth";
import { initializeApp } from "firebase/app";
import { getFirestore } from 'firebase/firestore';

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

export default function Marketplace() {
    async function logout() {
        const auth = getAuth();
        await auth.signOut();
        window.location.replace('/')
    }

    useEffect(() => {
        document.title = 'Best Place for Crypto Trading and Buying Crypto | CryptoForge';
    });

    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [searchTerm, setSearchTerm] = useState("");

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetch('https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en');
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const result = await response.json();
                setData(result);
            } catch (error) {
                setError(error.message);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    const formatPrice = (price) => {
        return price.toLocaleString('en-IN', { style: 'currency', currency: 'INR' });
    }

    const filteredData = data.filter(coin =>
        coin.name.toLowerCase().includes(searchTerm.toLowerCase())
    );
    function savedata(name,value,volume,low,high,sparkline,fullname,perc_24h) {
        localStorage.setItem("Name",name);
        localStorage.setItem("Value",value);
        localStorage.setItem("Volume",volume);
        localStorage.setItem("Low",low);
        localStorage.setItem("High",high);
        localStorage.setItem("Fullname",fullname);
        localStorage.setItem("Perc_24h",perc_24h);
        if (sparkline && sparkline.price) {
            localStorage.setItem('Price', JSON.stringify(sparkline.price));
        }
    }
    return (
        <>
            <div className="webbody">
                <div className="jnnvmkjdf">
                    <Link>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                    <div className="categories">
                        <Link style={{ textDecoration: "none", color: "white" }} to={'/home'}>
                            <div className="hjkv">
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
                        <Link style={{ textDecoration: "none", color: "yellow" }}>
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
                    </div>
                </div>
                <div className="emailaddress" style={{marginTop: "20px",marginLeft: "10px",marginRight: "50px"}}>
                            <input type="text" placeholder=" Search any coins" className='xjcxxckxc' id='whdujjfkem' value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)} style={{paddingLeft: "10px"}}/>
                        </div>
                <div className="uykfhrhkd">
                    {/* <div className="search-bar">
                        <input
                            type="text"
                            placeholder="Search Cryptocurrency"
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            className="search-input"
                        />
                    </div> */}
                    <div className="djgirfkgfmk">
                        <table className="market-table">
                            <thead>
                                <tr>
                                    <th>Coin</th>
                                    <th>Price</th>
                                    <th>24h Change</th>
                                </tr>
                            </thead>
                            <tbody>
                                {filteredData.map(coin => (
                                    <tr key={coin.id}>
                                        <td className="coin-cell">
                                            <img src={coin.image} alt={coin.name} height={40} width={40} />
                                            <span className="coin-name">{coin.name}</span>
                                        </td>
                                        <td className="price-cell" style={{ color: coin.price_change_percentage_24h < 0 ? "red" : "green" }}>
                                            {formatPrice(coin.current_price)}
                                        </td>
                                        <td className="change-cell" style={{ color: coin.price_change_percentage_24h < 0 ? "red" : "green" }}>
                                            {coin.price_change_percentage_24h >= 0 ? `+${coin.price_change_percentage_24h.toFixed(2)}` : coin.price_change_percentage_24h.toFixed(2)}%
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </>
    );
}
