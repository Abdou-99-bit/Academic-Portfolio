
import styles from "./Footer.module.css";

export const Footer = () => {
  return (
    <footer className={styles.footer}>
      <div className={styles.instaSection}>
        <h3>SHOP OUR INSTA</h3>
        <div className={styles.instaGrid}>
        
          <img src="http://localhost:8000/images/insta1.png" alt="" />
          <img src="http://localhost:8000/images/insta2.png" alt="" />
          <img src="http://localhost:8000/images/insta3.png" alt="" />
          <img src="http://localhost:8000/images/insta4.png" alt="" />
          <img src="http://localhost:8000/images/insta5.png" alt="" />
        </div>
      </div>

      <div className={styles.main}>
        <div className={styles.col}>
          <h2>MiniStore.</h2>
          <p>Nisi, purus vitae, ultrices nunc. Sit ac sit suscipit hendrerit.</p>
          <div className={styles.socials}>
            <i className="fab fa-facebook-f"></i>
            <i className="fab fa-instagram"></i>
            <i className="fab fa-twitter"></i>
            <i className="fab fa-linkedin-in"></i>
            <i className="fab fa-youtube"></i>
          </div>
        </div>
        <div className={styles.col}>
          <h4>QUICK LINKS</h4>
          <ul><li>HOME</li><li>ABOUT</li><li>SHOP</li><li>BLOGS</li><li>CONTACT</li></ul>
        </div>
        <div className={styles.col}>
          <h4>HELP & INFO</h4>
          <ul><li>TRACK YOUR ORDER</li><li>RETURNS POLICIES</li><li>FAQS</li></ul>
        </div>
        <div className={styles.col}>
          <h4>CONTACT US</h4>
          <p>yourinfo@gmail.com</p>
          <p>+55 111 222 333 44</p>
        </div>
      </div>

      <div className={styles.bottom}>
        <div className={styles.leftBottom}>
          <span>We ship with:</span>
          <span className={styles.logo}>DHL</span>
          <span className={styles.space}>Payment options:</span>
          <span className={styles.logo}>VISA</span>
          <span className={styles.logo}>MASTERCARD</span>
        </div>
        <div className={styles.rightBottom}>
          © Copyright 2023 MiniStore. Design by TemplatesJungle
        </div>
      </div>
    </footer>
  );
};

