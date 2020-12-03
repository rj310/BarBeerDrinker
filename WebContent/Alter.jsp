<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		<title>Alter Page</title>
	</head>
	<body>
	
	<%@ include file="Header.jsp" %>
	<div class="container">
		<div class="jumbotron">
		 	<h1>Alter Page</h1>
		</div>
	</div>

		<%String query = request.getParameter("alterstring");
		String[] words=query.split(" ");
		String action=words[0];
		%>
		<div class="container">
			<div class="alert alert-info" role="alert">
				  You have entered query: <%=query %>
			</div>
		</div>
		<br><br>
		<%String message; %>
		
		
		
		<% try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
		
			int rows = stmt.executeUpdate(query);
			if (rows>0) {
				message=action+" successful!";
				%>
				<div class="container">
					<div class="alert alert-info" role="alert">
				  	<%=message %>
					</div>
				</div>
				<br><br>
			<% } else {
				message="Failed to update. ";
				%>
				<div class="container">
					<div class="alert alert-danger" role="alert">
				  	<%=message %>
					</div>
				</div>
				<br><br>
			<% } %>
			
			<%  stmt.close();
				db.closeConnection(con);
			%>

			
			
		<%} catch(SQLIntegrityConstraintViolationException e) {
			message="Failed to "+action+":Foreign key constraint fails."; %>	
			<div class="container">
			<div class="alert alert-danger" role="alert">
			  	<%= message %>
				</div>
			</div>
			<br><br>
		<% } catch(SQLSyntaxErrorException e ) {
			message="The statement was not formatted properly. You need to start statement with 'Insert', 'Update' or 'Delete' keywords . Please refer to <a href ='https://www.tutsmake.com/mysql-insert-into-update-table-with-examples/' style='text-decoration: none;'>this </a> page for more info on how to format sql statements.";
			%>
			<div class="container">
				<div class="alert alert-danger" role="alert">
				  <%=message %>
				</div>
			</div>
			<br><br>
		<%  } catch(Exception e) {
			message="Some error occured when trying to conect to database. Please try again.";
		%>
		<div class="container">
				<div class="alert alert-danger" role="alert">
				  <%=message %>
				</div>
			</div>
			<br><br>
					
		<% }%>
		
		
		
</body>
</html>