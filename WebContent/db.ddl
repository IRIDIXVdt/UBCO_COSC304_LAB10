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
	admin					int,
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

INSERT INTO category VALUES ('Springy');
INSERT INTO category VALUES ('Flexible');
INSERT INTO category VALUES ('Inflexible');
INSERT INTO category VALUES ('Swishy');
INSERT INTO category VALUES ('Stiff');
INSERT INTO category VALUES ('Brittle');
INSERT INTO category VALUES ('Bendy');
INSERT INTO category VALUES ('Pliable');
INSERT INTO category VALUES ('Whippy');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Acacia Wand',1, 'A very unusual wand wood, which I have found creates tricky wands that often refuse to produce magic for any but their owner, and also withhold their best effects from all but those most gifted.',20.84);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Alder Wand',2,'Alder is an unyielding wood, yet I have discovered that its ideal owner is not stubborn or obstinate, but often helpful, considerate and most likeable.',14.69);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Apple Wand',3,'Applewood wands are not made in great numbers. They are powerful and best suited to an owner of high aims and ideals, as this wood mixes poorly with Dark magic.',19.55);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ash Wand',2,'The ash wand cleaves to its one true master and ought not to be passed on or gifted from the original owner, because it will lose power and skill. This tendency is extreme if the core is of unicorn.',22.56);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Aspen Wand',5,'Wand-quality aspen wood is white and fine-grained, and highly prized by all wand-makers for its stylish resemblance to ivory and its usually outstanding charmwork.',11.93);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Beech Wand',9,'The true match for a beech wand will be, if young, wise beyond his or her years, and if full-grown, rich in understanding and experience. Beech wands perform very weakly for the narrow-minded and intolerant.',12.66);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Blackthorn Wand',4,'Blackthorn, which is a very unusual wand wood, has the reputation, in my view well-merited, of being best suited to a warrior.',14.02);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Black Walnut Wand',5,'Less common than the standard walnut wand, that of black walnut seeks a master of good instincts and powerful insight. Black walnut is a very handsome wood, but not the easiest to master.',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cedar Wand',7,'Whenever I meet one who carries a cedar wand, I find strength of character and unusual loyalty. My father, Gervaise Ollivander, used always to say: you will never fool the cedar carrier, and I agree: the cedar wand finds its perfect home where there is perspicacity and perception.',24.56);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cherry Wand',9,'This very rare wand wood creates a wand of strange power, most highly prized by the wizarding students of the school of Mahoutokoro in Japan, where those who own cherry wands have special prestige.',11.73);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chestnut Wand',2,'This is a most curious, multi-faceted wood, which varies greatly in its character depending on the wand core, and takes a great deal of colour from the personality that possesses it.',11.53);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cypress Wand',3,'Cypress wands are associated with nobility. The great medieval wandmaker, Geraint Ollivander, wrote that he was always honoured to match a cypress wand, for he knew he was meeting a witch or wizard who would die a heroic death.',12.60);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dogwood Wand',4,'I have found that matching a dogwood wand with its ideal owner is always entertaining. Dogwood wands are quirky and mischievous. They have playful natures and insist upon partners who can provide them with scope for excitement and fun.',13.95);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ebony Wand',8,'This jet-black wand wood has an impressive appearance and reputation, being highly suited to all manner of combative magic, and to Transfiguration.',7.96);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('English Oak Wand',7,'A wand for good times and bad, this is a friend as loyal as the wizard who deserves it. Wands of English oak demand partners of strength, courage and fidelity.',9.53);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Elder Wand',4,'The rarest wand wood of all, and reputed to be deeply unlucky, the elder wand is trickier to master than any other. It contains powerful magic, but scorns to remain with any owner who is not the superior of his or her company. It takes a remarkable wizard to keep the elder wand for any length of time.',17.84);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Elm Wand',5,'The unfounded belief that only pure-bloods can produce magic from elm wands was undoubtedly started by some elm wand owner seeking to prove his own blood credentials, for I have known perfect matches of elm wands who are Muggle-borns.',24.63);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fir Wand',7,'My august grandfather, Gerbold Octavius Ollivander, always called wands of this wood ‘the survivor’s wand,’ because he had sold it to three wizards who subsequently passed through mortal peril unscathed.',14.73);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hawthorn Wand',6,'The wandmaker Gregorovitch wrote that hawthorn ‘makes a strange, contradictory wand, as full of paradoxes as the tree that gave it birth, whose leaves and blossoms heal, and yet whose cut branches smell of death.',12.92);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hazel Wand',6,'A sensitive wand, hazel often reflects its owner’s emotional state and works best for a master who understands and can manage their own feelings.',14.12);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Holly Wand',7,'Holly is one of the rarer kinds of wand woods. Traditionally considered protective, it works most happily for those who may need help overcoming a tendency to anger and impetuosity. Wood from Holly trees has magical healing properties and is thought to repel evil. Holly people make good leaders and thoughtful, loving and effective counsellors. Holly people should use their understanding of the dark, hidden side of humanity to guide others in their time of need.',16.66);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hornbeam Wand',9,'Hornbeam selects for its life mate the talented witch or wizard with a single, pure passion, which some might call obsession (though I prefer the term ‘vision’), which will almost always be realised.',6.68);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Larch Wand',3,'Strong, durable and warm in colour, larch has long been valued as an attractive and powerful wand wood. Its reputation for instilling courage and confidence in the user has ensured that demand has always outstripped supply.',13.11);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Laurel Wand',8,'It is said that a laurel wand cannot perform a dishonourable act, although in the quest for glory (a not uncommon goal for those best suited to these wands), I have known laurel wands perform powerful and sometimes lethal magic.',11.51);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Maple Wand',7,'I have often found that those chosen by maple wands are by nature travellers and explorers. They are not stay-at-home wands, and prefer ambition in their witch or wizard, otherwise their magic grows heavy and lacklustre.',20.70);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pear Wand',4,'This golden-toned wood produces wands of splendid magical powers, which give of their best in the hands of the warm-hearted, the generous and the wise. Possessors of pear wands are, in my experience, usually popular and well-respected.',21.79);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pine Wand',7,'The straight-grained pine wand always chooses an independent, individual master who may be perceived as a loner, intriguing and perhaps mysterious. Pine wands enjoy being used creatively, and unlike some others, will adapt unprotestingly to new methods and spells.',10.89);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Poplar Wand',1,'"If you seek integrity, search first among the poplars". Here is a wand to rely upon, of consistency, strength and uniform power, always happiest when working with a witch or wizard of clear moral vision.',16.98);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Red Oak Wand',9,'You will often hear the ignorant say that red oak is an infallible sign of its owner’s hot temper. In fact, the true match for a red oak wand is possessed of unusually fast reactions, making it a perfect duelling wand.',23.49);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Redwood Wand',6,'Wand-quality redwood is in short supply, yet constant demand, due to its reputation for bringing good fortune to its owner.',21.54);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Reed Wand',5,'Reed wands are best suited to those who are bold and are eloquent speakers, and prove to be very protective friends.', 21.61);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Rosewood Wand',9,null,17.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Rowan Wand',3,'Rowan wood has always been much-favoured for wands, because it is reputed to be more protective than any other, and in my experience renders all manner of defensive charms especially strong and difficult to break.',16.89);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Silver Lime Wand',1,'This unusual and highly attractive wand wood was greatly in vogue in the nineteenth century. Demand outstripped supply, and unscrupulous wandmakers dyed substandard woods in an effort to fool purchasers into believing that they had purchased silver lime.',16.75);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Spruce Wand',2,'Unskilled wandmakers call spruce a difficult wood, but in doing so they reveal their own ineptitude. It is quite true that it requires particular deftness to work with spruce, which produces wands that are ill-matched with cautious or nervous natures, and become positively dangerous in fumbling fingers.',15.39);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Snakewood Wand',3,null,10.87);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sugar Maple Wand',5,null,14.09);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sycamore',6,'The sycamore makes a questing wand, eager for new experience and losing brilliance if engaged in mundane activities. It is a quirk of these handsome wands that they may combust if allowed to become bored.',23.18);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Tamarack',2,null,16.41);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Vine Wand',6,'Vine wands are among the less common types, and I have been intrigued to notice that their owners are nearly always those witches or wizards who seek a greater purpose, who have a vision beyond the ordinary and who frequently astound those who think they know them best.',7.47);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Walnut Wand',9,'Highly intelligent witches and wizards ought to be offered a walnut wand for trial first, because in nine cases out of ten, the two will find in each other their ideal mate.',23.62);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Willow Wand',3,'Willow is an uncommon wand wood with healing power, and I have noted that the ideal owner for a willow wand often has some (usually unwarranted) insecurity, however well they may try and hide it.',13.74);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Yew Wand',6,'Yew wands are among the rarer kinds, and their ideal matches are likewise unusual, and occasionally notorious. The wand of yew is reputed to endow its possessor with the power of life and death.',15.63);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (1, 1, 80, 20.84);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (2, 1, 77, 14.69);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (3, 1, 67, 19.55);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (4, 1, 93, 22.56);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (5, 1, 3, 11.93);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (6, 1, 40, 12.66);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (7, 1, 14, 14.02);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (8, 1, 49, 10.50);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (9, 1, 83, 24.56);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (10, 1, 92, 11.73);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (11, 1, 55, 11.53);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (12, 1, 36, 12.60);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (13, 1, 73, 13.95);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (14, 1, 20, 7.96);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (15, 1, 14, 9.53);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (16, 1, 99, 17.84);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (17, 1, 124, 24.63);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (18, 1, 23, 14.73);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (19, 1, 38, 12.92);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (20, 1, 13, 14.12);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (21, 1, 46, 16.66);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (22, 1, 33, 6.68);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (23, 1, 12, 13.11);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (24, 1, 56, 11.51);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (25, 1, 13, 20.70);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (26, 1, 47, 21.79);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (27, 1, 24, 10.89);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (28, 1, 46, 16.98);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (29, 1, 85, 23.49);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (30, 1, 75, 21.54);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (31, 1, 63, 21.61);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (32, 1, 67, 17.4);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (33, 1, 35, 16.89);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (34, 1, 47, 16.75);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (35, 1, 76, 15.39);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (36, 1, 25, 10.87);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (37, 1, 58, 14.09);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (38, 1, 59, 23.18);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (39, 1, 70, 16.41);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (40, 1, 15, 7.47);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (41, 1, 76, 23.62);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (42, 1, 47, 13.74);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (43, 1, 75, 15.63);



INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Britney', 'Bentley', 'britney.bentley@gmail.com', '647-284-5996', '980 Front Street', 'Toronto', 'ON', 'M5J 2N1', 'Canada', 'ben' , 'test1',1);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Brenda', 'Kelly', 'brenda.kelly@hotmail.com', '403-884-7945', '4293 Pine Street', 'Halkirk', 'AB', 'T0C 1M0', 'Canada', 'kelly' , 'test2');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Jennifer', 'Barber', 'jennifer.barber@outlook.com', '403-709-3319', '4549 Port Washington Road', 'Cochrane', 'AB', 'T0L 0W0', 'Canada', 'barber' , 'test3');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Sandra', 'Jackson', 'sandra.jackson@gmail.com', '870-632-3716', '4779  Cedar Street', 'Dierks', 'AR', '71833', 'United States', 'jack' , 'test4');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Harry', 'Suarez', 'harry.suarez@hotmail.com', '317-714-7473', '849  Winifred Way', 'Marion', 'IN', '46953', 'United States', 'harry' , 'test5');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2020-11-20 14:42:33', 78.73)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 2, 20.84)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 12.66)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 11.73);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2020-10-28 19:20:30', 227.00)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 5,20.84)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 9, 5,24.56);

-- Order 3 cannot be shipped as do not have enough inventory for item 5
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2020-11-11 20:12:55', 96.9)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 6,11.93)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2,12.66);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2020-10-09 09:52:59', 108.25)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 5, 19.55)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 1, 10.50);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2020-09-29 14:44:22', 232.89)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 7, 19.55)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 9, 2, 24.56)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 4, 11.73);

UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/16.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/18.jpg' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/19.jpg' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/20.jpg' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'img/21.jpg' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'img/22.jpg' WHERE ProductId = 22;
UPDATE Product SET productImageURL = 'img/32.jpg' WHERE ProductId = 32;
UPDATE Product SET productImageURL = 'img/40.jpg' WHERE ProductId = 40;
UPDATE Product SET productImageURL = 'img/41.jpg' WHERE ProductId = 41;
UPDATE Product SET productImageURL = 'img/42.jpg' WHERE ProductId = 42;
UPDATE Product SET productImageURL = 'img/43.jpg' WHERE ProductId = 43;

INSERT INTO review(customerId, reviewRating, reviewDate, productId, reviewComment) VALUES (1, 5, '2020-12-01 12:24:30',1,'This wand is extremely comfortable to use! I love it!');
INSERT INTO review(customerId, reviewRating, reviewDate, productId, reviewComment) VALUES (2, 4, '2020-12-02 20:21:11',1,'Pretty good. I will recommend this wand to my friends.');
INSERT INTO review(customerId, reviewRating, reviewDate, productId, reviewComment) VALUES (2, 3, '2020-11-29 16:57:01',3,'Just ok.');
