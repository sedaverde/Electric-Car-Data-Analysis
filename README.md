# Electric-Car-Data-Analysis

## Background
In recent years, electric vehicles (EV) have become a more viable and popular choice to gasoline powered automobiles. Over thee course of ten years, improvements in battery technology and model design have increased the diversity of EV available for the consumer. We believe that many factors contribute to the increase of the popularity of EV. The purpose of this project is to develop answers to the following questions:

- What are the primary factors which drive electric car sales in the U.S. (eg income level, gasoline/electric prices, diversity of model types, cost of cars, savings on gasoline, availability of charging stations, etc.)?
- What is our estimated forecast projection for electric car sales using a ML approach?

### Contributers

| Name | Primary Role |
|:---|:---|
| Adai Urieta |Data Mining, Data Cleaning, Database Development, Machine Learning|
| Juan Camarillo |Data Manipulation, Dashboard Development, Presentation, As Needed Projects|
| Matt Kleineck |Data Mining, Data Cleaning, Database Development, Machine Learning| 
| Nielsa R. Lachapelle |Repository Management, Data Review, Dashboard Development, SQL queries, Presentation|
| Samad Fassihi |Data Mining, Data Cleaning, Database Development, Machine Learning|


## Project Requirements

### Software
- Jupyter / Colab Notebook with Python 3.7+
  - Packages: Pandas, SQLAlchemy, Plotly.express, SkLearn, Spark, pytrends
- Postgres hosted on AWS
- Amazon S3 (hosting Raw CSV files)
- ParseHub (Web Scraping Tool)
- Tableau
- dbdiagram.io

### Data
1. US Car Sales by Model
2. EV Car Sales by Model / Month / Year
3. EV Model Stats (Range, Price, Cost of Ownership, etc.)
4. Car Price by Model / Year (New)
5. Personal Income by County / State
6. US Charging Stations by City
7. Fuel Cost by Region

### API
1. Bureau of Economic Analysis (BEA)
2. Alternative Fuel Data Center

### Methodology
1. Extract, Transform, Load
2. Setup Backend / Hosting Services
3. Winters Method Forecasting for Time Series Data
4. Present Data Story

## Presentation Links
https://docs.google.com/presentation/d/1j5DLEuqZcNBLMlDRIU7UmMwGV5vLEUJBTLNXfdYayUk/edit#slide=id.p
https://public.tableau.com/views/ElectricVehicleDataAnalysis/Comparisons2?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link
https://public.tableau.com/views/ElectricVehicleDataAnalysisComparisons/Comparisons?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link

## Results
Our forecasting models predicted that EV sales would continue to grow. Out of five factors evaluated, model and manufacturer had the strongest correlation to EV sales. However, it is unclear whether or not the demand for EVs drives manufacturers to enter the market and probide more choices for the consumer, or if the diversity of choice is driving concumers to purchase EVs.

Importance ratings for variables tested:

![image](https://user-images.githubusercontent.com/90329647/168421178-6cf83088-071f-4e99-8c08-0857db3375e5.png)


## Recommendations for Future Work
We recommend for those who choose to take this work further or perform their own EV Sales analysis:
- Consider the weighted average cost of EVs in the analysis.
  - Hypothesis: The demand for EV's is directly proportional to the mean or median car price (adjusted for inflation) 

The methodology for this calculation is as follows:
<br>
Weighted Average Cost =  Σ Monthly EV Model Sales * Model Price / Total EV Sales
<br>
- Consider the range differential of electric vehicles to conventional gas-powered or hybrid vehicles. In other words, what impact does the total range on the ev when compared to their gas powered equivalent have on the demand?
  - Hypothesis: Longer Range EV's are more desirable than shorter range EV's when price is normalized. EV Range Bang for Buck plays a considerable role in Ev demand.

- Other predicting factors of ev demand:
  - [Brands with Federal tax incentives](https://www.fueleconomy.gov/feg/taxevb.shtml)
    - Over time, there is some variability in the net cost of an EV or PHEV due to the Federal tax incentive limited to the first 200k ev's sold **per manufacturer**
    - [Qualified EV and PHEV models](https://www.irs.gov/businesses/irc-30d-new-qualified-plug-in-electric-drive-motor-vehicle-credit) are eligible for up to $7,500 of tax credit from the sale price
  - Lifetime cost of ownership of EV's 
    - [Annual Fuel and Maintenance cost comparison of EVs to Gasoline vehicles](https://exchange.aaa.com/wp-content/uploads/2019/09/AAA-Your-Driving-Costs-2019.pdf)
  - [Google Searches related to EV's](https://www.cnn.com/2022/03/24/business/electric-vehicle-google-search-record-climate/index.html)
  - Availability of EV's due to: 
    - Supply chain issues
    - Lack of inventory
    - Cost of raw materials 
  - Public sentiment on autonomous driving & alternative fueling options
    - Safety concerns related to self-driving and/or batteries
    - Convenience factor of charging vehicles
  - Economic conditions
    - Inflation
    - Changes in GDP
    - Median Annual Income
    - Interest Rates
    - Commodity prices (other than gasoline and electricity)    

## References
- https://afdc.energy.gov/data/
- https://insideevs.com/news/344007/monthly-plug-in-ev-sales-scorecard-historical-charts/
- https://www.bea.gov/data/income-saving/personal-income-county-metro-and-other-areas
- https://www.kaggle.com/geoffnel/evs-one-electric-vehicle-dataset
- https://www.kaggle.com/datasets/prasertk/electric-vehicle-charging-stations-in-usa
- https://www.ev-volumes.com/
- https://ev-database.org/#sort:path~type~order=.rank~number~desc|range-slider-range:prev~next=0~1200|range-slider-acceleration:prev~next=2~23|range-slider-topspeed:prev~next=110~450|range-slider-battery:prev~next=10~200|range-slider-towweight:prev~next=0~2500|range-slider-fastcharge:prev~next=0~1500|paging:currentPage=0|paging:number=9
- https://www.bts.gov/content/gasoline-hybrid-and-electric-vehicle-sales
- https://www.statista.com/topics/4421/the-us-electric-vehicle-industry/#dossierKeyfigures
- https://www.eia.gov/dnav/pet/hist/LeafHandler.ashx?n=pet&s=emm_epmr_pte_nus_dpg&f=m
- https://fred.stlouisfed.org/series/APU000072610
- https://www.eia.gov/dnav/pet/hist/LeafHandler.ashx?n=pet&s=emm_epmr_pte_nus_dpg&f=m



