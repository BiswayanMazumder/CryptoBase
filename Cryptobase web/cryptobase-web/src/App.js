import React from 'react';
import logo from './logo.svg';
import './App.css';
import Homepage from './Home Page/homepage';
import {
  BrowserRouter,
  Routes,
  Route
} from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
        <Routes>
          <Route path="/" element={<Homepage />} />
        </Routes>
    </BrowserRouter>
  );
}

export default App;
