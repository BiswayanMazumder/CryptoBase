import React, { useEffect } from 'react'
import { Link } from 'react-router-dom'

export default function Aboutus() {
    useEffect(() => {
        document.title = 'CryptoForge: About Us | Buy Sell or Trade 100+ Cryptocurrencies with Highest Liquidity'
    })
    return (
        <>
            <div className="webbody">
            <br />
                <div className="nfkfmvfmv">
                    <Link to={'/'}>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                </div>
                <div className="jjjfnkvnfkv">
                    <div className="jnfn">
                        Change Starts
                    </div>
                    <div className="jnfnj">
                        Together!
                    </div>
                </div>
                <div className="ejfjkj">
                    Creating an inclusive ecosystem to maximise the adoption and acceleration of Web3.
                </div>
                <div className="aboutusvideo">
                    <video src="https://coindcx.s3.amazonaws.com/static/images/about_us_page_video.mp4#t=5" height={'200px'} width={'auto'} autoPlay loop muted style={{ borderRadius: '20px' }} controls></video>
                </div>
                <div className="locationinfos">
                    <div className="jdjdkdf">
                        Who are we?
                        <div className="jfdkvd">
                            We are a team of 600+ enthusiasts who are driven with passion to build for the future of Web3. We are looking for individuals to help us build the ecosystem of digital society on the tenets of fairness, equality, openness and transparency. With opportunities that are at an All Time High, you get to innovate, grow and be a changemaker, together with people who inspire you to be extraordinary as we believe ‘Change Starts Together’
                        </div>
                    </div>
                    <br /><br /><br />
                    <div className="jhjfdkd">
                        <video
                            src="https://coindcx.s3.amazonaws.com/static/images/about_us_web_animation.mp4"
                            width="320"
                            autoplay
                            loop
                            muted
                            controls
                            style={{ borderRadius: "20px" }}
                        />

                    </div>
                </div>
            </div>
        </>
    )
}
