## Road Width vs Accident Severity (Urban Estonia)

### Research Question
Is there a relationship between road width and traffic accident severity in urban Estonia?
The analysis focuses on accidents involving injuries or fatalities in Estonian cities between 2018 and 2025. Results are presented using aggregated statistics and visualizations to identify patterns rather than establish causation.

### Key Insight
Accident severity in urban Estonia is not driven by road width alone, but by the interaction between road width, speed, and pedestrian behavior. Pedestrian fatalities peak on 9 - 11 m urban roads, driven by mid-road crossing behavior at 31 - 50 km/h, with higher risk during daytime.

### Data
#### Road Width Data
* Dataset: TN.RoadTransportNetwork.RoadWidth Provider: Eesti topograafia andmekogu - Maa- ja Ruumiamet (Estonian Topographic Database - Republic of Estonia Land and Spatial Development Board)
* Metadata: https://metadata.geoportaal.ee/geonetwork/srv/eng/catalog.search#/metadata/bf38a8fc-96f1-4d34-9130-18160e489514
* Service endpoint (WFS): https://inspire.geoportaal.ee/geoserver/TN_transportetak/wfs, TN.RoadTransportNetwork.Roadwidth
* Accessed: March 2026
* Licence: https://geoportaal.maaruum.ee/opendata-licence (CC BY 4.0)

#### Traffic Accident Data
* Dataset: Inimkannatanutega liiklusõnnetuste andmed (Traffic accidents with casualties) Provider: Eesti Transpordiamet, Andmete teabevärav (Estonian Transport Administration via the Estonian Open Data Portal
* Dataset page: https://andmed.eesti.ee/datasets/inimkannatanutega-liiklusonnetuste-andmed,
* CSV Accessed: March 2026
* License: CC BY 3.0

### Data lineage

<img width="700" height="451" alt="image" src="https://github.com/user-attachments/assets/428371a8-8a7d-4ad7-8d07-ac085822f372" />

### Key Findings
#### 1. Fatality risk peaks on medium-width roads (9–11 m)

<img width="485" height="328" alt="image" src="https://github.com/user-attachments/assets/0d424290-801a-44da-8b1a-c39f390d07ce" />

* Highest fatality rate: 2.41% (9 - 11 m)
* Lower on:
   - 6 - 8 m → 1.27%
   - 15+ m → 1.11%
     
#### Interpretation:
Medium-width roads likely combine:
* higher speeds
* active pedestrian interaction
  
#### 2. Pedestrian accidents drive this pattern

<img width="485" height="328" alt="image" src="https://github.com/user-attachments/assets/58f05195-c17e-4030-b4ed-7a42939c2e72" />

* Pedestrian fatality rate (9 - 11 m): 5.25%
* Vehicle collisions: <1%
* High pedestrian volume amplifies overall risk
  
#### Interpretation:
High pedestrian exposure significantly increases overall fatality risk.

#### 3. Speed amplifies pedestrian fatality risk

<img width="485" height="328" alt="image" src="https://github.com/user-attachments/assets/b6251313-defc-4058-95c1-c2af82eb22e8" />

* Most fatal accidents: 31 - 50 km/h
* Fatality rate: 5.54% (9 - 11 m)
* Higher speeds → higher risk, but low sample sizes
* 
#### Interpretation:
Moderate urban speeds are sufficient to produce high fatality risk when pedestrian exposure is high.

#### 4. Crossing pedestrians are the highest-risk scenario

<img width="485" height="148" alt="image" src="https://github.com/user-attachments/assets/28e83e13-0b0b-448f-b2a6-8990d67a71af" />

* Conflict from left → 5.68%
* Conflict from right → 4.31%
  
#### Interpretation:
Unprotected / mid-block crossings are key risk points.

#### 5. Daytime conditions show higher fatality rates

<img width="485" height="148" alt="image" src="https://github.com/user-attachments/assets/d65ea72d-2ac7-41b0-9fb3-cb7910939f73" />

* Day (Valge aeg): 6.32%
* Night (Pimeda aeg): 3.73%
  
#### Interpretation:
Likely driven by higher traffic volume and pedestrian activity.

#### 6. Similar patterns on narrow roads (≤5 m), but less reliable

* Fatality rate ~5.4% in some cases
* Based on smaller samples
* 
#### Interpretation:
Patterns exist but are less statistically robust → focus remains on 9–11 m roads.

### Tableau Dashboard
[https://public.tableau.com/app/profile/aleksandra.doroshenko/viz/Roadwidthvsseverity/Dashboard1](https://public.tableau.com/app/profile/aleksandra.doroshenko/viz/Roadwidthvsseverity/Dashboard1)

### Method Overview
* Filtered urban accidents (2018–2025)
* Joined accident data with road width (GIS, 20m join)
* Classified accidents:
   - fatal (deaths > 0)
   - non-fatal
* Aggregated by:
   - road width
   - accident type
   - speed
   - scenario
   - lighting

Full details: Methodology.md [Methodology.md](Methodology.md).

### Repository Structure
```
road-width-accident-severity/
├── README.md
├── Methodology.md
├── data/
│   ├── raw_data/
│   ├── filtered_data/
│   └── cleaned_data.csv
└── sql/
    ├── cleaning/
    │   ├── 01_filtering.sql
    │   ├── 02_duplicates.sql
    │   ├── 03_null_analysis.sql
    │   └── 04_standarize_values.sql
    └── analysis/
        ├── 01_severity_by_width.sql
        ├── 02_accident_type_by_width.sql
        ├── 03_pedestrian_fatality_by_width.sql
        ├── 04_pedestrian_fatality_by_speed.sql
        ├── 05_pedestrian_fatality_by_scenario.sql
        └── 06_pedestrian_fatality_by_daytime.sql
```
### Limitations
* Broad speed categories (31 - 50 km/h)
* Small samples at higher speeds
* Road width ≠ full road design (lanes, crossings, signals)
  
### Author
Aleksandra Doroshenko
Junior Data Analyst Portfolio Project

### Acknowledgements
This project was completed as part of the Data Analysts Advanced Training Program by BCS Koolitus.

AI tools were used during the learning process to help review SQL queries, clarify concepts, and improve documentation. All analysis, data processing, and conclusions were performed and validated by the author.
