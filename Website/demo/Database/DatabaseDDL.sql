-- Drop the database 'commerce'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
ALTER DATABASE commerce SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
IF EXISTS (
  SELECT [name]
    FROM sys.databases
    WHERE [name] = N'commerce'
)
DROP DATABASE commerce
GO

CREATE DATABASE commerce
GO

USE commerce
GO

CREATE TABLE [user] (
  [userid] int PRIMARY KEY,
  [firstName] nvarchar(255),
  [lastName] nvarchar(255),
  [phone] nvarchar(255),
  [password] nvarchar(255)
)
GO

CREATE TABLE [account] (
  [account_number] int PRIMARY KEY,
  [userid] int,
  [Balance] float
)
GO

CREATE TABLE [userTransactionData] (
  [account_number] int,
  [transactionID] int PRIMARY KEY IDENTITY(1, 1),
  [processing_date] nvarchar(255),
  [balance] float,
  [deposit_withdrawal] nvarchar(255),
  [amount] float,
  [description] nvarchar(255)
)
GO

CREATE TABLE [transactionTrigger] (
  [userid] int,
  [triggerID] int PRIMARY KEY IDENTITY(1, 1),
  [trigger_name] nvarchar(255)
)
GO

CREATE TABLE [notificationData] (
  [notificationID] int PRIMARY KEY,
  [transactionID] int,
  [triggerID] int,
  [notification_name] nvarchar(255)
)
GO

ALTER TABLE [account] ADD FOREIGN KEY ([userid]) REFERENCES [user] ([userid])
GO

ALTER TABLE [userTransactionData] ADD FOREIGN KEY ([account_number]) REFERENCES [account] ([account_number])
GO

ALTER TABLE [transactionTrigger] ADD FOREIGN KEY ([userid]) REFERENCES [user] ([userid])
GO

ALTER TABLE [notificationData] ADD FOREIGN KEY ([triggerID]) REFERENCES [transactionTrigger] ([triggerID])
GO

ALTER TABLE [notificationData] ADD FOREIGN KEY ([transactionID]) REFERENCES [userTransactionData] ([transactionID])
GO



INSERT INTO [user](
  userid,
  firstName,
  lastName,
  phone,
  [password]
)
VALUES
('1', 'John', 'Doe', '8162223333', 'password123');

INSERT INTO account (
  account_number,
  userid,
  Balance
)
VALUES
('211111110', '1', '5000.00');

