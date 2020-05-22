/*
Structured Computation Project
*********************************************************************
Created By: Gita Kartika Suriah
*********************************************************************
*/
SHOW DATABASES;
USE classicmodels;

#CREATE DATABASE BY REDUCING COLUMN FROM TABLES
ALTER TABLE productlines
	DROP COLUMN textDescription, DROP COLUMN htmlDescription;
SELECT * FROM productlines;
ALTER TABLE products
	DROP COLUMN productScale, DROP COLUMN productVendor,DROP COLUMN productDescription, DROP COLUMN MSRP;
SELECT * FROM products;
SELECT * FROM orderdetails;
ALTER TABLE orders
	DROP COLUMN requiredDate, DROP COLUMN `status` ,DROP COLUMN comments;
SELECT * FROM orders;
SELECT * FROM payments;
ALTER TABLE customers
	DROP COLUMN contactLastName, DROP COLUMN contactFirstName ,DROP COLUMN phone, DROP COLUMN city,
    DROP COLUMN state, DROP COLUMN country, DROP COLUMN creditLimit;
SELECT * FROM customers;
ALTER TABLE employees
	DROP COLUMN extension, DROP COLUMN email , DROP COLUMN jobTitle;
SELECT * FROM employees;
ALTER TABLE offices
	DROP COLUMN city, DROP COLUMN phone , DROP COLUMN state, DROP COLUMN country, DROP COLUMN territory;
SELECT * FROM offices;

#JOIN TABLES
###ORDERDETAILS###
SELECT * FROM orderdetails;
#Orders
SELECT * FROM orders;
SELECT customerNumber,orderDate,shippedDate,quantityOrdered,priceEach,orderLineNumber FROM orderdetails
LEFT JOIN orders ON orders.orderNumber=orderdetails.orderNumber;
#Products
SELECT * FROM products;
SELECT orderNumber,productName,productLine,quantityOrdered,priceEach,orderLineNumber FROM orderdetails
LEFT JOIN products ON products.productCode=orderdetails.productCode;

###ORDERS###
SELECT * FROM orders;
#customerNumber
SELECT * FROM customers;
SELECT customerName,orderNumber,orderDate,shippedDate,addressLine1,addressLine2,postalCode FROM orders
LEFT JOIN customers ON orders.customerNumber=customers.customerNumber;

###CUSTOMERS###
SELECT * FROM customers;
#salesRepEmployeeNumber
SELECT customerName,lastName,FirstName,officeCode FROM customers
LEFT JOIN employees ON customers.SalesRepEmployeeNumber=employees.employeeNumber;

###PAYMENTS###
SELECT * FROM payments;
SELECT customerName,checkNumber,paymentDate,amount FROM payments
LEFT JOIN customers ON customers.customerNumber=payments.customerNumber;

###EMPLOYEES###
SELECT * FROM employees;
#OfficeCode
SELECT * FROM offices;
SELECT lastName,firstName,addressLine1,addressLine2,PostalCode FROM employees
LEFT JOIN offices ON offices.officeCode=employees.officeCode;

#FILTER/SEARCHING DATA
#Filter data with criteria: orderDate on 2003-01-06 AND 2003-01-09
SELECT orderDate, orderdetails.orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber  FROM orders 
LEFT JOIN orderdetails ON orderdetails.orderNumber=orders.orderNumber 
WHERE orderDate="2003-01-06" or orderDate="2003-01-09";

#Search for specific customer name and order number
SELECT * FROM orders;
#customerNumber
SELECT * FROM customers;
SELECT customerName,orderNumber,orderDate,shippedDate,addressLine1,addressLine2,postalCode FROM orders
LEFT JOIN customers ON orders.customerNumber=customers.customerNumber
WHERE customerName="Blauer See Auto, Co." AND orderNumber=10101;

#Search for maximum amount from payments
SELECT * FROM payments;
SELECT customerName,checkNumber,paymentDate,amount FROM payments
LEFT JOIN customers ON customers.customerNumber=payments.customerNumber
WHERE amount= (SELECT MAX(amount) FROM payments);
SELECT MAX(amount) FROM payments;
