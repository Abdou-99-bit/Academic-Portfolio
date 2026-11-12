import TelegramApi from "node-telegram-bot-api";
import { seq } from "./db.js";
import { User, Category, Product, Review, CartItem } from "./models.js";
import { Op } from "sequelize";

const bot = new TelegramApi("8334786950:AAHKVwm66wfpu1eL4IjTkxz5F3S1fWyD6Kc", { polling: true });

await seq.sync();


let currentProduct = {};
let currentReview = {};

bot.setMyCommands([
    { command: "/start", description: "Start bot" }
]);


bot.on("message", async msg => {
    const chatId = msg.chat.id;
    const text = msg.text;

    
    let user = await User.findOne({ where: { userId: chatId } });
    if (!user) user = await User.create({ userId: chatId });

    
    if (text === "/start") {
        return bot.sendMessage(chatId, "Welcome!", {
            reply_markup: {
                keyboard: [
                    ["Categories", "Catalog"],
                    ["Cart", "About Us"]
                ],
                resize_keyboard: true
            }
        });
    }

    if (text === "About Us") {
        return bot.sendMessage(chatId, "This is a shop bot created for your assignment.");
    }

    
    if (text === "Categories") {
        const cats = await Category.findAll({ raw: true });
        const list = cats.map(c => [{ text: c.name, callback_data: `cat_${c.id}` }]);
        return bot.sendMessage(chatId, "Choose category:", {
            reply_markup: { inline_keyboard: list }
        });
    }

    
    if (text === "Catalog") {
        const product = await Product.findOne({
            order: [["id", "ASC"]],
            raw: true
        });

        if (!product) return bot.sendMessage(chatId, "No products available.");

        currentProduct[chatId] = product.id;
        return sendProduct(chatId, product);
    }

    
    if (text === "Cart") {
        const items = await CartItem.findAll({
            where: { userId: user.id },
            include: Product,
            raw: true
        });

        if (items.length === 0)
            return bot.sendMessage(chatId, "Cart is empty.");

        const list = items
            .map(i => `• ${i["product.name"]} - $${i["product.price"]}`)
            .join("\n");

        return bot.sendMessage(chatId, "Your cart:\n\n" + list, {
            reply_markup: {
                inline_keyboard: [
                    [{ text: "Order", callback_data: "cart_order" }],
                    [{ text: "Clear Cart", callback_data: "cart_clear" }]
                ]
            }
        });
    }

    
    if (currentReview[chatId]) {
        await Review.create({
            text,
            productId: currentReview[chatId]
        });

        delete currentReview[chatId];
        return bot.sendMessage(chatId, "Review added!");
    }
});


bot.on("callback_query", async msg => {
    const chatId = msg.message.chat.id;
    const data = msg.data;

    const user = await User.findOne({ where: { userId: chatId } });

    
    if (data.startsWith("cat_")) {
        const catId = data.split("_")[1];
        const products = await Product.findAll({ where: { categoryId: catId }, raw: true });

        if (products.length === 0) return bot.sendMessage(chatId, "No products.");

        const product = products[0];
        currentProduct[chatId] = product.id;

        return sendProduct(chatId, product);
    }

    
    if (data === "next_product") {
        const id = currentProduct[chatId];
        if (!id) return bot.sendMessage(chatId, "Error: No product selected.");

        const next = await Product.findOne({
            where: { id: { [Op.gt]: id } },
            order: [["id", "ASC"]],
            raw: true
        });

        if (!next) return bot.sendMessage(chatId, "No more products.");

        currentProduct[chatId] = next.id;
        return sendProduct(chatId, next);
    }

    
    if (data === "prev_product") {
        const id = currentProduct[chatId];
        if (!id) return bot.sendMessage(chatId, "Error: No product selected.");

        const prev = await Product.findOne({
            where: { id: { [Op.lt]: id } },
            order: [["id", "DESC"]],
            raw: true
        });

        if (!prev) return bot.sendMessage(chatId, "First product.");

        currentProduct[chatId] = prev.id;
        return sendProduct(chatId, prev);
    }

    
    if (data === "add_to_cart") {
        await CartItem.create({
            userId: user.id,
            productId: currentProduct[chatId]
        });
        return bot.sendMessage(chatId, "Added to cart.");
    }

    
    if (data === "reviews") {
        const productId = currentProduct[chatId];

        const review = await Review.findOne({
            where: { productId },
            order: [["id", "ASC"]],
            raw: true
        });

        if (!review) return bot.sendMessage(chatId, "No reviews.");

        currentReview[chatId] = productId;
        currentReview[chatId + "_position"] = review.id;

        return sendReview(chatId, review);
    }

    
    if (data === "leave_review") {
        currentReview[chatId] = currentProduct[chatId];
        return bot.sendMessage(chatId, "Write your review:");
    }

    
    if (data === "cart_clear") {
        await CartItem.destroy({ where: { userId: user.id } });
        return bot.sendMessage(chatId, "Cart cleared.");
    }

});


async function sendProduct(chatId, p) {
    return bot.sendMessage(chatId,
        `*${p.name}*\n${p.description}\nPrice: $${p.price}`,
        {
            parse_mode: "Markdown",
            reply_markup: {
                inline_keyboard: [
                    [
                        { text: "Previous", callback_data: "prev_product" },
                        { text: "Next", callback_data: "next_product" }
                    ],
                    [{ text: "Reviews", callback_data: "reviews" }],
                    [{ text: "Add to Cart", callback_data: "add_to_cart" }],
                    [{ text: "To Top", callback_data: "/start" }]
                ]
            }
        }
    );
}


async function sendReview(chatId, r) {
    return bot.sendMessage(chatId, "Review:\n" + r.text, {
        reply_markup: {
            inline_keyboard: [
                [{ text: "Leave Review", callback_data: "leave_review" }],
                [{ text: "To Top", callback_data: "/start" }]
            ]
        }
    });
}

export { bot };
