INSERT INTO FACT_FLAT
SELECT 
A.RealEstate_ID,
B.AGENCY_ID,
C.LOCALITY_ID,
F.FLAT_TYPE_ID,
E.FLAT_FACILITY_ID,
A.LivingSpace AS FLAT_SIZE,
A.NumberOfRooms AS TOTAL_ROOMS,
A.NumberOfRooms  - ifnull(A.NumberOfBedRooms,0) AS TOTAL_LIVINGROOMS,
ifnull(A.NumberOfBedRooms,0) AS TOTAL_BEDROOMS,
ifnull(A.NumberOfBathRooms,0) AS TOTAL_BATHROOMS,
AD.IsActive AS IsActive,
AD.Creation_date As Creation_date,
AD.Modified_date AS Modified_date,
AD.HasPictures AS Has_Pictures,
A.BaseRent as Cold_Price,
A.CalculatedTotalRent AS Warm_Price,
CASE WHEN A.HeatingCostsInServiceCharge='NO' THEN ifnull(HeatingCosts,0) ELSE 0 END As Additional_Costs,
CASE WHEN ifnull(ParkingSpacePrice,'')='' THEN 0 ELSE ParkingSpacePrice END AS Parking_Space_Price
FROM STAGE_FLAT_DETAILS A
INNER JOIN STAGE_FLAT_GEOHIERARCHY G ON A.RealEstate_ID=G.RealEstate_ID
INNER JOIN STAGE_ADVERTISEMENT_DETAILS AD ON A.RealEstate_ID=AD.RealEstate_ID
INNER JOIN DIM_AGENCY B ON A.CustomerID=B.CUSTOMER_ID
INNER JOIN DIM_LOCALITY C 
ON substr(G.quarter_name,1,instr(G.quarter_name,'(')-1) = C.LOCALITY_NAME
AND 
REPLACE(substr(quarter_name,instr(quarter_name,'(')+1),')','') = C.DISTRICT_NAME
INNER JOIN DIM_FLAT_TYPE F
ON A.ApartmentType=F.FLAT_TYPE_NAME
INNER JOIN DIM_FLAT_FACILTIY E ON
CASE WHEN A.Balcony ='true' THEN 1 ELSE 0 END = E.HAS_BALCONY
AND 
CASE WHEN A.BuiltInKitchen='true' THEN 1 ELSE 0 END = E.HAS_BUILT_IN_KITCHEN
AND 
CASE WHEN A.Garden='true' THEN 1 ELSE 0 END = E.HAS_GARDEN
AND 
CASE WHEN A.Cellar='YES' THEN 1 ELSE 0 END = E.HAS_CELLAR
AND 
CASE WHEN A.GuestToilet='YES' THEN 1 ELSE 0 END = E.HAS_GUEST_TOILET
AND
CASE WHEN A.Lift='true' THEN 1 ELSE 0 END =E.HAS_LIFT
WHERE
A.RealEstate_ID IN (
SELECT DISTINCT A.RealEstate_ID FROM STAGE_FLAT_DETAILS A LEFT JOIN FACT_FLAT F 
ON A.RealEstate_ID=F.RealEstate_ID WHERE F.RealEstate_ID is null)