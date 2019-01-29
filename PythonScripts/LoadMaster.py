import Setup as S
import RawDataExtract as R
import LoadStageTables as S
import LoadDimFactTables as F
import datetime

def load_properties_data():
	S.check_dependency()
	currentDT = datetime.datetime.now()
	print ("Job Started :"+currentDT.strftime("%Y-%m-%d %H:%M:%S"))
	R.load_raw_data()
	S.load_stage_data()
	F.load_dim_tables()
	F.load_fact_tables()
	endDT = datetime.datetime.now()
	print("Job Completed :"+endDT.strftime("%Y-%m-%d %H:%M:%S"))
	duration = abs((currentDT-endDT).total_seconds())
	print("Total Duration:{0} ".format(duration)) 

if __name__ == '__main__':
	load_properties_data()
