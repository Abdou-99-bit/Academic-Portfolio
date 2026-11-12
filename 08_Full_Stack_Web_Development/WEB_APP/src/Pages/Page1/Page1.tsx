
import { useState } from "react";
import styles from "./Page1.module.css";
import { FaSearch } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import { useSelector, useDispatch } from "react-redux";
import { addProduct, removeProduct } from "../../Store/ProductSlice";
import type { RootState, AppDispatch } from "../../Store/Store";
import type { Product } from "../../types";
import { ProductImage } from "../../components/ProductImage";

export const Page1 = () => {
  const dispatch = useDispatch<AppDispatch>();
  const products = useSelector((state: RootState) => state.products.items);
  
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const navigate = useNavigate();

  const [newName, setNewName] = useState("");
  const [newPrice, setNewPrice] = useState<number>(0);

  const itemsPerPage = 6;

  const filteredProducts = products.filter((p: Product) =>
    p.name.toLowerCase().includes(search.toLowerCase())
  );

  const indexOfLast = currentPage * itemsPerPage;
  const indexOfFirst = indexOfLast - itemsPerPage;
  const currentProducts = filteredProducts.slice(indexOfFirst, indexOfLast);
  const totalPages = Math.ceil(filteredProducts.length / itemsPerPage);

  const handleAddProduct = () => {
    if (!newName || newPrice <= 0) return alert("Enter valid details");
    dispatch(addProduct({ name: newName, price: newPrice, image: "http://localhost:8000/images/phone1.png", category: "Phones" }));
    setNewName("");
    setNewPrice(0);
  };

  return (
    <>
      <div className={styles.topSection}>
        <h1>SHOP</h1>
        <p>Home <span>&gt; SHOP</span></p>
      </div>

      <div className={styles.container}>
        <div className={styles.left}>
          <div className={styles.grid}>
            {currentProducts.map((product: Product) => (
              <div
                key={product.id}
                className={styles.card}
                onClick={() => navigate("/product", { state: { product: { id: product.id, image: product.image, title: product.name, price: product.price, category: product.category } } })}
              >
                <div className={styles.image}>
                  {/* <img src={product.image} alt={product.name} /> */}
                  <ProductImage
                      src={product.image}
                      alt={product.image}
                                         />
                  <div className={styles.actions}>
                    <button onClick={(e) => { e.stopPropagation(); if(window.confirm("Delete?")) dispatch(removeProduct(product.id)); }}>
                      DELETE
                    </button>
                  </div>
                </div>
                <p>{product.name}</p>
                <span>${product.price}</span>
              </div>
            ))}
          </div>

          <div className={styles.pagination}>
            <span onClick={() => setCurrentPage((p: number) => Math.max(p - 1, 1))}>{"<"}</span>
            <span className={styles.active}>{currentPage}</span>
            <span onClick={() => setCurrentPage((p: number) => Math.min(p + 1, totalPages))}>{">"}</span>
          </div>
        </div>

        <div className={styles.sidebar}>
          <div className={styles.searchBox}>
            <input
              type="text"
              placeholder="Search..."
              value={search}
              onChange={(e) => { setSearch(e.target.value); setCurrentPage(1); }}
            />
            <div className={styles.iconBox}><FaSearch /></div>
          </div>
          
          <div className={styles.adminBox}>
            <h4>ADD PRODUCT</h4>
            <input placeholder="Name" value={newName} onChange={(e) => setNewName(e.target.value)} />
            <input type="number" placeholder="Price" value={newPrice} onChange={(e) => setNewPrice(Number(e.target.value))} />
            <button onClick={handleAddProduct}>SAVE</button>
          </div>
        </div>
      </div>
    </>
  );
};
