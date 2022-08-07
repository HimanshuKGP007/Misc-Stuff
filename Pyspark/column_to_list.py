print(dataframe.select('student Name').
      rdd.flatMap(lambda x: x).collect()


pd.set_option('display.max_columns', None)