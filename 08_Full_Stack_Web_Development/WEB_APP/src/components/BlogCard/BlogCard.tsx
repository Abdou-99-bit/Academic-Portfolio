import styles from "./BlogCard.module.css"

interface BlogCardProps {
  image: string
  date: string
  category: string
  title: string
}

export const BlogCard = ({ image, date, category, title }: BlogCardProps) => {
  return (
    <div className={styles.card}>
      <img src={image} alt={title} />

      <p className={styles.meta}>
        {date} • {category}
      </p>

      <h4>{title}</h4>
    </div>
  )
}