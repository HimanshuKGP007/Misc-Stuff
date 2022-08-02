print(dataframe.select('student Name').
      rdd.flatMap(lambda x: x).collect()