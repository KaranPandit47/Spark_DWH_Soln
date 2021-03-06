INSERT INTO DIM_COUNTRY(country_name)
select distinct S.country_name 
from STAGE_FLAT_GEOHIERARCHY S LEFT JOIN DIM_COUNTRY T 
ON S.country_name = T.COUNTRY_NAME
WHERE T.COUNTRY_NAME IS NULL;

INSERT INTO DIM_CITY(CITY_NAME,COUNTRY_ID)
select distinct S.city_name,C.COUNTRY_ID 
from STAGE_FLAT_GEOHIERARCHY S LEFT JOIN DIM_CITY T 
ON S.city_name = T.city_name
INNER JOIN DIM_COUNTRY C ON C.COUNTRY_NAME=S.COUNTRY_NAME
WHERE T.city_name IS NULL;

INSERT INTO DIM_LOCALITY(LOCALITY_NAME,DISTRICT_NAME,CITY_ID)
SELECT S.Locality, S.District, C.CITY_ID from
(
select distinct
substr(quarter_name,1,instr(quarter_name,'(')-1) as Locality,
REPLACE(substr(quarter_name,instr(quarter_name,'(')+1),')','') as District,
city_name
from STAGE_FLAT_GEOHIERARCHY 
) AS S  LEFT JOIN DIM_LOCALITY T
ON S.Locality=T.LOCALITY_NAME AND S.District=T.DISTRICT_NAME 
INNER JOIN DIM_CITY C ON C.CITY_NAME=S.city_name
WHERE T.LOCALITY_ID IS NULL;

DELETE FROM DIM_FLAT_FACILTIY;

INSERT INTO DIM_FLAT_FACILTIY(FLAT_FACILITY_ID,HAS_BALCONY,HAS_BUILT_IN_KITCHEN,HAS_GARDEN,HAS_CELLAR,HAS_GUEST_TOILET,HAS_LIFT)
values
(1,0,0,0,0,0,0),(2,0,0,0,0,0,1),(3,0,0,0,0,1,0),(4,0,0,0,0,1,1),(5,0,0,0,1,0,0),(6,0,0,0,1,0,1),(7,0,0,0,1,1,0),(8,0,0,0,1,1,1),
(9,0,0,1,0,0,0),(10,0,0,1,0,0,1),(11,0,0,1,0,1,0),(12,0,0,1,0,1,1),(13,0,0,1,1,0,0),(14,0,0,1,1,0,1),(15,0,0,1,1,1,0),(16,0,0,1,1,1,1),
(17,0,1,0,0,0,0),(18,0,1,0,0,0,1),(19,0,1,0,0,1,0),(20,0,1,0,0,1,1),(21,0,1,0,1,0,0),(22,0,1,0,1,0,1),(23,0,1,0,1,1,0),(24,0,1,0,1,1,1),
(25,0,1,1,0,0,0),(26,0,1,1,0,0,1),(27,0,1,1,0,1,0),(28,0,1,1,0,1,1),(29,0,1,1,1,0,0),(30,0,1,1,1,0,1),(31,0,1,1,1,1,0),(32,0,1,1,1,1,1),
(33,1,0,0,0,0,0),(34,1,0,0,0,0,1),(35,1,0,0,0,1,0),(36,1,0,0,0,1,1),(37,1,0,0,1,0,0),(38,1,0,0,1,0,1),(39,1,0,0,1,1,0),(40,1,0,0,1,1,1),
(41,1,0,1,0,0,0),(42,1,0,1,0,0,1),(43,1,0,1,0,1,0),(44,1,0,1,0,1,1),(45,1,0,1,1,0,0),(46,1,0,1,1,0,1),(47,1,0,1,1,1,0),(48,1,0,1,1,1,1),
(49,1,1,0,0,0,0),(50,1,1,0,0,0,1),(51,1,1,0,0,1,0),(52,1,1,0,0,1,1),(53,1,1,0,1,0,0),(54,1,1,0,1,0,1),(55,1,1,0,1,1,0),(56,1,1,0,1,1,1),
(57,1,1,1,0,0,0),(58,1,1,1,0,0,1),(59,1,1,1,0,1,0),(60,1,1,1,0,1,1),(61,1,1,1,1,0,0),(62,1,1,1,1,0,1),(63,1,1,1,1,1,0),(64,1,1,1,1,1,1);

INSERT INTO DIM_FLAT_TYPE(FLAT_TYPE_NAME)
select distinct ApartmentType 
from STAGE_FLAT_DETAILS S LEFT JOIN DIM_FLAT_TYPE T
ON S.ApartmentType=T.FLAT_TYPE_NAME
WHERE T.FLAT_TYPE_ID IS NULL;

INSERT INTO DIM_AGENCY(Customer_ID,AGENCY_NAME)
SELECT 
DISTINCT 
S.CustomerID as Customer_ID,
ifnull(UPPER(S.Company),'N/A') as AGENCY_NAME
from STAGE_CONTACT_DETAILS S LEFT JOIN DIM_AGENCY T ON S.CustomerID=T.Customer_ID
WHERE T.Customer_ID IS NULL;