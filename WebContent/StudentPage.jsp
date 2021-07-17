<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
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
	<title>Student DashBoard</title>
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
	</style>
</head>

<body>
	<!--NAVBAR SECTION BEGIN-->
	<nav class="navbar navbar-expand-lg navbar-expand-md navbar-expand-xs navbar-dark bg-dark">
		<a class="navbar-brand" href="HomePage.html">
			<h4 style="font-size: 2vw; color: orange;">STUDENT GRIEVANCE
				SUPPORT</h4>
			<h6 style="font-size: 1vw; color: yellow; text-align: center;">REPORT
				AND RESOLVE AT YOUR FINGERTIPS</h6>
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
				<li class="nav-item active"><a class="nav-link" href="StudentPage.jsp">
						<h6 style="color: white;">Dashboard</h6>
					</a></li>
				<li class="nav-item"><a class="nav-link" href="AboutUs.jsp">
						<h6 style="color: white;">About Us</h6>
					</a></li>
				<li class="nav-item"><a class="nav-link" href="ContactUs.jsp">
						<h6 style="color: white;">Contact Us</h6>
					</a></li>
				<li class="nav-item"><a class="nav-link" href="StudentViewTickets.jsp">
						<h6 style="color: white;">My Tickets</h6>
					</a></li>
				<li class="nav-item dropdown">
					<h6 style="color: white;">
						<a class="nav-link dropdown-toggle " data-toggle="dropdown"
							style="margin-right: 10px; color: white" title="">
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

				<li class="nav-item"><a class="nav-link" href="StudentTicketForm.jsp">
						<button style="height: 35px; padding-bottom: 20px;text-align: center" class="btn btn-info">
							<h6 style="color: white;">CREATE TICKET</h6>
						</button>
					</a></li>
			</ul>
		</div>
	</nav>
	<!--NAVBAR SECTION END-->
	<div class="hidden" id="gg" style="text-align: center;"></div>
	<div class="container p-3 my-3 border col-md-4 col-xs-4" style="text-align: center; background-color: lightblue;">
		<b>College Grievance Member:</b>
		<%
				String college = (String)ses.getAttribute("scollege");
				String university =(String)ses.getAttribute("suniversity");
				ServletContext sc = this.getServletContext();
				Class.forName(sc.getInitParameter("DB_DRIVER"));
				Connection con=DriverManager.getConnection(sc.getInitParameter("DB_URL"),sc.getInitParameter("DB_USER"),sc.getInitParameter("DB_PASSWORD"));
				Statement stat=con.createStatement();
				ResultSet r=stat.executeQuery("select mfirstname,mlastname from members where mcollege='"+college+"' and jurisdiction='College';");
				if(r.next()==false)
				{
					out.println("<i>There is no member currently</i>");
				}
				else
				{
				r.beforeFirst();
				while(r.next())
				{
					out.println(r.getString("mfirstname")+" "+r.getString("mlastname"));
				}
				}
		%>
		<br> <b>University Grievance Member:</b>
		<%
				Statement stat1=con.createStatement();
				ResultSet r1=stat1.executeQuery("select mfirstname,mlastname from members where muniversity='"+university+"' and jurisdiction='University';");
				if(r1.next()==false)
				{
					out.println("<i>There is no member currently</i>");
				}
				else
				{
				r1.beforeFirst();
				while(r1.next())
				{
					out.println(r1.getString("mfirstname")+" "+r1.getString("mlastname"));
				} 
				}
