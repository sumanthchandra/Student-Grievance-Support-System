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
 * Servlet implementation ChangePassword
 */
@WebServlet(urlPatterns = { "/ChangePassword" })
public class ChangePassword extends HttpServlet {
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
				System.out.println("ChangePassword-connection established");
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
		response.setContentType("text/html");
		try {
			Statement stat = con.createStatement();
			HttpSession session = request.getSession(false);
			String passmail = (String) session.getAttribute("passmail");
			String password = request.getParameter("pass");
			String confirmPassword = request.getParameter("cpass");
			if (password.equals(confirmPassword)) {
				SecureHash c = new SecureHash(password);
				String passCode = c.getHash();
				int rs = stat.executeUpdate(
						"update user set user_password='" + passCode + "' where user_email ='" + passmail + "';");
				ResultSet rSet = stat.executeQuery("select user_role from user where user_email ='" + passmail + "';");
				String role = "";

				while (rSet.next()) {
					role = rSet.getString("user_role");
				}
				Statement stat1 = con.createStatement();
				int rs1 = 0;
				if (role.equals("Student")) {
					rs1 = stat1.executeUpdate(
							"update student set password='" + passCode + "' where email ='" + passmail + "';");
				} else {
					rs1 = stat1.executeUpdate(
							"update members set mpassword='" + passCode + "' where memail ='" + passmail + "';");
				}
				session.invalidate();
				if (rs > 0 && rs1 > 0) {
					String path = "HomePage.html?param=pchange";
					response.sendRedirect(path);
				}
			} else {
				String path = "Verify.html?param=mismatch";
				response.sendRedirect(path);
			}
		} catch (Exception e) {
			System.out.println(e);
			String path = "Verify.html?param=error";
			response.sendRedirect(path);
		}
	}
}