INSERT INTO userTransactionData (
  account_number,
  processing_date,
  balance,
  deposit_withdrawal,
  amount,
  [description]
)
VALUES 
('211111110', '11/01/19', '5000.00', 'CR', '0.00', '(initial starting balance)'),
('211111110', '11/03/19', '4998.00', 'DR', '2.00', 'Starbucks'),
('211111110', '11/03/19', '5798.00', 'CR', '800.00', 'Payroll'),
('211111110', '11/03/19', '5790.00', 'DR', '8.00', 'Chipotle'),
('211111110', '11/04/19', '5780.00', 'DR', '10.00', 'ATM'),
('211111110', '11/05/19', '5748.00', 'DR', '32.00', 'Hoolihans'),
('211111110', '11/05/19', '5648.00', 'DR', '100.00', 'KCPL'),
('211111110', '11/09/19', '5458.00', 'DR', '190.00', 'Google Fiber'),
('211111110', '11/11/19', '5448.01', 'DR', '9.99', 'Netflix'),
('211111110', '11/11/19', '5098.01', 'DR', '350.00', 'Rent'),
('211111110', '11/15/19', '5096.01', 'DR', '2.00', 'Starbucks'),
('211111110', '11/22/19', '5846.01', 'CR', '750.00', 'Payroll'),
('211111110', '11/25/19', '5226.01', 'DR', '620.00', 'Commerce Bank Cedit Card payment'),
('211111110', '11/28/19', '5076.01', 'DR', '150.00', 'McFaddens'),
('211111110', '11/28/19', '4976.01', 'DR', '100.00', 'Price Chopper'),
('211111110', '11/29/19', '5026.01', 'CR', '50.00', 'Check from friend'),
('211111110', '12/01/19', '5826.01', 'CR', '800.00', 'Payroll'),
('211111110', '12/01/19', '5817.01', 'DR', '9.00', 'Hyvee'),
('211111110', '12/01/19', '5803.01', 'DR', '14.00', 'McFaddens'),
('211111110', '12/01/19', '5771.01', 'DR', '32.00', 'Target'),
('211111110', '12/01/19', '5671.01', 'DR', '100.00', 'KCPL'),
('211111110', '12/02/19', '6421.01', 'CR', '750.00', 'Payroll'),
('211111110', '12/03/19', '6231.01', 'DR', '190.00', 'Google Fiber'),
('211111110', '12/03/19', '6221.02', 'DR', '9.99', 'Netflix'),
('211111110', '12/03/19', '5871.02', 'DR', '350.00', 'Rent'),
('211111110', '12/03/19', '5864.52', 'DR', '6.50', 'Neos'),
('211111110', '12/05/19', '5634.52', 'DR', '230.00', 'Commerce Bank Credit Card payment'),
('211111110', '12/06/19', '5534.52', 'DR', '100.00', 'Best Buy'),
('211111110', '12/07/19', '5234.52', 'DR', '300.00', 'Pottery Barn'),
('211111110', '12/07/19', '5211.52', 'DR', '23.00', 'The Loft'),
('211111110', '12/07/19', '5166.52', 'DR', '45.00', 'Dave and Busters'),
('211111110', '12/08/19', '5131.52', 'DR', '35.00', 'Bowling'),
('211111110', '12/15/19', '5931.52', 'CR', '800.00', 'Payroll'),
('211111110', '12/20/19', '5721.52', 'DR', '210.00', 'McFaddens'),
('211111110', '12/25/19', '5703.52', 'DR', '18.00', 'Taco Bell'),
('211111110', '12/31/19', '5658.52', 'DR', '45.00', 'QuikTrip'),
('211111110', '01/01/20', '5528.52', 'DR', '130.00', 'KCPL'),
('211111110', '01/01/20', '5343.52', 'DR', '185.00', 'Google Fiber'),
('211111110', '01/02/20', '5335.53', 'DR', '7.99', 'Netflix'),
('211111110', '01/05/20', '5279.53', 'DR', '56.00', 'Price Chopper'),
('211111110', '01/06/20', '5236.53', 'DR', '43.00', 'Price Chopper'),
('211111110', '01/10/20', '5138.53', 'DR', '98.00', 'Target'),
('211111110', '01/10/20', '5125.53', 'DR', '13.00', 'Jose Peppers'),
('211111110', '01/12/20', '5116.53', 'DR', '9.00', 'Starbucks'),
('211111110', '01/13/20', '4766.53', 'DR', '350.00', 'Rent'),
('211111110', '01/14/20', '4763.03', 'DR', '3.50', 'Redbox'),
('211111110', '01/15/20', '4462.03', 'DR', '301.00', 'Bank of America Credit Card payment'),
('211111110', '01/16/20', '5192.03', 'CR', '730.00', 'Payroll'),
('211111110', '01/16/20', '4959.35', 'DR', '232.68', 'Target'),
('211111110', '01/16/20', '4940.85', 'DR', '18.50', 'Best Buy'),
('211111110', '01/16/20', '4820.85', 'DR', '120.00', 'Nationwide'),
('211111110', '01/17/20', '4770.85', 'DR', '50.00', 'KC Police - Speeding Ticket'),
('211111110', '01/18/20', '4720.85', 'DR', '50.00', 'Uber'),
('211111110', '01/18/20', '4711.65', 'DR', '9.20', 'Mannys'),
('211111110', '01/19/20', '4686.90', 'DR', '24.75', 'Toys R Us'),
('211111110', '01/19/20', '4683.40', 'DR', '3.50', 'Scooters'),
('211111110', '01/20/20', '4647.40', 'DR', '36.00', 'QuikTrip'),
('211111110', '01/20/20', '4615.40', 'DR', '32.00', 'Price Chopper'),
('211111110', '01/20/20', '4567.28', 'DR', '48.12', 'Home Depot'),
('211111110', '01/21/20', '4563.08', 'DR', '4.20', 'Burger King'),
('211111110', '01/22/20', '4518.08', 'DR', '45.00', 'Jiffy Lube'),
('211111110', '01/23/20', '4493.08', 'DR', '25.00', 'Doctor visit'),
('211111110', '01/23/20', '4457.08', 'DR', '36.00', 'CVS'),
('211111110', '01/23/20', '4428.08', 'DR', '29.00', 'Price Chopper'),
('211111110', '01/23/20', '4228.08', 'DR', '200.00', 'Transfer to Savings'),
('211111110', '01/24/20', '4378.08', 'CR', '150.00', 'Christmas Check from Grandma'),
('211111110', '01/25/20', '4128.08', 'DR', '250.00', 'Student loans'),
('211111110', '01/25/20', '4053.08', 'DR', '75.00', 'Ford Service'),
('211111110', '01/26/20', '4017.08', 'DR', '36.00', 'Hallmark'),
('211111110', '01/27/20', '3995.08', 'DR', '22.00', 'CVS'),
('211111110', '01/28/20', '4805.08', 'CR', '810.00', 'Payroll'),
('211111110', '01/29/20', '4625.08', 'DR', '180.00', 'Pottery Barn'),
('211111110', '01/30/20', '4579.08', 'DR', '46.00', 'Cheesecake Factory'),
('211111110', '01/30/20', '4571.08', 'DR', '8.00', 'Starbucks')
;