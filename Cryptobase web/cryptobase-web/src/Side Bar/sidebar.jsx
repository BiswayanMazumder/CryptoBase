import React from 'react'
import { Link } from 'react-router-dom';
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth, signInWithEmailAndPassword } from "firebase/auth";

const firebaseConfig = {
  apiKey: "AIzaSyCxkw9hq-LpWwGwZQ0APU0ifJ5JQU2T8Vk",
  authDomain: "cryptobase-admin.firebaseapp.com",
  projectId: "cryptobase-admin",
  storageBucket: "cryptobase-admin.appspot.com",
  messagingSenderId: "1090236390686",
  appId: "1:1090236390686:web:856b22fd209b267b89fd0f",
  measurementId: "G-LTBWYEEF6E"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
const auth = getAuth(app);
export default function Sidebar() {
    return (
        <div className='dashboardpage'>
            {/* <div className="sidebar"> */}
                <Link className="linktexts" to={'/home'}>
                <div className="firstoption">
                    <img src="https://app.litebite.rdiff.ridiv.in/static/media/Subscribers.cec7b8685986133672e3dc0f6c70c65b.svg" alt="" className='sidebarimage' />
                    Users Overview
                </div>
                </Link>
                <Link className='linktexts' to={'/verifications'}>
                <div className="otheroptions">
                    <img src="https://app.litebite.rdiff.ridiv.in/static/media/Orders.3c6715b85b4f1b027e5f35bed30187f2.svg" alt="" className='sidebarimage' />
                    Users KYC Verifications
                </div>
                </Link> 
                <Link className="linktexts">
                <div className="otheroptions">
                    <img src="https://app.litebite.rdiff.ridiv.in/static/media/Messages.e269bc93ea683ad68aaa2495b2f71c3d.svg" alt="" className='sidebarimage' />
                    Users Messages
                </div>
                </Link>
                <Link className="linktexts">
                <div className="otheroptions">
                    <img src="https://app.litebite.rdiff.ridiv.in/static/media/Production.684e800f95b1e1dc163d39825a1eb01a.svg" alt="" className='sidebarimage' />
                    Users Portfolios
                </div>
                </Link>
                <Link className="linktexts">
                <div className="otheroptions">
                    <img src="https://app.litebite.rdiff.ridiv.in/static/media/Delivery.dace630990ece0e34dbf8a5fd122d259.svg" alt="" className='sidebarimage' />
                    Event Management
                </div>
                </Link>
                <Link className="linktexts" to={'/'} onClick={
                    () => {
                        auth.signOut();
                        window.location.replace('/');
                    }
                }>
                <div className="otheroptions">
                <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 16 16" class="text-xl" height="1em"
                 width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M16 7.992C16 3.58 12.416 0 8 0S0 3.58 0 7.992c0 2.43 1.104 4.62 2.832 6.09.016.016.032.016.032.032.144.112.288.224.448.336.08.048.144.111.224.175A7.98 7.98 0 0 0 8.016 16a7.98 7.98 0 0 0 4.48-1.375c.08-.048.144-.111.224-.16.144-.111.304-.223.448-.335.016-.016.032-.016.032-.032 1.696-1.487 2.8-3.676 2.8-6.106zm-8 7.001c-1.504 0-2.88-.48-4.016-1.279.016-.128.048-.255.08-.383a4.17 4.17 0 0 1 .416-.991c.176-.304.384-.576.64-.816.24-.24.528-.463.816-.639.304-.176.624-.304.976-.4A4.15 4.15 0 0 1 8 10.342a4.185 4.185 0 0 1 2.928 1.166c.368.368.656.8.864 1.295.112.288.192.592.24.911A7.03 7.03 0 0 1 8 14.993zm-2.448-7.4a2.49 2.49 0 0 1-.208-1.024c0-.351.064-.703.208-1.023.144-.32.336-.607.576-.847.24-.24.528-.431.848-.575.32-.144.672-.208 1.024-.208.368 0 .704.064 1.024.208.32.144.608.336.848.575.24.24.432.528.576.847.144.32.208.672.208 1.023 0 .368-.064.704-.208 1.023a2.84 2.84 0 0 1-.576.848 2.84 2.84 0 0 1-.848.575 2.715 2.715 0 0 1-2.064 0 2.84 2.84 0 0 1-.848-.575 2.526 2.526 0 0 1-.56-.848zm7.424 5.306c0-.032-.016-.048-.016-.08a5.22 5.22 0 0 0-.688-1.406 4.883 4.883 0 0 0-1.088-1.135 5.207 5.207 0 0 0-1.04-.608 2.82 2.82 0 0 0 .464-.383 4.2 4.2 0 0 0 .624-.784 3.624 3.624 0 0 0 .528-1.934 3.71 3.71 0 0 0-.288-1.47 3.799 3.799 0 0 0-.816-1.199 3.845 3.845 0 0 0-1.2-.8 3.72 3.72 0 0 0-1.472-.287 3.72 3.72 0 0 0-1.472.288 3.631 3.631 0 0 0-1.2.815 3.84 3.84 0 0 0-.8 1.199 3.71 3.71 0 0 0-.288 1.47c0 .352.048.688.144 1.007.096.336.224.64.4.927.16.288.384.544.624.784.144.144.304.271.48.383a5.12 5.12 0 0 0-1.04.624c-.416.32-.784.703-1.088 1.119a4.999 4.999 0 0 0-.688 1.406c-.016.032-.016.064-.016.08C1.776 11.636.992 9.91.992 7.992.992 4.14 4.144.991 8 .991s7.008 3.149 7.008 7.001a6.96 6.96 0 0 1-2.032 4.907z"></path></svg>
                    Logout
                </div>
                </Link>
            {/* </div> */}
        </div>
    )
}
