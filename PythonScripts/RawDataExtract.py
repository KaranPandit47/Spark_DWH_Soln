# import required modules
import pandas as pd
import sqlite3
import os

def load_raw_data():
	print("============================")
	print("Started Loading Raw Tables")
	
	# Set directory paths for source file and database file
	raw_data_path = os.path.join(os.path.abspath('..'),'Data','raw')
	db_path = os.path.join(os.path.abspath('..'),'Data','db','PropertyListings.db')
	
	# Assuming single json file is present in raw folder
	json_file_name = [json_file for json_file in os.listdir(raw_data_path) if json_file.endswith('.json')]
	json_file_path = raw_data_path + "\\" + json_file_name[0]
	
	# Read Json File and normalize data
	
	line = pd.read_json(json_file_path, lines=True)
	data = pd.io.json.json_normalize(line['data'])

	data['realEstate_attachments'] = data['realEstate_attachments'].astype(str)
	data['realEstate_firingTypes'] = data['realEstate_firingTypes'].astype(str)
	data['realEstate_titlePicture_urls'] = data['realEstate_titlePicture_urls'].astype(str)
	data['realEstate_energySourcesEnev2014_energySourceEnev2014'] = data['realEstate_energySourcesEnev2014_energySourceEnev2014'].astype(str)
	
	# Create connection to sqlite db and load raw table
	conn = sqlite3.connect(db_path)
	data.to_sql("RAW_PROPERTY_DATA",conn, if_exists="replace", index=False)
	conn.commit()
	conn.close()
	
	print("Completed Loading Raw Tables")
	print("============================")

if __name__ == '__main__':
	
	load_raw_data()
	