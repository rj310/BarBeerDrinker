<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Bartender Beer Sales</title>
	</head>
	<body>
	<%@ include file="Header.jsp" %>
	<%String shift = request.getParameter("shift");
		session.setAttribute("shift", shift);
		String bartender = session.getAttribute("bartender").toString();%>
		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String nameofbeer = session.getAttribute("bartender").toString();
				
			
			String str = "select transactions.item,sum(transactions.quantity) as totalAmount from transactions , bills where transactions.bill_id = bills.bill_id and bills.bartender='"+ bartender +"' and transactions.type='beer' and bills.date='"+shift+"' group by transactions.item ";
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
		<div class="container">
		<table class="table table-striped">
		<thead class="thead-dark">
			<tr>
				<th style="text-align:center" scope="col">#</th>
				<th style="text-align:center" scope="col">Beer  </th>
				<th style="text-align:center" scope="col">Amount sold on <%= shift %></th>
			</tr>
		</thead>
		<tbody>
			<% int i=0;
			//parse out the results
			while (result.next()) { i++ ;%>
			<tr>
				<th style="text-align:center" scope="row"><%=i%></th>
				<td style="text-align:center"><%=result.getString("transactions.item") %></td>
				<td style="text-align:center"><%=result.getString("totalAmount") %></td>
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