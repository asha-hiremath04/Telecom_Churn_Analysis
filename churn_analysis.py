import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load the dataset
df = pd.read_csv("churn-bigml-80.csv")  # Change to the correct file path if needed

# Display first few rows
print(df.head())

# Check for missing values
print("\nMissing Values:\n", df.isnull().sum())

# Check basic statistics
print("\nDataset Summary:\n", df.describe())

# Check data types
print("\nData Types:\n", df.dtypes)


# Convert Churn column to numeric (0 = No, 1 = Yes)
df['Churn'] = df['Churn'].astype(int)

# Convert 'International plan' & 'Voice mail plan' to numeric (0 = No, 1 = Yes)
df['International plan'] = df['International plan'].map({'No': 0, 'Yes': 1})
df['Voice mail plan'] = df['Voice mail plan'].map({'No': 0, 'Yes': 1})

# Drop 'State' column (not needed for analysis)
df.drop(columns=['State'], inplace=True)

# Check updated dataset
print(df.head())
print("\nData Types After Processing:\n", df.dtypes)


import seaborn as sns
import matplotlib.pyplot as plt

sns.countplot(x=df['Churn'])
plt.title("Churn Distribution")
plt.show()

import seaborn as sns
import matplotlib.pyplot as plt

# Select only numeric columns
numeric_df = df.select_dtypes(include=['number'])

# Generate the heatmap
plt.figure(figsize=(12, 6))
sns.heatmap(numeric_df.corr(), annot=True, cmap="coolwarm", linewidths=0.5)
plt.title("Feature Correlation Heatmap")
plt.show()




