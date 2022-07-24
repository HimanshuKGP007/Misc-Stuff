select t.technology, count(t.trainee_id) as Trainee_count, AVG(t.CGPA) as AvgCGPA, count(p.projectid) as ProjectCount
from trainee t
LEFT JOIN projectdetails p USING(technology)
LEFT JOIN projectallocation pa USING (technology)
GROUP BY 1
ORDER BY 1;