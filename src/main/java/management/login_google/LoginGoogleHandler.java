package management.login_google;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import management.dao.ITaiKhoanDAO;

import java.io.IOException;
//import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.apache.http.client.fluent.Form;

/**
 * @author heaty566
 */
//@WebServlet(urlPatterns = { "/login_google/LoginGoogleHandler" })
@WebServlet(name = "LoginGoogleHandler", urlPatterns = "/login_google/LoginGoogleHandler")


public class LoginGoogleHandler extends HttpServlet {

	
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("code");
		String accessToken = getToken(code);
		 UserGoogleDto user = getUserInfo(accessToken);
		
		
		// Lưu email vào session
		// Lấy đối tượng HttpSession từ request
		HttpSession session = request.getSession();

		// Lấy thông tin email từ đối tượng UserGoogleDto (user) đã lấy được từ Google
		String userEmail = user.getEmail();

		// Lưu email vào session với một tên key cụ thể (ví dụ: "loggedInUserEmail")
		session.setAttribute("loggedInUserEmail", userEmail);
		if(userEmail !=null) session.setAttribute("login", true);
		else session.setAttribute("login", false);
		// Sau khi lưu email vào session, chuyển hướng đến controller TaiKhoanController
	    response.sendRedirect(request.getContextPath() + "/register/insert");
		
//		if (taiKhoanDAO != null) {
//	        ("Bean taiKhoanDAO đã được tiêm vào.");
//	    } else {
//	        ("Bean taiKhoanDAO chưa được tiêm vào.");
//	    }
		// Ktra neu email chua ton tai thi chuyen huong den trang dang ki tai khoan
//		if(iTaiKhoanDAO.check_MailExist(userEmail)==false)
//		{
//			// chuyển hướng đến view đăng kí thông tin 
//			ServletContext context = getServletContext();
//		    RequestDispatcher dispatcher = context.getRequestDispatcher("/WEB-INF/views/register.jsp");
//		    dispatcher.forward(request, response);
//		}
		
		
		
	}

	public static String getToken(String code) throws ClientProtocolException, IOException {
		// call api to get token
		String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
				.bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
						.add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
						.add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
						.add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
				.execute().returnContent().asString();

		JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
		String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
		return accessToken;
	}

	public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
		String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
		String response = Request.Get(link).execute().returnContent().asString();

		UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);

		return googlePojo;
	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the +
	// sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}