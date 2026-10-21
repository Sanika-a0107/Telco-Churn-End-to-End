
🚀 End-to-End Telco Customer Churn Prediction System
This project demonstrates a production-grade data lifecycle, bridging the gap between Data Engineering (PostgreSQL), Machine Learning (Python), and Business Intelligence (Power BI).

📊 Business Problem
Customer attrition (churn) is a major revenue killer in telecom. This project was built to transition from reactive analysis to proactive retention by assigning a risk probability score to every customer based on their behavior, contract type, and satisfaction levels.

🏗️ Technical Architecture
The project is structured into three distinct enterprise layers:

Phase 1: Data Engineering (SQL)
Developed a robust relational schema in PostgreSQL.

Performed ETL (Extract, Transform, Load) to migrate 7,000+ records into a structured "Source of Truth."

Optimized tables for high-performance querying and AI integration.

Phase 2: Predictive Analytics (Python)
Built a Random Forest Classifier using Scikit-Learn.

Developed a custom ETL pipeline with SQLAlchemy to automate data flow between SQL and Python.

Generated a churn_probability score (0.0 to 1.0) for every customer profile.

Phase 3: Business Intelligence (Power BI)
Designed an Executive Dashboard focused on "Revenue at Risk."

Implemented interactive slicers for geographic risk density and contract vulnerability.

Visualized prioritized "Call Lists" for the retention team.

🛠️ Tech Stack
💡 Key Business Insights
Risk Factor: Month-to-month customers are 3x more likely to churn compared to long-term subscribers.
Service Impact: Customers with low satisfaction scores (<3) but high Monthly Charges are at peak risk.
Geographic Trends: Identified specific cities (e.g., Los Angeles) with the highest concentration of high-value at-risk customers.
## 📊 Dashboard Preview

![Customer Churn Dashboard](Dashboard/REPLACE_WITH_YOUR_IMAGE_FILENAME.png)

## 📂 Repository Structure

- `Dashboard/` — Dashboard-related files and visuals
- `sql/` — SQL scripts and database queries
- `churn_prediction.pbix` — Power BI dashboard file
- `main_analysis.py` — Python analysis and churn prediction
- `requirements.txt` — Python dependencies
- `telco_churn.sql` — SQL script for churn analysis

## 🚀 How to Run

1. **Set up the database:** Run the SQL scripts in the `sql/` folder using PostgreSQL/pgAdmin.
2. **Install dependencies:** Run `pip install -r requirements.txt`.
3. **Run the Python analysis:** Execute `python main_analysis.py` from the repository root.
4. **Open the dashboard:** Open `churn_prediction.pbix` in Power BI Desktop



👤 Author
Sanika Data Science & Analytics Specialist 

