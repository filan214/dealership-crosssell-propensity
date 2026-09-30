import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()
engine = create_engine(os.environ["DATABASE_URL"])

df = pd.read_csv("data/raw/train.csv")
df.columns = [c.lower() for c in df.columns]

df.to_sql("customers", engine, if_exists="replace",
          index=False, chunksize=10_000, method="multi")
print("Loaded rows:", len(df))