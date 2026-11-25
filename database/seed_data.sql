
USE banking_system;

-- 1. Insert sample customers
INSERT INTO customer (first_name, last_name, email, phone)
VALUES
('Aarav', 'Sharma', 'aarav@example.com', '9876543210'),
('Rahul', 'Verma', 'rahul@example.com', '9876543211'),
('Priya', 'Singh', 'priya@example.com', '9876543212');

-- 2. Insert sample bank accounts
INSERT INTO account
(customer_id, account_number, balance, account_type, account_status)
VALUES
(1, 'ACC1001', 10000.00, 'SAVINGS', 'ACTIVE'),
(2, 'ACC1002', 5000.00, 'SAVINGS', 'ACTIVE'),
(3, 'ACC1003', 15000.00, 'CURRENT', 'ACTIVE'),
(1, 'ACC1004', 2000.00, 'SAVINGS', 'ACTIVE');

-- 3. Insert sample transaction records
INSERT INTO bank_transaction
(
    transaction_id,
    source_account_id,
    destination_account_id,
    source_account_number,
    destination_account_number,
    amount,
    transaction_type,
    transaction_status,
    processed_at
)
VALUES
('TXN001', NULL, 1, NULL, 'ACC1001',
 2000.00, 'DEPOSIT', 'SUCCESS', NOW()),

('TXN002', 2, NULL, 'ACC1002', NULL,
 1000.00, 'WITHDRAWAL', 'SUCCESS', NOW()),

('TXN003', 3, 4, 'ACC1003', 'ACC1004',
 500.00, 'TRANSFER', 'SUCCESS', NOW());
