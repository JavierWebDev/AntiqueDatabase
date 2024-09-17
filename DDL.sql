CREATE DATABASE antique_market;
USE antique_market;

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    permissions VARCHAR(255)
);

CREATE TABLE profile_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

CREATE TABLE antique_conditions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    condition_name VARCHAR(50) NOT NULL
);

CREATE TABLE antique_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE payment_methods (
    id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL
);

CREATE TABLE payment_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE delivery_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE inventory_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    full_name VARCHAR(255),
    address TEXT,
    phone_number VARCHAR(20),
    profile_type_id INT,
    avatar_url VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (profile_type_id) REFERENCES profile_types(id)
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    payment_method_id INT,
    payment_status_id INT,
    delivery_status_id INT,
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id),
    FOREIGN KEY (payment_status_id) REFERENCES payment_status(id),
    FOREIGN KEY (delivery_status_id) REFERENCES delivery_status(id)
);

CREATE TABLE antiques (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    photo_url VARCHAR(255),
    category VARCHAR(100),
    epoch VARCHAR(50),
    condition_id INT,
    price DECIMAL(10, 2) NOT NULL,
    status_id INT,
    seller_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (condition_id) REFERENCES antique_conditions(id),
    FOREIGN KEY (status_id) REFERENCES antique_status(id),
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id INT,
    seller_id INT,
    antique_id INT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sale_price DECIMAL(10, 2) NOT NULL,
    payment_id INT,
    FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (antique_id) REFERENCES antiques(id) ON DELETE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES payments(id) ON DELETE CASCADE
);

CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    antique_id INT,
    current_owner_id INT,
    status_id INT,
    FOREIGN KEY (antique_id) REFERENCES antiques(id) ON DELETE CASCADE,
    FOREIGN KEY (current_owner_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (status_id) REFERENCES inventory_status(id)
);

CREATE TABLE activity_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255),
    description TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE price_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    antique_id INT,
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (antique_id) REFERENCES antiques(id) ON DELETE CASCADE
);
