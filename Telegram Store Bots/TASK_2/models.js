import pkg from "sequelize";
const { Sequelize } = pkg;
import { seq } from "./db.js";

export const User = seq.define("user", {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
userId: {
    type: Sequelize.STRING,
    unique: false,
    allowNull: false
  }
});

export const Category = seq.define("category", {
  name: { type: Sequelize.STRING, allowNull: false },
  description: { type: Sequelize.STRING, allowNull: false }
});

export const Product = seq.define("product", {
  name: { type: Sequelize.STRING, allowNull: false },
  description: { type: Sequelize.STRING, allowNull: false },
  price: { type: Sequelize.FLOAT, allowNull: false },
  stock_quantity: { type: Sequelize.INTEGER, allowNull: false }
});

export const Review = seq.define("review", {
  text: { type: Sequelize.STRING, allowNull: false }
});

export const CartItem = seq.define("cartItem", {
  quantity: { type: Sequelize.INTEGER, defaultValue: 1 }
});

Category.hasMany(Product);
Product.belongsTo(Category);

Product.hasMany(Review);
Review.belongsTo(Product);

User.hasMany(CartItem);
CartItem.belongsTo(User);

Product.hasMany(CartItem);
CartItem.belongsTo(Product);
