
import styles from "./AboutPage.module.css";
import { FaTruck, FaMedal, FaTag, FaShieldAlt } from "react-icons/fa";

export const AboutPage = () => {
  return (
    <div>
      
      <div className={styles.topSection}>
        <h1>ABOUT US</h1>
        <p>
          Home <span>&gt; About Us</span>
        </p>
      </div>

    
      <div className={styles.features}>
        <div className={styles.feature}>
          <FaTruck />
          <h4>FREE DELIVERY</h4>
          <p>Consectetur adipi elit lorem ipsum dolor sit amet.</p>
        </div>

        <div className={styles.feature}>
          <FaMedal />
          <h4>QUALITY GUARANTEE</h4>
          <p>Dolor sit amet orem ipsu mcons ectetur adipi elit.</p>
        </div>

        <div className={styles.feature}>
          <FaTag />
          <h4>DAILY OFFERS</h4>
          <p>Amet consectetur adipi elit lorem ipsum dolor sit.</p>
        </div>

        <div className={styles.feature}>
          <FaShieldAlt />
          <h4>100% SECURE PAYMENT</h4>
          <p>Rem Lopsum dolor sit amet, consectetur adipi elit.</p>
        </div>
      </div>

      
      <div className={styles.aboutContent}>
        <div className={styles.imageWrapper}>
        
          <img src="http://localhost:8000/images/about-image.png" alt="about" />
          <div className={styles.playButton}>▶</div>
        </div>

        <div className={styles.textContent}>
          <h2>HOW WAS MINISTORE FOUND?</h2>
          <p>
            Risus augue curabitur diam senectus congue velit et. Sed vitae metus
            nibh sit era. Nulla adipiscing pharetra pellentesque maecenas odio
            eros at.
          </p>
          <p>
            Sed vitae metus nibh sit era. Nulla adipiscing pharetra pellentesque
            maecenas odio eros at. Quam libero etiam et in ac at quis.
          </p>
          <button>SHOP OUR STORE</button>
        </div>
      </div>

  
      <div className={styles.testimonial}>
        <div className={styles.arrow}>‹</div>
        <div className={styles.testimonialContent}>
          <div className={styles.quote}>“</div>
          <p>
            Tempus oncu enim pellen tesque este pretium in neque, elit morbi
            sagittis lorem habi mattis Pellen tesque pretium feugiat vel morbi
            suspen dise sagittis lorem habi tasse morbi.
          </p>
          <div className={styles.stars}>★★★★★</div>
          <h5>EMMA CHAMBERLIN</h5>
        </div>
        <div className={styles.arrow}>›</div>
      </div>

    
      <div className={styles.subscribe}>
        <div>
          <h3>SUBSCRIBE US NOW</h3>
          <p>Get latest news, updates and deals directly mailed to your inbox.</p>
        </div>
        <div className={styles.subscribeForm}>
          <input type="email" placeholder="Your email address here" />
          <button>SUBSCRIBE</button>
        </div>
      </div>

    
      {/* <div className={styles.instaSection}>
        <h3>SHOP OUR INSTA</h3>
        <div className={styles.instaGrid}>
        
          <img src="http://localhost:8000/images/insta1.png" alt="" />
          <img src="http://localhost:8000/images/insta2.png" alt="" />
          <img src="http://localhost:8000/images/insta3.png" alt="" />
          <img src="http://localhost:8000/images/insta4.png" alt="" />
          <img src="http://localhost:8000/images/insta5.png" alt="" />
        </div>
      </div> */}
{/* 
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
      </div> */}

      {/* <div className={styles.bottom}>
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
      </div> */}
    </div>
  );
};



