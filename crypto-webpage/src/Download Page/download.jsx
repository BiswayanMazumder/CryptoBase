import React, { useEffect } from 'react'
import { Link } from 'react-router-dom'

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
                    <div className="owck" style={{ paddingTop: "30px", width: "100%",zIndex: "999" }}>
                        <i >DOWNLOAD CRYPTOFORGE</i>
                    </div>
                    <div className="wjdsjcldkmc">
                        India’s only exchange with apps across 5 platforms! Say hello to a more powerful & seamless trading experience.
                    </div>
                    <center><img src="https://wazirx.com/static/media/downloads-banner-devices.bf2c48f1.png" alt="" className='jkhjkshk' /></center>
                </div>
            </div>
        </>
    )
}
