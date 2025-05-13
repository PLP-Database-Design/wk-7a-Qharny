-- Question 1: Achieving 1NF (First Normal Form)
-- We need to eliminate repeating groups in the Products column. Each product must be on its own row.

-- Input Table (ProductDetail):

-- Original non-normalized table (for reference)
-- | OrderID | CustomerName  | Products                        |
-- |---------|---------------|---------------------------------|
-- | 101     | John Doe      | Laptop, Mouse                   |
-- | 102     | Jane Smith    | Tablet, Keyboard, Mouse         |
-- | 103     | Emily Clark   | Phone                           |

-- Transformed Table in 1NF:

-- Create a normalized version of ProductDetail (1NF)
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert data into the normalized table
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Question 2: Achieving 2NF (Second Normal Form)
-- We now remove partial dependencies: CustomerName depends only on OrderID, not on the full composite key (OrderID, Product).

-- Step 1: Split into Two Tables
-- Orders: Contains OrderID and CustomerName

-- OrderDetails: Contains OrderID, Product, and Quantity

-- SQL Queries:

-- Create 'Orders' table to remove partial dependency
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert unique OrderID-CustomerName pairs
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Create 'OrderDetails_2NF' table for product info per order
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into normalized OrderDetails table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);