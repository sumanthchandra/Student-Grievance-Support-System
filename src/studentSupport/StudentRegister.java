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
 * Servlet implementation class StudentRegister
 */
@WebServlet(urlPatterns = { "/StudentRegister" })
public class StudentRegister extends HttpServlet {
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
				System.out.println("StudentRegister-connection established");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("text/html");
		String email1 = (String) session.getAttribute("email");
		try {
			Statement stat = con.createStatement();
			String formOTP = request.getParameter("otp1");
			String otp = (String) session.getAttribute("code");
			if (formOTP.equals(otp)) {
				String firstname = (String) session.getAttribute("firstname");
				String lastname = (String) session.getAttribute("lastname");
				String email = (String) session.getAttribute("email");
				String pass = (String) session.getAttribute("password");
				String gender = (String) session.getAttribute("gender");
				String course = (String) session.getAttribute("course");
				String year = (String) session.getAttribute("year");
				String branch = (String) session.getAttribute("branch");
				String college = (String) session.getAttribute("college");
				String university = (String) session.getAttribute("university");

				SecureHash c = new SecureHash(pass);
				String passCode = c.getHash();
				int rs = stat.executeUpdate("insert into user(user_email,user_password,user_role) values('" + email
						+ "','" + passCode + "','Student');");
				int rs1 = stat.executeUpdate(
						"insert into Student(firstname,lastname,email,password,gender,course,year,branch,college,university) values('"
								+ firstname + "','" + lastname + "','" + email + "','" + passCode + "','" + gender
								+ "','" + course + "'," + Integer.parseInt(year) + ",'" + branch + "','" + college
								+ "','" + university + "');");
				if (rs > 0 && rs1 > 0) {
					String path = "Login.html?param=success";
					response.sendRedirect(path);
				} else {
					Statement stat1 = con.createStatement();
					int rs3 = stat1.executeUpdate("delete from user where user_email='" + email + "';");
					if (rs3 > 0) {
						String path = "HomePage.html?param=wrong";
						response.sendRedirect(path);
					}
				}
			} else {
				String path = "HomePage.html?param=otp";
				response.sendRedirect(path);
			}
		} catch (Exception e) {
			try {
				Statement stat3 = con.createStatement();
				int rs4 = stat3.executeUpdate("delete from user where user_email='" + email1 + "';");
				if (rs4 > 0) {
				}
			} catch (Exception ee) {
				ee.printStackTrace();
			}
			String path = "HomePage.html?param=wrong";
			response.sendRedirect(path);
			e.printStackTrace();
		}
	}
}
