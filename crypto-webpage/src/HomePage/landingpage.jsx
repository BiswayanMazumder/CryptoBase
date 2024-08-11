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
                    <img src="https://media.wazirx.com/web_assets/landing_bg/dark/1x.svg" alt="" className='bodyimage' />
                    <div className="firstpartcontents">
                        <div className="texts">
                            <div className="headers">
                                <Typewriter
                                    options={{
                                        strings: ['India का  Ripple ', 'India का  Solana ', 'India का  Tron ',
                                            'India का  Matic ', 'India का  Etherium ', 'India का  Shiba Inu '],
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
                                <div className="downloadbtn">
                                    <div className="externalbtns">
                                        <div className="playstorebtn">
                                            <img src="https://media.wazirx.com/web_assets/download_from_playstore_btn/dark/1x.svg" alt="" className='playstoreimg' />
                                        </div>
                                        <div className="playstorebtn">
                                            <img src="https://media.wazirx.com/web_assets/download_from_appstore_btn/dark/1x.svg" alt="" className='playstoreimg' />
                                        </div>
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
                
                <div className="secondpart">
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
                </div>
                <br /><br />
            </div>
        </>
    )
}
