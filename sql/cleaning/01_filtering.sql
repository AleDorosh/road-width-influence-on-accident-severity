CREATE TABLE accidents_filtered AS
SELECT
-- accident identifiers
    "Juhtumi nr" AS accident_id,
    "Toimumisaeg" AS accident_time,
-- severity
    "Hukkunuid" AS deaths,
    "Vigastatuid" AS injured,
-- location
    "Maakond" AS county,
	"Omavalitsus" AS municipality,
    "Asustusüksus" AS settlement,
-- accident characteristics
    "Mootorsõidukijuhi osalusel" AS involving_motorvehicle_driver,
    "Liiklusõnnetuse liik" AS accident_type,
    "Liiklusõnnetuse liik (detailne)" AS accident_type_detailed,
    "Tüüpskeem" AS accident_scenario,
-- road characteristics
    "Tee tüüp" AS road_type,
    "Tee tüüp (detailne)" AS road_type_detail,
    road_width,
    "Lubatud sõidukiirus" AS speed_limit,
-- environment
    "Tee seisund" AS road_condition,
    "Teekatte seisund" AS road_surface_condition,
    "Ilmastik" AS weather,
    "Valgustus" AS lighting,
    
    distance AS join_distance,
    "X koordinaat" AS x_coord,
	  "Y koordinaat" AS y_coord
	
FROM accidents_full
WHERE 
-- Filter out joins with a distance greater than 15 m
distance <= 15
-- Set analysis period to 2018–2025
AND "Toimumisaeg" >= '2018-01-01' 
AND "Toimumisaeg" <  '2026-01-01'
-- Include only urban traffic environments with pop greater than 10k
AND "Asustusüksus" IN (
'Kesklinna linnaosa', 'Lasnamäe linnaosa', 'Põhja-Tallinna linnaosa', 
'Mustamäe linnaosa', 'Haabersti linnaosa' , 'Kristiine linnaosa', 
'Nõmme linnaosa','Pirita linnaosa',  
'Tartu linn', 'Narva linn', 'Pärnu linn', 
'Järve linnaosa', 'Ahtme linnaosa', 'Viljandi linn', 
'Maardu linn', 'Rakvere linn', 'Kuressaare linn', 
'Sillamäe linn', 'Võru linn', 'Valga linn', 'Keila linn', 'Jõhvi linn'
)
-- Retain only accidents where vehicles are directly involved
AND "Liiklusõnnetuse liik" IN (
'Ühesõidukiõnnetus', 
'Kokkupõrge', 
'Jalakäijaõnnetus'
)
AND "Mootorsõidukijuhi osalusel" = TRUE
-- Exclude non-standard road traffic environments
AND "Tee tüüp (detailne)" NOT IN (
'Parkla', 'Metsatee', 'Muu koht', 'Väljak',
'Jalg- ja jalgrattatee', 'Jalgrattatee', 'Jalgtee'
)
-- Keep only roads with width greater than 3 m 
AND road_width >= 3;
