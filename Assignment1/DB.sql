CREATE TABLE `User` (
  `user_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM ('admin', 'seller', 'customer') NOT NULL
);

CREATE TABLE `Seller` (
  `seller_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `user_id` INT UNIQUE NOT NULL,
  `store_name` VARCHAR(255) NOT NULL,
  `store_description` VARCHAR(255) NOT NULL,
  `contact_info` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL
);

CREATE TABLE `Store_Type` (
  `store_type_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `Store` (
  `store_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `store_name` VARCHAR(255) UNIQUE NOT NULL,
  `store_owner_id` INT UNIQUE NOT NULL,
  `contact_info` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `store_type_id` INT NOT NULL,
  `creation_date` TIMESTAMP NOT NULL,
  `rating` INT NOT NULL,
  `address` VARCHAR(255) NOT NULL
);

CREATE TABLE `Product` (
  `product_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(255) UNIQUE NOT NULL,
  `product_description` VARCHAR(255) NOT NULL,
  `price` FLOAT NOT NULL
);

CREATE TABLE `Rating` (
  `rating_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `rating_value` INT NOT NULL,
  `reviews` VARCHAR(255) NOT NULL
);

CREATE TABLE `Product_Store` (
  `product_store_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `stock_quantity` INT NOT NULL,
  `discount` INT NOT NULL
);

CREATE TABLE `Order` (
  `order_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `order_date` TIMESTAMP NOT NULL,
  `total_price` FLOAT NOT NULL,
  `payment_method_id` INT NOT NULL
);

CREATE TABLE `Order_Item` (
  `order_item_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` FLOAT NOT NULL,
  `total_price` FLOAT NOT NULL
);

CREATE TABLE `Payment_Method` (
  `payment_method_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL
);

CREATE TABLE `Card` (
  `card_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `card_number` VARCHAR(255) NOT NULL,
  `expiry_date` DATE NOT NULL,
  `cvv` INT NOT NULL
);

CREATE TABLE `Promotion` (
  `promotion_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `promotion_name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `start_date` TIMESTAMP NOT NULL,
  `end_date` TIMESTAMP NOT NULL,
  `discount_percentage` FLOAT NOT NULL
);

CREATE TABLE `Product_Promotion` (
  `product_promotion_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `promotion_id` INT NOT NULL
);

CREATE TABLE `Customer` (
  `customer_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `user_id` INT UNIQUE NOT NULL,
  `customer_name` VARCHAR(255) NOT NULL,
  `customer_description` VARCHAR(255) NOT NULL,
  `contact_info` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL
);

CREATE TABLE `Category` (
  `category_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `Product_Category` (
  `product_category_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `category_id` INT NOT NULL
);

CREATE TABLE `Wishlist` (
  `wishlist_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL
);

CREATE TABLE `Cart` (
  `cart_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL
);

CREATE TABLE `Event` (
  `event_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `event_name` VARCHAR(255) NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL
);

CREATE TABLE `Survey` (
  `survey_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `survey_name` VARCHAR(255) NOT NULL,
  `survey_questions` TEXT NOT NULL,
  `survey_responses` TEXT NOT NULL
);

CREATE TABLE `Employee` (
  `employee_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `position` VARCHAR(255) NOT NULL,
  `hire_date` DATE NOT NULL
);

ALTER TABLE `Seller` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Store` ADD FOREIGN KEY (`store_owner_id`) REFERENCES `Seller` (`seller_id`);

ALTER TABLE `Store` ADD FOREIGN KEY (`store_type_id`) REFERENCES `Store_Type` (`store_type_id`);

ALTER TABLE `Rating` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Rating` ADD FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`);

ALTER TABLE `Rating` ADD FOREIGN KEY (`store_id`) REFERENCES `Store` (`store_id`);

ALTER TABLE `Product_Store` ADD FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`);

ALTER TABLE `Product_Store` ADD FOREIGN KEY (`store_id`) REFERENCES `Store` (`store_id`);

ALTER TABLE `Order` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Order` ADD FOREIGN KEY (`payment_method_id`) REFERENCES `Payment_Method` (`payment_method_id`);

ALTER TABLE `Order_Item` ADD FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`);

ALTER TABLE `Order_Item` ADD FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`);

ALTER TABLE `Card` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Product_Promotion` ADD FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`);

ALTER TABLE `Product_Promotion` ADD FOREIGN KEY (`promotion_id`) REFERENCES `Promotion` (`promotion_id`);

ALTER TABLE `Customer` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Product_Category` ADD FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`);

ALTER TABLE `Product_Category` ADD FOREIGN KEY (`category_id`) REFERENCES `Category` (`category_id`);

ALTER TABLE `Wishlist` ADD FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`);

ALTER TABLE `Wishlist` ADD FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`);

ALTER TABLE `Cart` ADD FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`);

ALTER TABLE `Cart` ADD FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`);
