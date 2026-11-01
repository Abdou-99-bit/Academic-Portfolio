

import { useEffect } from "react";
import { useDispatch } from "react-redux";
import { Routes, Route } from "react-router-dom";
import { fetchProducts } from "./Store/ProductSlice"; 
import type { AppDispatch } from "./Store/Store";

import { Header } from "./components/Header/Header";
import { Footer } from "./components/Footer/Footer"; 
import { Home } from "./Pages/Home/Home";
import { AboutPage } from "./Pages/AboutPage/AboutPage";
import { Page1 } from "./Pages/Page1/Page1";
import Page2 from "./Pages/Page2/Page2";
import Page3 from "./Pages/Page3/Page3";

function App() {
  const dispatch = useDispatch<AppDispatch>();

  useEffect(() => {
    dispatch(fetchProducts());
    console.log("FETCHING PRODUCTS...");
  }, [dispatch]);

  return (
    <>
      <Header />
      
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/aboutPage" element={<AboutPage />} />
        <Route path="/Page1" element={<Page1 />} />
        <Route path="/product" element={<Page2 />} />
        <Route path="/page3" element={<Page3 />} />
      </Routes>

      <Footer /> 
    </>
  );
}

export default App;
