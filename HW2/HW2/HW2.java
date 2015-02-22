package database;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;


public class HW2 {
	
	static Connection conn;  
    static Statement st; 
    //static String arg[] = {"window", "student", "100", "100", "300", "300"};
    
	public static Connection getConnection() {  
        
		Connection con = null;  
		
		try {  
            Class.forName("com.mysql.jdbc.Driver");
            con = (Connection) DriverManager.getConnection(  
                    "jdbc:mysql://localhost:3306/585_HW2", "root", "");
            //System.out.println("Successfully!");
              
        } catch (Exception e) {  
            System.out.println("Failed" + e.getMessage());  
        }  
        return con; 
    }  
	
	
	public static void main(String [] args) {
		
		conn = getConnection();
		
		try {  
			
			String sql = null;
			int num1 = 0, num2 = 0, num3 = 0, num4 = 0;
			
			/*--------------------Query1:window--------------------*/
			
			if(args[0].equals("window")) {
				
				if(args[1].equals("building")) {
					//System.out.println(arg[0]);
					num1 = Integer.parseInt(args[2]);
					num2 = Integer.parseInt(args[3]);
					num3 = Integer.parseInt(args[4]);
					num4 = Integer.parseInt(args[5]);
					sql = "SELECT b_id "
							+ "FROM building "
							+ "WHERE st_contains (GeomFromText('Polygon((" + num1 + " " + num2 + "," + num3 + " " + num2 + ","+ num3 + " " + num4 + "," + num1 + " " + num4 + "," + num1 + " " + num2 + "))'), b_location)";
					System.out.println(sql);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs1 = st.executeQuery(sql);
					while(rs1.next()) {
						String b_id_1 = rs1.getString("b_id");
						System.out.println("ID:" + b_id_1 +"\n");
					}
					rs1.close();
				}
				
				if(args[1].equals("student")) {
					
					num1 = Integer.parseInt(args[2]);
					num2 = Integer.parseInt(args[3]);
					num3 = Integer.parseInt(args[4]);
					num4 = Integer.parseInt(args[5]);
					sql = "SELECT s_id "
							+ "FROM student "
							+ "WHERE st_contains (GeomFromText('Polygon((" + num1 + " " + num2 + "," + num3 + " " + num2 + ","+ num3 + " " + num4 + "," + num1 + " " + num4 + "," + num1 + " " + num2 + "))'), s_location)";
					//System.out.println(sql);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs2 = st.executeQuery(sql);
					while(rs2.next()) {
						String s_id_1 = rs2.getString("s_id");
						System.out.println("ID:" + s_id_1 +"\n");
					}
					rs2.close();
				}
				
				if(args[1].equals("tramstop")) {
					
					num1 = Integer.parseInt(args[2]);
					num2 = Integer.parseInt(args[3]);
					num3 = Integer.parseInt(args[4]);
					num4 = Integer.parseInt(args[5]);
					sql = "SELECT t_id "
							+ "FROM tramstop "
							+ "WHERE st_contains (GeomFromText('Polygon((" + num1 + " " + num2 + "," + num3 + " " + num2 + ","+ num3 + " " + num4 + "," + num1 + " " + num4 + "," + num1 + " " + num2 + "))'), t_location)";
					System.out.println(sql);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs3 = st.executeQuery(sql);
					while(rs3.next()) {
						String t_id_1 = rs3.getString("t_id");
						System.out.println("ID:" + t_id_1 +"\n");
					}
					rs3.close();
				}
			}
			
			/*--------------------Query2:within--------------------*/
			
			if(args[0].equals("within")) {
				
				String stu = args[1];
				num1 = Integer.parseInt(args[2]);
				
				sql =   "SELECT b_id AS id "
						+ "FROM  building, student "
						+ "WHERE s_id = '"+stu+"' AND ST_Distance(b_location, GeomFromText(AsText(s_location))) <" + num1
						
						+ " UNION "
						
						+ "SELECT t_id "
						+ "FROM  tramstop, student "
						+ "WHERE s_id = '"+stu+"' AND ST_Distance(t_location, GeomFromText(AsText(s_location))) <" + num1+";";

				//System.out.println(sql);
				st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
				ResultSet rs4 = st.executeQuery(sql);
				while(rs4.next()) {
					String id_1 = rs4.getString("id");
					System.out.println("ID:" + id_1 +"\n");
				}
				rs4.close();
			}	
	
			
			/*--------------------Query3:nearest-neighbor--------------------*/	
			
			if(args[0].equals("nearest-neighbor")) {
				
				num1 = Integer.parseInt(args[3]);
				String bn = args[2];
				
				if(args[1].equals("building")) {
					
					sql = "SELECT b_id "
							+ "FROM building "
							+ "ORDER BY ST_DISTANCE((SELECT b_location FROM building WHERE b_id = '"+bn+"' ), b_location) ASC "
							+ "LIMIT 1, "+num1;
					
					// Another case: if given objects are building, nearest objects are student and tramstop.
					/* sql = "SELECT * FROM ( "
							+ "SELECT s_id AS id, ST_DISTANCE(s_location, b_location) AS dis "
							+ "FROM building, student "
							+ "WHERE b_id = '"+ bn +"'"
							
							+ " UNION "
							
							+ "SELECT t_id AS id, ST_DISTANCE(t_location, b_location) AS dis "
							+ "FROM building, tramstop "
							+ "WHERE b_id = '"+ bn +"') a  "
							+ "ORDER BY dis ASC "
							+ "LIMIT "+ num1 + ";";
					*/
					//System.out.println(sql);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs5 = st.executeQuery(sql);
					while(rs5.next()) {
						String q3_1 = rs5.getString("b_id");
						System.out.println("Nearest objects ID:" + q3_1 +"\n");
					}
					rs5.close();	
				}
				
				if(args[1].equals("student")) {
					
					sql = "SELECT s_id "
							+ "FROM student "
							+ "ORDER BY ST_DISTANCE((SELECT s_location FROM student WHERE s_id = '"+bn+"' ), s_location) ASC "
							+ "LIMIT 1,"+num1;
					//System.out.println(sql);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs5 = st.executeQuery(sql);
					while(rs5.next()) {
						String q3_2 = rs5.getString("s_id");
						System.out.println("Nearest objects ID:" + q3_2 +"\n");
					}
					rs5.close();		
				}
				
				if(args[1].equals("tramstop")) {
					
					sql = "SELECT t_id "
							+ "FROM tramstop "
							+ "ORDER BY ST_DISTANCE((SELECT t_location FROM tramstop WHERE t_id = '"+bn+"' ), t_location) ASC "
							+ "LIMIT 1,"+num1;
					//System.out.println(sql);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs5 = st.executeQuery(sql);
					while(rs5.next()) {
						String q3_3 = rs5.getString("t_id");
						System.out.println("Nearest objects ID:" + q3_3 +"\n");
					}
					rs5.close();	
				}
			}
			
			/*-----------------------Query4:fixed----------------------------*/	
			
			if(args[0].equals("fixed")) {
				
				if(args[1].equals("1")) { //fixed, query1
					
					sql = "SELECT b_id FROM building WHERE st_contains("
							+ "(SELECT st_intersects "
							+ "(GeomFromText(\"SELECT buffer(t_location, t_radius) FROM tramstop WHERE t_id = 't2ohe'\"), "
							+ "GeomFromText(\"SELECT buffer(t_location, t_radius) FROM tramstop WHERE t_id = 't6ssl'\"))), "
							+ "b_location) "
							+ " UNION "
							+ "SELECT s_id FROM student WHERE st_contains("
							+ "(SELECT st_intersects "
							+ "(GeomFromText(\"SELECT buffer(t_location, t_radius) FROM tramstop WHERE t_id = 't2ohe'\"), "
							+ "GeomFromText(\"SELECT buffer(t_location, t_radius) FROM tramstop WHERE t_id = 't6ssl'\"))), "
							+ "s_location)";
					
				//	System.out.println(sql);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs6 = st.executeQuery(sql);
					while(rs6.next()) {
						String q4_1 = rs6.getString("b_id");
						System.out.println("IDs of all the students and buildings cover by tram stops:" + q4_1 +"\n");
					}
					rs6.close();	
				}
				
				if(args[1].equals("2")) { //fixed, query 2
					
					for(int i = 0; i < 80; i++) {
						String sid = "p" + i;
						//System.out.println(sid);
						sql = "SELECT t_id, s_id "
								+ "FROM tramstop, student WHERE s_id = " + "'"+ sid+"'"
								+ " ORDER BY ST_DISTANCE((SELECT t_location FROM tramstop WHERE t_id = 't1psa' ), (SELECT s_location FROM student WHERE s_id = 'p3')) "
								+ "LIMIT 2;";
						
						//System.out.println(sql);
						st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
						ResultSet rs7 = st.executeQuery(sql);
						while(rs7.next()) {
							String q4_2 = rs7.getString("t_id");
							System.out.println("one of the 2 nearest tramstops of the student whoes id is "+ sid+ ": " + q4_2 +"\n");
						}
						rs7.close();	
					}
				}
				
				if(args[1].equals("3")) { //fixed, query 3
					
					sql = "SELECT t_id, count(*) AS num "
							+ "FROM tramstop, student "
							+ "WHERE ST_DISTANCE(t_location, s_location) < 250 "
							+ "GROUP BY t_id "
							+ "ORDER BY count(*) DESC "
							+ "LIMIT 1;";
					
					//System.out.println(sql);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs8 = st.executeQuery(sql);
					while(rs8.next()) {
						String q4_3 = rs8.getString("t_id");
						System.out.println(" ID’s of the tram stop that cover the most buildings: "+ q4_3 +"\n");
						//String q4_32 = rs8.getString("num");
						//System.out.println("covered tramstop number:" + q4_32 +"\n");
					}
					rs8.close();	
				}
				
				if(args[1].equals("4")) { //fixed, query 4
					
					String sqll = null; 
					for(int i = 0; i < 36; i++){
						String f4 = "b" + i;
						sql = "(SELECT s_id, s_location, b_id, b_location, st_distance(s_location, b_location) "
								+ "FROM student, building "
								+ "WHERE B_ID = " + "'" + f4 + "'"
								+ " ORDER BY st_distance(s_location, b_location) ASC "
								+ "limit 1)";
						if(sqll == null) sqll = sql;
						else sqll = sqll + " UNION " + sql; 
					}
					String sqlll = "SELECT s_id, count(s_id) FROM (" + sqll +") a GROUP BY s_id ORDER BY count(s_id) DESC LIMIT 5; ";
					//System.out.println(sqlll);
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs9 = st.executeQuery(sqlll);
					while(rs9.next()) {
						String q4_4 = rs9.getString("s_id");
						System.out.println("The ID of the student: "+ q4_4 +"\n");
						String q4_42 = rs9.getString("count(s_id)");
						System.out.println("The num of the nearest buildings: "+ q4_42 +"\n");
					}
					rs9.close();		
				}
				
				if(args[1].equals("5")) { //fixed, query 5
					
				/*
					sql = "SELECT b_id, b_name, AsTeXT(b_location) FROM building WHERE b_name LIKE 'SS%';";
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs10 = st.executeQuery(sql);
					
					int j = 0; 
					String temp[] = new String[100]; // initail the array with a large size.
					while(rs10.next()) {
						temp[j] = rs10.getString("AsTeXT(b_location)");
						//System.out.println(temp[j]+"\n");
						j++;
					}
					
					String l = null;
					for(int i = 0; i<j; i++){
						if(l == null) l = temp[i];
						else l = l +", " + temp[i];
					}
					//System.out.println(l);
					String sq = "ExteriorRing(Envelope(ST_Union("+l+")))";
					//System.out.println(sq);
					sql="SELECT AsText(PointN("+sq+",1)) as lowerleft, AsText(PointN("+sq+",3)) as uppperright;";
					//System.out.println(sql);
					
					rs10.close();
				*/
					sql = "(SELECT min(astext(POINTN(EXTERIORRING(envelope(b_location)),1))) AS p "
							+ "FROM building "
							+ "WHERE b_name LIKE 'SS%' "
							+ "ORDER BY b_id) "
							
							+ " UNION "
							
							+ "(SELECT max(astext(POINTN(EXTERIORRING(envelope(b_location)),3))) AS p "
							+ "FROM building "
							+ "WHERE b_name LIKE 'SS%' "
							+ "ORDER BY b_id)";
					
					st = (Statement) conn.createStatement(); //create the Statement object which implement sql.
					ResultSet rs10 = st.executeQuery(sql);
					while(rs10.next()) {
						String q4_5 = rs10.getString("p");
						System.out.println("The left lower point and right upper points are: "+ q4_5 +"\n");
					}
					rs10.close();
					
				}
				
			}
		
			conn.close();   //close connection 
			
        } catch (SQLException e) {  
            System.out.println("Failed" + e);  
        }  
		
	}
	
}
