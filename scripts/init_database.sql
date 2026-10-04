/*
==============================================
Create Database and Schemas
==============================================

Purpose of Script:

  This script creates a new database called "data_warehouse". Additionally script creates 3 schemas like "bronze", "silver" and "gold".

*/



create database data_warehouse;

use data_warehouse;


-- Go acts as a seperator, which execute the previous query completly and then goes to the next query
create schema bronze;
GO

create schema silver;
GO

create schema gold;
GO
