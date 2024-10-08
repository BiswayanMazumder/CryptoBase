import React, { useEffect } from 'react'
import { Link } from 'react-router-dom'
import Typewriter from 'typewriter-effect';
export default function Download() {
    useEffect(() => {
        document.title = 'Download CryotoForge Apps - Best Crypto Wallet App to Buy Bitcoin'
    })
    return (
        <>
            <div className="webbody">
                <div className="heading">
                    <Link to={'/'}>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                    <Link to={'/download'} style={{ paddingRight: "20px" }}>
                        <div className="idsksld" style={{ backgroundColor: "#101723" }}>
                            <svg width="24" height="24" fill="white" viewBox="0 0 1024 1024" class="sc-fFucqa hUWLJA"><path d="M695.467 209.067v618.666H294.4V209.067h401.067zM776.533 128h-563.2v780.8H780.8V128h-4.267z"></path><path d="M648.533 499.2l-153.6 149.333-153.6-149.333 55.467-55.467 59.733 76.8v-230.4h76.8v230.4l59.734-76.8 55.466 55.467zm-247.85 188.117v76.8h192v-76.8h-192z" fill='white'></path></svg>
                        </div>
                    </Link>
                </div>
                <div className="sdssww">
                    {/* <div className="ldkcdms" style={{width:"100%",height:"600px"\}}>
                <video src="https://videos.pexels.com/video-files/4389377/4389377-uhd_2732_1440_30fps.mp4" alt="" className='bodyimage' autoPlay loop muted />
                </div> */}
                    <div className="owck" style={{ paddingTop: "30px", width: "100%", zIndex: "999" }}>
                        <i >DOWNLOAD CRYPTOFORGE</i>
                    </div>
                    <div className="wjdsjcldkmc">
                        India’s only exchange with apps across 5 platforms! Say hello to a more powerful & seamless trading experience.
                    </div>
                    <center><img src="https://wazirx.com/static/media/downloads-banner-devices.bf2c48f1.png" alt="" className='jkhjkshk' /></center>
                </div>
                {/* <center> */}
                <div className="ewkfwj">
                    <div className="oijff">
                        <div className="jdnsd" style={{ fontWeight: "bold", color: "white", fontSize: "20px" }}>
                        <Typewriter
                                    options={{
                                        strings: ['Lightning fast for the trader in you', 'Must-have for pro traders', 'Tweak the order and save time', 'Track your order', 'Pulse of the market'],
                                        autoStart: true,
                                        loop: true,
                                        cursor: '|',
                                        delay: 75,
                                    }}
                                />
                        </div>
                        <br />
                        <Typewriter
                                    options={{
                                        strings: ['There is speed and fluidity in everything you do. Every decision that goes into our app makes it stand apart - from the way it’s designed to the way we build in performance. We are by your side when you trade in a blink.', 'Most of the experience has been stitched keeping pro-traders in mind. There’s advance order book to calculate liquidity and price actions at a glance. Take actions from order-book, trade history, and many more essential touch points. Launch buy and sell sheet almost anywhere.', 'One-tap order edit to keep you up in the order book. This is love at first sight.', 'Information is fundamental to trading, and we strive to make this easy for you. Order-books say a lot about the market, and in between orders, you can now track your position like a boss.', 'Smart notifications to track trending markets, and ensure that you will not miss the pumps or dumps! We’ll only seek your attention when and where it is needed.'],
                                        autoStart: true,
                                        loop: true,
                                        cursor: '|',
                                        delay: 75,
                                    }}
                                />
                    </div>
                    <div className="wowkdoko">
                        <img src="https://wazirx.com/static/media/downloads-bullet-02-l2.dd2b106c.gif" alt="" style={{
                            height: "300px", width: "170px"
                        }} />
                    </div>
                </div>
                <div className="downloadcryptoforge">
                    <div className="jhfjgj">
                        <Link to={'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/CryptoBase.apk?t=2024-08-18T07%3A27%3A41.893Z'}>
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
                    <div className="djdfkd">
                        <Link to={'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/CryptoBase.apk?t=2024-08-18T07%3A27%3A41.893Z'} >
                            <div className="playstorebtn">
                                <img src="https://media.wazirx.com/web_assets/download_from_playstore_btn/dark/1x.svg" alt="" className='playstoreimg' />
                            </div>
                        </Link>
                        <Link to={'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/CryptoBase.apk?t=2024-08-18T07%3A27%3A41.893Z'}>
                            <div className="playstorebtn">
                                <img src="https://media.wazirx.com/web_assets/download_from_appstore_btn/dark/1x.svg" alt="" className='playstoreimg' />
                            </div>
                        </Link>
                    </div>
                </div>
                {/* </center> */}
            </div>
        </>
    )
}
