<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>All transactions</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
	</head>
	<body>
	<%@ include file="Header.jsp" %>
		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String nameofdrinker = session.getAttribute("finaldrinkername").toString();
			

			
			
			String str = "select b.bill_id,drinker,bar,time,t.item, t.quantity,t.type,t.price from bills b, transactions t where drinker = '"+nameofdrinker+"' and b.bill_id = t.bill_id group by bill_id,bar,time,t.quantity,t.item,t.type,t.price order by bar,time;";
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
		
		<div class="container">
		<table class="table table-striped">
		  <thead class="thead-dark">
		    <tr>
		      <th style="text-align:center" scope="col">Bill ID</th>
		      <th  style="text-align:center" scope="col">Bar</th>
		      <th  style="text-align:center" scope="col">Time</th>
		      <th  style="text-align:center" scope="col">Item</th>
		      <th  style="text-align:center" scope="col">Quantity</th>
		      <th  style="text-align:center" scope="col">Type</th>
		      <th  style="text-align:center" scope="col">Price</th>
		    </tr>
		  </thead>
		  <tbody>
			<% 
			//parse out the results
			while (result.next()) { %>
			<tr>
				<td style="text-align:center"><%=result.getString("bill_id") %></td>
				<td style="text-align:center"><%=result.getString("bar") %></td>
				<td style="text-align:center"><%=result.getString("time") %></td>
				<td style="text-align:center"><%=result.getString("item") %></td>
				<td style="text-align:center"><%=result.getString("quantity") %></td>
				<td style="text-align:center"><%=result.getString("type") %></td>
				<td style="text-align:center">$<%=result.getString("price") %></td>
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