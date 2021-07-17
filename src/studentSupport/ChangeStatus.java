package studentSupport;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ChangeStatus
 */
@WebServlet(urlPatterns = { "/ChangeStatus" })
public class ChangeStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		try {
			ServletContext sc = this.getServletContext();
			Class.forName(sc.getInitParameter("DB_DRIVER"));
			con = DriverManager.getConnection(sc.getInitParameter("DB_URL"), sc.getInitParameter("DB_USER"),
					sc.getInitParameter("DB_PASSWORD"));
			if (con != null)
				System.out.println("ChangeStatus-connection established");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		try {
			HttpSession session = request.getSession(false);
			boolean g = session.getAttribute("role") == null ? true : false;
			try {
				String ticket_id = request.getParameter("id");
				int id = Integer.parseInt(ticket_id);
				String status = request.getParameter("status");
				Statement stat = con.createStatement();
				HttpSession ses = request.getSession(false);
				String role = (String) ses.getAttribute("role");
				String student_mail = "";
				String member_mail = "";
				String subject = "Ticket Status Changed-#" + id;
				String message = "";

				if (role.equals("Member")) {
					member_mail = (String) ses.getAttribute("memail");
					Statement stat1 = con.createStatement();
					ResultSet rs = stat1.executeQuery("select email_id from ticket where ticket_id=" + id + ";");
					while (rs.next()) {
						student_mail = rs.getString("email_id");
					}
				} else {
					student_mail = (String) ses.getAttribute("semail");
					Statement stat2 = con.createStatement();
					ResultSet rs2 = stat2
							.executeQuery("select level,college,university from ticket where ticket_id=" + id + ";");
					String level = "", college = "", university = "";
					Statement stat3;
					ResultSet rs3;
					while (rs2.next()) {
						level = rs2.getString("level");
						college = rs2.getString("college");
						university = rs2.getString("university");
					}
					if (level.equals("College")) {
						stat3 = con.createStatement();
						rs3 = stat3.executeQuery("select memail from members where jurisdiction='" + level
								+ "' and mcollege ='" + college + "';");
						while (rs3.next()) {
							member_mail = rs3.getString("memail");
						}
					} else {
						stat3 = con.createStatement();
						rs3 = stat3.executeQuery("select memail from members where jurisdiction='" + level
								+ "' and muniversity ='" + university + "';");
						while (rs3.next()) {
							member_mail = rs3.getString("memail");
						}
					}
				}

				int r1 = 0, r2 = 0, r3 = 0;
				if (status.equals("progress")) {
					r1 = stat.executeUpdate("update ticket set status=\"IN PROGRESS\" where ticket_id =" + id + ";");
					message = "Status Changed from \'OPENED\' to \'IN PROGRESS\'";
				} else if (status.equals("close")) {
					r2 = stat.executeUpdate("update ticket set status=\"CLOSED\" where ticket_id =" + id + ";");
					message = "Status Changed from \'IN PROGRESS\' to \'CLOSED\'";
				} else {
					r3 = stat.executeUpdate("update ticket set status=\"OPENED\" where ticket_id =" + id + ";");
					message = "Ticket Re-opened. Status Changed from \'CLOSED\' to \'OPENED\'";
				}

				if (r1 > 0) {
					SendEmail s = new SendEmail(member_mail, subject, message);
					s.setMailServerProperties();
					s.createEmailMessage();
					s.sendEmail();
					SendEmail s1 = new SendEmail(student_mail, subject, message);
					s1.setMailServerProperties();
					s1.createEmailMessage();
					s1.sendEmail();
					String path = "MemberViewTickets.jsp?param=status_changed";
					response.sendRedirect(path);
				} else if (r2 > 0) {
					SendEmail s = new SendEmail(member_mail, subject, message);
					s.setMailServerProperties();
					s.createEmailMessage();
					s.sendEmail();
					SendEmail s1 = new SendEmail(student_mail, subject, message);
					s1.setMailServerProperties();
					s1.createEmailMessage();
					s1.sendEmail();
					String path = "MemberViewTickets.jsp?param=status_changed";
					response.sendRedirect(path);
				} else if (r3 > 0) {
					SendEmail s = new SendEmail(member_mail, subject, message);
					s.setMailServerProperties();
					s.createEmailMessage();
					s.sendEmail();
					SendEmail s1 = new SendEmail(student_mail, subject, message);
					s1.setMailServerProperties();
					s1.createEmailMessage();
					s1.sendEmail();
					String path = "StudentViewTickets.jsp?param=status_changed";
					response.sendRedirect(path);
				}
			} catch (Exception e) {
				e.printStackTrace();
				String path = "ViewTicketsStudents.jsp?param=status_unchanged";
				response.sendRedirect(path);
			}
		} catch (Exception e) {
			response.sendRedirect("Login.html?param=again"); // No logged-in user found, so redirect to login page.
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setDateHeader("Expires", 0);
		}
	}
}
