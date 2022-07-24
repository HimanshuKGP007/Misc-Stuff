df.registerTempTable("people")

df2 = spark.sql("select * from people")