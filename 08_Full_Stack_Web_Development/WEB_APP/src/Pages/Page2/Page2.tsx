
import { useNavigate, useLocation } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { addToCart } from "../../Store/CartSlice";
import { useState } from "react";
import type { RootState } from "../../Store/Store";

import styles from "./Page2.module.css";
import { SubscribeSection } from "../../components/SubscribeSection/SubscribeSection";
import { ProductImage } from "../../components/ProductImage";

const Page2 = () => {
  const { state } = useLocation();
  const product = state?.product; 
  const navigate = useNavigate();
  const dispatch = useDispatch();

  
  const allProducts = useSelector((state: RootState) => state.products.items);

  const [quantity, setQuantity] = useState(1);
  const [activeTab, setActiveTab] = useState("description");

  if (!product) return <h2>No product selected</h2>;

  
  const numericPrice = product.price;

  return (
    <>
      <div className={styles.container}>
        <div className={styles.top}>

          <div className={styles.left}>
            <img src={product.image} alt={product.title} />
          </div>

          <div className={styles.right}>
            <h2>{product.title}</h2>
            <div className={styles.rating}>⭐ 5.0</div>
            <h3 className={styles.price}>{product.price}</h3>

            <p className={styles.desc}>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit.
              Database driven product details for your Figma design.
            </p>

            <div className={styles.quantity}>
              <button onClick={() => setQuantity(q => Math.max(1, q - 1))}>-</button>
              <span>{quantity}</span>
              <button onClick={() => setQuantity(q => q + 1)}>+</button>
            </div>

            <div className={styles.buttons}>
              <button className={styles.buy}>BUY NOW</button>
              <button
                className={styles.cart}
                onClick={() => {
                  
              const cleanImage = product.image
                    .replace("http://localhost:8000/images/", "")
                    .replace("/images/", "");

                  dispatch(
                    addToCart({
                      id: product.id || product.title,
                      title: product.title,
                      price: numericPrice,
                      image: cleanImage,
                      quantity
                    })
                  );
                  navigate("/page3"); 
                }}
              >
                ADD TO CART
              </button>
            </div>

            <div className={styles.meta}>
              <p>SKU: 1223</p>
              <p>Category: {product.category || 'General'}</p>
            </div>
          </div>
        </div>

        
        <div className={styles.tabs}>
          <div className={styles.tabHeader}>
            <span className={activeTab === "description" ? styles.activeTab : ""} onClick={() => setActiveTab("description")}>DESCRIPTION</span>
            <span className={activeTab === "info" ? styles.activeTab : ""} onClick={() => setActiveTab("info")}>ADDITIONAL INFO</span>
            <span className={activeTab === "reviews" ? styles.activeTab : ""} onClick={() => setActiveTab("reviews")}>REVIEWS</span>
          </div>
          <div className={styles.tabContent}>
            {activeTab === "description" && <p>Description from MySQL source.</p>}
            {activeTab === "info" && <p>Weight: 200g | Material: High Quality</p>}
            {activeTab === "reviews" && <p>No reviews yet.</p>}
          </div>
        </div>

      
        <div className={styles.related}>
          <h3>RELATED PRODUCTS</h3>
          <button className={styles.shopBtn} onClick={() => navigate("/Page1")}>GO TO SHOP →</button>

          <div className={styles.grid}>
            
            {allProducts.slice(0, 4).map((p) => (
              <div key={p.id} className={styles.card} onClick={() => navigate("/product", { state: { product: { image: p.image, title: p.name, price: `$${p.price}` } } })}>
                {/* <img src={p.image} alt={p.name} /> */}

                <ProductImage
                       src={p.image}
                       alt={p.name}
                       className={styles.image}
                                              />
                <p>{p.name}</p>
                <span>${p.price}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      <SubscribeSection />
    
    </>
  );
};

export default Page2;
