
import styles from "./ProductsSection.module.css";
import { ProductCard } from "../ProductCard/ProductCard"; 
import { useDispatch, useSelector } from "react-redux";
import { addToCart } from "../../Store/CartSlice";
import { useNavigate } from "react-router-dom";
import type { RootState, AppDispatch } from "../../Store/Store";
import type { Product } from "../../types";

export const ProductsSection = () => {
  const dispatch = useDispatch<AppDispatch>();
  const navigate = useNavigate();
  
 
  const allProducts = useSelector((state: RootState) => state.products.items);
  
  const displayProducts = allProducts.filter(
  (p: Product) =>
    p.category?.toLowerCase().includes("phone") ||
    p.name.toLowerCase().includes("phone")
);
  

  console.log("ALL PRODUCTS:", allProducts);



  return (
    <section className={styles.products}>
      <div className={styles.header}>
        <h2>MOBILE PRODUCTS</h2>
        <button className={styles.shopButton} onClick={() => navigate("/Page1")}>
          GO TO SHOP →
        </button>
      </div>

      <div className={styles.grid}>
        {displayProducts.map((product: Product) => {
    
         const fullImagePath = `http://localhost:8000${product.image}`; 

          return (
            <ProductCard
              key={product.id}
              id={product.id}
              image={fullImagePath}
              title={product.name}
              price={`$${product.price}`}
              onAdd={() => 
                dispatch(addToCart({ 
                  id: product.id.toString(), 
                  title: product.name, 
                  price: product.price, 
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


