
import styles from "./FeaturesSection.module.css"
import { FeatureCard } from "./FeatureCard"

const features = [
  {
    icon: "http://localhost:8000/images/delivery.png",
    title: "Free Delivery",
    description: "Consectetur adipi elit lorem ipsum dolor sit amet."
  },
  {
    icon: "http://localhost:8000/images/guarantee.png",
    title: "Quality Guarantee",
    description: "Dolor sit amet orem ipsu mcons ectetur adipi elit."
  },
  {
    icon: "http://localhost:8000/images/offers.png",
    title: "Daily Offers",
    description: "Amet consectetur adipi elit loreme ipsum dolor sit."
  },
  {
    icon: "http://localhost:8000/images/secure.png",
    title: "100% Secure Payment",
    description: "Rem Lopsum dolor sit amet, consectetur adipi elit."
  }
]

export const FeaturesSection = () => {
  return (
    <section className={styles.features}>
      <div className={styles.container}>
        {features.map((feature, index) => (
          <FeatureCard
            key={index}
            icon={feature.icon}
            title={feature.title}
            description={feature.description}
          />
        ))}
      </div>
    </section>
  )
}
