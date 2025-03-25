# Import necessary libraries
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, classification_report

# Load dataset
data_path = r"C:\Users\LENOVO\Desktop\Custumer churn predection project\churn-bigml-80.csv"
data = pd.read_csv(data_path)

# 📌 Step 1: Data Preprocessing
# ------------------------------------
# Handle missing values by removing rows with NaN values
data.dropna(inplace=True)  

# Encode categorical variables (Convert text values into numerical form)
le = LabelEncoder()
data['International_Plan'] = le.fit_transform(data['International_Plan'])
data['Voice_Mail_Plan'] = le.fit_transform(data['Voice_Mail_Plan'])
data['Churn'] = le.fit_transform(data['Churn'])  # Target variable

# Drop non-relevant columns (like 'State' which is not useful for prediction)
X = data.drop(['Churn', 'State'], axis=1)  
y = data['Churn']  # Target variable (0 = No Churn, 1 = Churn)

# 📌 Step 2: Train-Test Split (80% Training, 20% Testing)
# ------------------------------------
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 📌 Step 3: Feature Scaling (Standardizing the data for better model performance)
# ------------------------------------
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# 📌 Step 4: Train Machine Learning Models
# ------------------------------------
# Define models
models = {
    "Logistic Regression": LogisticRegression(),
    "Decision Tree": DecisionTreeClassifier(),
    "Random Forest": RandomForestClassifier()
}

# Train and evaluate each model
for name, model in models.items():
    model.fit(X_train, y_train)  # Train the model
    y_pred = model.predict(X_test)  # Make predictions

    # 📌 Step 5: Model Evaluation
    # ------------------------------------
    print(f"\n{name} Results:")
    print(f"Accuracy: {accuracy_score(y_test, y_pred):.4f}")
    print(f"Precision: {precision_score(y_test, y_pred):.4f}")
    print(f"Recall: {recall_score(y_test, y_pred):.4f}")
    print(f"F1 Score: {f1_score(y_test, y_pred):.4f}")
    print(classification_report(y_test, y_pred))  # Detailed classification report


""""
Logistic Regression

Accuracy: 85.96% (Good but weak on detecting churn)
Precision: 56.25%
Recall: 22.78% (Very low; it misses many churn cases)
F1 Score: 32.43%
Decision Tree

Accuracy: 89.89% (Improved)
Precision: 66.67%
Recall: 63.29% (Much better at detecting churn)
F1 Score: 64.94%
Random Forest (Best Model)

Accuracy: 94.76% (Highest among all models ✅)
Precision: 98.11%
Recall: 65.82% (Much better at identifying churn than Logistic Regression)
F1 Score: 78.79%"
"""