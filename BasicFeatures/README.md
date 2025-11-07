# BasicFeatures

Simple demo that shows basic features of CloverDX. Contains over 30 example data jobs that serve both as a great general overview of platform capabilities, and as a reference for the behavior of specific components. 

These example data jobs demonstrate reading and writing CSV, Excel, JSON, XML and EDI files, interacting with relational and NOSQL databases, interacting with APIs, transforming data with normalization, denormalization, aggregate, filter and data validation components, data job reuse with subgraphs, and job control with looping and orchestration.


# Installation
Many of the examples in this project require sample data and/or sample data endpoints. There are several data jobs in the project which, in addition to being instructive, also generate sample data and configure data endpoints used by other data jobs. 

Many of these data jobs rely on the open source Postgres database. To get the most out of these examples start with these five steps:

1.	Generate sample data files by running
`jobflow/generators/GenerateAll.jbf`  and `jobflow/generators/GenerateWeblogs.jbf`  . 
2.	Configure a connection to a postgres database by opening `graph/init/01 - Database connections.grf` and editing the connection `TrainingDB.cfg`. 
By default this connection assumes postgres is running on localhost, and that there is a database called basic_features with a user/password of clover/clover. 
3.	Run `graph/init/02 - Recreate database tables.grf` to create the (empty) database tables used by other example datajobs
4.	Run `jobflow/01  Load online store.jbf` to load the data generated in Step 1 into the database tables created in Step 3.


# Properties
Author: Branislav Repcek <branislav.repcek@cloverdx.com>  
Version: 1.3  
Compatible: CloverDX 6.5+  
