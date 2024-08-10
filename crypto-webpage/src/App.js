import React from 'react';
import './App.css';
import {
  BrowserRouter,
  Routes,
  Route
} from 'react-router-dom';
import Landingpage from './HomePage/landingpage';
function App() {
  return (
    <BrowserRouter>
        <Routes>
          <Route path="/" element={<Landingpage />} />
        </Routes>
    </BrowserRouter>
  );
}

export default App;
