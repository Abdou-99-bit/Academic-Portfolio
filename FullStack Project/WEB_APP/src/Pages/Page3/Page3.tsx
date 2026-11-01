
import { useSelector, useDispatch } from "react-redux";
import {
  removeFromCart,
  increaseQty,
  decreaseQty
} from "../../Store/CartSlice";

import { SubscribeSection } from "../../components/SubscribeSection/SubscribeSection";


import type { RootState } from "../../Store/Store";
import styles from "./Page3.module.css";
import { ProductImage } from "../../components/ProductImage";

const Page3 = () => {
  const dispatch = useDispatch();
  const items = useSelector((state: RootState) => state.cart.items);

  
  const total = items.reduce(
    (acc, item) => acc + item.price * item.quantity,
    0
  );

  return (
    <div className={styles.container}>

      <div className={styles.topSection}>
        <h1>CART</h1>
        <p>
          Home <span>&gt; CART</span>
        </p>
      </div>

      
      <div className={styles.tableHeader}>
        <span>PRODUCT</span>
        <span>PRICE</span>
        <span>QUANTITY</span>
        <span>SUBTOTAL</span>
      </div>

    
      <div className={styles.cartContent}>
        {items.length === 0 ? (
          <div className={styles.emptyMsg}>
            <h2>Your cart is currently empty.</h2>
            <p>Go back to the shop to add some products!</p>
          </div>
        ) : (
          items.map((item) => (
            <div key={item.id} className={styles.row}>
              
              <div className={styles.product}>
            
                {/* <img src={item.image} className={styles.image} alt={item.title} /> */}
                <ProductImage
                     src={item.image}
                     alt={item.title}
                     className={styles.image}
                                     />
                <div className={styles.productDetails}>
                  <h4>{item.title}</h4>
                  <button
                    className={styles.remove}
                    onClick={() => dispatch(removeFromCart(item.id))}
                  >
                    Remove
                  </button>
                </div>
              </div>

             
              <div className={styles.price}>
                ${item.price.toFixed(2)}
              </div>

            
              <div className={styles.quantity}>
                <div className={styles.qtyControls}>
                  <button onClick={() => dispatch(decreaseQty(item.id))}>-</button>
                  <span>{item.quantity}</span>
                  <button onClick={() => dispatch(increaseQty(item.id))}>+</button>
                </div>
              </div>

           
              <div className={styles.subtotal}>
                ${(item.price * item.quantity).toFixed(2)}
              </div>

            </div>
          ))
        )}
      </div>

      {items.length > 0 && (
        <div className={styles.summaryContainer}>
          <div className={styles.totalBox}>
            <div className={styles.totalRow}>
              <span>Subtotal:</span>
              <span>${total.toFixed(2)}</span>
            </div>
            <div className={styles.totalRow}>
              <strong>Total:</strong>
              <strong>${total.toFixed(2)}</strong>
            </div>
            <button className={styles.checkoutBtn}>PROCEED TO CHECKOUT</button>
          </div>
        </div>
      )}

      <SubscribeSection />
      
    </div>
  );
};

export default Page3;


