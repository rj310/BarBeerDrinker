<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		<title>Bars Page</title>
	</head>
	
	<body>
	<%@ include file="Header.jsp" %>
		<%String barname = request.getParameter("barname");
		session.setAttribute("finalbarname", barname);%>


		
		<div class="container">
		  <div class="jumbotron">
		 	 <h1>Bar Page</h1>
			</div>
		</div>
		
		<%if(barname.length() == 0){ %>
			<div class="container">
				<div class="alert alert-danger" role="alert">
					  You did not select a bar! Please press the button to return home
				</div>
				<a class="btn btn-primary" href="firstpage.jsp" role="button">Go back home!</a>
				</div>
				<br><br>
			<% } else{%>
				<div class="container">
				<div class="alert alert-info" role="alert">
					  You have selected bar: <%=barname %>
					</div>
					</div>
			<% }%>
		
	<div class="container">
	<div class="list-group">
	  <a href="BarOption1.jsp" class="list-group-item list-group-item-action">Click Here to see top 10 Drinkers</a>
	  <a href="BarOption2.jsp" class="list-group-item list-group-item-action">Click Here to see top 10 beers sold</a>
	  <a href="BarOption3.jsp" class="list-group-item list-group-item-action">Click Here to see top Manufacturers sold</a>
	  <a href="BarOption4.jsp" class="list-group-item list-group-item-action">Click Here to see Busiest time periods</a>
	  <a href="BarOption5.jsp" class="list-group-item list-group-item-action">Distribution of sales per day of the week</a>
	  <a href="BarOption6.jsp" class="list-group-item list-group-item-action">Distribution of sales per month</a>
	  <a href="BarOption7.jsp" class="list-group-item list-group-item-action">Distribution of sales per time of the day</a>
	</div>	
	</div>
		
		
		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt1 = con.createStatement();
			Statement stmt2 = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("bartenderBar");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str1 = "SELECT distinct name as beername FROM beer";
			String str2 = "SELECT distinct name as dayname from day";
			//Run the query against the database.
			ResultSet result1 = stmt1.executeQuery(str1);
			ResultSet result2 = stmt2.executeQuery(str2);
			%>
		<br>
		
		<br>
	
		<div class="container">
		<h3>Bar analytics</h3>
		 <form method = "get" action = "BarAnalytics.jsp">
			  <select class="custom-select" name = "beer" id="beer">
			  <option selected>Choose a beer name</option>
			  <%while (result1.next()) { %>				
				<%String beername = result1.getString("beername");%>
				<option value = '<%= beername %>'><%=beername%></option>
			<% } %>
			</select>

			<select class = "custom-select" name="day" id="day">
			<option selected>Choose a day</option>
			<%while (result2.next()) { %>				
				<%String dayname = result2.getString("dayname");%>
				<option value = '<%=dayname %>'><%=dayname%></option>
			<% } %>	
			<% db.closeConnection(con);
			stmt1.close();
			result1.close();
			stmt2.close();
			result2.close();%>
			</select>
			
			
			<br><button type="submit" class="btn btn-primary">Submit</button>
		</form> 
		</div>
			 
			
			
		<%} catch (Exception e) {
			out.print(e);
		}%>


	</body>
</html>