%>
	</div>



	<div class="container">
		<form id="regForm">
			<div style="overflow: auto;">
				<div style="float: right;">
					<button type="button" id="prevBtn" onclick="nextPrev(-1)">Previous</button>
					<button type="button" id="nextBtn" onclick="nextPrev(1)">Next</button>
				</div>
			</div>
			<!-- One "tab" for each step in the form: -->
			<div class="tab">
				<p>
					<i>Welcome to Student Page!</i>
				</p>
				Here's how you can raise a ticket
				</p>


			</div>
			<!-- second tab: -->
			<div class="tab">
				<div class="container p-3 my-3 border bg-grey">
					<!-- Main container -->
					<h1>Overview of Ticket Form</h1>

					<div action="RaiseTicket" method="post">
						<div class="container p-3 my-3 border bg-light">
							<div class="row">
								<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
									<label for="level">Level</label>
									<select class="form-control" id="level" name="level">
										<option value="College" disabled selected>College</option>
										<option value="University" disabled>University</option>
									</select>
								</div>

								<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
									<label for="keyword">Keyword</label>
									<select class="form-control" name="keyword" id="keyword">
										<option value="Finance" disabled selected>Finance</option>
										<option value="Admission" disabled>Admission</option>
										<option value="Staff" disabled>Staff</option>
										<option value="Management" disabled>Management</option>
										<option value="Examination" disabled>Examination</option>
										<option value="Placement" disabled>Placement</option>
										<option value="Canteen" disabled>Canteen</option>
										<option value="Office" disabled>Office</option>
										<option value="Security" disabled>Security</option>
									</select>
								</div>

								<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
									<label for="subject">Subject (50 characters only)</label>
									<input type="text" class="form-control" name="subject" id="subject" maxlength="50"
										id="sel2" placeholder="Your subject..." disabled>
								</div>

								<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
									<label for="urgency">Urgency</label>
									<select class="form-control" id="urgency" name="urgency" required>
										<option value="High" disabled selected>High</option>
										<option value="Low" disabled>Low</option>
									</select>
								</div>

								<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
									<label for="description">Description (200 characters only)</label>
									<textarea class="form-control" rows="5" id="description" name="description"
										maxlength="200" placeholder="Your description..." disabled></textarea>
								</div>

								<div class="col-xs-6 col-md-6 bg-light p-3 my-3 border">
									<label for="anonymity">Anonymity</label>
									<label class="radio-inline">
										<input type="radio" id="anonymity" value="Yes" name="anonymity" checked
											disabled>Yes
									</label>
									<label class="radio-inline">
										<input type="radio" value="No" name="anonymity" disabled>No
									</label>
								</div>
							</div>

						</div>
						<div style="text-align:center;">
							<button type="submit" class="btn btn-primary" disabled>SUBMIT</button>
						</div>
					</div>
				</div>
			</div>
			<div class="tab">
				<br>
				<p>The ticket will be directed to the respective grievance member once <button type="submit"
						class="btn btn-primary" disabled>SUBMIT</button> is clicked</p>
			</div>
			<div class="tab">
				<br>
				<p>This is how the ticket will look in your table</p>
				<div class="container-fluid bg-light">
					<table id="myTable" class="table table-striped table-responsive-md table-responsive-xs">
						<thead>
							<tr>
								<th>Ticket ID</th>
								<th>Level</th>
								<th>Subject</th>
								<th>Urgency</th>
								<th>Ticket Date</th>
								<th>Ticket Time</th>
							</tr>
						</thead>
						<tbody>
							<tr class="o">
								<td>
									100000
								</td>
								<td>
									College
								</td>
								<td>
									Fees
								</td>
								<td>
									High
								</td>
								<td>
									01-05-2020
								</td>
								<td>
									22:12:43
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<!-- Circles which indicates the steps of the form: -->
			<div style="text-align:center;margin-top:40px;">
				<span class="step"></span>
				<span class="step"></span>
				<span class="step"></span>
				<span class="step"></span>
			</div>
		</form>
	</div>

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
	if (url == "param=ticket_raised") {
		$('.hidden').addClass('alert alert-success');
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "TICKET RAISED SUCCESSFULLY";

	}

	if (url == "param=ticket_not_raised") {
		$('.hidden').addClass('alert alert-danger');
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "TICKET COULD NOT BE RAISED";

	}

	if (url == "param=status_changed") {
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "STATUS CHANGED";

	}

	if (url == "param=status_unchanged") {
		$('.hidden').addClass('alert alert-danger');
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "STATUS UNCHANGED";

	}
	if (url == "param=feedback") {
		$('.hidden').addClass("alert alert-success");
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "THANK YOU FOR THE FEEDBACK :)";
	}
	if (url == "param=wrong") {
		$('.hidden').addClass("alert alert-danger");
		$('.hidden').show();
		document.getElementById('gg').innerHTML = "OOPS, SOMETHING WENT WRONG :(";
	}
