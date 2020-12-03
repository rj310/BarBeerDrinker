<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		
		<style>
			.button {
			  border: none;
			  color: white;
			  width: 350px;
			  padding-top: 25px;
			  padding-bottom: 25px;"
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 16px;
			  margin: 4px 2px;
			  transition-duration: 0.4s;
			  cursor: pointer;
			}
			
			.button1 {
			  background-color: white; 
			  color: black; 
			  border: 2px solid #4CAF50;
			}
			
			.button1:hover {
			  background-color: #4CAF50;
			  color: white;
			}
			
			.button2 {
			  background-color: white; 
			  color: black; 
			  border: 2px solid #008CBA;
			}
			
			.button2:hover {
			  background-color: #008CBA;
			  color: white;
			}
		</style>
		<title>Bartender Page</title>
	</head>
	<body>
	<%@ include file="Header.jsp" %>
<script type="text/javascript">
			function myFunction() {
				var x = document.getElementById("myDIV");
				var y = document.getElementById("togButton");
				/*var z = document.getElementById("intro");
				var i=document.getElementById("intro2");*/
				var j = document.getElementById("togButton2");
				  if (x.style.display === "none") {
				    x.style.display = "block";
				    y.style.display="none";
				    /*z.style.display="none";
				    i.style.display="none";*/
				    j.style.display="none";
				  } else {
				    x.style.display = "none";
				 }
			}
			
			function myFunction2() {
				var x = document.getElementById("myDIV2");
				var y = document.getElementById("togButton");
				/*var z = document.getElementById("intro");*/
				/*var i=document.getElementById("intro2");*/
				var j = document.getElementById("togButton2");
				  if (x.style.display === "none") {
				    x.style.display = "block";
				    y.style.display="none";
				    /*z.style.display="none";*/
				    /*i.style.display="none";*/
				    j.style.display="none";
				  } else {
				    x.style.display = "none";
				 }
			}
</script>
<%String bartender = request.getParameter("bartender");
		session.setAttribute("bartender", bartender);
		String bar = request.getParameter("bar");
		session.setAttribute("bar",bar);
		ApplicationDB db0 = new ApplicationDB();	
		Connection con0 = db0.getConnection();		
		//Create a SQL statement
		Statement stmt0 = con0.createStatement();
		
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String str0= "select distinct shifts.bar from shifts where shifts.bartender='"+bartender+"'";
		//Run the query against the database.
		ResultSet result0 = stmt0.executeQuery(str0);	
		
		if (result0.next()) {
			String correctBar= result0.getString("shifts.bar");
			
			
			/*<div class="container">
			<div class="list-group">
			  <a href="BarOption1.jsp" class="list-group-item list-group-item-action">Click Here to see top 10 Drinkers</a>
			  <a href="BarOption2.jsp" class="list-group-item list-group-item-action">Click Here to see top 10 beers sold</a>
			  <a href="BarOption3.jsp" class="list-group-item list-group-item-action">Click Here to see top Manufacturers sold</a>
			  <a href="BarOption4.jsp" class="list-group-item list-group-item-action">Click Here to see Busiest time periods</a>
			  <a href="BarOption5.jsp" class="list-group-item list-group-item-action">Distribution of sales per day of the week</a>
			  <a href="BarOption6.jsp" class="list-group-item list-group-item-action">Distribution of sales per month</a>
			  <a href="BarOption7.jsp" class="list-group-item list-group-item-action">Distribution of sales per time of the day</a>
			</div>	
			</div>*/
			
			  /*out.println("<h2 id='intro'>"+bartender+"works at "+ correctBar+". Do you want to chose it to see shifts?</h2>"); */
			out.println("<div class='container'>");
			out.println("<div class='list-group'>");
			  out.println("<button class='list-group-item list-group-item-action' onclick='myFunction()' id='togButton'>SEE "+bartender+"'s shifts</button>");
			/* out.println("<h2 id='intro2'>OR,do you want to see bartenders analytics for bar "+bar+"?</h2>"); */
			out.println("<button class='list-group-item list-group-item-action' onclick='myFunction2()' id='togButton2'>See "+bar+"'s Analytics</button>");
			out.println("</div'>");
			out.println("</div'>");
					session.setAttribute("correctBar",correctBar);
		}
			
%>
		
		
<!--  choose a shift-->

<% try {	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str= "select shifts.date,shifts.start,shifts.end from shifts where  shifts.bartender='"+bartender+"' and shifts.bar='"+session.getAttribute("correctBar").toString()+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);			
		%>
		<br>
		
		
		
	
		<div class="container" id="myDIV" style="display:none">
			<h2>Choose a shift for <%=bartender %> to see the sales of beers</h2>
			<form method = "get" action = "BartenderSales.jsp">
				<div class="form-group">
				<select class="custom-select" name = "shift" size=1>
				<%while (result.next()) { %>				
					<%String shift = result.getString("date");%>
					<option value = '<%=shift %>'><%=shift%></option>
				<% }
				//close the connection.
				db.closeConnection(con);
				%>
				</select><br></div><button type = "submit" value = "submit" class="btn btn-primary">Submit</button>
				</form>
			<br>
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
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str= "select distinct shifts.day,shifts.start,shifts.end from shifts where shifts.bar='"+session.getAttribute("bar").toString()+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);			
		%>
		<br>
		<div class="container" id="myDIV2" style="display:none">
			<h2>Choose a shift </h2>
			<form method = "get" action = "BartenderAnalytics.jsp">
				<div class="form-group">
				<select class="custom-select" name = "shift" size=1>
				<%while (result.next()) { %>				
					<%String shift = result.getString("shifts.day")+" from "+result.getString("shifts.start") +" to "+result.getString("shifts.end");%>
					<option value = '<%=shift %>'><%=shift%></option>
				<% }
				//close the connection.
				db.closeConnection(con);
				stmt.close();
				result.close();
				%>
				</select><br>
				 <input type="hidden" id="barStats" name="barStats" value=<%=session.getAttribute("bar").toString() %>>
				</div><button type = "submit" value = "submit" class="btn btn-primary">Submit</button>
				
				</form>
			<br>
		</div>			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		


</body>
</html>