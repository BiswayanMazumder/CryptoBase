import React, { useEffect } from 'react'
import Sidebar from '../Side Bar/sidebar'

export default function Userpage() {
    useEffect(() => {
        document.title = 'CryproBase Admin Panel';
      }, []);
  return (
    
    <div className="pages">
        <Sidebar />
        <div className="detailspage">
            <div className="tables">
                <li className='ListDetails'>
                    User ID
                </li>
                <li className='ListDetails2'>
                    User Name
                </li>
                <li className='ListDetails2'>
                    User Email
                </li>
                {/* <li className='ListDetails2'>
                    User Name
                </li> */}
                <li className='ListDetails2'>
                    Profile Pic
                </li>
                <li className='ListDetails2'>
                    DoJ
                </li>
            </div>
        </div>
    </div>
  )
}
