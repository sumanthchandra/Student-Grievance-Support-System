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
 * Servlet implementation class MemberRegister
 */
@WebServlet(urlPatterns = { "/MemberRegister" })
public class MemberRegister extends HttpServlet {
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
				System.out.println("MemberRegister-connection established");
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
			int flag = 0;
			String formOTP = request.getParameter("otp2");
			String otp = (String) session.getAttribute("code");

			if (formOTP.equals(otp)) {
				String jurisdiction = (String) session.getAttribute("jurisdiction");
				String college = "";
				if (jurisdiction.equals("College")) {
					college = (String) session.getAttribute("mcollege");
					flag = 1;
				}
				String university = (String) session.getAttribute("muniversity");
				String firstname = (String) session.getAttribute("mfirstname");
				String lastname = (String) session.getAttribute("mlastname");
				String email = (String) session.getAttribute("memail");
				String pass = (String) session.getAttribute("mpassword");
				String gender = (String) session.getAttribute("mgender");

				SecureHash c = new SecureHash(pass);
				String passCode = c.getHash();
				int rs = stat.executeUpdate("insert into user(user_email,user_password,user_role) values('" + email
						+ "','" + passCode + "','Member');");
				int rs1 = 0, rs2 = 0;
				if (flag == 0)// University purview
				{
					rs1 = stat.executeUpdate(
							"insert into members(jurisdiction,muniversity,mfirstname,mlastname,memail,mpassword,mgender) values('"
									+ jurisdiction + "','" + university + "','" + firstname + "','" + lastname + "','"
									+ email + "','" + passCode + "','" + gender + "');");
				}
				if (flag == 1) // College purview
				{
					rs2 = stat.executeUpdate(
							"insert into members(jurisdiction,mcollege,muniversity,mfirstname,mlastname,memail,mpassword,mgender) values('"
									+ jurisdiction + "','" + college + "','" + university + "','" + firstname + "','"
									+ lastname + "','" + email + "','" + passCode + "','" + gender + "');");
				}
				if ((rs > 0 && rs1 > 0) || (rs > 0 && rs2 > 0)) {
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
