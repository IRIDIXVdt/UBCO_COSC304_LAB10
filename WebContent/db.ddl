DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS productinventory;
DROP TABLE IF EXISTS warehouse;
DROP TABLE IF EXISTS orderproduct;
DROP TABLE IF EXISTS incart;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS ordersummary;
DROP TABLE IF EXISTS paymentmethod;
DROP TABLE IF EXISTS customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    admin                  INT,
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Gryffindor');
INSERT INTO category(categoryName) VALUES ('Hufflepuff');
INSERT INTO category(categoryName) VALUES ('Ravenclaw');
INSERT INTO category(categoryName) VALUES ('Slytherin');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Harry Potter',1, '11 inches, holly, phoenix feather',6.26);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Voldemort',4,'13.5 inches, yew, phoenix feather core',12.31);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Albus Dumbledore',1,'15 inches, thestral tail hair core',6.30);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Severus Snape',4,'unknown',1.09);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bellatrix Lestrange',4,'12.75 inches, walnut, dragon heartstring',5.02);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Draco Malfoy',4,'10 inches, aawthorn, unicorn hair',6.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Minerva McGonagall',1,'9.5 inches, fir, dragon heartstring',10.04);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Neville Longbottom',1,'13 inches, cherry, unicorn hair',7.30);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hermione Granger',1,'10.75 inches, vine wood, dragon heartstring',9.19);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ronald Weasley',1,'12 inches, ash, unicorn tail hair',3.01);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Remus Lupin',1,'10.25 inches, cypress, unicorn hair',3.10);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Peter Pettigrew',1,'9.25 inches, chestnut, dragon heartstring',9.01);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gilderoy Lockhart',3,'9 inches, cherry, dragon heartstring',1.26);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fleur Delacour',4,'9.5 inches, rosewood, veela hair',10.30);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cedric Diggory',2,'12.25 inches, ash, Unicorn hair',6.24);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ginevra Weasley',1,'unknown',8.11);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Luna Lovegood',3,'unknown',2.13);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Narcissa Malfoy',4,'unknown',19.55);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Horace Slughorn',4,'10.25 inches, cedar, dragon heartstring, fairly flexibles',4.28);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sirius Black',1,'unknown',11.03);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Viktor Krum',2,'10.25 inches, hornbeam, dragon heartstring',19.76);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (1, 1, 20, 6.26);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 12.31);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (3, 1, 15, 6.30);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (4, 1, 4, 1.09);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (5, 1, 1, 5.02);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (6, 1, 5, 6.05);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (7, 1, 3, 10.04);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (8, 1, 2, 7.30);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (9, 1, 10, 9.19);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (10, 1, 13, 3.01);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Britney', 'Bentley', 'britney.bentley@gmail.com', '647-284-5996', '980 Front Street', 'Toronto', 'ON', 'M5J 2N1', 'Canada', 'ben' , 'test1',1);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Brenda', 'Kelly', 'brenda.kelly@hotmail.com', '403-884-7945', '4293 Pine Street', 'Halkirk', 'AB', 'T0C 1M0', 'Canada', 'kelly' , 'test2');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Jennifer', 'Barber', 'jennifer.barber@outlook.com', '403-709-3319', '4549 Port Washington Road', 'Cochrane', 'AB', 'T0L 0W0', 'Canada', 'barber' , 'test3');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Sandra', 'Jackson', 'sandra.jackson@gmail.com', '870-632-3716', '4779  Cedar Street', 'Dierks', 'AR', '71833', 'United States', 'jack' , 'test4');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Harry', 'Suarez', 'harry.suarez@hotmail.com', '317-714-7473', '849  Winifred Way', 'Marion', 'IN', '46953', 'United States', 'harry' , 'test5');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2020-11-20 14:42:33', 27.63)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 2, 6.26)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 6.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 3.01);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2020-10-28 19:20:30', 77.25)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 5, 6.26)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 9, 5, 9.19);

-- Order 3 cannot be shipped as do not have enough inventory for item 5
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2020-11-11 20:12:55', 27.16)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 3, 5.02)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 6.05);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2020-10-09 09:52:59', 38.8)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 5, 6.30)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 1, 7.30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2020-09-29 14:44:22', 74.52)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 7, 6.3)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 9, 2, 9.19)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 4, 3.01);

UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/14.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/16.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/17.jpg' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/18.jpg' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/19.jpg' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/20.jpg' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'img/21.jpg' WHERE ProductId = 21;