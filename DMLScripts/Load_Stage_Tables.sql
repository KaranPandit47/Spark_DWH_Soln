INSERT INTO STAGE_CONTACT_DETAILS
SELECT 
R.realEstate_id as realEstate_id,
companyWideCustomerId as companyWideCustomerId,
contactDetails_firstname as contactDetails_firstname,
contactDetails_lastname as contactDetails_lastname,
contactDetails_address_houseNumber as contactDetails_address_houseNumber,
contactDetails_address_street as contactDetails_address_street,
contactDetails_address_city as contactDetails_address_city,
contactDetails_address_postcode as contactDetails_address_postcode,
contactDetails_company as contactDetails_company,
contactDetails_countryCode as contactDetails_countryCode,
contactDetails_email as contactDetails_email,
contactDetails_homepageUrl as contactDetails_homepageUrl,
contactDetails_portraitUrl as contactDetails_portraitUrl,
contactDetails_realtorLogo as contactDetails_realtorLogo,
contactDetails_salutation as contactDetails_salutation,
contactDetails_title as contactDetails_title,
contactDetails_cellPhoneNumber as contactDetails_cellPhoneNumber,
contactDetails_cellPhoneNumberAreaCode as contactDetails_cellPhoneNumberAreaCode, 
contactDetails_cellPhoneNumberCountryCode as contactDetails_cellPhoneNumberCountryCode,
contactDetails_cellPhoneNumberSubscriber as contactDetails_cellPhoneNumberSubscriber,
contactDetails_faxNumber as contactDetails_faxNumber,
contactDetails_faxNumberAreaCode as contactDetails_faxNumberAreaCode,
contactDetails_faxNumberCountryCode as contactDetails_faxNumberCountryCode,
contactDetails_faxNumberSubscriber as contactDetails_faxNumberSubscriber,
contactDetails_phoneNumber as contactDetails_phoneNumber,
contactDetails_phoneNumberAreaCode as contactDetails_phoneNumberAreaCode,
contactDetails_phoneNumberCountryCode as contactDetails_phoneNumberCountryCode,
contactDetails_phoneNumberSubscriber as contactDetails_phoneNumberSubscriber
FROM RAW_PROPERTY_DATA R LEFT JOIN STAGE_CONTACT_DETAILS C ON TRIM(R.realEstate_id)=TRIM(C.realEstate_id)
WHERE C.CustomerID  is null;

INSERT INTO STAGE_FLAT_GEOHIERARCHY
SELECT 
R.realEstate_id,
realEstate_address_geoHierarchy_city_fullGeoCodeId,
realEstate_address_geoHierarchy_city_geoCodeId,
realEstate_address_geoHierarchy_city_name,
realEstate_address_geoHierarchy_continent_fullGeoCodeId,
realEstate_address_geoHierarchy_continent_geoCodeId,
realEstate_address_geoHierarchy_country_fullGeoCodeId,
realEstate_address_geoHierarchy_country_geoCodeId,
realEstate_address_geoHierarchy_country_name,
realEstate_address_geoHierarchy_neighbourhood_geoCodeId,
realEstate_address_geoHierarchy_quarter_fullGeoCodeId,
realEstate_address_geoHierarchy_quarter_geoCodeId,
realEstate_address_geoHierarchy_quarter_name,
realEstate_address_geoHierarchy_region_fullGeoCodeId,
realEstate_address_geoHierarchy_region_geoCodeId,
realEstate_address_geoHierarchy_region_name
FROM RAW_PROPERTY_DATA R LEFT JOIN STAGE_FLAT_GEOHIERARCHY C ON TRIM(R.RealEstate_ID)=TRIM(C.RealEstate_ID)
WHERE C.RealEstate_ID  is null;


INSERT INTO STAGE_FLAT_ADDRESS_DETAILS
SELECT 
R.realEstate_id,
realEstate_address_houseNumber,
realEstate_address_postcode,
realEstate_address_quarter,
realEstate_address_street,
realEstate_address_wgs84Coordinate_latitude,
realEstate_address_wgs84Coordinate_longitude
FROM RAW_PROPERTY_DATA R LEFT JOIN STAGE_FLAT_ADDRESS_DETAILS C ON TRIM(R.RealEstate_ID)=TRIM(C.RealEstate_ID)
WHERE C.RealEstate_ID  is null;

INSERT INTO STAGE_FLAT_DETAILS
SELECT 
R.realEstate_id,companyWideCustomerId,realEstate_apartmentType,realEstate_assistedLiving,realEstate_attachments,
realEstate_balcony,realEstate_baseRent,realEstate_buildingEnergyRatingType,realEstate_builtInKitchen,realEstate_calculatedTotalRent,
realEstate_calculatedTotalRentScope,realEstate_cellar,realEstate_certificateOfEligibilityNeeded,realEstate_condition,realEstate_constructionYear,
realEstate_constructionYearUnknown,realEstate_courtage_hasCourtage,realEstate_creationDate,realEstate_deposit,realEstate_descriptionNote,
realEstate_energyCertificate_energyCertificateAvailability,realEstate_energyCertificate_energyCertificateCreationDate,
realEstate_energyCertificate_energyEfficiencyClass,realEstate_energyConsumptionContainsWarmWater,realEstate_energyPerformanceCertificate,
realEstate_energySourcesEnev2014_energySourceEnev2014,realEstate_externalId,realEstate_firingTypes,realEstate_floor,realEstate_floorplan,
realEstate_freeFrom,realEstate_furnishingNote,realEstate_garden,realEstate_groupNumber,realEstate_guestToilet,realEstate_handicappedAccessible,
realEstate_heatingCosts,realEstate_heatingCostsInServiceCharge,realEstate_heatingType,realEstate_heatingTypeEnev2014,realEstate_interiorQuality,
realEstate_lastModificationDate,realEstate_lastRefurbishment,realEstate_lift,realEstate_livingSpace,realEstate_locationNote,realEstate_numberOfBathRooms,
realEstate_numberOfBedRooms,realEstate_numberOfFloors,realEstate_numberOfParkingSpaces,realEstate_numberOfRooms,realEstate_otherNote,
realEstate_parkingSpacePrice,realEstate_parkingSpaceType,realEstate_petsAllowed,realEstate_serviceCharge,realEstate_state,realEstate_thermalCharacteristic,realEstate_title,realEstate_totalRent,realEstate_usableFloorSpace,
realEstate_useAsFlatshareRoom
FROM RAW_PROPERTY_DATA R LEFT JOIN STAGE_FLAT_DETAILS C ON TRIM(R.RealEstate_ID)=TRIM(C.RealEstate_ID)
WHERE C.RealEstate_ID  is null;

INSERT INTO STAGE_ADVERTISEMENT_DETAILS
SELECT 
R.Realestate_id,
CASE WHEN R.realEstate_state='ACTIVE' THEN 1 ELSE 0 END as IsActive,
creation,
modification,
CASE WHEN ifnull(R.realEstate_attachments,'nan')='nan' THEN 0 ELSE 1 END As HasPictures
FROM RAW_PROPERTY_DATA R LEFT JOIN STAGE_ADVERTISEMENT_DETAILS C ON TRIM(R.RealEstate_ID)=TRIM(C.Realestate_id)
WHERE C.Realestate_id  is null;