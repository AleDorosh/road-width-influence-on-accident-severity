# Name
Case Study – Beginner data analytics course

## Tableau Dashboard

## Project Overview
The aim of this project is to analyze whether road width is associated with traffic accident severity in urban areas of Estonia.
Traffic safety is influenced by multiple factors, including road design, speed limits, and traffic conditions. Road width is often assumed to play a role in accident outcomes, as wider roads may encourage higher speeds, while narrower roads may increase conflict between road users.
This project combines traffic accident data with road network data to explore how accident severity varies across different road widths. During the analysis, it became clear that road width alone does not fully explain accident severity. Therefore, additional factors such as speed limits and accident types were also considered to better understand the patterns observed in the data.
The analysis focuses on accidents involving injuries or fatalities in Estonian cities between 2018 and 2025. Results are presented using aggregated statistics and visualizations to identify patterns rather than establish causation.

## Research Question
#### Primary question:
Is there a relationship between road width and traffic accident severity in urban Estonia?

#### Supporting questions:
How does accident severity vary across different road width categories?
Does the relationship between road width and severity change when controlling for speed limits (e.g. 30 km/h vs 50 km/h)?
What types of accidents are most common across different road widths, and how might they influence severity?

## Repository Structure

## Data 
#### Road Width Data
Dataset: TN.RoadTransportNetwork.RoadWidth
Provider: Eesti topograafia andmekogu - Maa- ja Ruumiamet (Estonian Topographic Database - Republic of Estonia Land and Spatial Development Board
Metadata:
https://metadata.geoportaal.ee/geonetwork/srv/eng/catalog.search#/metadata/bf38a8fc-96f1-4d34-9130-18160e489514

Service endpoint (WFS):
https://inspire.geoportaal.ee/geoserver/TN_transportetak/wfs

Description:
This dataset provides road transport network attributes based on the INSPIRE Transport Networks data model, including road geometry and attributes such as road width. The dataset is published through Estonia’s INSPIRE spatial data services and is accessible via Web Feature Service (WFS).
Format used in this project:
TN.RoadTransportNetwork.RoadWidth
Accessed: March 2026
Licence: https://geoportaal.maaruum.ee/opendata-licence (CC BY 4.0)

#### Traffic Accident Data
Dataset: Inimkannatanutega liiklusõnnetuste andmed (Traffic accidents with casualties)
Provider: Eesti Transpordiamet, Andmete teabevärav (Estonian Transport Administration via the Estonian Open Data Portal
Dataset page:
https://andmed.eesti.ee/datasets/inimkannatanutega-liiklusonnetuste-andmed
Description:
The dataset contains records of traffic accidents involving casualties in Estonia. Each record includes accident time, location, accident type, environmental conditions, and the number of injuries and fatalities.
Format used in this project:
CSV
Accessed: March 2026
License: CC BY 3.0

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

#### Sample Dataset


## Tools Used 
* QGIS - Spatial join
* SQL (DuckDB & DBeaver) - Data cleaning and analysis
* Tableau - Data visualization and dashboard
* GitHub - Project documentation

## Key Analysis
The following aspects of ... were analyzed:

Road width categories were created based on the distribution of values in the dataset. Most observations were concentrated between 6 and 10 meters, so narrower bins were used in this range to capture variation. Wider bins were used for larger road widths due to fewer observations.

Road width categories were defined based on the distribution of values to ensure sufficient observations in each group, while also reflecting meaningful differences in road size.

## Key Findings
The analysis shows that accident severity is not evenly distributed across road types and conditions, but is concentrated in specific scenarios.
#### 1. Pedestrian mid-section crossings drive fatal outcomes
Most fatal accidents occur in situations where a pedestrian crosses the road outside of intersections:
Vehicle conflict with a pedestrian crossing the road mid-section (from left or right)
At 50 km/h, the two most common fatal scenarios are:
Crossing from left: 68 accidents, 4 fatal (5.88%)
Crossing from right: 80 accidents, 4 fatal (5.0%)
This indicates that unregulated pedestrian crossings are a key contributor to fatal outcomes.

#### 2. Medium-width roads (9–11 m) at 50 km/h show elevated risk
The highest fatality rates are observed on 9–11 meter roads, particularly at 50 km/h speed limits, when combined with pedestrian crossing scenarios.
This suggests that:
roads are wide enough to allow higher speeds
but may lack sufficient pedestrian infrastructure or separation

#### 3. Road conditions are not a primary factor
Most fatal accidents occur when:
road condition = “sõidutee on korras”
This indicates that poor road condition is not a major driver of fatal outcomes in this dataset.

#### 4. Time-of-day pattern (unexpected finding)
For mid-section pedestrian crossings on 9–11 m roads:
Daytime: ~7.4% fatality rate
Nighttime: ~3.8% fatality rate
Fatality rates are approximately twice as high during daytime.
The exact cause cannot be determined from this dataset, but possible explanations include:
higher traffic volume during daytime
more frequent crossing attempts
differences in traffic flow dynamics

#### 5. Overall conclusion
The results suggest that:
Accident severity in urban Estonia is not primarily driven by road width alone, but by the interaction between road width, speed, and pedestrian behavior.
The most critical risk scenario identified is:
Pedestrians crossing mid-road on medium-width (9–11 m) urban roads with 50 km/h speed limits.

## Tableau Dashboard
Visualizations include:


## Recommendations
Based on the analysis, ...:


## Author

Aleksandra Doroshenko

Junior Data Analyst Portfolio Project

## Acknowledgements
This project was completed as part of the ... .

AI tools were used during the learning process to help review SQL queries, clarify concepts, and improve documentation. All analysis, data processing, and conclusions were performed and validated by the author.
