# import required modules
import pandas as pd
import sqlite3
import os

def load_stage_data():
	print("============================")
	print("Started Loading Stage Tables")
	
	# Set directory path for db and stage table DDL and DML Scripts
	db_path = os.path.join(os.path.abspath('..'),'Data','db','PropertyListings.db')
	stage_ddl_path = os.path.join(os.path.abspath('..'),'DDLScripts','StageTables.sql')
	stage_dml_path = os.path.join(os.path.abspath('..'),'DMLScripts','Load_Stage_Tables.sql')

	# Create connection to sqlite db
	conn = sqlite3.connect(db_path, isolation_level=None)
	cursor = conn.cursor()

	# Create Stage Tables
	query = open(stage_ddl_path, 'r').read()
	cursor.executescript(query)
	conn.commit()
	
	# Load Stage Tables
	query = open(stage_dml_path, 'r').read()
	cursor.executescript(query)
	cursor.close()
	conn.commit()
	conn.close()
	print("Completed Loading Stage Tables")
	print("============================")

if __name__ == '__main__':
	load_stage_data()
	
