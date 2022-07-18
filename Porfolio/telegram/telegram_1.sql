select a.name as Name, a.species as Species, a.primary_color as Primary_Color, a.breed as Breed, count(b.vaccination_time) as Number_Of_Vaccines
from TBL_Animals a
LEFT JOIN TBL_Vaccinations v USING (Name)
GROUP BY 1
ORDER BY 1;