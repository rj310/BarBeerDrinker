<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		<title>Top 10 Drinkers</title>
	</head>
	<body>
	<%@ include file="Header.jsp" %>
	

		
		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String nameofbar = session.getAttribute("finalbarname").toString();
			
			String str = "select drinker,round(sum(total_price),2) as cost from bills where bar = '"+nameofbar+
			"' group by drinker order by cost desc limit 10";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
		
		
		
		<div class="container">
		<table class="table table-striped">
		  <thead class="thead-dark">
		    <tr>
		    	<th style="text-align:center" scope="col">#</th>
		      <th style="text-align:center" scope="col">Drinker</th>
		      <th  style="text-align:center" scope="col">Money Spent at <%=nameofbar%></th>
		    </tr>
		  </thead>
		  <tbody>
			<% int i=0;
			//parse out the results
			while (result.next()) { i++ ;%>
			<tr>
				<th style="text-align:center" scope="row"><%=i%></th>
				<td style="text-align:center"><%=result.getString("drinker") %></td>
				<td style="text-align:center">$<%=result.getString("cost") %></td>
			</tr>
		<% }
			//close the connection.
			db.closeConnection(con);
			stmt.close();
			result.close();
			%>
		  </tbody>
		</table>
		</div>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>

</body>
</html>