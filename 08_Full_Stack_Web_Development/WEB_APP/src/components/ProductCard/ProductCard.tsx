
import styles from "./ProductCard.module.css";
import { useNavigate } from "react-router-dom"; // 🎯 Ensure this is here
import { useDispatch } from "react-redux";
import { removeProduct } from "../../Store/ProductSlice";
import type { AppDispatch } from "../../Store/Store";
import { ProductImage } from "../ProductImage";


interface ProductCardProps {
  id: number;
  image: string;
  title: string;
  price: string;
  onAdd?: () => void;
}

export const ProductCard = ({ id, image, title, price, onAdd }: ProductCardProps) => {
  const navigate = useNavigate();
  const dispatch = useDispatch<AppDispatch>();


  const productData = { id, image, title, price };

  return (
    <div
      className={styles.card}
      
      onClick={() => navigate("/product", { state: { product: productData } })}
      style={{ cursor: "pointer" }}
    >
      <div className={styles.imageWrapper}>
        
         <ProductImage src={image} alt={title} className={styles.img} />

        <div className={styles.buttonGroup}>
          <button
            className={styles.addBtn}
            onClick={(e) => {
              e.stopPropagation(); 
              onAdd?.();
            }}
          >
            ADD TO CART
          </button>

          <button
            className={styles.deleteBtn}
            onClick={(e) => {
              e.stopPropagation(); 
              if (window.confirm("Delete from MySQL?")) {
                dispatch(removeProduct(id));
              }
            }}
          >
            🗑️
          </button>
        </div>
      </div>

      <div className={styles.info}>
        <h4 className={styles.title}>{title}</h4>
        <p className={styles.price}>{price}</p>
      </div>
    </div>
  );
};
