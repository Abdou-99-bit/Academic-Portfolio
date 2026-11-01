

import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";
import type { Product } from "../types";

interface ProductState {
  items: Product[];
  status: 'idle' | 'loading' | 'succeeded' | 'failed';
}

const initialState: ProductState = {
  items: [],
  status: 'idle',
};

export const fetchProducts = createAsyncThunk("products/fetch", async () => {
  const response = await axios.get("http://localhost:8000/api/products");
  return response.data;
});

export const removeProduct = createAsyncThunk("products/delete", async (id: number) => {
  await axios.delete(`http://localhost:8000/api/products/${id}`);
  return id;
});

export const addProduct = createAsyncThunk("products/add", async (newProduct: Partial<Product>) => {
  const response = await axios.post("http://localhost:8000/api/products", newProduct);
  return response.data;
});

const productSlice = createSlice({
  name: "products",
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(fetchProducts.fulfilled, (state, action) => {
        state.items = action.payload;
        state.status = 'succeeded';
      })
      .addCase(removeProduct.fulfilled, (state, action) => {
        state.items = state.items.filter(item => item.id !== action.payload);
      })
      .addCase(addProduct.fulfilled, (state, action) => {
        state.items.push(action.payload);
      });
  },
});

export default productSlice.reducer;
