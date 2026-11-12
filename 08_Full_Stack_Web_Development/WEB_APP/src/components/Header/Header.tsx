
import { Link } from 'react-router-dom';
import { useSelector } from "react-redux";
import type { RootState } from "../../Store/Store";
import styles from './Header.module.css';

export const Header = () => {
  const cartItems = useSelector((state: RootState) => state.cart.items);
  const totalItems = cartItems.reduce((acc, item) => acc + item.quantity, 0);

  return (
    <header className={styles.header}>
      <div className={styles.logo}>
      
        <Link to="/"><img src="http://localhost:8000/images/logo.png" alt="MiniStore" /></Link>
      </div>

      <nav className={styles.nav}>
        <Link to="/">HOME</Link>
        <Link to="/Page1">PAGES</Link>
        <Link to="/aboutPage">ABOUT</Link>
        <Link to="/">BLOGS</Link>
        <Link to="/">CONTACT</Link>
      </nav>

      <div className={styles.actions}>
        <img src="http://localhost:8000/images/ion_search.png" alt="search" />
        <img src="http://localhost:8000/images/ion_person.png" alt="user" />
        <Link to="/page3" className={styles.cart}>
          <img src="http://localhost:8000/images/ion_cart.png" alt="cart" />
          {totalItems > 0 && <span className={styles.badge}>{totalItems}</span>}
        </Link>
      </div>
    </header>
  );
};
