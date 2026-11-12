SHOW DATABASES ;
CREATE TABLE Factory (
    factory_id INT AUTO_INCREMENT PRIMARY KEY,
    factory_name VARCHAR(100) NOT NULL,
    location VARCHAR(150)
);

CREATE TABLE Seller (
    seller_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone VARCHAR(20)
);
CREATE TABLE Goods (
    goods_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    seller_id INT,
    factory_id INT,
	FOREIGN KEY (seller_id) REFERENCES Seller(seller_id) ON DELETE SET NULL,
	FOREIGN KEY (factory_id) REFERENCES Factory(factory_id) ON DELETE SET NULL
);
CREATE TABLE Client (
    client_id sellerINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(200)
);

CREATE TABLE orders (
	order_id INT AUTo_INCREMENT PRIMARY KEY,
    delivery_time VARCHAR(100) NOT NULL,
    receiving_time VARCHAR(100) NOT NULL,
	price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id) ON DELETE SET NULL,
);goods    
    
    
    
    







