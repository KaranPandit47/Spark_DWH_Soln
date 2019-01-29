# import required modules
import pandas as pd
import sqlite3
import os

def load_dim_tables():
	print("============================")
	print("Started Loading Dimension Tables")
	
	# Set directory path for db and dimension table DDL and DML Scripts
	db_path = os.path.join(os.path.abspath('..'),'Data','db','PropertyListings.db')
	dim_ddl_path = os.path.join(os.path.abspath('..'),'DDLScripts','DimTables.sql')
	dim_dml_path = os.path.join(os.path.abspath('..'),'DMLScripts','Load_Dim_Tables.sql')
	
	conn = sqlite3.connect(db_path, isolation_level=None)
	cursor = conn.cursor()
	query = open(dim_ddl_path, 'r').read()
	cursor.executescript(query)
	query = open(dim_dml_path, 'r').read()
	cursor.executescript(query)
	conn.commit()
	cursor.close()
	conn.close()
	print("Completed Loading Dimension Tables")
	
def load_fact_tables():
	
	print("Started Loading Fact Tables")
	# Set directory path for db and fact table DDL and DML Scripts
	db_path = os.path.join(os.path.abspath('..'),'Data','db','PropertyListings.db')
	fact_ddl_path = os.path.join(os.path.abspath('..'),'DDLScripts','FactTables.sql')
	fact_dml_path = os.path.join(os.path.abspath('..'),'DMLScripts','Load_Fact_Tables.sql')

	conn = sqlite3.connect(db_path, isolation_level=None)
	cursor = conn.cursor()
	query = open(fact_ddl_path, 'r').read()
	cursor.executescript(query)
	query = open(fact_dml_path, 'r').read()
	cursor.executescript(query)
	conn.commit()
	cursor.close()
	conn.close()
	print("Completed Loading Fact Tables")
	print("============================")

if __name__ == '__main__':
	load_dim_tables()
	load_fact_tables()
	
