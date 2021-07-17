<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<link href="https://fonts.googleapis.com/css2?family=Comic+Neue:wght@700&display=swap" rel="stylesheet">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<style>
		html {
			box-sizing: border-box;
		}

		*,
		*:before,
		*:after {
			box-sizing: inherit;
		}

		.column {
			float: left;
			width: 33.3%;
			margin-bottom: 16px;
			padding: 0 8px;
		}

		.card {
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
			margin: 8px;
		}

		.about-section {
			padding: 50px;
			text-align: center;
			background-color: #474e5d;
			color: white;
		}

		.container {
			padding: 0 16px;
		}

		.container::after,
		.row::after {
			content: "";
			clear: both;
			display: table;
		}

		.title {
			color: grey;
		}

		.button {
			border: none;
			outline: 0;
			display: inline-block;
			padding: 8px;
			color: white;
			background-color: #000;
			text-align: center;
			cursor: pointer;
			width: 100%;
		}

		.button:hover {
			background-color: #555;
		}

		h2.b {
			font-family: 'Comic Neue', cursive;
		}

		p.asd {
			font-family: 'Spicy Rice', cursive;
		}

		p.aa {
			font-family: 'Spicy Rice', cursive;
			font-family: 'Indie Flower', cursive;
		}

		h2.st {
			font-family: 'Spicy Rice', cursive;
			font-family: 'Indie Flower', cursive;
			font-family: 'IM Fell French Canon SC', serif;
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
	<title>About Us</title>
</head>

<body>
	<%
try
{
HttpSession ses = request.getSession(false);
if(ses.getAttribute("role").equals("Student")) { %>
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
							<%out.print("Hi "+(String)ses.getAttribute("sfirstname"));%>
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
	<%}
else if(ses.getAttribute("role").equals("Member")) {%>
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
							<%out.print("Hi "+(String)ses.getAttribute("mfirstname"));%>
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
	<%} 
} catch(Exception e) {%>
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
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="HomePage.html">
						<h5 style="color: white;">Home</h5>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="AboutUs.jsp">
						<h5 style="color: white;">About Us</h5>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="ContactUs.jsp">
						<h5 style="color: white;">Contact Us</h5>
					</a>
				</li>
			</ul>
			<form method="post" action="Login" class="form-inline">
				<div class="form-group">
					<input type="email" class="form-control mr-xs-2 mr-md-2" name="login_email" id="login_email"
						placeholder="Email" required>
				</div>
				<div style="display:listitem;padding-top:1.5vw;">
					<div class="form-group">
						<input type="password" class="form-control mr-xs-2 mr-md-2" name="login_password"
							id="login_password" placeholder="Password" required>
					</div>
					<small class="form-text" style="text-align:center;">
						<a href="Verify.html">Forgot Password?</a>
					</small>
				</div>
				&nbsp;
				<div class="form-group">
					<button class="btn btn-info" type="submit" value="Log In">Sign In</button>
				</div>
			</form>
		</div>
	</nav>
	<!--NAVBAR SECTION END-->
	<%} %>
	<div class="about-section text-warning">
		<h1>About Us</h1>
		<p class="asd">Student Grievance Support</p>
		<p class=aa">Meet the people behind this application</p>
	</div>

	<h2 style="text-align:center" class="st">Our Team</h2>
	<div class="row">
		<div class="col">
			<div class="card">
				<img src="/w3images/team1.jpg" alt="" style="width:100%">
				<div class="container">
					<h2 class="b">Sumanth Chandra</h2>
					<p class="title">Team Leader & Developer</p>

					<p>vsumanthchandra11@gmail.com<a style="color:white;" href="mailto:vsumanthchandra11@gmail.com"
							target="_top">&nbsp;<img src="ASSETS\\mail.png"></a></p>
					<!--<p><button class="button">Contact</button></p>-->
				</div>
			</div>
		</div>

		<div class="col">
			<div class="card">
				<img src="/w3images/team2.jpg" alt="" style="width:100%">
				<div class="container">
					<h2 class="b">Ravi Chandra</h2>
					<p class="title">UI-Engineer</p>

					<p>ravichandrayachamaneni98@gmail.com<a style="color:white;"
							href="mailto:ravichandrayachamaneni98@gmail.com" target="_top">&nbsp;<img
								src="ASSETS\\mail.png"></a></p>
					<!--<p><button class="button">Contact</button></p>-->
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="card">
				<img src="/w3images/team3.jpg" alt="" style="width:100%">
				<div class="container ">
					<h2 class="b">Savanth</h2>
					<p class="title">FrontEnd Devoloper</p>

					<p>cs.yeluri@gmail.com<a style="color:white;" href="mailto:cs.yeluri@gmail.com"
							target="_top">&nbsp;<img src="ASSETS\\mail.png"></a></p>
					<!--<p><button class="button">Contact</button></p>-->
				</div>
			</div>
		</div>
		<div class="col" style="">
			<div class="card">
				<img src="/w3images/team3.jpg" alt="" style="width:100%">
				<div class="container">
					<h2 class="b">Rohith Singam</h2>
					<p class="title">Web-Designer</p>
					<p>rohitsingam22@gmail.com<a style="color:white;" href="mailto:rohitsingam22@gmail.com"
							target="_top">&nbsp;<img src="ASSETS\\mail.png"></a></p>
					<!--<p><button class="button">Contact</button></p>-->
				</div>
			</div>
		</div>
	</div>
	<br>
</body>
<!--FOOTER BEGIN-->
<div id="FooterPlaceholder" class="custom-footer"></div>
<!--FOOTER END-->
<script>
	$(function () {
		$("#FooterPlaceholder").load("Footer.html");
	});
</script>

</html>