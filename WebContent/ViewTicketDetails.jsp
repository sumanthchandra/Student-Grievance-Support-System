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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Ticket Details</title>
</head>
<%
try {
	ServletContext sc = this.getServletContext();
	Class.forName(sc.getInitParameter("DB_DRIVER"));
	Connection con=DriverManager.getConnection(sc.getInitParameter("DB_URL"),sc.getInitParameter("DB_USER"),sc.getInitParameter("DB_PASSWORD"));
System.out.println("ViewTicketDetails-Connection Established");
String ticket_id=request.getParameter("id");
int id=Integer.parseInt(ticket_id);
Statement stat=con.createStatement();
ResultSet r=stat.executeQuery("select ticket_id,email_id,name,gender,college,university,level,keyword,subject,urgency,description,anonymity,ticket_date,ticket_time,status from ticket where ticket_id='"+id+"';");
%>
<div class="container">
	<div class="jumbotron">

		<body style="padding-right:40px;">
			<h1 style="color:blue; text-align:center"><u><b>TICKET DETAILS</b></u></h1>
			<%
while(r.next())
{
String anonymity=(String)r.getString("anonymity");
String email=(String)r.getString("email_id");
%>
			<h2><b>TICKET ID: </b><% out.println(r.getInt("ticket_id"));%></h2>
			<h2><b>USER DETAILS:</b>
				<%
if(anonymity.equals("Yes"))
{
%>
				<i>
					<h3 style="color:orange;">The user has chosen to remain anonymous</h3>
				</i>
				<%
}
else
{%>
				<br>
				<h2><b>EMAIL ID:</b><% out.println(email);%><a href="mailto:<% out.println(email);%>?Subject=Regd_Ticket"
					target="_top"><img src="ASSETS\\mail.png"></a></h2>
				<h2><b>NAME:</b><%out.println(r.getString("name"));%></h2>
				<h2><b>GENDER:</b><%out.println(r.getString("gender"));%></h2>
				<h2><b>COLLEGE:</b><%out.println(r.getString("college"));%></h2>
				<h2><b>UNIVERSITY:</b><%out.println(r.getString("university"));%>;</h2>
				<%}%>
<h2><b>LEVEL:</b><%out.println(r.getString("level"));%>
			</h2>
			<h2><b>KEYWORD:</b><%out.println(r.getString("keyword"));%></h2>
			<h2><b>SUBJECT:</b> <%out.println(r.getString("subject"));%></h2>
			<h2><b>URGENCY:</b> <%out.println(r.getString("urgency"));%></h2>
			<h2><b>DESCRIPTION:</b>
				<p><%out.println(r.getString("description"));%></p>
			</h2>
			<h2><b>TICKET DATE:</b><%out.println(r.getString("ticket_date"));%></h2>
			<h2><b>TICKET TIME:</b><%out.println(r.getString("ticket_time"));%></h2>
			<h2><b>STATUS:</b><%out.println(r.getString("status"));%></h2>
			<%}//while %>
		</body>
	</div>
</div>

</html>
<%
}//try
catch(Exception e)
{
	System.out.println(e);
}
}
%>