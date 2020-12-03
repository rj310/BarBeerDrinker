<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		
		<title>Beers Page</title>
	</head>
	<body>
	<%@ include file="Header.jsp" %>
	
		<%String beername = request.getParameter("beername");
		session.setAttribute("finalbeername", beername);%>
				<div class="container">
		  <div class="jumbotron">
		 	 <h1>Beer Page</h1>
			</div>
		</div>
		
		<%if(beername.length() == 0){ %>
			<div class="container">
				<div class="alert alert-danger" role="alert">
					  You did not select a beer! Please press the button to return home
				</div>
				<a class="btn btn-primary" href="firstpage.jsp" role="button">Go back home!</a>
				</div>
				<br><br>
			<% } else{%>
				<div class="container">
				<div class="alert alert-info" role="alert">
					  You have selected beer: <%=beername %>
					</div>
					</div>
			<% }%>
		
	<div class="container">
	<div class="list-group">
	  <a href="BeerOption1.jsp" class="list-group-item list-group-item-action">Click Here to see top 5 bars that sell <%=session.getAttribute("finalbeername").toString()+"" %></a>
	  <a href="BeerOption2.jsp" class="list-group-item list-group-item-action">Click Here to see biggest consumers of <%=session.getAttribute("finalbeername").toString()+"" %></a>
	  <a href="BeerOption3.jsp" class="list-group-item list-group-item-action">Click Here to see when <%=session.getAttribute("finalbeername").toString()+"" %> sells the most</a>
	</div>	
	</div>
		
		
</body>
</html>