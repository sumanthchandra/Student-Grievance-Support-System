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
 * Servlet implementation class Feedback
 */
@WebServlet(urlPatterns = { "/Feedback" })
public class Feedback extends HttpServlet {
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
				System.out.println("Feedback-connection established");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession(false);
			String role = (String) session.getAttribute("role");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String message = request.getParameter("message");
			Statement stat = con.createStatement();
			int rs = stat.executeUpdate("insert into feedback(name,email,message) values ('" + name + "','" + email
					+ "','" + message + "');");
			if (rs > 0) {
				if (role.equals("Student")) {
					String path = "StudentPage.jsp?param=feedback";
					response.sendRedirect(path);
				} else if (role.equals("Member")) {
					String path = "MemberPage.jsp?param=feedback";
					response.sendRedirect(path);
				} else {
					String path = "HomePage.html?param=feedback";
					response.sendRedirect(path);
				}
			} else {
				if (role.equals("Student")) {
					String path = "StudentPage.jsp?param=wrong";
					response.sendRedirect(path);
				} else if (role.equals("Member")) {
					String path = "MemberPage.jsp?param=wrong";
					response.sendRedirect(path);
				} else {
					String path = "HomePage.html?param=wrong";
					response.sendRedirect(path);
				}
			}
		} catch (Exception e) {
			String path = "HomePage.html?param=feedback";
			response.sendRedirect(path);
		}
	}

}
