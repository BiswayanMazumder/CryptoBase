import React, { useEffect } from 'react';

export default function Homepage() {
  useEffect(() => {
    document.title = 'Welcome To CryproBase Admin Panel';
  }, []);

  return (
    <div className='homepage'>
      <img
        src="https://cdn.dribbble.com/userupload/3726865/file/original-332b7cf604fac4578e206989fffe9eee.png?resize=1200x817&vertical=center"
        alt=""
        className='Homepageimg'
      />
      <div className="loginoptions">
      <img src="https://firebasestorage.googleapis.com/v0/b/cryptobase-admin.appspot.com/o/CryptoBase%20Admin%20photos%2Fcryptobaselogo.png?alt=media&token=ad490f3d-9ecd-451d-bab9-e7d3974093a0" 
      alt="image" className='logoimage'/>
      <div className="welcometext">
        Welcome Back!!!
      </div>
      <div className="header">
      <h1>Sign In!!!</h1>
      </div>
      </div>
    </div>
  );
}
