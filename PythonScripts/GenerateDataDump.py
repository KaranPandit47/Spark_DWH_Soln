# import required modules
import sqlite3
import os
import pandas as pd

db_path = os.path.join(os.path.abspath('..'),'Data','db','PropertyListings.db')
process_path = os.path.join(os.path.abspath('..'),'Data','processed','DataDump.csv')

conn = sqlite3.connect(db_path, isolation_level=None)

df = pd.read_sql_query("""
					select
					F.REALESTATE_ID, A.AGENCY_NAME, B.LOCALITY_NAME, B.DISTRICT_NAME, B1.CITY_NAME, B2.COUNTRY_NAME, C.HAS_BALCONY,
					C.HAS_BUILT_IN_KITCHEN, C.HAS_GARDEN, C.HAS_CELLAR, C.HAS_GUEST_TOILET, C.HAS_LIFT, TOTAL_ROOMS, TOTAL_LIVING_ROOMS,TOTAL_BEDROOMS,
					TOTAL_BATHROOMS, IsActive, CREATION_DATE, MODIFIED_DATE, HasPictures, COLD_PRICE, WARM_PRICE, ADDITIONAL_COSTS, PARKING_SPACE_PRICE
					from FACT_FLAT F
					INNER JOIN DIM_AGENCY A ON F.AGENCY_ID = A.AGENCY_ID
					INNER JOIN DIM_LOCALITY B ON F.LOCALITY_ID = B.LOCALITY_ID
					INNER JOIN DIM_CITY B1 ON B1.CITY_ID = B.CITY_ID
					INNER JOIN DIM_COUNTRY B2 ON B2.COUNTRY_ID = B1.COUNTRY_ID 
					INNER JOIN DIM_FLAT_FACILTIY C ON C.FLAT_FACILITY_ID = F.FLAT_FACILITY_ID
					INNER JOIN DIM_FLAT_TYPE D ON D.FLAT_TYPE_ID = F.FLAT_TYPE_ID;""", 
					conn)

print(df.head())
export = df.to_csv(process_path, index=None, header=True)
conn.close()

