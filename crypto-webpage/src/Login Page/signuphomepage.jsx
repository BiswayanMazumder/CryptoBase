import React, { useEffect } from 'react'
import { Link } from 'react-router-dom'

export default function Signuphomepage() {
    useEffect(() => {
        document.title = "Log in - CryptoForge"
    })
    return (
        <>
            <div className="webbody">
                <div className="heading">
                    <Link to={'/'}>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                </div>
                <center>
                    <div className="loginoptions">
                        Sign up to CryptoForge
                        <div className="loginsignup">
                            <Link className="loginbutton" style={{backgroundColor:'transparent'}} to={'/login'}>
                                <div >
                                    Login
                                </div>
                            </Link>
                            <Link className="signup" style={{backgroundColor:'#1E2433'}}>
                                <div >Sign Up</div>
                            </Link>
                        </div>
                    </div>
                </center>
            </div>
        </>
    )
}
