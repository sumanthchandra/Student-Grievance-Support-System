<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<% 
HttpSession log=request.getSession(false);
if((String)log.getAttribute("role")==null)
{
    response.sendRedirect("Login.html?param=again"); // No logged-in user found, so redirect to login page.
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0);
}
else
{
%>
<!DOCTYPE html>
<html>

<head>
	<title>All Tickets</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<!-- For Table -->
	<link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
	<script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
	<style>
		.total_button,
		.male_button,
		.female_button,
		.other_button,
		.opened_button,
		.closed_button,
		.inProgress_button {
				border: 2px solid black;
			min-height: 1.5vw;
			min-width: 15vw;
		}
		
		table,
		th,
		td {
			border: 1px solid black;
			border-collapse: collapse;
		}

		body {
			position: relative;
			min-height: 100vh;
			padding-bottom: 14rem;
		}

		.custom-footer {
			position: absolute;
			bottom: 0;
			width: 100%;
			height: 14rem;

		}

		/*for mobile phones and tablets (both)*/
		@media only screen and (min-width: 320px) and (max-width: 767px) {
			.custom-footer {
				position: static !important;
			}
		}

		/* for mobile phones only*/
		@media only screen and (min-width: 320px) and (max-width: 480px) {
			.custom-footer {
				position: static !important;
			}
		}
	</style>
</head>

<%
try {
	ServletContext sc = this.getServletContext();
	Class.forName(sc.getInitParameter("DB_DRIVER"));
	Connection con=DriverManager.getConnection(sc.getInitParameter("DB_URL"),sc.getInitParameter("DB_USER"),sc.getInitParameter("DB_PASSWORD"));
System.out.println("AdminViewTickets.jsp-Connection Established");
int opened_count=0,progress_count=0,closed_count=0,total_tickets=0;
Statement stat=con.createStatement();
Statement stat1=con.createStatement();
Statement stat2=con.createStatement();
Statement stat3=con.createStatement();
Statement stat4=con.createStatement();
ResultSet r,rs1,rs2,rs3,rs4;
r=stat.executeQuery("select ticket_id,email_id,name,gender,college,university,level,keyword,subject,urgency,"+
"description,anonymity,ticket_date,ticket_time,status from ticket;");		
rs4 = stat4.executeQuery("select count(*) as 'count' from ticket");
while(rs4.next()){
total_tickets= rs4.getInt("count");
}	
rs1 = stat1.executeQuery("select count(*) as 'count' from ticket where status = 'OPENED';");
while(rs1.next()){
opened_count = rs1.getInt("count");
}
rs2 = stat2.executeQuery("select count(*) as 'count' from ticket where status = 'IN PROGRESS';");
while(rs2.next()){
progress_count = rs2.getInt("count");
}
rs3 = stat3.executeQuery("select count(*) as 'count' from ticket where status = 'CLOSED';");
while(rs3.next()){
closed_count = rs3.getInt("count");
}		
ResultSet rs7,rs8,rs9;
int male=0,female=0,other=0;
Statement stat7=con.createStatement();
rs7= stat7.executeQuery("select count(*) as 'count' from ticket where gender='Male';");
while(rs7.next()){
male= rs7.getInt("count");
}
Statement stat8=con.createStatement();
rs8= stat8.executeQuery("select count(*) as 'count' from ticket where gender='Female';");
while(rs8.next()){
female= rs8.getInt("count");
}
Statement stat9=con.createStatement();
rs9= stat9.executeQuery("select count(*) as 'count' from ticket where gender='Other';");
while(rs9.next()){
other= rs9.getInt("count");
}
%>

<body>
	<!--NAVBAR SECTION BEGIN-->
	<nav class="navbar navbar-expand-lg navbar-expand-md navbar-expand-xs navbar-dark bg-dark">
		<a class="navbar-brand" href="HomePage.html">
			<h4 style="font-size:2vw;color: orange;">STUDENT GRIEVANCE SUPPORT</h4>
			<h6 style="font-size:1vw;color: yellow;text-align: center;">REPORT AND RESOLVE AT YOUR FINGERTIPS</h6>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto"></ul>
			<ul class="navbar-nav mr-auto"></ul>
			<ul class="navbar-nav mr-auto"></ul>
			<ul class="navbar-nav mr-auto"></ul>
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"> <a class="nav-link" href="AdminPage.jsp">
						<h6 style="color: white;">Dashboard</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AdminViewTickets.jsp">
						<h6 style="color: white;">Tickets</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AdminColleges.jsp">
						<h6 style="color: white;">Colleges</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AdminUniversities.jsp">
						<h6 style="color: white;">Universities</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AdminStudents.jsp">
						<h6 style="color: white;">Students</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AdminMembers.jsp">
						<h6 style="color: white;">Members</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AdminFeedback.jsp">
						<h6 style="color: white;">Feedback</h6>
					</a>
				</li>
				<li class="nav-item dropdown">
					<h6 style="color: white;">
						<a class="nav-link dropdown-toggle " data-toggle="dropdown"
							style="margin-right: 10px;color:white" title="">
							Hi Admin
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu bg-dark">
							<li><a href="LogOut">
									<h6 style="color: white;">Logout</h6>
								</a></li>
						</ul>
					</h6>
				</li>
			</ul>
		</div>
	</nav>
	<!--NAVBAR SECTION END-->
	<div class="hidden" id="gg" style="text-align: center;">
		<br>
	</div>
	<br>
	<div class="container col-md-5 col-xs-5" style="display: flex;justify-content:center;">
		<button class="btn btn-info text-white total_button active"><b>Total
				Tickets<br><% out.println(total_tickets);%></b></button>
	</div>
	<br>
	<div class="container" style="display: flex;justify-content:center;">
		<div>
			<button class="btn btn-success text-white male_button active"><b>Men<br><% out.println(male);%></b></button>
		</div>&nbsp;&nbsp;&nbsp;&nbsp;
		<div>
			<button
				class="btn btn-danger text-white female_button active"><b>Women<br><% out.println(female);%></b></button>
		</div>&nbsp;&nbsp;&nbsp;&nbsp;
		<div>
			<button
				class="btn btn-primary text-white other_button active"><b>Other<br><% out.println(other);%></b></button>
		</div>
	</div><br>
	<div class="container" style="display: flex;justify-content:center;">
		<div>
			<button onclick="func1();"
				class="btn btn-primary text-white opened_button active"><b>OPENED<br><% out.println(opened_count);%></b></button>
		</div>&nbsp;&nbsp;&nbsp;&nbsp;
		<div>
			<button onclick="func2();" class="btn btn-success text-white inProgress_button active"><b>IN
					PROGRESS<br><% out.println(progress_count);%></b></button>
		</div>&nbsp;&nbsp;&nbsp;&nbsp;
		<div>
			<button onclick="func3();"
				class="btn btn-danger text-white closed_button active"><b>CLOSED<br><% out.println(closed_count);%></b></button>
		</div>
	</div>
	<br>
	<!-- FILTER SECTION -->
	<div class="container col-md-3 col-xs-3" style="justify-content:right;display:flex;">
	<span style="padding-top:0.5vh;">FILTERS:&nbsp;</span>
    <select class="custom-select" id="keyword-filter" name="keyword-filter" onchange="filter();" aria-describedby="keywordBlock">      
        <option value="No Filter" selected>--Keyword--</option>
        <option value="Finance">Finance</option>
		<option value="Admission">Admission</option>
		<option value="Staff">Staff</option>
		<option value="Management">Management</option>
		<option value="Examination">Examination</option>
		<option value="Placement">Placement</option>
		<option value="Canteen">Canteen</option>
		<option value="Office">Office</option>
		<option value="Security">Security</option>
	</select>
	&nbsp;&nbsp;
	<select class="custom-select" id="priority-filter" name="priority-filter" onchange="pfilter();" aria-describedby="priorityBlock">      
        <option value="No Filter" selected>--Priority--</option>
        <option value="Low">Low</option>
		<option value="High">High</option>
	</select>
    </div>
    <div class="container col-md-2 col-xs-2" style="justify-content:center;display:flex;">
    <small id="keywordBlock"></small>
    &nbsp;&nbsp;
   	<small id="priorityBlock"></small>
   	</div>
   	<!-- FILTER SECTION END-->   
	<table id="myTable" class="table table-striped table-responsive-md table-responsive-xs">
		<thead>
			<tr>
				<th>Ticket ID</th>
				<th>Keyword</th>
				<th>Subject</th>
				<th>Urgency</th>
				<th>Ticket Date</th>
				<th>Ticket Time</th>
			</tr>
		</thead>
		<tbody>
			<%	
int flag=0;
while(r.next())
{   String status=r.getString("status");
	flag=1;
	if(status.equals("OPENED"))
	{
	out.println("<tr class=\"o\">");
	out.println("<td><a target=\"_blank\" href=ViewTicketDetails.jsp?id="+r.getInt("ticket_id")+">"+r.getInt("ticket_id")+"</a></td><td>"+r.getString("keyword")+"</td><td>"+r.getString("subject")+"</td><td>"+r.getString("urgency")+"</td><td>"+r.getDate("ticket_date")+"</td><td>"+r.getTime("ticket_time")+"</td>");
	}
	else if(status.equals("IN PROGRESS"))
	{
		out.println("<tr class=\"i\">");
		out.println("<td><a target=\"_blank\" href=ViewTicketDetails.jsp?id="+r.getInt("ticket_id")+">"+r.getInt("ticket_id")+"</a></td><td>"+r.getString("keyword")+"</td><td>"+r.getString("subject")+"</td><td>"+r.getString("urgency")+"</td><td>"+r.getDate("ticket_date")+"</td><td>"+r.getTime("ticket_time")+"</td>");
	}
	else
	{
		out.println("<tr class=\"c\">");
		out.println("<td><a target=\"_blank\" href=ViewTicketDetails.jsp?id="+r.getInt("ticket_id")+">"+r.getInt("ticket_id")+"</a></td><td>"+r.getString("keyword")+"</td><td>"+r.getString("subject")+"</td><td>"+r.getString("urgency")+"</td><td>"+r.getDate("ticket_date")+"</td><td>"+r.getTime("ticket_time")+"</td>");
	}
	out.println("</tr>");
}
} catch (Exception e) {
	e.printStackTrace();
}
%>
		</tbody>
	</table>
	<br>
</body>
<!--FOOTER BEGIN-->
<div class="custom-footer">
	<%@ include file="Footer.html"%>
</div>
<!--FOOTER END-->
<script>
	var url = window.location.search;
	url = url.replace("?", ''); // remove the ? 
	if (url == "param=status_changed") {
		$('.hidden').addClass('alert alert-success');
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "STATUS CHANGED";

	}

	if (url == "param=status_unchanged") {
		$('.hidden').addClass('alert alert-danger');
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "STATUS UNCHANGED";

	}
	var class_name='o'; //global variable
	$(document).ready(function () {
		$('#myTable').dataTable();
		$('.c').hide();
		$('.i').hide();
		$('.opened_button').css('outline', 'orange solid 5px');//active opened 
		$('.inProgress_button').css('opacity', '0.5');//inactive in progress 
		$('.closed_button').css('opacity', '0.5');//inactive closed 

	});
	function func1() {
		$('#keyword-filter').val("No Filter");
		$('#priority-filter').val("No Filter");
		class_name='o';
		$('.opened_button').css('opacity', '1');
		$('.inProgress_button').css('opacity', '0.5');
		$('.closed_button').css('opacity', '0.5');
		$('.inProgress_button').css('outline', 'none');
		$('.closed_button').css('outline', 'none');
		$('.opened_button').css('outline', 'orange solid 5px');
		$('.i').hide();
		$('.c').hide();
		$('.o').show();
	}

	function func2() {
		$('#keyword-filter').val("No Filter");
		$('#priority-filter').val("No Filter");
		class_name='i';
		$('.inProgress_button').css('opacity', '1');
		$('.closed_button').css('opacity', '0.5');
		$('.opened_button').css('opacity', '0.5');
		$('.inProgress_button').css('outline', 'orange solid 5px');
		$('.closed_button').css('outline', 'none');
		$('.opened_button').css('outline', 'none');
		$('.c').hide();
		$('.o').hide();
		$('.i').show();
	}
	function func3() {
		$('#keyword-filter').val("No Filter");
		$('#priority-filter').val("No Filter");
		class_name='c';
		$('.closed_button').css('opacity', '1');
		$('.inProgress_button').css('opacity', '0.5');
		$('.opened_button').css('opacity', '0.5');
		$('.inProgress_button').css('outline', 'none');
		$('.opened_button').css('outline', 'none');
		$('.closed_button').css('outline', 'orange solid 5px');
		$('.i').hide();
		$('.o').hide();
		$('.c').show();
	} 
	
	function filter()  // based on keyword
	{
	    var keywordFilterText=document.getElementById("keyword-filter").value;
	    var priorityFilterText=document.getElementById("priority-filter").value;
	    if(keywordFilterText!="No Filter" && priorityFilterText!="No Filter")
	    {
	    document.getElementById("keywordBlock").innerHTML=keywordFilterText;
	    document.getElementById("priorityBlock").innerHTML=priorityFilterText;
	    // Find the heading with the text Keyword
	    columnTh = $("table th:contains('Keyword')");
	    columnTh1 = $("table th:contains('Urgency')");
	    // Get the index & increment by 1 to match nth-child indexing
	    columnIndex = columnTh.index() + 1; 
	    columnIndex1 = columnTh1.index() + 1; 
	    // Display all the elements having that index and keyword
	    if(class_name=='o')
	    {
	    $('tbody tr.o').css("display","none");
	    $('tbody tr.o').has('td:nth-child(' + columnIndex + '):contains('+keywordFilterText+')').has('td:nth-child(' + columnIndex1 + '):contains('+priorityFilterText+')').css("display", "");
	    }
	    else if(class_name=='i')
	    {
	    $('tbody tr.i').css("display","none");
	    $('tbody tr.i').has('td:nth-child(' + columnIndex + '):contains('+keywordFilterText+')').has('td:nth-child(' + columnIndex1 + '):contains('+priorityFilterText+')').css("display", "");
	    }
	    else if(class_name=='c')
	    {
	    $('tbody tr.c').css("display","none");
	    $('tbody tr.c').has('td:nth-child(' + columnIndex + '):contains('+keywordFilterText+')').has('td:nth-child(' + columnIndex1 + '):contains('+priorityFilterText+')').css("display", "");
	    }
	    }
	    else if(keywordFilterText!="No Filter" && priorityFilterText=="No Filter")
	    {
	        
	    	document.getElementById("keywordBlock").innerHTML=keywordFilterText;
	    	document.getElementById("priorityBlock").innerHTML="";
	    	
	    	columnTh = $("table th:contains('Keyword')");
	        
	        // Get the index & increment by 1 to match nth-child indexing
	        columnIndex = columnTh.index() + 1;  
	        // Display all the elements having that index and keyword
	        if(class_name=='o')
	        {
	        $('tbody tr.o').css("display","none");
	        $('tbody tr.o').has('td:nth-child(' + columnIndex + '):contains('+keywordFilterText+')').css("display", "");
	        }
	        else if(class_name=='i')
	        {
	        $('tbody tr.i').css("display","none");
	        $('tbody tr.i').has('td:nth-child(' + columnIndex + '):contains('+keywordFilterText+')').css("display", "");
	        }
	        else if(class_name=='c')
	        {
	        $('tbody tr.c').css("display","none");
	        $('tbody tr.c').has('td:nth-child(' + columnIndex + '):contains('+keywordFilterText+')').css("display", "");
	        }
	    }
	    else
	    {
	    	
	    	
	    	if(priorityFilterText!="No Filter")
	    	{
	    		document.getElementById("keywordBlock").innerHTML="";
	    		document.getElementById("priorityBlock").innerHTML=priorityFilterText;
	    		pfilter();
	    	}
	    	else
	    	{
	    		document.getElementById("keywordBlock").innerHTML="";
	    		document.getElementById("priorityBlock").innerHTML="";
	    	if(class_name=='o')
	    		$('tbody tr.o').css("display","");
	    	else if(class_name=='i')
	    		$('tbody tr.i').css("display","");
	    	else if(class_name=='c')
	    		$('tbody tr.c').css("display","");
	    		}
	    }
	}


	function pfilter()  //based on priority
	{
	    var priorityFilterText=document.getElementById("priority-filter").value;
	    var keywordFilterText=document.getElementById("keyword-filter").value;
	 
	    if(priorityFilterText!="No Filter" && keywordFilterText!="No Filter")
	    {
	    	document.getElementById("keywordBlock").innerHTML=keywordFilterText;
	        document.getElementById("priorityBlock").innerHTML=priorityFilterText;	
	    // Find the heading with the text Keyword
	    columnTh = $("table th:contains('Urgency')");
	    columnTh1 = $("table th:contains('Keyword')");
	    // Get the index & increment by 1 to match nth-child indexing
	    columnIndex = columnTh.index() + 1; 
	    columnIndex1= columnTh1.index() + 1; 
	    // Display all the elements having that index and keyword
	    if(class_name=='o')
	    {
	    $('tbody tr.o').css("display","none");
	    $('tbody tr.o').has('td:nth-child(' + columnIndex + '):contains('+priorityFilterText+')').has('td:nth-child(' + columnIndex1 + '):contains('+keywordFilterText+')').css("display", "");
	    }
	    else if(class_name=='i')
	    {
	    $('tbody tr.i').css("display","none");
	    $('tbody tr.i').has('td:nth-child(' + columnIndex + '):contains('+priorityFilterText+')').has('td:nth-child(' + columnIndex1 + '):contains('+keywordFilterText+')').css("display", "");
	    }
	    else if(class_name=='c')
	    {
	    $('tbody tr.c').css("display","none");
	    $('tbody tr.c').has('td:nth-child(' + columnIndex + '):contains('+priorityFilterText+')').has('td:nth-child(' + columnIndex1 + '):contains('+keywordFilterText+')').css("display", "");
	    }
	    }
	    else if (priorityFilterText!="No Filter" && keywordFilterText=="No Filter")
	    {
	    	
	    	document.getElementById("keywordBlock").innerHTML="";
	        document.getElementById("priorityBlock").innerHTML=priorityFilterText;	
	    	// Find the heading with the text Keyword
	        columnTh = $("table th:contains('Urgency')");
	        // Get the index & increment by 1 to match nth-child indexing
	        columnIndex = columnTh.index() + 1; 
	        // Display all the elements having that index and keyword
	        if(class_name=='o')
	        {
	        $('tbody tr.o').css("display","none");
	        $('tbody tr.o').has('td:nth-child(' + columnIndex + '):contains('+priorityFilterText+')').css("display", "");
	        }
	        else if(class_name=='i')
	        {
	        $('tbody tr.i').css("display","none");
	        $('tbody tr.i').has('td:nth-child(' + columnIndex + '):contains('+priorityFilterText+')').css("display", "");
	        }
	        else if(class_name=='c')
	        {
	        $('tbody tr.c').css("display","none");
	        $('tbody tr.c').has('td:nth-child(' + columnIndex + '):contains('+priorityFilterText+')').css("display", "");
	        }
	    }
	    
	    else
	    {
	    	
	    	if(keywordFilterText!="No Filter")
	    		{
	    		document.getElementById("keywordBlock").innerHTML=keywordFilterText;
	            document.getElementById("priorityBlock").innerHTML="";		
	    		filter();
	    		
	    		}
	    	else
	    	{
	    		document.getElementById("keywordBlock").innerHTML="";
	            document.getElementById("priorityBlock").innerHTML="";		
	    	if(class_name=='o')
	    		$('tbody tr.o').css("display","");
	    	else if(class_name=='i')
	    		$('tbody tr.i').css("display","");
	    	else if(class_name=='c')
	    		$('tbody tr.c').css("display","");
	    	}
	    }
	}
</script>
</html>
<%}%>