<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Bartender Analytics Page</title>
	</head>
<body>
<%@ include file="Header.jsp" %>
	<% String barStats = session.getAttribute("bar").toString(); %>
	
		<div class="container">
			<div class="alert alert-info" role="alert">
				 You have selected bar <%=barStats %>
			</div>
		</div>
	<% String shift = request.getParameter("shift");
	    String[] shiftData=shift.split(" ");
		String day=shiftData[0];
		String shiftStart=shiftData[2];
		String shiftEnd = shiftData[4]; %>
		<div class="container">
			<div class="alert alert-info" role="alert">
				 You have selected shift <%=shift %>
			</div>
		</div>
	<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();				
			
			String str = "select bills.bartender, sum(transactions.quantity) as totalSales from  transactions, bills ,shifts where transactions.bill_id = bills.bill_id and shifts.bartender=bills.bartender and shifts.bar=bills.bar and shifts.bar='"+barStats+"' and shifts.day='"+day+"' and shifts.start='"+shiftStart+"' and shifts.end='"+shiftEnd+"' group by bills.bartender ;";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
		<div class="container">
		<table class="table table-striped">
		<thead class="thead-dark">
			<tr>
		    <th style="text-align:center" scope="col">#</th>
			<th style="text-align:center" scope="col">Bartender </th>
			<th style="text-align:center" scope="col">Total beers sales</th>
			</tr>
			</thead>
			<tbody>
			
			<% int i=0;
			//parse out the results
			while (result.next()) { i++ ;%>
			<tr>
				<th style="text-align:center" scope="row"><%=i%></th>
				<td style="text-align:center"><%=result.getString("bills.bartender") %></td>
				<td style="text-align:center"><%=result.getString("totalSales") %></td>
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