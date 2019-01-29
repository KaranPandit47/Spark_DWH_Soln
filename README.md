## Solution for the DWH Exercise
### Description
1. Tech Stack
   * Python Scripts for designing the data pipeline
   * Database: SQlite - SQlite is a lightweight and portable database which makes it easier to share across users. Also it comes packaged by default with python so it does not require any installation on user side
2. Data flow Description
   * JSON file present under 'Data/raw' folder is parsed using 'RawDataExtract.py' file and loaded into base table 'RAW_PROPERTY_DATA' table in sqlite db

![alt text](https://github.com/KaranPandit47/Spark_DWH_Soln/blob/master/DWH_Model.png)
