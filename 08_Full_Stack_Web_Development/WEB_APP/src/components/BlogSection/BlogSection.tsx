

import styles from "./BlogSection.module.css"
import { BlogCard } from "../BlogCard/BlogCard"

export const BlogSection = () => {
  return (
    <section className={styles.blog}>

      <div className={styles.header}>
        <h2>LATEST POSTS</h2>
        <a href="#">READ BLOGS</a>
      </div>

      <div className={styles.grid}>
    
        <BlogCard
          image="http://localhost:8000/images/post1.png"
          date="Feb 22, 2023"
          category="GADGETS"
          title="GET SOME COOL GADGETS IN 2023"
        />

        <BlogCard
          image="http://localhost:8000/images/post2.png"
          date="Feb 22, 2023"
          category="TECHNOLOGY"
          title="TECHNOLOGY HACK YOU WON'T GET"
        />

        <BlogCard
          image="http://localhost:8000/images/post3.png"
          date="Feb 22, 2023"
          category="CAMERA"
          title="TOP 10 SMALL CAMERA IN THE WORLD"
        />
      </div>

    </section>
  )
}
