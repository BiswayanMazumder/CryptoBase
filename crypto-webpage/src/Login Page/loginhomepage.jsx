import React, { useEffect } from 'react'
import { Link } from 'react-router-dom'

export default function Loginhomepage() {
    useEffect(() => {
        document.title = "Log in - CryptoForge"
    })
  return (
   <>
    <div className="webbody">
        <div className="heading">
            <Link to={'/'}>
            <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo'/>
            </Link>
        </div>
        <center>
            <div className="loginoptions">
            Login to WazirX
            </div>
        </center>
    </div>
   </>
  )
}
