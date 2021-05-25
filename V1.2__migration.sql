INSERT INTO Location (TerName, AreaName, RegName)
SELECT        TerName,       AreaName,       RegName       FROM TABLE1
UNION SELECT  EOTerName,     EOAreaName,     EORegName     FROM TABLE1
UNION SELECT  ukrPTTerName,  ukrPTAreaName,  ukrPTRegName  FROM TABLE1
UNION SELECT  mathPTTerName, mathPTAreaName, mathPTRegName FROM TABLE1
UNION SELECT  histPTTerName, histPTAreaName, histPTRegName FROM TABLE1
UNION SELECT  physPTTerName, physPTAreaName, physPTRegName FROM TABLE1
UNION SELECT  chemPTTerName, chemPTAreaName, chemPTRegName FROM TABLE1
UNION SELECT  bioPTTerName,  bioPTAreaName,  bioPTRegName  FROM TABLE1
UNION SELECT  geoPTTerName,  geoPTAreaName,  geoPTRegName  FROM TABLE1
UNION SELECT  engPTTerName,  engPTAreaName,  engPTRegName  FROM TABLE1
UNION SELECT  fraPTTerName,  fraPTAreaName,  fraPTRegName  FROM TABLE1
UNION SELECT  deuPTTerName,  deuPTAreaName,  deuPTRegName  FROM TABLE1
UNION SELECT  spaPTTerName,  spaPTAreaName,  spaPTRegName  FROM TABLE1
WHERE TerName IS NOT NULL;


UPDATE Location 
SET TerTypeName = TABLE1.TerTypeName
FROM TABLE1
WHERE (TABLE1.TerName  = Location.TerName AND
       TABLE1.AreaName = Location.AreaName AND
       TABLE1.RegName  = Location.RegName) ;





INSERT INTO Educational_Institution(InstitutionName, TypeName, Category, location_id)
SELECT DISTINCT ON (EducInfo.InstitutionName)
	EducInfo.InstitutionName, 
	TABLE1.EOTypeName, 
	TABLE1.EOParent,
	Location.location_id
FROM (
    select distinct * 
    FROM (
        SELECT  EOName, EOTerName, EOAreaName, EORegName FROM TABLE1
        UNION SELECT  ukrPTName,  ukrPTTerName,  ukrPTAreaName,  ukrPTRegName  FROM TABLE1
        UNION SELECT  mathPTName, mathPTTerName, mathPTAreaName, mathPTRegName FROM TABLE1
        UNION SELECT  histPTName, histPTTerName, histPTAreaName, histPTRegName FROM TABLE1
        UNION SELECT  physPTName, physPTTerName, physPTAreaName, physPTRegName FROM TABLE1
        UNION SELECT  chemPTName, chemPTTerName, chemPTAreaName, chemPTRegName FROM TABLE1
        UNION SELECT  bioPTName,  bioPTTerName,  bioPTAreaName,  bioPTRegName  FROM TABLE1
        UNION SELECT  geoPTName,  geoPTTerName,  geoPTAreaName,  geoPTRegName  FROM TABLE1
        UNION SELECT  engPTName,  engPTTerName,  engPTAreaName,  engPTRegName  FROM TABLE1
        UNION SELECT  fraPTName,  fraPTTerName,  fraPTAreaName,  fraPTRegName  FROM TABLE1
        UNION SELECT  deuPTName,  deuPTTerName,  deuPTAreaName,  deuPTRegName  FROM TABLE1
        UNION SELECT  spaPTName,  spaPTTerName,  spaPTAreaName,  spaPTRegName  FROM TABLE1
    ) info
) AS EducInfo (InstitutionName, TerName, AreaName, RegName)
LEFT JOIN TABLE1 ON 
	EducInfo.InstitutionName = TABLE1.EOName
LEFT JOIN Location ON
	EducInfo.TerName = Location.TerName AND
	EducInfo.AreaName = Location.AreaName AND
	EducInfo.RegName = Location.RegName
WHERE EducInfo.InstitutionName IS NOT NULL;





INSERT INTO Participant (OutID, birth, SEXTYPENAME, 
					 ClassProfileName, ClassLangName, location_id, InstitutionName)
SELECT DISTINCT ON (OutID) OutID, birth, SEXTYPENAME, 
					 ClassProfileName, ClassLangName, location_id, EOName
FROM TABLE1
INNER JOIN Location
ON TABLE1.TerTypeName = Location.TerTypeName
    AND TABLE1.TerName = Location.TerName
    AND TABLE1.AreaName = Location.AreaName
    AND TABLE1.RegName = Location.RegName;





INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, ukrTest, Year, NULL, ukrTestStatus, NULL, 
    ukrBall100, ukrBall12, ukrBall, ukrAdaptScale, UkrPTName
FROM TABLE1
WHERE ukrTest IS NOT NULL;


INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, histTest, Year, histLang, histTestStatus, NULL, 
    histBall100, histBall12, histBall, NULL, histPTName
FROM TABLE1
WHERE histTest IS NOT NULL;


INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, mathTest, Year, mathLang, mathTestStatus, NULL, 
    mathBall100, mathBall12, mathBall, NULL, mathPTName
FROM TABLE1
WHERE mathTest IS NOT NULL;



INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, physTest, Year, physLang, physTestStatus, NULL, 
    physBall100, physBall12, physBall, NULL, physPTName
FROM TABLE1
WHERE physTest IS NOT NULL;



INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, chemTest, Year, chemLang, chemTestStatus, NULL, 
    chemBall100, chemBall12, chemBall, NULL, chemPTName
FROM TABLE1
WHERE chemTest IS NOT NULL;


INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, bioTest, Year, bioLang, bioTestStatus, NULL, 
    bioBall100, bioBall12, bioBall, NULL, bioPTName
FROM TABLE1
WHERE bioTest IS NOT NULL;



INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, geoTest, Year, geoLang, geoTestStatus, NULL, 
    geoBall100, geoBall12, geoBall, NULL, geoPTName
FROM TABLE1
WHERE geoTest IS NOT NULL;



INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, engTest, Year, NULL, engTestStatus, engDPALevel, 
    engBall100, engBall12, engBall, NULL, engPTName
FROM TABLE1
WHERE engTest IS NOT NULL;


INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, fraTest, Year, NULL, fraTestStatus, fraDPALevel, 
    fraBall100, fraBall12, fraBall, NULL, fraPTName
FROM TABLE1
WHERE fraTest IS NOT NULL;



INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, deuTest, Year, NULL, deuTestStatus, deuDPALevel, 
    deuBall100, deuBall12, deuBall, NULL, deuPTName
FROM TABLE1
WHERE deuTest IS NOT NULL;



INSERT INTO ZNO_Result (OutID, TestName, Year, Lang, TestStatus,
    DPA_mark, Ball_100, Ball_12, Ball, AdaptScale, PTName)
SELECT OutID, spaTest, Year, NULL, spaTestStatus, spaDPALevel, 
    spaBall100, spaBall12, spaBall, NULL, spaPTName
FROM TABLE1
WHERE spaTest IS NOT NULL;