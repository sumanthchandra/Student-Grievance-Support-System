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
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="utf-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		body {
			font-family: Arial, Helvetica, sans-serif;
		}

		* {
			box-sizing: border-box;
		}

		/* Style inputs */
		input[type=text],
		select,
		textarea {
			width: 100%;
			padding: 12px;
			border: 1px solid #ccc;
			margin-top: 6px;
			margin-bottom: 16px;
			resize: vertical;
		}

		input[type=email],
		select,
		textarea {
			width: 100%;
			padding: 12px;
			border: 1px solid #ccc;
			margin-top: 6px;
			margin-bottom: 16px;
			resize: vertical;
		}

		input[type=submit] {
			background-color: #4CAF50;
			color: white;
			padding: 12px 20px;
			border: none;
			cursor: pointer;
		}

		input[type=submit]:hover {
			background-color: #45a049;
		}

		/* Create two columns that float next to eachother */
		.column {
			float: left;
			width: 50%;
			margin-top: 6px;
			padding: 20px;
		}

		/* Clear floats after the columns */
		.row:after {
			content: "";
			display: table;
			clear: both;
		}

		/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
		@media screen and (max-width: 600px) {

			.column,
			input[type=submit] {
				width: 100%;
				margin-top: 0;
			}
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
	<title>Edit Ticket</title>
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
							<%HttpSession ses= request.getSession(false);out.print("Hi "+(String)ses.getAttribute("sfirstname"));%>
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
	<div class="container">
		<div>
			<%
				String idString = request.getParameter("id");
				int id= Integer.parseInt(idString);
				String url = "EditTicketDetails";
				ServletContext sc = this.getServletContext();
				Class.forName(sc.getInitParameter("DB_DRIVER"));
				Connection con=DriverManager.getConnection(sc.getInitParameter("DB_URL"),sc.getInitParameter("DB_USER"),sc.getInitParameter("DB_PASSWORD"));
				Statement stat=con.createStatement();
				ResultSet r=stat.executeQuery("select level,keyword,subject,urgency,description,anonymity from ticket where ticket_id='"+id+"';");
				while(r.next())
				{
			%>

			<h2>Edit Ticket: #<%out.println(id);%></h2>
			<form action=<%out.println("\""+url+"\"");%> method="get">
				<input type="hidden" name="id" value=<%out.println(id);%>>
				<div class="container p-3 my-3 border bg-light">
					<div class="row">
						<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
							<label for="level">Level</label>
							<select class="form-control" id="level" name="level" required>
								<option value="College">College</option>
								<option value="University">University</option>
							</select>
						</div>

						<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
							<label for="keyword">Keyword</label> <select class="form-control" name="keyword"
								id="keyword" required>
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
						</div>

						<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
							<label for="subject">Subject (50 characters only)</label> <input type="text"
								class="form-control" name="subject" maxlength="50" id="subject" required>
						</div>

						<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
							<label for="urgency">Urgency</label> <select class="form-control" id="urgency"
								name="urgency" required>
								<option value="High">High</option>
								<option value="Low">Low</option>
							</select>
						</div>

						<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
							<label for="description">Description (200 characters only)</label>
							<textarea class="form-control" rows="5" id="description" name="description" maxlength="200"
								required></textarea>
						</div>

						<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
							<label for="anonymity">Anonymity</label> <label class="radio-inline">
								<input type="radio" id="Yes" value="Yes" name="anonymity" checked required>Yes
							</label> <label class="radio-inline"> <input type="radio" value="No" id="No"
									name="anonymity">No
							</label>
						</div>
					</div>
				</div>
				<div style="text-align:center;">
					<button type="submit" class="btn btn-primary">SAVE CHANGES</button>
				</div>
			</form>
		</div>
	</div>
	<br>
</body>
<!--FOOTER BEGIN-->
<div class="custom-footer">
	<%@ include file="Footer.html"%>
</div>
<!--FOOTER END-->
<script>
	$('#level').val(<% out.println("\'" + r.getString("level") + "\'");%>);
	$('#keyword').val(<% out.println("\'" + r.getString("keyword") + "\'");%>);
	$('#subject').val(<% out.println("\'" + r.getString("subject") + "\'");%>);
	$('#urgency').val(<% out.println("\'" + r.getString("urgency") + "\'");%>);
	$('#description').val(<% out.println("\'" + r.getString("description") + "\'");%>);
	$('#anonymity').val(<% out.println("\'" + r.getString("anonymity") + "\'");%>);
	$(<% out.println("\'#" + r.getString("anonymity") + "\'");%>).prop("checked", true);
</script>
<%}%>
</html>
<%}%>