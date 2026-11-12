
import styles from "./Hero.module.css"

export const Hero = () => {
  return (
    <section className={styles.hero}>
      
      <div className={styles.left}>
        <h1>
          YOUR PRODUCTS <br />
          ARE GREAT.
        </h1>

        <button className={styles.button}>
          SHOP PRODUCT
        </button>
      </div>

      <div className={styles.right}>
  
        <img src="http://localhost:8000/images/watch.png" alt="Smart Watch" />
      </div>

      <div>
        
        <img src="http://localhost:8000/images/Vector.png" alt="Vector" className={styles.Vector} />
      </div>

    </section>
  )
}



