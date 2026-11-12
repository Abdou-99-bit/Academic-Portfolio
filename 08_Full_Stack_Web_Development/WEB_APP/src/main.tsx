import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { BrowserRouter } from 'react-router-dom'
import "@fortawesome/fontawesome-free/css/all.min.css"
import { Provider } from "react-redux";
import { Store } from "./Store/Store"


createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <Provider store={Store}>  
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </Provider>
  </StrictMode>
)
