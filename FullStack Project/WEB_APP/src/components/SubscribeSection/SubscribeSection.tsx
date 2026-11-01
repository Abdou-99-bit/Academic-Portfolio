import styles from "./SubscribeSection.module.css"

export const SubscribeSection = () => {
  return (
    <section className={styles.subscribe}>

      <div className={styles.left}>
        <h2>SUBSCRIBE US NOW</h2>
        <p>Get latest news, updates and deals directly mailed to your inbox.</p>
      </div>

      <div className={styles.right}>
        <input 
          type="email" 
          placeholder="Your email address here" 
        />
        <button>SUBSCRIBE</button>
      </div>

    </section>
  )
}