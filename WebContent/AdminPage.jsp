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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<title>Admin Page</title>
	<style>
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

		.custom_button {
			background-color: white;
			border: 2px solid black;
			display: block;
			min-height: 40px;
			min-width: 200px;
			width: 100%;
		}
	</style>
</head>

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
				<li class="nav-item active">
					<a class="nav-link" href="AdminPage.jsp">
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
	<div class="hidden" id="gg" style="text-align: center;"></div>
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
	if (url == "param=deletefail") {
		$('.hidden').addClass('alert alert-danger');
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "USER COULD NOT BE REMOVED";
	}
</script>
</html>
<%}%>