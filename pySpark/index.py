# Install Apache Spark 3.2.0
# !apt-get install openjdk-8-jdk-headless -qq > /dev/null
# !wget -q https://archive.apache.org/dist/spark/spark-3.2.0/spark-3.2.0-bin-hadoop3.2.tgz
# !tar xf spark-3.2.0-bin-hadoop3.2.tgz
# !pip install -q findspark

# Set up environment variables
import os
os.environ["JAVA_HOME"] = "/usr/lib/jvm/java-8-openjdk-amd64"
os.environ["SPARK_HOME"] = "/content/spark-3.2.0-bin-hadoop3.2"

# Start a SparkSession
import findspark
findspark.init()

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum

# Initialize a Spark session
spark = SparkSession.builder.appName("SalesAnalysis").getOrCreate()

# Load the CSV file into a DataFrame
input_file_path = "/content/sales_data.csv"
sales_data = spark.read.csv(input_file_path, header=True, inferSchema=True)

# Perform data cleaning: handle missing values and remove duplicates
cleaned_sales_data = sales_data.dropDuplicates().na.drop()

# Calculate the total sales amount for each product
total_sales_per_product = (
    cleaned_sales_data
    .groupBy("Product")
    .agg(sum("SalesAmount").alias("TotalSalesAmount"))
)

# Output the results to a new CSV file
output_file_path = "/content/output_file.csv"
total_sales_per_product.write.csv(output_file_path, header=True)

spark.stop()
