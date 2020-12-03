<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<title>BarBeerDrinker Project</title>
</head>
<body>
		<%@ include file="Header.jsp" %>
		<div class="container">
		  <div class="jumbotron">
		 	 <h1>Welcome to the BarBeerDrinker Home page!</h1>
			</div>
		</div>

	
			
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM bar";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
		%>
	
		
		<div class="container" id = "bardropper">
		<h3>Bar Page</h3>
		 <form method = "get" action = "Bars.jsp">
		 <div class="form-group">
			  <select class="custom-select" name = "barname" id = "bardrop">
			  <option value = "" selected>Choose a bar name</option>
			    <%while (result.next()) { %>				
				<%String barname = result.getString("name");%>
				<option value = '<%=barname %>'><%=barname%></option>
			<% }
			//close the connection.
			db.closeConnection(con);
			stmt.close();
			result.close();
			%>
			</select><br></div><button type="submit" class="btn btn-primary">Submit</button>
		</form> 
		</div>
		

		
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		
		<!-- Choosing a beer: -->
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM beer";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);			
		%>
		<br>
		<br>
		<div class="container">
		<h3>Beer Page</h3>
		 <form method = "get" action = "Beers.jsp">
		 <div class="form-group">
			  <select class="custom-select" name = "beername">
			  <option value="" selected>Choose a beer name</option>
			  <%while (result.next()) { %>				
				<%String beername = result.getString("name");%>
				<option value = '<%=beername %>'><%=beername%></option>
			<% }
			//close the connection.
			db.closeConnection(con);
			stmt.close();
			result.close();
			%>
			</select><br></div><button type="submit" class="btn btn-primary">Submit</button>
		
		</form> 
		</div>
		
		
		
		
		
		
						
		<%} catch (Exception e) {
			out.print(e);
		}%>
		<!-- choosing Bartender and a bar: -->
		
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
			String str1 = "SELECT * FROM bartender";
			String str2 = "SELECT * from bar";
			//Run the query against the database.
			ResultSet result1 = stmt1.executeQuery(str1);
			ResultSet result2 = stmt2.executeQuery(str2);
			%>
		<br>
		
		<br>
	
		<div class="container">
		<h3>Bartender Page</h3>
		 <form method = "get" action = "Bartender.jsp">
		 <div class="form-group">
			  <select class="custom-select" name = "bartender" id="bartender">
			  <option selected>Choose a bartender name</option>
			  <%while (result1.next()) { %>				
				<%String bartender = result1.getString("name");%>
				<option value = '<%= bartender %>'><%=bartender%></option>
			<% } %>
			</select>

			<select class = "custom-select" name="bar" id="bar">
			<option selected>Choose a bar name</option>
			<%while (result2.next()) { %>				
				<%String bar = result2.getString("name");%>
				<option value = '<%=bar %>'><%=bar%></option>
			<% } %>	
			<% db.closeConnection(con);
			stmt1.close();
			result1.close();
			stmt2.close();
			result2.close();%>
			</select>
			
			
			<br></div><button type="submit" class="btn btn-primary">Submit</button>
		</form> 
		</div>
			 
			
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		
		
		
		
		
		
		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT distinct manf FROM beer";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
		%>
		
		
		<br>
		<br>
		<div class="container">
		<h3>Manufacturer Page</h3>
		 <form method = "get" action = "Manufacturer.jsp">
		 <div class="form-group">
			  <select class="custom-select" name = "manfname">
			  <option value="" selected>Choose a manufacturer name</option>
			  <%while (result.next()) { %>				
				<%String manfname = result.getString("manf");%>
				<option value = '<%=manfname %>'><%=manfname%></option>
			<% }
			//close the connection.
			db.closeConnection(con);
			stmt.close();
			result.close();
			
			%>
			</select><br></div><button type="submit" class="btn btn-primary">Submit</button>
		</form> 
		</div>
			
		
			
		<%} catch (Exception e) {
			out.print(e);
		}%>


		
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT name FROM drinker";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
		%>
		
		
		<br>
		<br>
		<div class="container">
		<h3>Drinker Page</h3>
		 <form method = "get" action = "Drinker.jsp">
		 	<div class="form-group">
			  <select class="custom-select" name = "drinkname">
			  <option value="" selected>Choose a drinker name</option>
			  <%while (result.next()) { %>				
				<%String drinkname = result.getString("name");%>
				<option value = '<%=drinkname %>'><%=drinkname%></option>
			<% }
			//close the connection.
			db.closeConnection(con);
			stmt.close();
			result.close();
			%>
			</select><br> </div><button type="submit" class="btn btn-primary">Submit</button>
		</form> 
		</div>
			
		
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		
		<br><br>
		<div class="container">
			<form method="get" action="Alter.jsp">
			  <div class="form-group">
			    <h2>Alter a table</h2>
			    <input type="text" class="form-control" name="alterstring" placeholder="Enter query">
			  </div>
			  <button type="submit" class="btn btn-primary">Submit</button>
			</form>
				
		</div>
		
		
		

</body>
</html>