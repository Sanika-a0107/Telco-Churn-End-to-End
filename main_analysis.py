import pandas as pd
from sqlalchemy import create_engine
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

# 1. DATABASE CONNECTION
# Replace 'Sanika123' if you changed your password
password = "Sanika123" 
engine = create_engine(f'postgresql://postgres:{password}@localhost:5432/telco_churn')

print("Step 1: Connecting to telco_churn database...")

try:
    # Load data from the table you created
    df = pd.read_sql('SELECT * FROM telco_data', engine)
    
    print(f"DEBUG: Successfully loaded {len(df)} rows.")

    if df.empty:
        print("!!! ERROR: Table is empty. Please check your pgAdmin import.")
    else:
        # 2. FEATURE SELECTION
        # These names MUST match your SQL columns exactly (lowercase)
        features = [
            'tenure_in_months', 
            'monthly_charge', 
            'satisfaction_score', 
            'cltv', 
            'churn_score'
        ]
        
        X = df[features]
        # Convert 'Yes'/'No' labels to 1 and 0 for the machine learning model
        y = df['churn_label'].apply(lambda x: 1 if str(x).strip().lower() == 'yes' else 0)

        # 3. TRAIN THE MODEL (Random Forest)
        print("Step 2: Training the Machine Learning model...")
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
        
        model = RandomForestClassifier(n_estimators=100, random_state=42)
        model.fit(X_train, y_train)

        # 4. GENERATE PREDICTIONS
        # We calculate the probability (0.0 to 1.0) of a customer leaving
        df['churn_probability'] = model.predict_proba(X)[:, 1]

        # 5. EXPORT RESULTS
        print("Step 3: Saving results to CSV and back to SQL...")
        
        # Save a local CSV file for your project folder
        df.to_csv('telco_with_predictions.csv', index=False)
        
        # Save a new table in pgAdmin for your final presentation
        df.to_sql('churn_predictions', engine, if_exists='replace', index=False)
        
        print("\n" + "="*40)
        print("DONE! PROJECT COMPLETED SUCCESSFULLY")
        print("1. Local file created: telco_with_predictions.csv")
        print("2. SQL Table created: churn_predictions")
        print("="*40)

except Exception as e:
    print(f"Connection Error: {e}")