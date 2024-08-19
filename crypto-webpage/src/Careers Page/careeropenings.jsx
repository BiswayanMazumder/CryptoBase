import React, { useState } from 'react'
import { Link } from 'react-router-dom'

export default function Careeropenings() {
    const [blr, setblr] = useState(true);
    const [del, setdel] = useState(false);
    const [mum, setmum] = useState(false);
    function BangaloreLocset() {
        if (!blr) {
            setblr(true);
            setdel(false);
            setmum(false);
        }
    }
    function MumbaiLocset() {
        setblr(false);
        setdel(false);
        setmum(true);
    }
    function DelhiLocset() {
        setblr(false);
        setdel(true);
        setmum(false);
    }
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
                <div className="openingdetails">
                    <div className="jhfjkfnjvfnv">
                        <table className='openingtable'>
                            <th>Req Title</th>
                            <th>Unit</th>
                            <th>Location</th>
                            <th>Positions</th>
                        </table>
                    </div>
                    
                </div>
                <div className="jjjfnkvnfkv" style={{ position: "relative", top: "200px" }}>
                    <div className="jnfn">
                        Discover Our
                    </div>
                    <div className="jnfnj">
                        Spaces
                    </div>
                </div>
                <div className="locations">
                    <div className="jhdjfndn" style={{ backgroundColor: blr ? 'orangered' : "transparent" }}>
                        <Link style={{ textDecoration: "none", color: "white", }} onClick={BangaloreLocset}>
                            Bengaluru
                        </Link>
                    </div>
                    <div className="jhdjfndn" style={{ textDecoration: "none", color: "white", backgroundColor: mum ? 'orangered' : "transparent" }}>
                        <Link style={{ textDecoration: "none", color: "white" }} onClick={MumbaiLocset}>
                            Mumbai
                        </Link>
                    </div>
                    <div className="jhdjfndn" style={{ textDecoration: "none", color: "white", backgroundColor: del ? 'orangered' : "transparent" }}>
                        <Link style={{ textDecoration: "none", color: "white" }} onClick={DelhiLocset}>
                            Delhi
                        </Link>
                    </div>
                </div>
                <div className="locationinfos">
                    <div className="jdjdkdf">
                        {
                            blr ? ' Bengaluru' : mum ? 'Mumbai' : 'Delhi'
                        }
                        <div className="jfdkvd">
                            {
                                blr ? ' Located at the heart of Namma Bengaluru, it is fully equipped with a large cafeteria, gym as well as a lounge area to help you recharge post work. With beautiful views and a pantry full of delicious snacks, enjoy BUILDing in this workplace.' : mum ? 'Our Mumbai office is located in a socially active area - Andheri which gives you a variety of places to explore. With large windows to thoroughly enjoy the beautiful views and the convenience of being situated near the metro station, it is surrounded by numerous food outlets to satiate all your cravings from delicious buffets, to burgers.' : 'This cozy workspace is sure to make you feel like you’re home. Surrounded by many spots you can hangout post work, including malls, theatres and delicious street delights.'
                            }
                            <br /><br /><br />
                        </div>
                    </div>
                    <div className="jhjfdkd">
                        <video
                            src="https://coindcx.s3.amazonaws.com/static/images/life_at_coindcx_page_video.mp4"
                            width="300"
                            autoplay
                            loop
                            muted
                            controls
                            style={{ borderRadius: "20px" }}
                        />

                    </div>
                </div>
                <div className="jvkfklkflklf">
                    <div className="jigjfkkgldk">
                        <img src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRR3qpnbkv573m6cEpjB3h1wsxj9CV5IiHpY1Xc5I-i8KzdNF89" alt="" className='njfnkf' />
                        <div className="fjfkbvbmfbm">
                            Didn’t find the position you are looking for?
                            <div className="jdfndvn">
                                We will find one for you! Drop in your CV at apply@cryptoforge.com
                            </div>
                            <br /><br />
                            <a className="djfkdkfmd" href="mailto:apply@cryptoforge.com">
                                <div>
                                    Apply Now
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
        </div>
    </>
  )
}
