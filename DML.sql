USE antique_market;

INSERT INTO roles (role_name, permissions) VALUES ('Admin', 'ALL'), ('Buyer', 'VIEW'), ('Seller', 'SELL');

INSERT INTO profile_types (type_name) VALUES ('Standard'), ('Premium');

INSERT INTO antique_conditions (condition_name) VALUES ('New'), ('Like New'), ('Used'), ('Antique');

INSERT INTO antique_status (status_name) VALUES ('Available'), ('Sold'), ('On Hold');

INSERT INTO payment_methods (method_name) VALUES ('Credit Card'), ('PayPal'), ('Bank Transfer');

INSERT INTO payment_status (status_name) VALUES ('Paid'), ('Pending'), ('Refunded');

INSERT INTO delivery_status (status_name) VALUES ('Shipped'), ('Pending'), ('Delivered');

INSERT INTO inventory_status (status_name) VALUES ('In Stock'), ('Sold Out');

INSERT INTO users (username, password, email, role_id) VALUES 
('johndoe', 'password123', 'johndoe@example.com', 2),
('janedoe', 'password456', 'janedoe@example.com', 3),
('admin', 'adminpass', 'admin@example.com', 1);

INSERT INTO profiles (user_id, full_name, address, phone_number, profile_type_id, avatar_url) VALUES 
(1, 'John Doe', '123 Elm Street', '555-1234', 1, 'url_to_avatar'),
(2, 'Jane Doe', '456 Oak Avenue', '555-5678', 2, 'url_to_avatar');

INSERT INTO payments (payment_method_id, payment_status_id, delivery_status_id) VALUES 
(1, 1, 1),
(2, 2, 2);

INSERT INTO antiques (name, description, photo_url, category, epoch, condition_id, price, status_id, seller_id) VALUES 
('Antique Chair', 'A beautiful antique chair.', 'url_to_photo', 'Furniture', 'Victorian', 4, 1500.00, 1, 2),
('Vintage Lamp', 'A vintage lamp from the 1920s.', 'url_to_photo', 'Lighting', '1920s', 3, 800.00, 1, 3);

INSERT INTO transactions (buyer_id, seller_id, antique_id, transaction_date, sale_price, payment_id) VALUES 
(1, 2, 1, '2024-08-15', 1500.00, 1),
(1, 3, 2, '2024-09-01', 800.00, 2);

INSERT INTO inventory (antique_id, current_owner_id, status_id) VALUES 
(1, 2, 1),
(2, 3, 1);

INSERT INTO activity_log (user_id, action, description) VALUES 
(1, 'Purchase', 'Purchased Antique Chair'),
(1, 'Purchase', 'Purchased Vintage Lamp');

INSERT INTO price_history (antique_id, old_price, new_price, changed_at) VALUES 
(1, 1600.00, 1500.00, '2024-08-01'),
(2, 850.00, 800.00, '2024-09-01');
