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
  [Balance] int
)
GO

CREATE TABLE [userTransactionData] (
  [account_number] int PRIMARY KEY,
  [transactionID] int IDENTITY(1, 1),
  [processing_date] nvarchar(255),
  [balance] int,
  [deposit_withdrawal] nvarchar(255),
  [amount] float,
  [description] nvarchar(255)
)
GO

CREATE TABLE [transactionTrigger] (
  [userid] int,
  [triggerID] int IDENTITY(1, 1),
  [trigger_name] nvarchar(255),
  PRIMARY KEY ([userid], [triggerID])
)
GO

CREATE TABLE [notificationData] (
  [userid] int PRIMARY KEY,
  [transactionID] int,
  [triggerID] int,
  [notifcation_name] nvarchar(255)
)
GO

ALTER TABLE [user] ADD FOREIGN KEY ([userid]) REFERENCES [account] ([account_number])
GO

ALTER TABLE [account] ADD FOREIGN KEY ([account_number]) REFERENCES [userTransactionData] ([account_number])
GO

ALTER TABLE [notificationData] ADD FOREIGN KEY ([transactionID]) REFERENCES [userTransactionData] ([transactionID])
GO

ALTER TABLE [notificationData] ADD FOREIGN KEY ([triggerID]) REFERENCES [transactionTrigger] ([triggerID])
GO

ALTER TABLE [user] ADD FOREIGN KEY ([userid]) REFERENCES [transactionTrigger] ([userid])
GO

