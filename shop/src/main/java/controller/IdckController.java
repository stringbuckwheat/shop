package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.SignService;

@WebServlet("/idckController")
public class IdckController extends HttpServlet{
	private SignService signService;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setContentType("application/json");
		resp.setCharacterEncoding("utf-8");
		
		this.signService = new SignService();
		String idck = req.getParameter("idck");
		System.out.println("IdCkController idck: " + idck);
		boolean isValidId = this.signService.checkId(idck);
		
		Gson gson = new Gson();
		String jsonStr = "n"; // 기본값 false
		
		if(isValidId) {
			jsonStr = "y";
		}
		
		jsonStr = gson.toJson(jsonStr);
		
		PrintWriter out = resp.getWriter();
		out.println(jsonStr);
		out.flush();
		out.close(); // 스트림은 가비지 콜렉터 대상이 아니기때문에 close해준다.
	}	
}
