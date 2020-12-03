<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<% 
	StringBuilder myData=new StringBuilder();
	String strData ="";
    String chartTitle="";
    String legend="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list = new ArrayList();
   		Map<String,Integer> map = null;
   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		
   		String nameofbar = session.getAttribute("finalbarname").toString();
   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		
   		String query="select '8 to 9' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '08:00'and b.time < '09:00' and bar = '"+nameofbar+"'"
				+" union "+"select '9am to 10am' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '9:00'and b.time < '10:00' and bar = '"+nameofbar+"'"
				+" union "+"select '10am to 11am' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '10:00'and b.time < '11:00' and bar = '"+nameofbar+"'"
				+" union "+"select '11am to 12pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '11:00'and b.time < '12:00' and bar = '"+nameofbar+"'"
				+" union "+"select '12pm to 13am' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '12:00'and b.time < '13:00' and bar = '"+nameofbar+"'"
				+" union "+"select '13pm to 14pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '13:00'and b.time < '14:00' and bar = '"+nameofbar+"'"
				+" union "+"select '14pm to 15pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '14:00'and b.time < '15:00' and bar = '"+nameofbar+"'"
				+" union "+"select '15pm to 16am' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '15:00'and b.time < '16:45' and bar = '"+nameofbar+"'"
				+" union "+"select '16pm to 17pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '16:00'and b.time < '17:00' and bar = '"+nameofbar+"'"
				+" union "+"select '17pm to 18pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '17:00'and b.time < '18:00' and bar = '"+nameofbar+"'"
				+" union "+"select '18pm to 19pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '18:00'and b.time < '19:00' and bar = '"+nameofbar+"'"
				+" union "+"select '19pm to 20pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '19:00'and b.time < '20:00' and bar = '"+nameofbar+"'"
				+" union "+"select '20pm to 21pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '20:00'and b.time < '21:00' and bar = '"+nameofbar+"'"
				+" union "+"select '21pm to 22pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '21:00'and b.time < '22:00' and bar = '"+nameofbar+"'"
				+" union "+"select '22pm to 23pm' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '22:00'and b.time < '23:00' and bar = '"+nameofbar+"'"
				+" union "+"select '23pm to 12am' as time,count(distinct t.bill_id) as billcount from transactions t, bills b where t.bill_id = b.bill_id and b.time > '23:00'and b.time < '23:59' and bar = '"+nameofbar+"'"
														
				;
   		
   		
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   			map.put(result.getString("time"),result.getInt("billcount"));
   			list.add(map);
   	    } 
   	    result.close();
   	    
        for(Map<String,Integer> hashmap : list){
        		Iterator it = hashmap.entrySet().iterator();
            	while (it.hasNext()) { 
           		Map.Entry pair = (Map.Entry)it.next();
           		String key = pair.getKey().toString().replaceAll("'", "");
           		myData.append("['"+ key +"',"+ pair.getValue() +"],");
           	}
        }
        strData = myData.substring(0, myData.length()-1); //remove the last comma
        
        
        chartTitle="Transactions per time of the day";
        legend="transactions";
	}catch(SQLException e){
    		out.println(e);
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Busiest Times</title>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data = [<%=strData%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title = '<%=chartTitle%>'; 
			var legend = '<%=legend%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat = [];
			data.forEach(function(item) {
			  cat.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart = Highcharts.chart('graphContainer', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend,
			        data: data
			    }]
			});
			});
		
		</script>
	
		
	</head>
	<body>
		<%@ include file="Header.jsp" %>
		<h2>Times of the day with most transactions in <%=session.getAttribute("finalbarname").toString() %></h2>
		<div id="graphContainer" style="width: 500px; height: 400px; margin: 0 auto"></div>
		
</body>
</html>