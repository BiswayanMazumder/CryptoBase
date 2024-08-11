import React from 'react'
import { Link } from 'react-router-dom';
import Typewriter from 'typewriter-effect';
export default function Landingpage() {
    function setdoctitle() {
        document.title = 'Buy Bitcoin, Cryptocurrency at India’s Largest Exchange | Trading Platform | CryptoBase'
    }

    return (
        <>
            <div className="webbody" onLoad={setdoctitle()}>
                <div className="firstpart">
                    <video src="https://videos.pexels.com/video-files/4389377/4389377-uhd_2732_1440_30fps.mp4" alt="" className='bodyimage' autoPlay loop muted />
                    <div className="firstpartcontents">
                        <div className="texts">
                            <div className="headers">
                                <Typewriter
                                    options={{
                                        strings: ['India का  Ripple ', 'India का  Solana ', 'India का  Tron ',
                                            'India का  Matic ', 'India का  Ethereum ', 'India का  Shiba Inu '],
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
                                        <Link className="signupbtn">
                                            <div >
                                                SIGN UP
                                            </div>
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
                                    <Link className="signupbtn">
                                        <div >
                                            SIGN UP
                                        </div>
                                    </Link>
                                    {/* <div className="heroimagecont">
                                    <img src="https://media.wazirx.com/web_assets/landing_page_hero_app_screen/dark/2x.png" alt=""
                                        loading='lazy' className='heroimagemobo' />
                                    </div> */}
                                </div>

                            </div>
                            <img src="https://media.wazirx.com/web_assets/landing_page_hero_app_screen/dark/2x.png" alt=""
                                loading='lazy' className='heroimage' />
                        </div>
                    </div>
                </div>
                <section className="secondpart">
                    <div className="firstinfo">
                        300+ cryptos to invest in for your next big move
                        <img src="
                    https://media.wazirx.com/web_assets/cryptos/dark/3x.png" alt="" className='detailsimg' />
                    </div>
                    <div className="firstinfo">
                        India’s best prices, driven by highest liquidity
                        <img src="
                    https://media.wazirx.com/web_assets/liquidity/dark/3x.png" alt="" className='detailsimg' />
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
                    <div className="firstfeature" >
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
                <br /><br /><br />
            </div>
        </>
    )
}
