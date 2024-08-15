import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Typewriter from 'typewriter-effect';
import { getAuth, onAuthStateChanged } from "firebase/auth";
export default function Landingpage() {
    function setdoctitle() {
        document.title = 'Buy Bitcoin, Cryptocurrency at India’s Largest Exchange | Trading Platform | CryptoForge';
    }

    function changefeature() {
        var thirdsection = document.querySelector('.thirdsection');
        thirdsection.scrollIntoView({ behavior: "smooth" });
        thirdsection.innerHTML += `<img src="https://media.wazirx.com/web_assets/landing_page_feature1/dark/3x.png" alt="" className='featureimagechanging'  />`;
    }

    const images = [
        'https://media.wazirx.com/web_assets/landing_page_feature1/dark/3x.png',
        'https://media.wazirx.com/web_assets/landing_page_feature2/dark/3x.png',
        'https://media.wazirx.com/web_assets/landing_page_feature3/dark/3x.png',
        'https://media.wazirx.com/web_assets/landing_page_feature4/dark/3x.png'
    ];

    useEffect(() => {
        setdoctitle();

        const interval = setInterval(() => {
            const elements = document.querySelectorAll('.subtextfeaturechanging span');
            const currentIndex = Math.floor(Date.now() / 10000) % elements.length;
            elements.forEach((element, index) => {
                element.style.color = index === currentIndex ? 'white' : 'grey';
            });

            // Change the image
            const imageElement = document.querySelector('.featureimagechanging');
            if (imageElement) {
                imageElement.src = images[currentIndex];
            }
        }, 1000);

        return () => clearInterval(interval);
    }, []);
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
    useEffect(() => {
        const auth = getAuth();
        onAuthStateChanged(auth, (user) => {
            if (user) {
                // User is signed in, see docs for a list of available properties
                // https://firebase.google.com/docs/reference/js/auth.user
                const uid = user.uid;
                console.log('User is signed in:', uid);
                window.location.replace('/home')
                // ...
            } else {
                // User is signed out
                console.log('User is not signed')
                // window.location.replace('/')
                // ...
            }
        });
    })
    const firstFourData = data.slice(0, 4);
    return (
        <>
            <div className="webbody">
                <div className="firstpart">
                    <video src="https://videos.pexels.com/video-files/4389377/4389377-uhd_2732_1440_30fps.mp4" alt="" className='bodyimage' autoPlay loop muted />
                    <div className="firstpartcontents">
                        <div className="texts">
                            <div className="headers">
                                <Typewriter
                                    options={{
                                        strings: ['India का Ripple ', 'India का Solana ', 'India का Tron ', 'India का Matic ', 'India का Ethereum ', 'India का Shiba Inu '],
                                        autoStart: true,
                                        loop: true,
                                        cursor: '|',
                                        delay: 75,
                                    }}
                                />
                                Exchange
                                <div className="subtext">
                                    Trusted By 15 million+ Indians
                                </div>
                                <div className="downloadbtnmobo">
                                    <div className="externalbtnsmobo">
                                        <Link to={'https://play.google.com/store/apps/details?id=com.wrx.wazirx&referrer=utm_source%3DWazirX%2520Desktop%26utm_medium%Hero%2520Image%26utm_term%3DDownload%2520App'} target='blank'>
                                            <div className="playstorebtn">
                                                <img src="https://media.wazirx.com/web_assets/download_from_playstore_btn/dark/1x.svg" alt="" className='playstoreimg' />
                                            </div>
                                        </Link>
                                        <Link to={'https://apps.apple.com/in/app/wazirx-buy-btc-trade-crypto/id1349082789'} target='blank'>
                                            <div className="playstorebtn">
                                                <img src="https://media.wazirx.com/web_assets/download_from_appstore_btn/dark/1x.svg" alt="" className='playstoreimg' />
                                            </div>
                                        </Link>
                                        <Link className="signupbtn" to={'/login'}>
                                            <div>SIGN UP</div>
                                        </Link>
                                    </div>
                                </div>
                                <div className="downloadbtn">
                                    <div className="externalbtns">
                                        <Link to={'https://play.google.com/store/apps/details?id=com.wrx.wazirx&referrer=utm_source%3DWazirX%2520Desktop%26utm_medium%Hero%2520Image%26utm_term%3DDownload%2520App'} target='blank'>
                                            <div className="playstorebtn">
                                                <img src="https://media.wazirx.com/web_assets/download_from_playstore_btn/dark/1x.svg" alt="" className='playstoreimg' />
                                            </div>
                                        </Link>
                                        <Link to={'https://apps.apple.com/in/app/wazirx-buy-btc-trade-crypto/id1349082789'} target='blank'>
                                            <div className="playstorebtn">
                                                <img src="https://media.wazirx.com/web_assets/download_from_appstore_btn/dark/1x.svg" alt="" className='playstoreimg' />
                                            </div>
                                        </Link>
                                    </div>
                                    <Link className="signupbtn" to={'/login'}>
                                        <div>SIGN UP</div>
                                    </Link>
                                </div>
                            </div>
                            <img src="https://media.wazirx.com/web_assets/landing_page_hero_app_screen/dark/2x.png" alt="" loading='lazy' className='heroimage' />
                        </div>
                    </div>
                </div>
                <section className="secondpart">
                    <div className="firstinfo">
                        300+ cryptos to invest in for your next big move
                        <img src="https://media.wazirx.com/web_assets/cryptos/dark/3x.png" alt="" className='detailsimg' />
                    </div>
                    <div className="firstinfo">
                        India’s best prices, driven by highest liquidity
                        <img src="https://media.wazirx.com/web_assets/liquidity/dark/3x.png" alt="" className='detailsimg' />
                    </div>
                </section>
                <center>
                    <section className='thirdsection'>
                        <div className="firstfeature">
                            <center>
                                <div className="featurebox">
                                    <center>
                                        <img src="https://media.wazirx.com/web_assets/good_security_white/dark/1x.svg" alt="" className='featureimage' />
                                    </center>
                                </div>
                            </center>
                            KYC - Swift & Compliant
                            <div className="subtextfeature">
                                Experience seamless onboarding <br />with swift KYC processes, ensuring <br />full compliance with regulations.
                            </div>
                        </div>
                        <div className="firstfeature">
                            <center>
                                <div className="featurebox" style={{ backgroundColor: '#EE895B' }}>
                                    <center>
                                        <img src="https://media.wazirx.com/web_assets/live_help_white/dark/1x.svg" alt="" className='featureimage' />
                                    </center>
                                </div>
                            </center>
                            24/7 Support
                            <div className="subtextfeature">
                                Like a trusted friend, our 24/7 expert <br /> support is always there, making your <br /> crypto investment journey smoother.
                            </div>
                        </div>
                        <div className="firstfeature">
                            <center>
                                <div className="featurebox" style={{ backgroundColor: "#F56565" }}>
                                    <center>
                                        <img src="https://media.wazirx.com/web_assets/api_white/dark/1x.svg" alt="" className='featureimage' />
                                    </center>
                                </div>
                            </center>
                            Seamless API Trading
                            <div className="subtextfeature">
                                Amplify your crypto trading <br /> experience with ChainTrade through <br />seamless API integration.
                            </div>
                        </div>
                    </section>
                </center>
                <center>
                    <section className='thirdsection'>
                        <div className="firstfeature" style={{ fontSize: "25px" }}>
                            Features You Will Love
                            <div className="subtextfeaturechanging">
                                <span>Stay informed, stay engaged - an all- <br /> inclusive dashboard, keeping you always <br /> in action.</span>
                                {/* <br /><br /> */}
                                <span>Simplify your crypto trading journey with <br />QuickBuy—the fastest way to buy and <br />sell your favorites.</span>
                                {/* <br /><br /> */}
                                <span>Take control with advanced P&L tracking <br /> for smarter decision-making.</span>
                                {/* <br /><br /> */}
                                <span>Refer, Earn, Repeat: With our unique  <br />Referral Program, you can invite friends <br />and earn up to 50% of their trading fees.</span>
                            </div>
                        </div>
                        <img src="https://media.wazirx.com/web_assets/landing_page_feature3/dark/3x.png" alt="" className='featureimagechanging' />
                    </section>
                </center>
                <section className='Cryptovalues'>
                    <div className="cryptotexts">
                        Top crypto today
                    </div>
                    <Link className="dfknf" style={{ textDecoration: "none", color: "white" }}>
                        {firstFourData.map(coin => (
                            <div key={coin.id} className="cryptocontainers">
                                <center>
                                    {coin.name}
                                    <div className="dcdjksj">
                                        {coin.symbol.toUpperCase()}
                                    </div>
                                    ₹{coin.current_price.toLocaleString('en-IN', { maximumFractionDigits: 2 })}
                                </center>
                            </div>
                        ))}
                    </Link>
                </section>
                <center>
                    <div className="thirdsectext">
                        <center>Your Security Matters</center>
                    </div>
                    <section className='thirdsection'>
                        <div className="firstfeature">

                            <center>
                                <div className="featurebox">
                                    <center>
                                        <img src="https://media.wazirx.com/web_assets/sd_card/dark/1x.svg" alt="" className='featureimage' />
                                    </center>
                                </div>
                            </center>
                            Safekeeping Your Digital Assets
                            <div className="subtextfeature">
                                We keep your digital assets safe with an extra layer of <br /> security.
                            </div>
                        </div>
                        <div className="firstfeature">
                            <center>
                                <div className="featurebox" style={{ backgroundColor: '#EE895B' }}>
                                    <center>
                                        <img src="https://media.wazirx.com/web_assets/live_help_white/dark/1x.svg" alt="" className='featureimage' />
                                    </center>
                                </div>
                            </center>
                            2 - Factor Authentication
                            <div className="subtextfeature">
                                Double your CryptoForge account security with 2-factor  <br />authentication - choose the setup that suits you best.
                            </div>
                        </div>
                        <div className="firstfeature">
                            <center>
                                <div className="featurebox" style={{ backgroundColor: "#F56565" }}>
                                    <center>
                                        <img src="https://media.wazirx.com/web_assets/api_white/dark/1x.svg" alt="" className='featureimage' />
                                    </center>
                                </div>
                            </center>
                            End-to-End Encryption
                            <div className="subtextfeature">
                                We use advanced encryption and follow the <br /> highest  industry standards, ensuring worry-free crypto <br />trading and investment for you.
                            </div>
                        </div>
                    </section>
                </center>
                <center>
                </center>
            </div>
        </>
    );
}
