<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Profile</title>
	<style>
	.delete-button
		{
			min-height: 1.5vw;
			min-width: 15vw;
		}
		.change-button
		{
		   min-height: 1.5vw;
			min-width: 16vw;
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
System.out.println("ViewProfile-Connection Established");
session = request.getSession(false);
String role=(String)session.getAttribute("role");
String email_id="",sfirstname="",mfirstname="";
Statement stat=con.createStatement();
ResultSet r = null;
ResultSet r1 = null;
if(role.equals("Student"))
{
	email_id=(String)session.getAttribute("semail");
	sfirstname=(String)session.getAttribute("sfirstname");
	r=stat.executeQuery("select firstname,lastname,email,gender,course,year,branch,college,university"+
                       " from student where email='"+email_id+"';");
		    	r.beforeFirst();
}
else
{  
	email_id=(String)session.getAttribute("memail");
	mfirstname=(String)session.getAttribute("mfirstname");
	r1=stat.executeQuery("select jurisdiction,mcollege,muniversity,mfirstname,mlastname,memail,mgender from members where memail='"+email_id+"';");
		    	r1.beforeFirst();
}
%>

<body style="text-align:center">
	<%if(role.equals("Student"))
{
%>
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
				<li class="nav-item active">
					<a class="nav-link" href="StudentPage.jsp">
						<h6 style="color: white;">Dashboard</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AboutUs.jsp">
						<h6 style="color: white;">About Us</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ContactUs.jsp">
						<h6 style="color: white;">Contact Us</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="StudentViewTickets.jsp">
						<h6 style="color: white;">My Tickets</h6>
					</a>
				</li>
				<li class="nav-item dropdown">
					<h6 style="color: white;">
						<a class="nav-link dropdown-toggle " data-toggle="dropdown"
							style="margin-right: 10px;color:white" title="">
							<%out.println("Hi "+sfirstname);%>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu bg-dark">
							<li><a href="ViewProfile.jsp">
									<h6 style="color: white;">Profile</h6>
								</a></li>
							<li><a href="LogOut">
									<h6 style="color: white;">Logout</h6>
								</a></li>
						</ul>
					</h6>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="StudentTicketForm.jsp">
						<button style="height: 35px; padding-bottom: 20px;text-align: center" class="btn btn-info">
							<h6 style="color: white;">CREATE TICKET</h6>
						</button>
					</a>
				</li>
			</ul>
		</div>
	</nav>
	<!--NAVBAR SECTION END-->
	<%
}
else
{
%>
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
			<ul class="navbar-nav mr-auto">
			</ul>
			<ul class="navbar-nav mr-auto">
			</ul>
			<ul class="navbar-nav mr-auto">
			</ul>
			<ul class="navbar-nav mr-auto">
			</ul>
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="MemberPage.jsp">
						<h6 style="color: white;">Dashboard</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AboutUs.jsp">
						<h6 style="color: white;">About Us</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ContactUs.jsp">
						<h6 style="color: white;">Contact Us</h6>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="MemberViewTickets.jsp">
						<h6 style="color: white;">My Tickets</h6>
					</a>
				</li>
				<li class="nav-item dropdown">
					<h6 style="color: white;">
						<a class="nav-link dropdown-toggle " data-toggle="dropdown"
							style="margin-right: 10px;color:white" title="">
							<%out.println("Hi "+mfirstname); %>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu bg-dark">
							<li><a href="ViewProfile.jsp">
									<h6 style="color: white;">Profile</h6>
								</a></li>
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
	<%}// end Member navbar's if %>
	<div class="hidden" id="gg" style="text-align: center;"></div>
	<br>
	<h1 style="color:orange;">Your Profile</h1>
	<div class="container col-md-6 col-xs-6" style="display: flex;justify-content:center;">
		<div class="row">
			<div class="col-md-6 col-xs-6">
				<div class="card">
					<%
if(role.equals("Student"))
{
     while(r.next())
	    {   
	       		if(r.getString("gender").equals("Male"))
       				out.println("<img class=\"card-img-top\" alt=\"Card image\" src=\"ASSETS\\man.png\" style=\"width:65%;\">");
	       		else if(r.getString("gender").equals("Female"))
	       			out.println("<img class=\"card-img-top\" alt=\"Card image\" src=\"ASSETS\\woman.png\" style=\"width:75%;\">");
	       		else
	       			out.println("<img class=\"card-img-top\" alt=\"Card image\" src=\"ASSETS\\other.png\" style=\"width:75%;\">");	
%>
					<div class=card-body>
						<h4><%out.println(r.getString("firstname")+" "+r.getString("lastname"));%></h4>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-xs-6">
				<div class="card" style="width:400px;">
					<div class="card-body">
						<div class="table table-bordered table-striped table-light">
							<table>
								<tbody>
									<tr>
										<td><b>Email:</b></td>
										<td><%out.println(r.getString("email"));%></td>
									</tr>
									<tr>
										<td><b>Course:</b></td>
										<td><%out.println(r.getString("course"));%></td>
									</tr>
									<tr>
										<td><b>Year:</b></td>
										<td><%out.println(r.getString("year"));%></td>
									</tr>
									<tr>
										<td><b>Branch:</b></td>
										<td><%out.println(r.getString("branch"));%></td>
									</tr>
									<tr>
										<td><b>College:</b></td>
										<td><%out.println(r.getString("college"));%></td>
									</tr>
									<tr>
										<td><b>University:</b></td>
										<td><%out.println(r.getString("university"));%></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<div class="container col-md-6 col-xs-6" style="justify-content:center;display:flex;">
	<a href="Delete"
		onclick="return confirm('Are you sure? There is no going back once you delete account')"><button
			class="btn btn-danger delete-button col-md-6 col-xs-6">
			<h3>Delete Account</h3>
		</button></a>
	&nbsp;&nbsp;<a href="Verify.html?param=loggedin&email=<%out.println(r.getString("email"));%>"><button
			class="btn btn-success change-button col-md-6 col-xs-6">
			<h3>Change Password</h3>
		</button></a>
	</div>
	<%
}  //while close
} //if close
else
{
	while(r1.next())
   	{   
		       		if(r1.getString("mgender").equals("Male"))
	       				out.println("<img class=\"card-img-top\" alt=\"Card image\" src=\"ASSETS\\man.png\" style=\"width:55%\">");
		       		else if(r1.getString("mgender").equals("Female"))
		       			out.println("<img class=\"card-img-top\" alt=\"Card image\" src=\"ASSETS\\woman.png\" style=\"width:55%\">");
		       		else
		       			out.println("<img class=\"card-img-top\" alt=\"Card image\" src=\"ASSETS\\other.png\" style=\"width:55%\">");
%>
	<div class="card-body">
		<h4><%out.println(r1.getString("mfirstname")+" "+r1.getString("mlastname"));%></h4>
	</div>
	</div>
	</div>
	<div class="col-md-6 col-xs-6">
		<div class="card" style="width:450px;">
			<div class="card-body">
				<div class="table table-bordered table-striped table-light">
					<table>
						<tbody>
							<tr>
								<td><b>Email:</b></td>
								<td><%out.println(r1.getString("memail"));%></td>
							</tr>
							<tr>
								<td><b>Jurisdiction:</b></td>
								<td><%out.println(r1.getString("jurisdiction"));%></td>
							</tr>
							<tr>
								<td><b>College:</b></td>
								<td><%out.println(r1.getString("mcollege"));%></td>
							</tr>
							<tr>
								<td><b>University:</b></td>
								<td><%out.println(r1.getString("muniversity"));%></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	<br>
	<div class="container col-md-6 col-xs-6" style="justify-content:center;display:flex;">
	<a href="Delete"
		onclick="return confirm('Are you sure? There is no going back once you delete account')"><button
			class="btn btn-danger delete-button col-md-6 col-xs-6">
			<h3>Delete Account</h3>
		</button></a>
	&nbsp;&nbsp;<a href="Verify.html?param=loggedin&email=<%out.println(r1.getString("memail"));%>"><button
			class="btn btn-success change-button col-md-6 col-xs-6">
			<h3>Change Password</h3>
		</button></a>
		</div>
	<%
}
}//else
}//try 
catch (Exception e) {
	e.printStackTrace();
}
%>
	<br><br>
</body>
<!--FOOTER BEGIN-->
<div class="custom-footer">
	<%@ include file="Footer.html"%>
</div>
<!--FOOTER END-->
<script>
	$('.hidden').hide();
	var url = window.location.search;
	url = url.replace("?", ''); // remove the ? 
	if (url == "param=deletefail") {
		$('.hidden').addClass('alert alert-danger');
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "ACCOUNT COULDN'T BE DELETED";
	} 
</script>
</html>
<%}%>