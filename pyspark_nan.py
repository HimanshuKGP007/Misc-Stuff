# Find Count of Null, None, NaN of All DataFrame Columns
from pyspark.sql.functions import col,isnan, when, count
df.select([count(when(isnan(c) | col(c).isNull(), c)).alias(c) for c in df.columns]).show()

=INDEX($B$3:$B$12, SMALL(IF(COUNTIF($D$3:$D$12, $B$3:$B$12), MATCH(ROW($B$3:$B$12),ROW($B$3:$B$12)), ""), ROWS($A$1:A1)))