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
 * Servlet implementation class Login
 */
@WebServlet(urlPatterns = { "/Login" })
public class Login extends HttpServlet {
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
				System.out.println("connection established");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");

		try {
			Statement stat = con.createStatement();
			String email = request.getParameter("login_email");
			String pass = request.getParameter("login_password");
			SecureHash c = new SecureHash(pass);
			String checkSum = c.getHash();
			HttpSession session = request.getSession();
			ResultSet r = stat.executeQuery("select user_email from user where user_email='" + email + "';");
			r.beforeFirst();
			if (r.next() == false) {
				String path = "Login.html?param=fail1";
				response.sendRedirect(path);
			} else {
				String role = "";
				String userEmail = "";
				ResultSet rs = stat.executeQuery("select user_email,user_role from user where user_email='" + email
						+ "' and user_password='" + checkSum + "';");
				rs.beforeFirst();
				if (rs.next() == false) {
					String path = "Login.html?param=fail";
					response.sendRedirect(path);
				} else {
					role = rs.getString("user_role");
					userEmail = rs.getString("user_email");
					session.setAttribute("role",role);
					if (role.equals("Student")) // Student role
					{
						Statement stat1 = con.createStatement();
						ResultSet res1 = stat1.executeQuery(
								"select firstname,lastname,email,gender,course,year,branch,college,university from student where email = '"
										+ userEmail + "';");
						while (res1.next()) {
							session.setAttribute("sfirstname", res1.getString("firstname"));
							session.setAttribute("slastname", res1.getString("lastname"));
							session.setAttribute("semail", res1.getString("email"));
							session.setAttribute("sgender", res1.getString("gender"));
							session.setAttribute("scourse", res1.getString("course"));
							session.setAttribute("syear", res1.getInt("year"));
							session.setAttribute("sbranch", res1.getString("branch"));
							session.setAttribute("scollege", res1.getString("college"));
							session.setAttribute("suniversity", res1.getString("university"));
						}
						String path = "StudentPage.jsp";
						response.sendRedirect(path);
						//request.getRequestDispatcher("StudentPage.jsp").include(request, response);
					} else if(role.equals("Member"))// Member role
					{
						Statement stat2 = con.createStatement();
						ResultSet res2 = stat2.executeQuery(
								"select jurisdiction,mcollege,muniversity,mfirstname,mlastname,memail,mgender from members where memail = '"
										+ userEmail + "';");
						
						while (res2.next()) {
							session.setAttribute("jurisdiction", res2.getString("jurisdiction"));
							session.setAttribute("mcollege", res2.getString("mcollege"));
							session.setAttribute("muniversity", res2.getString("muniversity"));
							session.setAttribute("mfirstname", res2.getString("mfirstname"));
							session.setAttribute("mlastname", res2.getString("mlastname"));
							session.setAttribute("memail", res2.getString("memail"));
							session.setAttribute("mgender", res2.getString("mgender"));
						}
						String path = "MemberPage.jsp";
						response.sendRedirect(path);
						//request.getRequestDispatcher("MemberPage.jsp").include(request, response);
					}
					else
					{
						session.setAttribute("role","Admin");
						//request.getRequestDispatcher("AdminPage.jsp").include(request, response);
						String path = "AdminPage.jsp";
						response.sendRedirect(path);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