</script>
<script>
	var currentTab = 0; // Current tab is set to be the first tab (0)
	showTab(currentTab); // Display the current tab

	function showTab(n) {
		// This function will display the specified tab of the form...
		var x = document.getElementsByClassName("tab");
		x[n].style.display = "block";
		//... and fix the Previous/Next buttons:
		if (n == 0) {
			document.getElementById("prevBtn").style.display = "none";
		} else {
			document.getElementById("prevBtn").style.display = "inline";
		}
		if (n == (x.length - 1)) {
			document.getElementById("nextBtn").style.display = "Next";
		} else {
			document.getElementById("nextBtn").innerHTML = "Next";
		}
		//... and run a function that will display the correct step indicator:
		fixStepIndicator(n)
	}

	function nextPrev(n) {
		// This function will figure out which tab to display
		var x = document.getElementsByClassName("tab");
		// Exit the function if any field in the current tab is invalid:
		if (n == 1 && !validateForm()) return false;
		// Hide the current tab:
		x[currentTab].style.display = "none";
		// Increase or decrease the current tab by 1:
		currentTab = currentTab + n;
		// if you have reached the end of the form...
		if (currentTab >= x.length) {
			// ... the form gets submitted:
			document.getElementById("regForm").submit();
			return false;
		}
		// Otherwise, display the correct tab:
		showTab(currentTab);
	}

	function validateForm() {
		// This function deals with validation of the form fields
		var x, y, i, valid = true;
		x = document.getElementsByClassName("tab");
		y = x[currentTab].getElementsByTagName("input");
		// A loop that checks every input field in the current tab:
		for (i = 0; i < y.length; i++) {
			// If a field is empty...

		}
		// If the valid status is true, mark the step as finished and valid:
		if (valid) {
			document.getElementsByClassName("step")[currentTab].className += " finish";
		}
		return valid; // return the valid status
	}

	function fixStepIndicator(n) {
		// This function removes the "active" class of all steps...
		var i, x = document.getElementsByClassName("step");
		for (i = 0; i < x.length; i++) {
			x[i].className = x[i].className.replace(" active", "");
		}
		//... and adds the "active" class on the current step:
		x[n].className += " active";
	}
</script>
<style>
	* {
		box-sizing: border-box;
	}

	body {
		background-color: #f1f1f1;
	}

	#regForm {
		background-color: #ffffff;
		margin: 100px auto;
		font-family: Raleway;
		padding: 40px;
		width: 70%;
		min-width: 300px;
	}

	h1 {
		text-align: center;
	}

	input {
		padding: 10px;
		width: 100%;
		font-size: 17px;
		font-family: Raleway;
		border: 1px solid #aaaaaa;
	}

	/* Mark input boxes that gets an error on validation: */
	input.invalid {
		background-color: #ffdddd;
	}

	/* Hide all steps by default: */
	.tab {
		display: none;
	}

	button {
		background-color: #4CAF50;
		color: #ffffff;
		border: none;
		padding: 10px 20px;
		font-size: 17px;
		font-family: Raleway;
		cursor: pointer;
	}

	button:hover {
		opacity: 0.8;
	}

	#prevBtn {
		background-color: #bbbbbb;
	}

	/* Make circles that indicate the steps of the form: */
	.step {
		height: 15px;
		width: 15px;
		margin: 0 2px;
		background-color: #bbbbbb;
		border: none;
		border-radius: 50%;
		display: inline-block;
		opacity: 0.5;
	}

	.step.active {
		opacity: 1;
	}

	/* Mark the steps that are finished and valid: */
	.step.finish {
		background-color: #4CAF50;
	}
</style>

</html>
<%}%>