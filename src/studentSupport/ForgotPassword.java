package studentSupport;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = { "/ForgotPassword" })
public class ForgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		try {
			HttpSession session = request.getSession(false);
			String code = (String) session.getAttribute("code");
			String form_code = request.getParameter("code");
			if (form_code.equals(code)) {
				request.getRequestDispatcher("ChangePassword.html").forward(request,response);
			} else {
				String path = "Verify.html?param=wrong_code";
				response.sendRedirect(path);
			}
		} 
		catch (Exception e) {
			System.out.println(e);
			String path = "Verify.html?param=error";
			response.sendRedirect(path);
		}
	}

}
