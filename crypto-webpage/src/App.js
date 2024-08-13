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
      <Analytics />
    </BrowserRouter>
  );
}

export default App;
