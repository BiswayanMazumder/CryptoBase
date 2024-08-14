import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { getAuth, signInWithPopup, GoogleAuthProvider, createUserWithEmailAndPassword } from "firebase/auth";
import { doc, getFirestore, setDoc } from "firebase/firestore";
import { initializeApp } from "firebase/app";
const provider = new GoogleAuthProvider();
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyCxkw9hq-LpWwGwZQ0APU0ifJ5JQU2T8Vk",
    authDomain: "cryptobase-admin.firebaseapp.com",
    projectId: "cryptobase-admin",
    storageBucket: "cryptobase-admin.appspot.com",
    messagingSenderId: "1090236390686",
    appId: "1:1090236390686:web:856b22fd209b267b89fd0f",
    measurementId: "G-LTBWYEEF6E"
};
const app = initializeApp(firebaseConfig);
// Initialize Cloud Firestore and get a reference to the service
const db = getFirestore(app);
export default function Signuphomepage() {
    useEffect(() => {
        document.title = "Sign up - CryptoForge"
    })
    async function googlelogin() {
        const auth = getAuth();
        signInWithPopup(auth, provider)
            .then((result) => {
                // This gives you a Google Access Token. You can use it to access the Google API.
                const credential = GoogleAuthProvider.credentialFromResult(result);
                const token = credential.accessToken;
                // The signed-in user info.
                const user = result.user;
                // IdP data available using getAdditionalUserInfo(result)
                // ...
            }).catch((error) => {
                // Handle Errors here.
                const errorCode = error.code;
                const errorMessage = error.message;
                // The email of the user's account used.
                const email = error.customData.email;
                // The AuthCredential type that was used.
                const credential = GoogleAuthProvider.credentialFromError(error);
                // ...
            });
    }
    async function signup() {
        const auth = getAuth();
        const db = getFirestore(); // Initialize Firestore

        const name = document.getElementById('skdkdwld').value;
        const email = document.getElementById('okslxzdlkdm').value;
        const password = document.getElementById('wioiwodkwl').value;

        console.log(email, name, password);

        try {
            // Create user with email and password
            const userCredential = await createUserWithEmailAndPassword(auth, email, password);

            // Get the newly created user ID
            const userId = userCredential.user.uid;

            // Define user data to be stored
            const userData = {
                Name: name,
                Email: email
            };
            // Write user data to Firestore in 'User Details' collection with document ID as userId
            await setDoc(doc(db, 'User Details', userId), userData);

            console.log('User created and details written to Firestore!');
            window.location.href = '/';
        } catch (error) {
            console.error('Error creating user or writing to Firestore:', error);
        }
    }
    async function googlelogin() {
        const auth = getAuth();
        signInWithPopup(auth, provider)
            .then((result) => {
                // This gives you a Google Access Token. You can use it to access the Google API.
                const credential = GoogleAuthProvider.credentialFromResult(result);
                const token = credential.accessToken;
                // The signed-in user info.
                const user = result.user;
                // IdP data available using getAdditionalUserInfo(result)
                // ...
            }).catch((error) => {
                // Handle Errors here.
                const errorCode = error.code;
                const errorMessage = error.message;
                // The email of the user's account used.
                const email = error.customData.email;
                // The AuthCredential type that was used.
                const credential = GoogleAuthProvider.credentialFromError(error);
                // ...
            });
    }
    const [passwordHidden, setPasswordHidden] = useState(true);
    const handleClick = () => {
        setPasswordHidden(!passwordHidden);
        console.log('Password hidden:', passwordHidden);
    };
    return (
        <>
            <div className="webbody">
                <div className="heading">
                    <Link to={'/'}>
                        <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" alt="" className='homelogo' />
                    </Link>
                    <Link to={'/download'} style={{ paddingRight: "20px" }}>
                        <div className="idsksld">
                            <svg width="24" height="24" fill="white" viewBox="0 0 1024 1024" class="sc-fFucqa hUWLJA"><path d="M695.467 209.067v618.666H294.4V209.067h401.067zM776.533 128h-563.2v780.8H780.8V128h-4.267z"></path><path d="M648.533 499.2l-153.6 149.333-153.6-149.333 55.467-55.467 59.733 76.8v-230.4h76.8v230.4l59.734-76.8 55.466 55.467zm-247.85 188.117v76.8h192v-76.8h-192z" fill='white'></path></svg>
                        </div>
                    </Link>
                </div>
                <center>
                    <div className="loginoptions">
                        Sign up to CryptoForge
                        <div className="loginsignup">
                            <Link className="loginbutton" style={{ backgroundColor: 'transparent' }} to={'/login'}>
                                <div >
                                    Login
                                </div>
                            </Link>
                            <Link className="signup" style={{ backgroundColor: '#1E2433' }}>
                                <div >Sign Up</div>
                            </Link>
                        </div>
                        <div className="emailaddress">
                            <input type="text" placeholder=" Enter your name" className='xjcxxckxc' id='skdkdwld' />
                        </div>
                        <div className="emailaddress">
                            <input type="text" placeholder=" Enter your email" className='xjcxxckxc' id='okslxzdlkdm' />
                        </div>
                        <div className="emailaddress">
                            <div className="input-container">
                                <input type={passwordHidden ? "password" : "text"} placeholder="Enter your password" className='xjcxxckxc' />
                                <img src="https://account.coindcx.com/assets/password_hidden.svg" alt="Toggle Password Visibility" className='toggle-icon' onClick={handleClick}/>
                            </div>
                        </div>

                        <Link className="loginsignup" style={{ backgroundColor: '#3067F0', justifyContent: "center", fontWeight: "bold", marginBottom: "10px", textDecoration: "none", color: "white" }} onClick={signup}>
                            <div>
                                SIGN UP
                            </div>
                        </Link>
                        <div className="emailaddress" style={{
                            justifyContent: "center",
                            textAlign: "center", fontSize: "15px", marginBottom: "10px",
                        }}>
                            OR
                        </div>
                        <div className="loginsignup" style={{ backgroundColor: 'transparent', justifyContent: "center", fontWeight: "bold", marginBottom: "20px", border: "1px solid #3067F0", gap: "10px" }} onClick={googlelogin}>
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"><path d="M18.1712 8.36727H17.5V8.33268H9.99996V11.666H14.7095C14.0225 13.6064 12.1762 14.9993 9.99996 14.9993C7.23871 14.9993 4.99996 12.7606 4.99996 9.99935C4.99996 7.2381 7.23871 4.99935 9.99996 4.99935C11.2745 4.99935 12.4341 5.48018 13.317 6.2656L15.6741 3.90852C14.1858 2.52143 12.195 1.66602 9.99996 1.66602C5.39788 1.66602 1.66663 5.39727 1.66663 9.99935C1.66663 14.6014 5.39788 18.3327 9.99996 18.3327C14.602 18.3327 18.3333 14.6014 18.3333 9.99935C18.3333 9.4406 18.2758 8.89518 18.1712 8.36727Z" fill="#FFC107"></path><path d="M2.62744 6.1206L5.36536 8.12852C6.10619 6.29435 7.90036 4.99935 9.99994 4.99935C11.2745 4.99935 12.4341 5.48018 13.317 6.2656L15.6741 3.90852C14.1858 2.52143 12.1949 1.66602 9.99994 1.66602C6.79911 1.66602 4.02327 3.4731 2.62744 6.1206Z" fill="#FF3D00"></path><path d="M9.99999 18.3336C12.1525 18.3336 14.1083 17.5099 15.5871 16.1703L13.0079 13.9878C12.1712 14.6215 11.1312 15.0003 9.99999 15.0003C7.83249 15.0003 5.99207 13.6182 5.29874 11.6895L2.58124 13.7832C3.9604 16.482 6.76124 18.3336 9.99999 18.3336Z" fill="#4CAF50"></path><path d="M18.1712 8.36857H17.5V8.33398H10V11.6673H14.7096C14.3796 12.5994 13.78 13.4032 13.0067 13.9886L13.0079 13.9877L15.5871 16.1702C15.4046 16.3361 18.3333 14.1673 18.3333 10.0007C18.3333 9.4419 18.2758 8.89648 18.1712 8.36857Z" fill="#1976D2"></path></svg>
                            Continue with Google
                        </div>
                    </div>
                </center>

            </div>
        </>
    )
}
