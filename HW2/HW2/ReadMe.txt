
/*-------------------------------------Files:--------------------------------------------*/

Two createdb.sql (One is automatically created by exporting tables, and the other one is programed.)
dropdb.sql, HW2.java, mysql-connector-java-5.1.34-bin.jar, ReadMe.txt


/*--------------------------------------Run:---------------------------------------------*/

 Compile and run as the commmand of HW2.


/*-------------------------------------Assumption:---------------------------------------*/

1. window case: my query doesn't cover the point on the boundry, using st_contains() function. If you want to cover 
   the boundry, use function contains().
   contains(g1, g2)  uses MBR only (not exact!)
	st_contains(g1, g2) uses exact shapes
2. Nearest-neighbour case: Only find the same type of objects. For example, if the given object is building b3, 
   you should only find serveral nearest buildings.
3. Nearest-neighbour case: Finding the nearest buildings of a specific building(for example: b3) doesn't consider itself(b3).
4. Fixed 4 case: I checked the result of Oracle, it's a little different. Using Oracle, the output includes the p66, because sdo_nn in Oracle considers the distance beginning from the center. But in MySQL, it considers the distance to the nearest edge. 


/*-------------------------------------Reference:-----------------------------------------*/

1. Using the new spatial functions in MySQL 5.6 for geo-enabled applications 
   http://www.percona.com/blog/2013/10/21/using-the-new-spatial-functions-in-mysql-5-6-for-geo-enabled-applications/
2. How to connect JDBC with MYSQL
   http://blog.csdn.net/cxwen78/article/details/6863696/