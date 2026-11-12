import styles from "./TestimonialSection.module.css"

export const TestimonialSection = () => {
  return (
    <section className={styles.testimonial}>

      <button className={styles.leftArrow}>❮</button>

      <div className={styles.content}>

        <div className={styles.quote}>“</div>

        <p className={styles.text}>
          "Tempus oncu enim pellentesque est pretium in neque,
          elit morbi sagittis lorem habitasse Pellentesque
          pretium feugiat vel morbi suspendisse sagittis
          lorem habitasse morbi."
        </p>

        <div className={styles.stars}>
          ★ ★ ★ ★ ★
        </div>

        <p className={styles.author}>EMMA CHAMBERLIN</p>

      </div>

      <button className={styles.rightArrow}>❯</button>

    </section>
  )
}