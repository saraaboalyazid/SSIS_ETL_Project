-- Source Database Setup
CREATE DATABASE financial_transactions_db;
USE financial_transactions_db;
--Create Financial Transactions Table
CREATE TABLE financial_transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    supplier_name VARCHAR(50),
    transaction_date DATE,
    amount DECIMAL(10, 2),
    currency VARCHAR(10)
);
--Insert Sample Data into Financial Transactions Table
INSERT INTO financial_transactions (transaction_id, customer_id, supplier_name, transaction_date, amount, currency)
VALUES
    (1, 101, 'ABC Corp', '2024-01-15', 1000.00, 'USD'),
    (2, 102, 'XYZ Ltd', '2024-01-20', 1500.50, 'EUR'),
    (3, 103, 'Global Inc', '2024-02-05', 2000.00, 'GBP'),
    (4, 104, 'ABC Corp', '2024-02-10', 500.25, 'USD');
    --Create Customer Details Table
    CREATE TABLE customer_details (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20)
);
--Insert Sample Data into Customer Details Table
INSERT INTO customer_details (customer_id, customer_name, email, phone)
VALUES
    (101, 'John Doe', 'john.doe@example.com', '123-456-7890'),
    (102, 'Jane Smith', 'jane.smith@example.com', '234-567-8901'),
    (103, 'Mike Johnson', 'mike.johnson@example.com', '345-678-9012'),
    (104, 'Emily Davis', 'emily.davis@example.com', '456-789-0123');

-- see the data 
select * from dbo.customer_details;
select * from dbo.financial_transactions;

-- creating the schema for the datawarehouse 
CREATE DATABASE financial_data_warehouse;
USE financial_data_warehouse;
-- using financial_transactions_db we will join the 2 tables 

select t.* , c.customer_name , c.email customer_email , c.phone customer_phone from dbo.financial_transactions t inner join dbo.customer_details c 
on t.customer_id = c.customer_id
 -- after joinning we have to edit the schema for the destintation 
 alter table dbo.financial_transactions
 add [customer_name] [varchar](50) NULL,
	 [customer_email] [varchar](100) NULL,
	 [customer_phone] [varchar](20) NULL
-- solve the issue of primiry key  
truncate table dbo.financial_transactions
-- add schema for the flat files 
create table dbo.exchange_rates
(
from_currency	varchar(10),
to_currency	 varchar(10),
exchange_rate float ,
effective_date date
)
create table dbo.suppliers 
(
supplier_id	int ,
supplier_name varchar(100),
contact_name varchar(100),
phone  varchar(25),
)
-- see all data
select * from dbo.financial_transactions;
select * from dbo.exchange_rates;
select * from dbo.suppliers;
-- we have duplicate data 
-- add truncate before al the control flow 

-- add the conversion 
alter table dbo.financial_transactions
add amount_USD float ;

--add supplier info 
alter table dbo.financial_transactions
add [supplier_contact_name] [varchar] (100) NULL, 
    [supplier_phone] [varchar] (25) NULL
