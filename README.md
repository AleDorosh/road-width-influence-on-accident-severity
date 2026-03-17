# Name
Case Study – Beginner data analytics course

## Tableau Dashboard

![Cyclistic Dashboard](dashboard/dashboard.png)

## Project Overview
The aim of the study is to determine whether there is a relationship between road width and traffic accident severity (injury or fatality) in urban traffic in Estonia.


## Problem Overview



## Repository Structure


## Data 
#### Road Width Data

Dataset: TN.RoadTransportNetwork.RoadWidth
Provider: Estonian Topographic Database: Republic of Estonia Land and Spatial Development Board
Metadata:
https://metadata.geoportaal.ee/geonetwork/srv/eng/catalog.search#/metadata/bf38a8fc-96f1-4d34-9130-18160e489514

Service endpoint (WFS):
https://inspire.geoportaal.ee/geoserver/TN_transportetak/wfs

Description:
This dataset provides road transport network attributes based on the INSPIRE Transport Networks data model, including road geometry and attributes such as road width. The dataset is published through Estonia’s INSPIRE spatial data services and is accessible via Web Feature Service (WFS).

Format used in this project:

TN.RoadTransportNetwork.RoadWidth

Accessed: March 2026
Open data licence: https://geoportaal.maaruum.ee/opendata-licence (Creative Commons equivalent CC BY 4.0)


#### Traffic Accident Data

Dataset: Inimkannatanutega liiklusõnnetuste andmed (Traffic accidents with casualties)
Provider: Estonian Transport Administration via the Estonian Open Data Portal

Dataset page:
https://andmed.eesti.ee/datasets/inimkannatanutega-liiklusonnetuste-andmed

Description:
The dataset contains records of traffic accidents involving casualties in Estonia. Each record includes accident time, location, accident type, environmental conditions, and the number of injuries and fatalities.

Format used in this project:
CSV

Accessed: March 2026
License: CC BY 3.0 - Creative Commons Attribution 3.0 Unported

#### Data Filtering Methodology

**The original traffic accident dataset contains records from multiple years and accident types. 
Several filters were applied to ensure the data matched the research question.

1. Traffic accident locations were spatially matched to road segments to obtain road width information. The spatial join was performed in QGIS using a maximum search distance of 20 meters. The distribution of join distances showed an average distance of 2.38 m and a 95th percentile of 13.6 m. To reduce potential spatial mismatches, only joins with a distance of 15 meters or less were retained. This threshold was selected based on the distribution of join distances and removes observations where the accident location may have been incorrectly matched to a road segment. A smaller radius (10 m) resulted in substantial data loss due to positional inaccuracies in the source datasets, while the 20 m threshold preserved additional observations without significantly increasing the average join distance. During the spatial join between accidents and road segments, some accidents matched multiple nearby road geometries. To avoid influencing data by choosing which of rows to keep and which discard, all accidents that appeared more than once were deleted. 

2. The analysis focuses on the period 2018–2025. This time frame aligns with Transpordiamet's traffic accident reporting period and reflects the most recent traffic conditions.

3. Cities and towns with populations over approximately 10,000 residents were selected. In total 14, cities and towns were included: Tallinn, Tartu, Narva, Pärnu, Kohtla-Järve, Viljandi, Maardu, Rakvere, Kuressaare, Sillamäe, Võru, Valga, Keila and Jõhvi. These locations are geographically distributed across Estonia and represent variety of urban characteristics.
In the case of Tallinn, accidents were analyzed at the district level to maintain comparable spatial units.

It should be noted that the Ida-Virumaa region is heavily represented with Narva, Kohtla-Järve, Sillamäe, Jõhvi. These are all former Soviet industrial centers with potentially similar urban planning features and distinct demographic profile. This is acknowledged as a limitation, though addressing it is beyond the scope of the current analysis.

4. The analysis includes three main accident types: vehicle collisions, single-vehicle accidents, and pedestrian accidents.
Initially, accidents involving pedestrians and cyclists were excluded to focus on motor-vehicle collisions. However, these road users are an integral part of urban traffic systems and frequently interact with motor vehicles in shared road space. Therefore, pedestrian- and bicycle-related accidents were included in the final dataset. Pedestrian and cyclist accidents may be influenced by additional factors such as crossing infrastructure and pedestrian facilities, which are not explicitly modeled in this analysis. 

5. Only accidents involving a motor vehicle driver were included.

6.  Accidents occurring in locations not representative of standard road traffic environments (e.g., parking lots, forest roads, pedestrian paths, and squares) were excluded. These environments have different traffic dynamics and are unlikely to reflect the relationship between road width and accident severity in urban streets.

7.  Only road segments with a recorded width of 3 meters or greater were included in the analysis. According to Estonian road design standards, typical traffic lane widths range between 3.0 and 3.25 meters, with narrower lanes (around 2.75 meters) occurring only in low-speed environments. Values below 3 meters are therefore likely to represent data inaccuracies, non-standard traffic environments, or infrastructure not intended for regular motor vehicle traffic.**

After applying spatial, temporal, and contextual filters, the final dataset contained 3,742 accidents, including 68 fatalities and 4,265 injuries.
#### 

The original accident dataset contains a large number of attributes describing accident circumstances, participants, and infrastructure characteristics. During data preparation, variables not relevant to the research objective were removed to simplify the dataset. The final analysis dataset includes variables related to accident severity, road characteristics, environmental conditions, and spatial matching with the road network.

The final dataset includes variables related to:
• accident severity (injuries, fatalities)
• road characteristics (road width, speed limit, road type)
• environmental conditions (weather, lighting, road surface)
• spatial join quality (distance to matched road segment)

Missing values in categorical variables were retained as “Unknown” to avoid introducing bias through imputation.

#### Sample Dataset


## Tools Used 
* SQL (DuckDB) - Data cleaning and analysis
* Tableau - Data visualization and dashboard
* GitHub - Project documentation

## Data Preparation


Steps performed during data preparation:


## Key Analysis
The following aspects of rider behavior were analyzed:




## Key Findings
#### 1. 

#### 2. 



## Tableau Dashboard
Visualizations include:


## Recommendations
Based on the analysis, the following strategies could help convert casual riders into annual members:


## Author

Aleksandra Doroshenko

Junior Data Analyst Portfolio Project

## Acknowledgements
This project was completed as part of the Google Data Analytics Certificate.

AI tools were used during the learning process to help review SQL queries, clarify concepts, and improve documentation. All analysis, data processing, and conclusions were performed and validated by the author.
