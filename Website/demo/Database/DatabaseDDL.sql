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
  [userid] int PRIMARY KEY IDENTITY(1, 1),
  [firstName] nvarchar(255),
  [lastName] nvarchar(255),
  [phone] nvarchar(255),
  [password] nvarchar(255)
)
GO

CREATE TABLE [account] (
  [account_number] int PRIMARY KEY IDENTITY(1, 1),
  [Userid] int,
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

ALTER TABLE [account] ADD FOREIGN KEY ([Userid]) REFERENCES [user] ([userid])
GO

ALTER TABLE [userTransactionData] ADD FOREIGN KEY ([account_number]) REFERENCES [account] ([account_number])
GO

ALTER TABLE [transactionTrigger] ADD FOREIGN KEY ([userid]) REFERENCES [user] ([userid])
GO

ALTER TABLE [notificationData] ADD FOREIGN KEY ([triggerID]) REFERENCES [transactionTrigger] ([triggerID])
GO

ALTER TABLE [notificationData] ADD FOREIGN KEY ([transactionID]) REFERENCES [userTransactionData] ([transactionID])
GO