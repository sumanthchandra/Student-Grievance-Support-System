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
 * Servlet implementation class EditTicketDetails
 */
@WebServlet(urlPatterns = { "/EditTicketDetails" })
public class EditTicketDetails extends HttpServlet {
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
				System.out.println("EditTicketDetails-connection established");
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
				System.out.println(ticket_id);
				int id = Integer.parseInt(ticket_id);

				String level = request.getParameter("level");
				String keyword = request.getParameter("keyword");
				String subject = request.getParameter("subject");
				String urgency = request.getParameter("urgency");
				String description = request.getParameter("description");
				String anonymity = request.getParameter("anonymity");

				Statement stat = con.createStatement();
				int rs = stat.executeUpdate("update ticket set level='" + level + "',keyword='" + keyword
						+ "',subject='" + subject + "',urgency='" + urgency + "',description='" + description
						+ "',anonymity='" + anonymity + "' where ticket_id=" + id);
				if (rs > 0) {
					String path = "StudentViewTickets.jsp?param=edited";
					response.sendRedirect(path);
				}

			} catch (Exception e) {
				e.printStackTrace();
				String path = "StudentViewTickets.jsp?param=wrong";
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
