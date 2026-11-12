
import styles from "./WatchesSection.module.css";
import { ProductCard } from "../ProductCard/ProductCard";
import { useDispatch, useSelector } from "react-redux";
import { addToCart } from "../../Store/CartSlice";
import { useNavigate } from "react-router-dom";
import type { RootState, AppDispatch } from "../../Store/Store";
import type { Product } from "../../types";

export const WatchesSection = () => {
  const dispatch = useDispatch<AppDispatch>();
  const navigate = useNavigate();

  


  const allProducts = useSelector((state: RootState) => state.products.items);

  
  const displayWatches = allProducts.filter(
  (p: Product) =>
    p.category?.toLowerCase().includes("watch") ||
    p.name.toLowerCase().includes("watch")
);

  console.log("ALL PRODUCTS:", allProducts);

  return (
    <section className={styles.watches}>
      <div className={styles.header}>
        <h2>SMART WATCHES</h2>
        <button className={styles.shopButton} onClick={() => navigate("/Page1")}>
          GO TO SHOP →
        </button>
      </div>

      <div className={styles.grid}>
        {displayWatches.map((watch: Product) => {

          const fullImagePath = `http://localhost:8000${watch.image}`; 

          return (
            <ProductCard
              key={watch.id}
              id={watch.id} 
              image={fullImagePath}
              title={watch.name}
              price={`$${watch.price}`}
              onAdd={() => 
                dispatch(addToCart({ 
                  id: watch.id.toString(), 
                  title: watch.name, 
                  price: watch.price, 
                  image: fullImagePath,
                  quantity: 1
                }))
              }
            />
          );
        })}
      </div>
    </section>
  );
};

