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
    useEffect(() => {
        document.title = 'CryptoForge Careers | Opportunities'
    })
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
                    // console.log('Name', docSnap.data()["Locations"]);
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
                                <svg class="MuiSvgIcon-root MuiSvgIcon-fontSizeMedium css-16asun5" focusable="false" aria-hidden="true" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none"><path d="M12.1542 6.15375C12.1542 8.45216 8.00043 13.9997 8.00043 13.9997C8.00043 13.9997 3.84668 8.45216 3.84668 6.15375C3.84668 5.05211 4.28431 3.99558 5.06328 3.2166C5.84226 2.43763 6.89879 2 8.00043 2C9.10207 2 10.1586 2.43763 10.9376 3.2166C11.7166 3.99558 12.1542 5.05211 12.1542 6.15375Z" stroke="#FA4A29" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"></path><path d="M8.00079 7.53845C8.76548 7.53845 9.38538 6.91855 9.38538 6.15387C9.38538 5.38919 8.76548 4.76929 8.00079 4.76929C7.23611 4.76929 6.61621 5.38919 6.61621 6.15387C6.61621 6.91855 7.23611 7.53845 8.00079 7.53845Z" stroke="#FA4A29" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"></path></svg>
                                {location[index]}
                            </div>
                        </div>
                    ))}
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
