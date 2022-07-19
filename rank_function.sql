
SELECT * FROM (
	SELECT
		product_id,
		product_name,
		brand_id,
		list_price,
		RANK () OVER ( 
			PARTITION BY brand_id
			ORDER BY list_price DESC
		) price_rank 
	FROM
		production.products
) t
WHERE price_rank <= 3;