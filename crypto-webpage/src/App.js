import React from 'react';
import './App.css';
import {
  BrowserRouter,
  Routes,
  Route
} from 'react-router-dom';
import Landingpage from './HomePage/landingpage';
import { Analytics } from "@vercel/analytics/react"
import Loginhomepage from './Login Page/loginhomepage';
import Signuphomepage from './Login Page/signuphomepage';
import Download from './Download Page/download';
import About from './About Us/Updates';
import Homepage from './Logged in page/homepage';
import Transactions from './Transactions And Money/transactions';
import Withdrawal from './Transactions And Money/withdrawal';
import Profile from './Profile Page/profile';
import Portfolio from './Portfolio Page/portfolio';
import Marketplace from './Market Place/marketplace';
import CarrersHome from './Careers Page/careerhomepage';
import Aboutus from './About Us/about-us';
function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Landingpage />} />
      </Routes>
      <Routes>
        <Route path="/login" element={<Loginhomepage />} />
      </Routes>
      <Routes>
        <Route path="/signup" element={<Signuphomepage />} />
      </Routes>
      <Routes>
        <Route path="/download" element={<Download />} />
      </Routes>
      <Routes>
        <Route path="/updates" element={<About />} />
      </Routes>
      <Routes>
        <Route path="/home" element={<Homepage />} />
      </Routes>
      <Routes>
        <Route path="/transactions" element={<Transactions />} />
      </Routes>
      <Routes>
        <Route path="/withdrawal" element={<Withdrawal />} />
      </Routes>
      <Routes>
        <Route path="/profile" element={<Profile />} />
      </Routes>
      <Routes>
        <Route path="/portfolio" element={<Portfolio />} />
      </Routes>
      <Routes>
        <Route path="/market" element={<Marketplace />} />
      </Routes>
      <Routes>
        <Route path="/oppurtunity" element={<CarrersHome />} />
      </Routes>
      <Routes>
        <Route path="/about-us" element={<Aboutus />} />
      </Routes>
      <Analytics />
    </BrowserRouter>
  );
}

export default App;
