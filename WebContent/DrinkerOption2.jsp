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
   		String nameofdrinker = session.getAttribute("finaldrinkername").toString();
   		out.println("<h2>Showing graph for "+nameofdrinker+".</h2>");
   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		
   		String graphType = request.getParameter("graph");   
   		//Make a query
   		String query = "" ;
   		if(graphType.equalsIgnoreCase("favoriteBeers")){
   	   		query = "select transactions.item ,sum(transactions.quantity) as totalPurchased from bills, transactions where transactions.bill_id = bills.bill_id and bills.drinker='"+nameofdrinker+"' and transactions.type='beer' group by transactions.item order by totalPurchased desc";
   		} else if(graphType.equalsIgnoreCase("SpendingInBars")){
   			query="select bills.bar, sum(transactions.price) as totalSpent from bills, transactions where transactions.bill_id=bills.bill_id and bills.drinker='"+nameofdrinker+"' group by bills.bar order by totalSpent asc";
   		} else if (graphType.equalsIgnoreCase("SpendingPerDayOfTheWeek")){
   			query = "select bills.day, sum(case when bills.drinker = '"+nameofdrinker+"' then transactions.price else 0 end) as totalSpent from bills, transactions where transactions.bill_id=bills.bill_id group by bills.day order by totalSpent asc";

   		} else if (graphType.equalsIgnoreCase("SpendingPerMonth")) { query = "select (case when bills.date like '%-01-%'  then 'Jan' when bills.date like '%-02-%'  then 'Feb' when bills.date like '%-03-%'  then 'Mar' when bills.date like '%-04-%'  then 'Apr' when bills.date like '%-05-%'  then 'May' when bills.date like '%-06-%'  then 'Jun' when bills.date like '%-07-%'  then 'Jul' when bills.date like '%-08-%'  then 'Aug' when bills.date like '%-09-%'  then 'Sep' when bills.date like '%-10-%'  then 'Oct' when bills.date like '%-11-%'  then 'Nov' when bills.date like '%-12-%'  then 'Dec' end ) as month,  sum(case when bills.drinker='"+nameofdrinker+"' then transactions.price else 0 end) as totalSpent from bills, transactions where transactions.bill_id=bills.bill_id  group by month order by totalSpent asc";
   		}
   		
   		
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   			if(graphType.equalsIgnoreCase("favoriteBeers")){
   	   			map.put(result.getString("transactions.item"),result.getInt("totalPurchased"));
   	   		}else if (graphType.equalsIgnoreCase("SpendingInBars")){
   	   			map.put(result.getString("bills.bar"),result.getInt("totalSpent"));
   	   		} else if (graphType.equalsIgnoreCase("SpendingPerDayOfTheWeek")){
   	   			map.put(result.getString("bills.day"),result.getInt("totalSpent"));
   	   		} else if (graphType.equalsIgnoreCase("SpendingPerMonth")){
   	   			map.put(result.getString("month"),result.getInt("totalSpent"));
   	   		}
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
        
        //Create the chart title according to what the user selected
        if(graphType.equalsIgnoreCase("favoriteBeers")){
          chartTitle = "Favorite beers ";
          legend = "beers";
        }else if (graphType.equalsIgnoreCase("SpendingInBars")){
            chartTitle="Spending per Bar";
            legend="bars";
        } else if (graphType.equalsIgnoreCase("SpendingPerDayOfTheWeek")) {
        	chartTitle="Spending per Day OF The WEeek";
            legend="Days Of The Week";
        } else if (graphType.equalsIgnoreCase("SpendingPerMonth")) {
        	chartTitle="Spending per Month";
            legend="Month";
        }
	}catch(SQLException e){
    		out.println(e);
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
	
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Graphs</title>
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
	<div id="graphContainer" style="width: 500px; height: 400px; margin: 0 auto"></div>


</body>
</html>