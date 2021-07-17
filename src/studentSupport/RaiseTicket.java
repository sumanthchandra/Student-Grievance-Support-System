package studentSupport;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
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
 * Servlet implementation class RaiseTicket
 */
@WebServlet(urlPatterns = { "/RaiseTicket" })

public class RaiseTicket extends HttpServlet {
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
				System.out.println("RaiseTicket-connection established");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		try {
			HttpSession session = request.getSession(false);
			boolean g = session.getAttribute("role") == null ? true : false;
			try {
				String fname = (String) session.getAttribute("sfirstname");
				String lname = (String) session.getAttribute("slastname");
				String name = fname + " " + lname;
				String email = (String) session.getAttribute("semail");
				String gender = (String) session.getAttribute("sgender");
				String college = (String) session.getAttribute("scollege");
				String university = (String) session.getAttribute("suniversity");

				String level = request.getParameter("level");
				String keyword = request.getParameter("keyword");
				String subject = request.getParameter("subject");
				String urgency = request.getParameter("urgency");
				String description = request.getParameter("description");
				String anonymity = request.getParameter("anonymity");

				long millis = System.currentTimeMillis();
				java.sql.Date date = new java.sql.Date(millis);
				java.sql.Time time = new java.sql.Time(millis);

				Statement stat = con.createStatement();
				int rs = stat.executeUpdate(
						"insert into ticket(email_id,name,gender,college,university,level,keyword,subject,urgency,"
								+ "description,anonymity,ticket_date,ticket_time,status) values('" + email + "','"
								+ name + "','" + gender + "','" + college + "','" + university + "','" + level + "','"
								+ keyword + "','" + subject + "','" + urgency + "','" + description + "','" + anonymity
								+ "','" + date + "','" + time + "','OPENED');");
				if (rs > 0) {
					String path = "StudentPage.jsp?param=ticket_raised";
					response.sendRedirect(path);
				} else {
					String path = "StudentPage.jsp?param=ticket_not_raised";
					response.sendRedirect(path);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			response.sendRedirect("Login.html?param=again"); // No logged-in user found, so redirect to login page.
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setDateHeader("Expires", 0);
		}
	}
}
