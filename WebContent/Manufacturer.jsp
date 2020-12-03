<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		<title>Manufacturer Page</title>
	</head>
	<body>
	<%@ include file="Header.jsp" %>
	
		<%String manfname = request.getParameter("manfname");
		session.setAttribute("finalmanfname", manfname);%>
		
		<div class="container">
		  <div class="jumbotron">
		 	 <h1>Manufacturer Page</h1>
			</div>
		</div>

		<%if(manfname.length() == 0){ %>
			<div class="container">
				<div class="alert alert-danger" role="alert">
					  You did not select a manufacturer! Please press the button to return home
				</div>
				<a class="btn btn-primary" href="firstpage.jsp" role="button">Go back home!</a>
				</div>
				<br><br>
			<% } else{%>
				<div class="container">
				<div class="alert alert-info" role="alert">
					  You have selected manufacturer: <%=manfname %>
					</div>
					</div>
			<% }%>

		
	<div class="container">
	<div class="list-group">
	  <a href="ManfOption1.jsp" class="list-group-item list-group-item-action">Click Here to see top 10 States where <%=manfname %> is sold</a>
	  <a href="ManfOption2.jsp" class="list-group-item list-group-item-action">Click Here to see top 10 States where <%=manfname%>'s top drinkers live</a>
	  
	</div>
	</div>
		

	</body>
</html>