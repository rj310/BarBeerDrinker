<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Drinker Page</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
	</head>
	<body>
	<%@ include file="Header.jsp" %>

<%String drinkername = request.getParameter("drinkname");
		session.setAttribute("finaldrinkername", drinkername);%>
		
		
		<div class="container">
		  <div class="jumbotron">
		 	 <h1>Drinker Page</h1>
			</div>
		</div>

		<%if(drinkername.length() == 0){ %>
			<div class="container">
				<div class="alert alert-danger" role="alert">
					  You did not select a drinker! Please press the button to return home
				</div>
				<a class="btn btn-primary" href="firstpage.jsp" role="button">Go back home!</a>
				</div>
				<br><br>
			<% } else{%>
				<div class="container">
				<div class="alert alert-info" role="alert">
					  You have selected drinker: <%=drinkername %>
					</div>
					</div>
			<% }%>
		
		
		<div class="container">
	<div class="list-group">
	  <a href="DrinkerOption1.jsp" class="list-group-item list-group-item-action">Click here to see all transactions for <%=session.getAttribute("finaldrinkername").toString()+"" %></a>  
	</div>
	</div>
	
	
		<br>
		<br>
		<div class="container">
		<h3>Show me a graph for:</h3>
		 <form method = "get" action = "DrinkerOption2.jsp">
		 	<div class="form-group">
			  <select name="graph" class="custom-select">
				<option value="FavoriteBeers">Favorite beers</option>
				<option value="SpendingInBars">Spending in bars</option>
				<option value="SpendingPerDayOfTheWeek">Spending Per Day Of The Week</option>
				<option value="SpendingPerMonth">Spending Per Month</option>
			</select>&nbsp;<br>
			<input type="hidden" id="drinkerName" name="drinkerName" value = <%=session.getAttribute("finaldrinkername").toString() %>> 
			</div><button type="submit" value="GO" class="btn btn-primary">Submit</button>
		</form> 
		</div>
	

		
</body>
</html>