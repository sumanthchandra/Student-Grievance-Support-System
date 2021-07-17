package studentSupport;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

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
@WebServlet(urlPatterns = { "/RegisterOTP" })
public class RegisterOTP extends HttpServlet {
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
				System.out.println("RegisterOTP-connection established");
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
			String form = request.getParameter("form-name");
			HttpSession session = request.getSession();
			String mes = "Verification Code from Student Grievance Support";
			String num = "";
			Random rnd = new Random();
			int n = 100000 + rnd.nextInt(900000);
			num = num + n;
			session.setAttribute("code", num);

			if (form.equals("Student")) {
				String firstname = request.getParameter("firstname");
				session.setAttribute("firstname", firstname);
				String lastname = request.getParameter("lastname");
				session.setAttribute("lastname", lastname);
				String email = request.getParameter("email");
				session.setAttribute("email", email);
				String pass = request.getParameter("password");
				session.setAttribute("password", pass);
				String gender = request.getParameter("gender");
				session.setAttribute("gender", gender);
				String course = request.getParameter("course");
				session.setAttribute("course", course);
				String year = request.getParameter("year");
				session.setAttribute("year", year);
				String branch = request.getParameter("branch");
				session.setAttribute("branch", branch);
				String college = request.getParameter("college");
				session.setAttribute("college", college);
				String university = request.getParameter("university");
				session.setAttribute("university", university);

				Statement stat = con.createStatement();
				ResultSet rset = stat
						.executeQuery("select user_email,user_role from user where user_email ='" + email + "';");
				int i = 0;
				while (rset.next()) {
					i++;
				}
				if (i == 0) {
					SendEmail s = new SendEmail(email, mes, num);
					s.setMailServerProperties();
					s.createEmailMessage();
					s.sendEmail();
					String path = "OTP.html?param=student";
					response.sendRedirect(path);
				} else {
					String path = "HomePage.html?param=exist";
					response.sendRedirect(path);
				}
			} else {
				String jurisdiction = request.getParameter("jurisdiction");
				session.setAttribute("jurisdiction", jurisdiction);
				String college = "";
				if (jurisdiction.equals("College")) {
					college = request.getParameter("mcollege");
					session.setAttribute("mcollege", college);
				}
				String university = request.getParameter("muniversity");
				session.setAttribute("muniversity", university);
				String firstname = request.getParameter("mfirstname");
				session.setAttribute("mfirstname", firstname);
				String lastname = request.getParameter("mlastname");
				session.setAttribute("mlastname", lastname);
				String email = request.getParameter("memail");
				session.setAttribute("memail", email);
				String gender = request.getParameter("mgender");
				session.setAttribute("mgender", gender);
				String pass = request.getParameter("mpassword");
				session.setAttribute("mpassword", pass);

				Statement stat = con.createStatement();
				ResultSet rset = stat
						.executeQuery("select user_email,user_role from user where user_email ='" + email + "';");
				int i = 0;
				while (rset.next()) {
					i++;
				}
				if (i == 0) {

					Statement stat1;
					ResultSet rset1;
					if (jurisdiction.equals("College")) {
						stat1 = con.createStatement();
						rset1 = stat1
								.executeQuery("select memail from members where jurisdiction='College' and mcollege='"
										+ college + "';");
					} else {
						stat1 = con.createStatement();
						rset1 = stat1.executeQuery(
								"select memail from members where jurisdiction='University' and muniversity='"
										+ university + "';");
					}
					int j = 0;
					while (rset1.next()) {
						j++;
					}
					if (j == 0) {
						SendEmail s = new SendEmail(email, mes, num);
						s.setMailServerProperties();
						s.createEmailMessage();
						s.sendEmail();
						String path = "OTP.html?param=member";
						response.sendRedirect(path);
					} else {
						String path = "HomePage.html?param=mexist";
						response.sendRedirect(path);
					}
				} else {
					String path = "HomePage.html?param=exist";
					response.sendRedirect(path);
				}
			}
		} catch (Exception e) {
			String path = "HomePage.html?param=wrong";
			response.sendRedirect(path);
			e.printStackTrace();
		}
	}

}
