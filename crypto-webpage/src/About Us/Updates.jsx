import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'

export default function About() {
    useEffect(() => {
        document.title = 'Finance Flash - Latest News & Updates on Crypto Trading | CryptoForge'
    }, [])

    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetch('https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=7e9dca0b236b40889ff29da579280e8d');
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const result = await response.json();
                setData(result.articles); // Assuming the articles are in result.articles
            } catch (error) {
                setError(error.message);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    const [date, setDate] = useState('');

    useEffect(() => {
        const today = new Date();
        const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        const dayOfWeek = daysOfWeek[today.getDay()];
        const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        const dayOfMonth = today.getDate();
        const month = today.getMonth() + 1; // Months are 0-indexed
        const year = today.getFullYear();
        const formattedDate = `${dayOfWeek} ${dayOfMonth} ${months[month - 1]}`;
        setDate(formattedDate);
    }, []);

    return (
        <div className="webbody">
            <div className="jnnvmkjd">
                <Link to={'/'}>
                    <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                </Link>
                <div className="categories">
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Home
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                India
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                World
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Local
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Business
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Technology
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Entertainment
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Sports
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Science
                            </div>
                        </Link>
                        <Link style={{ textDecoration: "none", color: "white" }}>
                            <div className="hjkv">
                                Health
                            </div>
                        </Link>
                        <div className="hjkv">

                        </div>
                    </div>
            </div>
            <div className="maincontent">
                <div className="woijlf" style={{ fontSize: "30px" }}>
                    <div className="jfefj">
                        Your briefing
                    </div>
                    <div className="jefjewd" style={{ color: "grey", fontWeight: "300", fontSize: "15px" }}>
                        {date}
                    </div>
                    <Link className="newsbody">
                        <div>
                            Top stories
                        </div>
                    </Link>
                    {data.length > 0 && (
                        <div className="news-list">
                            {data.map((article, index) => (
                                <div key={index} className="news-item">
                                    <Link to={article.url} target="_blank" rel="noopener noreferrer" className="news-item">
                                        <h3>{article.title}</h3>
                                        {/* <p>{article.publishedAt}</p> */}
                                    </Link>
                                </div>
                            ))}
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}
