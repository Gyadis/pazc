DROP DATABASE IF EXISTS TechFix;
CREATE DATABASE TechFix;
USE TechFix;

-- zakaznici, zamestnanci a administrator
CREATE TABLE User
(
    id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstName   VARCHAR(30) NOT NULL,
    lastName    VARCHAR(30) NOT NULL,
    phone       VARCHAR(20) NOT NULL,
    email       VARCHAR(60),
    role        VARCHAR(20) NOT NULL CHECK (role IN ('CUSTOMER', 'EMPLOYEE', 'ADMIN'))
);

-- zariadenia zakaznikov
CREATE TABLE Device
(
    id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userId          INT NOT NULL,
    deviceType      VARCHAR(30) NOT NULL,
    manufacturer    VARCHAR(30) NOT NULL,
    model           VARCHAR(50) NOT NULL,
    serialNumber    VARCHAR(50),
    description     TEXT,
    FOREIGN KEY (userId) REFERENCES User(id)
);

-- servisne poziadavky
CREATE TABLE ServiceRequest
(
    id                  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customerId          INT NOT NULL,
    employeeId          INT,
    deviceId            INT NOT NULL,
    title               VARCHAR(100) NOT NULL,
    problemDescription  TEXT NOT NULL,
    diagnosis           TEXT,
    status              VARCHAR(25) NOT NULL
                        CHECK (status IN ('RECEIVED', 'DIAGNOSIS', 'WAITING_FOR_PARTS',
                                          'IN_PROGRESS', 'COMPLETED', 'READY_FOR_PICKUP',
                                          'DELIVERED', 'CANCELLED')),
    priority            VARCHAR(15) NOT NULL
                        CHECK (priority IN ('LOW', 'NORMAL', 'HIGH', 'URGENT')),
    createdAt           DATETIME NOT NULL,
    completedAt         DATETIME,
    price          DECIMAL(8,2) CHECK (price >= 0),
    FOREIGN KEY (customerId) REFERENCES User(id),
    FOREIGN KEY (employeeId) REFERENCES User(id),
    FOREIGN KEY (deviceId) REFERENCES Device(id)
);

-- sklad nahradnych dielov
CREATE TABLE SparePart
(
    id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(80) NOT NULL,
    manufacturer    VARCHAR(50),
    category        VARCHAR(40),
    quantity        INT NOT NULL CHECK (quantity >= 0),
    purchasePrice   DECIMAL(8,2) NOT NULL CHECK (purchasePrice >= 0),
    sellingPrice    DECIMAL(8,2) NOT NULL CHECK (sellingPrice >= 0)
);

-- prepojenie servisnych poziadaviek a nahradnych dielov
CREATE TABLE RequestPart
(
    id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    requestId       INT NOT NULL,
    sparePartId     INT NOT NULL,
    quantity        INT NOT NULL CHECK (quantity > 0),
    unitPrice       DECIMAL(8,2) NOT NULL CHECK (unitPrice >= 0),
    FOREIGN KEY (requestId) REFERENCES ServiceRequest(id),
    FOREIGN KEY (sparePartId) REFERENCES SparePart(id)
);

-- platby za servisne poziadavky
CREATE TABLE Payment
(
    id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    requestId       INT NOT NULL,
    amount          DECIMAL(8,2) NOT NULL CHECK (amount > 0),
    paymentMethod   VARCHAR(15) NOT NULL
                    CHECK (paymentMethod IN ('CASH', 'CARD', 'TRANSFER')),
    paymentDate     DATETIME NOT NULL,
    FOREIGN KEY (requestId) REFERENCES ServiceRequest(id)
);
