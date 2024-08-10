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
                                        strings: ['India का  Ripple ','India का  Solana ','India का  Tron ',
                                        'India का  Matic ','India का  Etherium ','India का  Shiba Inu '],
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
                            </div>
                            <img src="https://media.wazirx.com/web_assets/landing_page_hero_app_screen/dark/2x.png" alt=""
                                loading='lazy' className='heroimage' />
                        </div>
                    </div>
                </div>
            </div>
        </>
    )
}
