## Solution for the DWH Exercise
### Description
1. Tech Stack
   * Python Scripts for designing the data pipeline
   * Database: SQlite - SQlite is a lightweight and portable database which makes it easier to share across users. Also it comes packaged by default with python so it does not require any installation on user side
2. Data flow Description
   * JSON file present under 'Data/raw' folder is parsed and loaded into a raw table with no transformations
   * Raw table is then logically split into multiple staging tables. Basic transformations and any business logic is applied here
   * Stage tables are then used to populate fact and dimension tables
   * Note: Job Scripts have been designed to only add new records. Updates are not handled but can be easily incorporated


### Instructions to Run Job
1. Clone the Github Repo on local machine
2. Place .json source file under 'Data/raw' folder
3. Open command prompt. Navigate to PythonScripts folder under the github repo folder
4. Execute 'LoadMaster.py' file (python LoadMaster.py)
   * SQLlite Database file is created under 'Data/db' folder
5. Execute 'GenerateDataDump.py' file (python GenerateDataDump.py) to generate a flat dump of the fact table under 'Data/processed' folder


![alt text](https://github.com/KaranPandit47/Spark_DWH_Soln/blob/master/DWH_Model.png)
