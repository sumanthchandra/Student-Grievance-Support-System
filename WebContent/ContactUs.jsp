<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
* {
  box-sizing: border-box;
}

/* Style inputs */
input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=email], select, textarea {
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

/* Style the container/contact section */
.container.contact-container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 10px;
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
  .column, input[type=submit] {
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
<title>Contact Us</title>
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
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	 <ul class="navbar-nav mr-auto"></ul>
	 <ul class="navbar-nav mr-auto"></ul>
	 <ul class="navbar-nav mr-auto"></ul>
	 <ul class="navbar-nav mr-auto"></ul>
	  <ul class="navbar-nav mr-auto">
		<li class="nav-item active">
		  <a class="nav-link" href="StudentPage.jsp"><h6 style="color: white;">Dashboard</h6></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="AboutUs.jsp"><h6 style="color: white;">About Us</h6></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="ContactUs.jsp"><h6 style="color: white;">Contact Us</h6></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="StudentViewTickets.jsp"><h6 style="color: white;">My Tickets</h6></a>
		</li>
		<li class="nav-item dropdown">
			<h6 style="color: white;">
			<a class="nav-link dropdown-toggle " data-toggle="dropdown"  style="margin-right: 10px;color:white" title="">
			<%out.print("Hi "+(String)ses.getAttribute("sfirstname"));%>
			<span class="caret"></span>
			</a>
			<ul class="dropdown-menu bg-dark">
			<li><a href="ViewProfile.jsp" ><h6 style="color: white;">Profile</h6></a></li>
			<li><a href="LogOut"><h6 style="color: white;">Logout</h6></a></li>
			</ul>
			</h6>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="StudentTicketForm.jsp">
				<button style="height: 35px; padding-bottom: 20px;text-align: center" class="btn btn-info">
					<h6 style="color: white;">CREATE TICKET</h6></button>
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
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
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
		  <a class="nav-link" href="MemberPage.jsp"><h6 style="color: white;">Dashboard</h6></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="AboutUs.jsp"><h6 style="color: white;">About Us</h6></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="ContactUs.jsp"><h6 style="color: white;">Contact Us</h6></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="MemberViewTickets.jsp"><h6 style="color: white;">My Tickets</h6></a>
		</li>
		<li class="nav-item dropdown">
			<h6 style="color: white;">
			<a class="nav-link dropdown-toggle " data-toggle="dropdown"  style="margin-right: 10px;color:white" title="">
			<%out.print("Hi "+(String)ses.getAttribute("mfirstname"));%>
			<span class="caret"></span>
			</a>
			<ul class="dropdown-menu bg-dark">
			<li><a href="ViewProfile.jsp" ><h6 style="color: white;">Profile</h6></a></li>
			<li><a href="LogOut"><h6 style="color: white;">Logout</h6></a></li>
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
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	<ul class="navbar-nav mr-auto"></ul>
	<ul class="navbar-nav mr-auto"></ul>
	  <ul class="navbar-nav mr-auto">
		<li class="nav-item">
		  <a class="nav-link" href="HomePage.html"><h5 style="color: white;">Home</h5></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="AboutUs.jsp"><h5 style="color: white;">About Us</h5></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="ContactUs.jsp"><h5 style="color: white;">Contact Us</h5></a>
		  </li>
	  </ul>
	  <form method="post" action="Login" class="form-inline">
		<div class="form-group">
		<input type="email" class="form-control mr-xs-2 mr-md-2" name="login_email" id="login_email" placeholder="Email" required>
		</div>
		<div style="display:listitem;padding-top:1.5vw;">
		<div class="form-group">
		<input type="password" class="form-control mr-xs-2 mr-md-2" name="login_password" id="login_password" placeholder="Password" required>
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
<div class="container contact-container">
  <div style="text-align:center">
    <h2>Contact Us</h2>
    <p>Drop us a message</p>
  </div>
  <div class="row">
    <div class="column">
      <img src="ASSETS//student.png" style="width:100%">
    </div>
    <div class="column">
      <form action="Feedback" method="post">
      <%try
		{
			HttpSession ses = request.getSession(false);
			if(ses.getAttribute("role").equals("Student")) {
		%>
		<label for="fname">Name</label>
        <input type="text" id="fname" name="name" placeholder="Your name.." required value="<%out.println((String)ses.getAttribute("sfirstname")+" "+(String)ses.getAttribute("slastname"));%>">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Your email id.." required value="<%out.println((String)ses.getAttribute("semail"));%>">
        <%}
		else if(ses.getAttribute("role").equals("Member")) {%>
		  <label for="fname">Name</label>
        <input type="text" id="fname" name="name" placeholder="Your name.." required value="<%out.println((String)ses.getAttribute("mfirstname")+" "+(String)ses.getAttribute("mlastname"));%>">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Your email id.." required value="<%out.println((String)ses.getAttribute("memail"));%>">
        <%} 
		} catch(Exception e) {%>
        <label for="fname">Name</label>
        <input type="text" id="fname" name="name" placeholder="Your name.." required>
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Your email id.." required>
        <label for="message">Message</label>
        <%} %>
        <textarea id="message" name="message" placeholder="Write something.." style="height:170px" required maxlength="200"></textarea>
        <input type="submit" value="Submit">
      </form>
    </div>
  </div>
</div>
<br>
</body>
<!--FOOTER BEGIN-->
<div id="FooterPlaceholder" class="custom-footer"></div>
<!--FOOTER END-->
<script>
$(function() {
	$("#FooterPlaceholder").load("Footer.html");
});
</script>
</html>
