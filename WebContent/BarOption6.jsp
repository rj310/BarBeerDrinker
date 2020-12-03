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
   		
   		String query = "select (case when bills.date like '%-01-%' then 'Jan' when bills.date like '%-02-%' then 'Feb'"
   				+ " when bills.date like '%-03-%' then 'Mar' when bills.date like '%-04-%' then 'Apr'" 
  				 +" when bills.date like '%-05-%' then 'May' when bills.date like '%-06-%' then 'Jun'"
  				 +" when bills.date like '%-07-%' then 'Jul' when bills.date like '%-08-%' then 'Aug'"
  				 +" when bills.date like '%-09-%' then 'Sep' when bills.date like '%-10-%' then 'Oct'"
  				+"  when bills.date like '%-11-%' then 'Nov' when bills.date like '%-12-%' then 'Dec' end ) "
  				+" as month,sum(  case when bills.bar='"+nameofbar+"' then t.price else 0 end) as total from transactions t, bills where t.bill_id = bills.bill_id "
  				+"  group by month;";
   		
   		
   		
				
   		
   		
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   			map.put(result.getString("month"),result.getInt("total"));
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
        
        
        chartTitle="Sales by month";
        legend="Amount in $";
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
		<h2>Destribution of sales in <%= session.getAttribute("finalbarname").toString()%> per month.</h2>
		<div id="graphContainer" style="width: 500px; height: 400px; margin: 0 auto"></div>
		
</body>
</html>

