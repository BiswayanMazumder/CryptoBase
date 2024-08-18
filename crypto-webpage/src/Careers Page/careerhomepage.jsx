import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { getAuth, onAuthStateChanged } from "firebase/auth";
import Typewriter from 'typewriter-effect';
import { getFirestore, doc, getDoc, setDoc } from 'firebase/firestore';
import { initializeApp } from "firebase/app";
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
export default function CarrersHome() {
    const [category, setcategory] = useState([])
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [location, setlocation] = useState([])
    useEffect(() => {
        const fetchData = async () => {
            const auth = getAuth();
            const db = getFirestore(app);
            const user = auth.currentUser;
            const docRef = doc(db, "Opening Categories", "Categories");

            try {
                const docSnap = await getDoc(docRef);

                if (docSnap.exists()) {
                    // Document found, update state
                    setcategory(docSnap.data()["Req Titles"]);
                    setlocation(docSnap.data()["Locations"]);
                    console.log('Name', docSnap.data()["Locations"]);
                } else {
                    setError('No such document!');
                }
            } catch (e) {
                // Handle errors here
                setError(`Error getting document: ${e.message}`);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []); // Add dependencies here if needed
    return (
        <>
            <div className="webbody">
                <div className="jjjfnkvnfkv">
                    <div className="jnfn">
                        Change Starts
                    </div>
                    <div className="jnfnj">
                        Together!
                    </div>
                </div>
                {/* <div className="kkdkdmv">
                    <video src="https://coindcx.s3.amazonaws.com/static/images/about_us_page_video.mp4#t=5" height={"300px"} style={{borderRadius:"10px"}} autoPlay muted></video>
                </div> */}
                <div className="openingcategories">
                    {location.map((item, index) => (
                        <div className="krjkrgmr" key={item}>
                            <div className="jobcat">
                                {category[index]}
                            </div>
                            <br /><br />
                            <div className="jobcat" style={{ fontWeight: "400" }}>
                                {location[index]}
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </>
    )
}
