
import styles from "./SaleBanner.module.css"

export const SaleBanner = () => {
  return (
    <section className={styles.banner}>
      
      <div className={styles.left}>
        <span className={styles.discount}>10% OFF</span>

        <h2>NEW YEAR SALE</h2>

        <button className={styles.button}>
          SHOP SALE
        </button>
      </div>

      <div className={styles.right}>
      
        <img src="http://localhost:8000/images/sale-phone.png" alt="sale product" />
      </div>

    </section>
  )
}
