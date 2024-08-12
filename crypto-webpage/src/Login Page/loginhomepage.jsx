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
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                </div>
                <center>
                    <div className="loginoptions">
                        Login to CryptoForge
                        <div className="loginsignup">
                            <Link className="loginbutton">
                                <div >
                                    Login
                                </div>
                            </Link>
                            <Link className="signup" to={'/signup'} >
                                <div >Sign Up</div>
                            </Link>
                        </div>
                        <div className="emailaddress">
                            <input type="text" placeholder=" Enter your email" className='xjcxxckxc' />
                        </div>
                        <div className="emailaddress">
                            <input type="password" placeholder=" Enter your password" className='xjcxxckxc' />
                        </div>
                        <Link className="dnjdkssq">
                            <div>
                                Forgot Password
                            </div>
                        </Link>
                        <div className="loginsignup" style={{ backgroundColor: '#3067F0', justifyContent: "center", fontWeight: "bold", marginBottom: "10px" }}>
                            LOGIN
                        </div>
                        <div className="emailaddress" style={{
                            justifyContent: "center",
                            textAlign: "center", fontSize: "15px", marginBottom: "10px",
                        }}>
                            OR
                        </div>
                        <div className="loginsignup" style={{ backgroundColor: 'transparent', justifyContent: "center", fontWeight: "bold", marginBottom: "20px", border: "1px solid #3067F0", gap: "10px" }}>
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"><path d="M18.1712 8.36727H17.5V8.33268H9.99996V11.666H14.7095C14.0225 13.6064 12.1762 14.9993 9.99996 14.9993C7.23871 14.9993 4.99996 12.7606 4.99996 9.99935C4.99996 7.2381 7.23871 4.99935 9.99996 4.99935C11.2745 4.99935 12.4341 5.48018 13.317 6.2656L15.6741 3.90852C14.1858 2.52143 12.195 1.66602 9.99996 1.66602C5.39788 1.66602 1.66663 5.39727 1.66663 9.99935C1.66663 14.6014 5.39788 18.3327 9.99996 18.3327C14.602 18.3327 18.3333 14.6014 18.3333 9.99935C18.3333 9.4406 18.2758 8.89518 18.1712 8.36727Z" fill="#FFC107"></path><path d="M2.62744 6.1206L5.36536 8.12852C6.10619 6.29435 7.90036 4.99935 9.99994 4.99935C11.2745 4.99935 12.4341 5.48018 13.317 6.2656L15.6741 3.90852C14.1858 2.52143 12.1949 1.66602 9.99994 1.66602C6.79911 1.66602 4.02327 3.4731 2.62744 6.1206Z" fill="#FF3D00"></path><path d="M9.99999 18.3336C12.1525 18.3336 14.1083 17.5099 15.5871 16.1703L13.0079 13.9878C12.1712 14.6215 11.1312 15.0003 9.99999 15.0003C7.83249 15.0003 5.99207 13.6182 5.29874 11.6895L2.58124 13.7832C3.9604 16.482 6.76124 18.3336 9.99999 18.3336Z" fill="#4CAF50"></path><path d="M18.1712 8.36857H17.5V8.33398H10V11.6673H14.7096C14.3796 12.5994 13.78 13.4032 13.0067 13.9886L13.0079 13.9877L15.5871 16.1702C15.4046 16.3361 18.3333 14.1673 18.3333 10.0007C18.3333 9.4419 18.2758 8.89648 18.1712 8.36857Z" fill="#1976D2"></path></svg>
                            Continue with Google
                        </div>
                    </div>

                </center>

            </div>
        </>
    )
}
