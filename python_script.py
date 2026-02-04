import pandas as pd
from sqlalchemy import create_engine


# Load Excel Data


print("\nLoading Excel dataset...")

excel_file = r"C:\Users\BADAL\Downloads\EXCEL PROJECT 1\Project 1.xlsx"
sheet_name = "Hospital Emergency Room Data (3"

df = pd.read_excel(excel_file, sheet_name=sheet_name)

print("Dataset Loaded Successfully!")
print("Shape:", df.shape)
print(df.head())



# Cleaning


print("\nCleaning Data...")

df.drop_duplicates(inplace=True)

df["Patient Admission Date"] = pd.to_datetime(df["Patient Admission Date"], errors="coerce")

df["Patient Age"] = pd.to_numeric(df["Patient Age"], errors="coerce")
df["Patient Waittime"] = pd.to_numeric(df["Patient Waittime"], errors="coerce")
df["Patient Satisfaction Score"] = pd.to_numeric(df["Patient Satisfaction Score"], errors="coerce")

# Fill missing values
df["Department Referral"] = df["Department Referral"].fillna("Unknown")
df["Patient Race"] = df["Patient Race"].fillna("Unknown")
df["Patient Gender"] = df["Patient Gender"].fillna("Unknown")

print("Cleaning Done!")
print("Shape:", df.shape)



# Feature Engineering



print("\nCreating new columns...")

df["DATE"] = df["Patient Admission Date"].dt.date
df["Day Name"] = df["Patient Admission Date"].dt.day_name()

def age_group(age):
    if pd.isna(age):
        return "Unknown"
    elif age <= 12:
        return "Child"
    elif age <= 19:
        return "Teen"
    elif age <= 35:
        return "Young Adult"
    elif age <= 60:
        return "Adult"
    else:
        return "Senior"

df["Age_Group"] = df["Patient Age"].apply(age_group)

def satisfaction_status(score):
    if pd.isna(score):
        return "Not Given"
    elif score >= 4:
        return "Good"
    elif score >= 3:
        return "Average"
    else:
        return "Bad"

df["Satisfaction_Status"] = df["Patient Satisfaction Score"].apply(satisfaction_status)

print("New columns created successfully!")



# MySQL Connection using SQLAlchemy



print("\nConnecting to MySQL using SQLAlchemy...")

USER = "root"
PASSWORD = "214112Badal"     # change this
HOST = "localhost"
DB = "healthcare_db"

engine = create_engine(f"mysql+pymysql://{USER}:{PASSWORD}@{HOST}/{DB}")

print("Connected Successfully!")



# Load Data into MySQL



print("\nStoring data into MySQL table...")

df.to_sql("hospital_data", con=engine, if_exists="replace", index=False)

print("Data stored successfully in MySQL!")
