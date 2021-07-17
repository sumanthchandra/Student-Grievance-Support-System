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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">"
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<title>Feedback Details</title> 
</head> 
<%
try {
	ServletContext sc = this.getServletContext();
	Class.forName(sc.getInitParameter("DB_DRIVER"));
	Connection con=DriverManager.getConnection(sc.getInitParameter("DB_URL"),sc.getInitParameter("DB_USER"),sc.getInitParameter("DB_PASSWORD"));
System.out.println("ViewFeedbackDetails-Connection Established");
String feedback_id=request.getParameter("id");
int id=Integer.parseInt(feedback_id);
Statement stat=con.createStatement();
ResultSet r=stat.executeQuery("select * from feedback where id='"+id+"';");
%>
<div class="container">"
<div class="jumbotron">"
<body style="padding-right:40px;"> 
<h1 style="color:blue; text-align:center"><u><b>FEEDBACK DETAILS</b></u></h1>
<%
while(r.next())
{
%>
<h2><b>FEEDBACK ID: </b><%out.println(r.getInt("id"));%></h2>
<h2><b>EMAIL ID:</b><%out.println(r.getString("email"));%>&nbsp;&nbsp;<a href="mailto:<%out.println(r.getString("email"));%>?Subject=Reply from Student Grievance Support" target="_top"><img src="ASSETS\\mail.png"></a></h2>
<h2><b>NAME:</b><%out.println(r.getString("name"));%></h2>
<h2><b>DESCRIPTION:</b><p><%out.println(r.getString("message"));%></p></h2>
<h2><b>REPLY STATUS:</b><%out.println(r.getString("reply_status"));%></h2>");
<%}%>
</body>
</div></div> 
</html>
<% 
}
catch(Exception e)
{
	System.out.println(e);
}
}
%>