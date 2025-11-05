# Exploratory Data Analysis using MySQL | Data Cleaning 
## Dataset: Global Layoffs  
### Timeline & Data: March 2020 – March 2023  
**Project Overview:** 

**Executive Summary:**  
I conducted a comprehensive exploratory data analysis (EDA) on global layoffs to uncover patterns, trends, and insights across companies, industries, countries, and time.  
The analysis included data cleaning, aggregation, and deriving actionable business insights for investors, policy makers, and workforce planning.  



**Business Problem**  
•	Identify which companies and industries are most affected by layoffs.  
•	Understand how layoffs vary across funding stages.  
•	Track trends over time to anticipate workforce reductions.  
•	Provide insights for companies, investors, and employees to make informed decisions.  

**Methodology**   
Step 1 : Explore the data and understand key columns.  
Step 2: Clean and standardize data; handle missing values; extract Year/Month.  
Step 3: Analyse layoffs by companies, industries, funding stages, and over time (monthly/yearly trends and rolling totals).  
Step 4: Derive insights and create visualizations.  

**Key Insights**  

•	Top Companies by Layoffs:  
Companies accounting for the majority of workforce reductions. 

Google : 0.06% (~12000 employees laid off)  
Meta: 0.13% (~11000 employees laid off)  
Amazon: 0.03% (~10000 employees laid off)    

<img width="576" height="212" alt="image" src="https://github.com/user-attachments/assets/845c15d0-90cd-4f77-aabf-cec82332b882" />  
<img width="472" height="516" alt="image" src="https://github.com/user-attachments/assets/a182cac1-dba4-4204-93a8-08fe71330087" />  


 
•	Some companies like (Airlift, Amplero) even laid off 100% of their staff, indicating closures or major restructuring. 

<img width="940" height="312" alt="image" src="https://github.com/user-attachments/assets/8fa03499-9a99-4b45-b1c2-93fdf19e0ff7" />  
 
 
•	Industry Insights: Consumer, Retail, and transportation were among the sectors that experienced the highest layoffs, showing vulnerability to market and funding fluctuations.  

<img width="505" height="534" alt="image" src="https://github.com/user-attachments/assets/cc6e41a6-97b1-49cd-a1a2-ad936283bd7c" />  

 
•	Many companies at Series D or IPO stage reported layoffs, showing that even well-funded or public firms faced scaling pressures. 

<img width="471" height="473" alt="image" src="https://github.com/user-attachments/assets/143a26cb-2ad5-4a01-bd6a-4c0e0311f7b6" />  


Rolling Cumulative Layoffs (Monthly Trend)  
- The rolling total illustrates how layoffs accumulated over time.  
- A sharp increase is visible between April 2020 and December 2020, indicating mass layoffs during the early pandemic phase.  
- After mid-2021, the curve flattens, showing reduced layoffs and market stabilization.  

  <img width="270" height="390" alt="Screenshot 2025-10-30 145939" src="https://github.com/user-attachments/assets/67a365a5-df2f-4221-9f83-9348f18cfa4f" />   
- Yearly Trend
     
  <img width="602" height="317" alt="image" src="https://github.com/user-attachments/assets/af1ec01f-4704-4ad0-b0ed-21aa8364c1a6" />
  

**Country Level - Analysis:**  

The United States experienced the highest number of layoffs globally, with over 256,000 employees affected, followed by India with nearly 36,000. European countries like the Netherlands and Sweden, along with Brazil, also faced notable layoffs but on a smaller scale. This indicates that while large markets like the US and India bore the brunt of workforce reductions, layoffs were a global phenomenon impacting both mature and emerging economies. 

  <img width="495" height="252" alt="image" src="https://github.com/user-attachments/assets/de328022-aab8-4c76-b04c-0f524d9e61ca" />  
    <img width="302" height="192" alt="image" src="https://github.com/user-attachments/assets/87dbb1ee-2c19-493b-9767-c404bbaa6069" />  

**Business Takeaway:**
 
_Companies and investors should interpret this trend as a signal to prioritize operational efficiency and risk management. Markets with higher layoffs may indicate sectors under pressure, presenting both cautionary signs for investment and potential opportunities for strategic acquisitions or talent acquisition at scale._  


 

**Tools & Techniques:**     
SQL (CTEs, window functions, aggregations), data cleaning, trend analysis, and insights extraction  
Excel for Data Visualization
