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
export default function Careeropenings() {
    const [growthData, setGrowthData] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
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
    const [reqtitle, settitle] = useState([]);
    const [units, setunits] = useState([]);
    const [location, setlocation] = useState([]);
    const [positions, setpositions] = useState([]);
    const jobids = ["834", "835", "836"];
    const [jobDetails, setJobDetails] = useState([]);
    var clickedLocation=localStorage.getItem("clickedLocation");
    useEffect(() => {
        const fetchData = async () => {
            
            const auth = getAuth();
            const db = getFirestore(app);
            const user = auth.currentUser;
            let details = []; // Array to store job details

            for (let i = 0; i < jobids.length; i++) {
                const docRef = doc(db, clickedLocation, jobids[i]);

                try {
                    const docSnap = await getDoc(docRef);

                    if (docSnap.exists()) {
                        // Document found, push data to details array
                        details.push({
                            jobId: jobids[i],
                            title: docSnap.data()["Job Title"],
                            location: docSnap.data()["Location"],
                            positions: docSnap.data()["Opening"]
                        });

                    } else {
                        // Document not found, push error message
                        details.push({
                            jobId: jobids[i],
                            error: 'No such document!'
                        });
                    }
                } catch (e) {
                    // Handle errors and push error message
                    details.push({
                        jobId: jobids[i],
                        error: `Error getting document: ${e.message}`
                    });
                }
            }

            // Update state with all job details
            setJobDetails(details);
            setLoading(false);
            // console.log(jobDetails);
        };

        fetchData();
    }, []); // Add dependencies here if needed
    return (
        <>
            <div className="webbody">
                <br />
                <div className="nfkfmvfmv">
                    <Link to={'/oppurtunity'}>
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
                            <thead>
                                <tr>
                                    <th>Req Title</th>
                                    <th>Unit</th>
                                    <th>Location</th>
                                    <th>Positions</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    jobDetails.map((job, index) => {
                                        return (
                                            <tr key={index}>
                                                <td>{job.title}</td>
                                                <td>{clickedLocation}</td>
                                                <td>{job.location}</td>
                                                <td>{job.positions}</td>
                                            </tr>
                                        )
                                    })
                                }
                            </tbody>

                        </table>


                    </div>

                </div>
                <div className="jjjfnkvnfkv" style={{ position: "relative", top: "10px" }}>
                    <div className="jnfn">
                        Discover Our
                    </div>
                    <div className="jnfnj">
                        Spaces
                    </div>
                </div>
                <div className="locations" style={{ position: "relative", top: "10px" }}>
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
                <div className="locationinfos" style={{ position: "relative", top: "10px" }}>
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
                    <div className="jhjfdkd" >
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
                <div className="jvkfklkflklf" style={{ position: "relative", top: "10px" }}>
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
