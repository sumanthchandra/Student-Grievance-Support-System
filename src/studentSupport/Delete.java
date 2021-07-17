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
 * Servlet implementation class Delete
 */
@WebServlet(urlPatterns = { "/Delete" })

public class Delete extends HttpServlet {
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
				System.out.println("Delete-connection established");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		try {
			HttpSession session = request.getSession(false);
			boolean g = session.getAttribute("role") == null ? true : false;
			try {
				session = request.getSession(false);
				String email_id = "";
				String role = (String) session.getAttribute("role");
				if (role.equals("Student")) {
					email_id = (String) session.getAttribute("semail");
				} else {
					email_id = (String) session.getAttribute("memail");
				}
				Statement stat = con.createStatement();

				if (role.equals("Student")) {
					System.out.println("Email: " + email_id);
					int rs = 0, rs1 = 0, rs2 = 0;
					rs = stat.executeUpdate("delete from ticket where email_id='" + email_id + "';");
					rs2 = stat.executeUpdate("delete from student where email='" + email_id + "';");
					rs1 = stat.executeUpdate("delete from user where user_email='" + email_id + "';");
					System.out.println("RS2 and RS1 " + rs2 + " " + rs1);
					if (rs1 > 0 && rs2 > 0) {
						session.invalidate();
						String path = "HomePage.html?param=accdelete";
						response.sendRedirect(path);
					} else {
						System.out.println("a");
						String path = "ViewProfile.jsp?param=deletefail";
						response.sendRedirect(path);
					}
				} else {
					int rs3 = 0, rs4 = 0;
					rs3 = stat.executeUpdate("delete from members where memail='" + email_id + "';");
					rs4 = stat.executeUpdate("delete from user where user_email='" + email_id + "';");
					if (rs3 > 0 && rs4 > 0) {
						session.invalidate();
						String path = "HomePage.html?param=accdelete";
						response.sendRedirect(path);
					} else {
						String path = "ViewProfile.jsp?param=deletefail";
						response.sendRedirect(path);
					}
				}
			} catch (Exception e) {
				System.out.println("a");
				String path = "ViewProfile.jsp?param=deletefail";
				response.sendRedirect(path);
				System.out.println(e);
			}
		} catch (Exception e) {
			response.sendRedirect("Login.html?param=again"); // No logged-in user found, so redirect to login page.
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			response.setDateHeader("Expires", 0);
		}
	}
}
