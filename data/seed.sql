INSERT INTO customers VALUES
(1,'Silver Rock Supply','NV','2024-01-15'),
(2,'Desert Valley Co','AZ','2024-02-10'),
(3,'Highland Services','CA','2024-03-05');

INSERT INTO products VALUES
(10,'Widget A','Widgets',12.50),
(11,'Widget B','Widgets',18.00),
(12,'Gadget A','Gadgets',22.00),
(13,'Gadget B','Gadgets',35.00);

INSERT INTO orders VALUES
(100,1,'2024-04-01','2024-04-03','2024-04-02','Shipped'),
(101,1,'2024-04-15','2024-04-18','2024-04-20','Shipped'),
(102,2,'2024-05-02','2024-05-05',NULL,'Processing'),
(103,3,'2024-05-10','2024-05-12','2024-05-12','Shipped');

INSERT INTO order_items VALUES
(1000,100,10,2),
(1001,100,12,1),
(1002,101,11,3),
(1003,102,13,1),
(1004,103,10,5),
(1005,103,12,2);
