# Assignment-1 Queries for ER Diagram
use assignment1_1;

# Create tables

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255)
);

CREATE TABLE CarCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255)
);

CREATE TABLE Car (
    CarID INT PRIMARY KEY,
    Model VARCHAR(255),
    Manufacturer VARCHAR(255),
    Year INT,
    RentalRate DECIMAL(10, 2),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES CarCategory(CategoryID)
);



CREATE TABLE Rental (
    RentalID INT PRIMARY KEY,
    RentalDate DATE,
    ReturnDate DATE,
    TotalCost DECIMAL(10, 2),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Position VARCHAR(255)
);

CREATE TABLE Branch (
    BranchID INT PRIMARY KEY,
    Location VARCHAR(255)
);

CREATE TABLE EmployeeBranch (
    EmployeeID INT,
    BranchID INT,
    PRIMARY KEY (EmployeeID, BranchID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY,
    PolicyNumber VARCHAR(255),
    CoverageDetails TEXT
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    RentalID INT,
    FOREIGN KEY (RentalID) REFERENCES Rental(RentalID)
);

CREATE TABLE PickupLocation (
    PickupLocationID INT PRIMARY KEY,
    Location VARCHAR(255)
);

CREATE TABLE DropoffLocation (
    DropoffLocationID INT PRIMARY KEY,
    Location VARCHAR(255)
);


# Insert Data

-- Inserting data into the Customer table
INSERT INTO Customer (CustomerID, Name, ContactNumber, Email) VALUES
(1, 'John Doe', '123-456-7890', 'john.doe@example.com'),
(2, 'Jane Smith', '987-654-3210', 'jane.smith@example.com'),
(3, 'Alice Johnson', '555-555-5555', 'alice.johnson@example.com'),
(4, 'Bob Williams', '666-666-6666', 'bob.williams@example.com');

-- Inserting data into the CarCategory table
INSERT INTO CarCategory (CategoryID, CategoryName) VALUES
(1, 'Sedan'),
(2, 'SUV'),
(3, 'Truck'),
(4, 'Convertible'),
(5, 'Van');

-- Inserting data into the Car table
INSERT INTO Car (CarID, Model, Manufacturer, Year, RentalRate, CategoryID) VALUES
(1, 'Camry', 'Toyota', 2022, 50.00, 1),
(2, 'Explorer', 'Ford', 2023, 60.00, 2),
(3, 'Silverado', 'Chevrolet', 2021, 70.00, 3),
(4, 'Mustang', 'Ford', 2023, 80.00, 4),
(5, 'Grand Caravan', 'Dodge', 2022, 90.00, 5);

-- Inserting data into the Rental table
INSERT INTO Rental (RentalID, RentalDate, ReturnDate, TotalCost, CustomerID) VALUES
(1, '2024-02-15', '2024-02-20', 250.00, 1),
(2, '2024-02-16', '2024-02-19', 300.00, 2),
(3, '2024-02-17', '2024-02-22', 400.00, 3),
(4, '2024-02-18', '2024-02-25', 500.00, 4);

-- Inserting data into the Employee table
INSERT INTO Employee (EmployeeID, Name, Position) VALUES
(1, 'Michael Johnson', 'Manager'),
(2, 'Emily Davis', 'Sales Representative'),
(3, 'David Brown', 'Sales Representative'),
(4, 'Sarah White', 'Assistant Manager');

-- Inserting data into the Branch table
INSERT INTO Branch (BranchID, Location) VALUES
(1, 'Main Street'),
(2, 'Broadway Avenue'),
(3, 'Park Avenue'),
(4, 'Main Street');

-- Inserting data into the EmployeeBranch table
INSERT INTO EmployeeBranch (EmployeeID, BranchID) VALUES
(1, 1),
(2, 2),
(2, 1),
(3, 3),
(4, 4),
(4, 3);

-- Inserting data into the Insurance table
INSERT INTO Insurance (InsuranceID, PolicyNumber, CoverageDetails) VALUES
(1, 'ABCD1234', 'Collision coverage up to $50,000'),
(2, 'WXYZ5678', 'Comprehensive coverage up to $100,000'),
(3, 'EFGH9876', 'Liability coverage up to $50,000'),
(4, 'IJKL4321', 'Rental car damage coverage up to $75,000');

-- Inserting data into the Payment table
INSERT INTO Payment (PaymentID, PaymentDate, Amount, RentalID) VALUES
(1, '2024-02-15', 100.00, 1),
(2, '2024-02-16', 150.00, 2),
(3, '2024-02-17', 200.00, 3),
(4, '2024-02-18', 300.00, 4);

-- Inserting data into the PickupLocation table
INSERT INTO PickupLocation (PickupLocationID, Location) VALUES
(1, 'Airport'),
(2, 'Downtown'),
(3, 'Shopping Mall'),
(4, 'Train Station');

-- Inserting data into the DropoffLocation table
INSERT INTO DropoffLocation (DropoffLocationID, Location) VALUES
(1, 'Hotel'),
(2, 'Residence'),
(3, 'Airport Hotel'),
(4, 'Convention Center');


# Question 2.a.i
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255)
);

describe Customer;

# Question 2.a.ii
SELECT RentalID, RentalDate, ReturnDate, TotalCost
FROM Rental
WHERE CustomerID = 2;

# Question 2.a.iii
SELECT 
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.Position,
    b.Location AS BranchLocation,
    r.RentalID,
    r.RentalDate,
    r.ReturnDate,
    r.TotalCost,
    c.Name AS CustomerName
FROM 
    Employee AS e
JOIN 
    EmployeeBranch AS eb ON e.EmployeeID = eb.EmployeeID
JOIN 
    Branch AS b ON eb.BranchID = b.BranchID
JOIN 
    Rental AS r ON e.EmployeeID = r.EmployeeID
JOIN 
    Customer AS c ON r.CustomerID = c.CustomerID
WHERE 
    e.EmployeeID = 2;


#Question 2.a.iv
SELECT c.CustomerID, c.Name AS CustomerName, SUM(r.TotalCost) AS TotalAmountSpent
FROM Customer c
JOIN Rental r ON c.CustomerID = r.CustomerID
WHERE r.RentalDate >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
GROUP BY c.CustomerID, c.Name;

select * from customer;
select * from rental;


