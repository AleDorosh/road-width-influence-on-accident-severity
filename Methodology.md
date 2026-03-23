### Data Preparation
#### Spatial join 
Traffic accident locations were spatially matched to road segments to obtain road width information. The spatial join was performed in QGIS using a maximum search distance of 20 meters.
The distribution of join distances showed:
* average distance: 2.38 m
* 95th percentile: 13.6 m

#### Data Filtering Methodology
The original traffic accident dataset contains records from multiple years and accident types. 
Several filters were applied to align the data with the research goal.

1. Only joins with a distance of 15 meters or less were retained to reduce spatial mismatches. A smaller threshold (10 m) resulted in significant data loss, while 20 m increased the risk of incorrect matches.

2. The analysis focuses on the period 2018–2025. This time frame aligns with Transpordiamet's traffic accident reporting period and reflects the most recent traffic conditions.

3. Cities and towns with populations over ~10,000 were selected (14 total): Tallinn, Tartu, Narva, Pärnu, Kohtla-Järve, Viljandi, Maardu, Rakvere, Kuressaare, Sillamäe, Võru, Valga, Keila, Jõhvi. These locations are geographically distributed across Estonia and represent variety of urban characteristics.
Note: Ida-Virumaa is relatively overrepresented (Narva, Kohtla-Järve, Sillamäe, Jõhvi), which may influence results. This is acknowledged as a limitation.

4. The analysis includes three main accident types: vehicle collisions, single-vehicle accidents, and accidents involving pedestrians, cyclists, and micromobility users. 

5. Only accidents involving a least one motor vehicle driver were included.

6.  Accidents in non-standard environments (e.g. parking lots, forest roads, pedestrian paths, squares) were excluded.

7.  Only road segments with of ≥ 3 meters were included. According to Estonian road design standards, typical traffic lane widths range between 3.0 and 3.25 meters, with narrower lanes (around 2.75 meters) occurring only in low-speed environments. 

After filtering the dataset contained 3,742 accidents, including 68 fatalities and 4,265 injuries.

#### Data Cleaning Methodology
The dataset was cleaned to improve consistency and reliability. At the time of cleaning, no official documentation was available (accessed later on 18.03.2026), so decisions were based on data inspection.

1. Duplicate rows were identified by accident_id. These rows had identical values except for road_width, likely due to the spatial join matching multiple road segments. All these rows were removed, as there was no way to tell which row had correct data.  

2. Extreme values that were inconsistent with accident context and likely represent data entry errors were removed (e.g. unusually high injury counts for low-speed or pedestrian accidents).

3. Rows with more than 1 NULL value were removed. Rows with 1 NULL value were retained. Missing values were replaced with 'Unknown'. Values such as “Pole teada” and “Teadmata” were also standardized to 'Unknown'.

#### Final Dataset
* 3,533 accidents
* 67 deaths
* 4,019 injuries
* Average road width: 9.19 m

#### Variables Used
* accident identifiers (accident id and time)
* accident severity (injuries, fatalities)
* location (county, municipality, settlement)
* accident characteristics (accident type and scenario)
* road characteristics (road width, speed limit, road type)
* environmental conditions (weather, lighting, road surface)
* spatial join quality (distance to matched road segment)
