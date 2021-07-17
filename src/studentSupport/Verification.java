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
 * Servlet implementation class Verification
 */
@WebServlet(urlPatterns = { "/Verification" })
public class Verification extends HttpServlet {
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
				System.out.println("Verification-connection established");
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
			HttpSession session1 = request.getSession(false);
			if (session1 != null) {
				session1.invalidate();

			}
			HttpSession session = request.getSession();
			String email = request.getParameter("email");
			Statement stat = con.createStatement();
			ResultSet res = stat.executeQuery("select user_email from user where user_email='" + email + "';");
			int i = 0;
			while (res.next()) {
				i++;
			}
			if (i > 0) {
				String mes = "Verification Code from Student Grievance Support";
				String num = "";
				Random rnd = new Random();
				int n = 100000 + rnd.nextInt(900000);
				num = num + n;
				SendEmail s = new SendEmail(email, mes, num);
				s.setMailServerProperties();
				s.createEmailMessage();
				s.sendEmail();
				session.setAttribute("code", num);
				session.setAttribute("passmail", email);
				request.getRequestDispatcher("EmailValidation.html").forward(request, response);
			} else {
				String path = "Verify.html?param=noregister";
				response.sendRedirect(path);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}