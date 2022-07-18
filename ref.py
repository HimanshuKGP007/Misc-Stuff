# Setting an user define function:
# This function converts the string cell into a date:
func =  udf (lambda x: datetime.strptime(x, '%m/%d/%Y'), DateType())

df = df1.withColumn('test', func(col('first')))

df.show()

df.printSchema()