import React from 'react'
import { Link } from 'react-router-dom';
export default function Sidebar() {
    return (
        <div className='dashboardpage'>
            <div className="sidebar">
                <Link className="linktexts">
                <div className="firstoption">
                    <img src="https://app.litebite.rdiff.ridiv.in/static/media/Subscribers.cec7b8685986133672e3dc0f6c70c65b.svg" alt="" className='sidebarimage' />
                    Users
                </div>
                </Link>
                <Link className='linktexts'>
                <div className="otheroptions">
                    <img src="https://app.litebite.rdiff.ridiv.in/static/media/Orders.3c6715b85b4f1b027e5f35bed30187f2.svg" alt="" className='sidebarimage' />
                    Users Details
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
            </div>
        </div>
    )
}
