import React from 'react';
import logo from './logo.svg';
import './App.css';
import Homepage from './Home Page/homepage';
import {
  BrowserRouter,
  Routes,
  Route
} from 'react-router-dom';
import Sidebar from './Side Bar/sidebar';

function App() {
  return (
    <BrowserRouter>
        <Routes>
          <Route path="/" element={<Homepage />} />
        </Routes>
        <Routes>
          <Route path="/home" element={<Sidebar />} />
        </Routes>
    </BrowserRouter>
  );
}

export default App;
