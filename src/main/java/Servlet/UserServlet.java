package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import entity.Person;

@WebServlet(name = "UserServlet", urlPatterns = { "/UserServlet" })
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static List<Person> userList = new ArrayList<Person>();
	private static Integer size=userList.size();
	public UserServlet() {
		super();
		userList.add(new Person(1, "Mehmet", "Özkan", "021200000"));
		userList.add(new Person(2, "Erkan", "Arslan", "021600000"));
		userList.add(new Person(3, "musta", "can", "021600000"));
	}
	 @Override
	    public String getServletInfo() {
	        return "Short description";
	    } 

	protected void processRequest(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		try {
			String op = request.getParameter("op");
			String result = "";
			if (op.equals("user_list")) {
				result = UserList(request); 
			}else if(op.equals("user_silme")){
				result = UserSilme(request); 
			}
			else if(op.equals("user_ekleme")){
				result = UserEkleme(request); 
				
			}
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.setHeader("Access-Control-Allow-Methods", "POST");
			response.setHeader("Access-Control-Allow-Headers", "Content-Type");
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", 0);
			 
			// response.setHeader("Cache-control", "no-cache, no-store");
			// response.setHeader("Pragma", "no-cache");
			// response.setHeader("Expires", "-1");
			// response.setHeader("Access-Control-Allow-Origin", "*");
			// response.setHeader("Access-Control-Allow-Methods", "POST");
			// response.setHeader("Access-Control-Allow-Headers", "Content-Type");
			// response.setHeader("Access-Control-Max-Age", "86400");
			
//			response.setContentType("text/html; charset=UTF-8");
			 PrintWriter writer = response.getWriter();
			 writer.append(result);
				writer.flush();
			  
		} catch (Exception e) {
			System.out.println("ERROR: " + e);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", 0);
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setHeader("Access-Control-Allow-Methods", "POST");
			response.setHeader("Access-Control-Allow-Headers", "Content-Type");
			response.setHeader("Access-Control-Max-Age", "86400");

//			response.setContentType("text/html; charset=UTF-8");
			 PrintWriter writer = response.getWriter();
				writer.append("{\"error\":\"" + e + "\",\"code\":1002}");
				writer.flush();
	 
		}
	}

	private String UserEkleme(HttpServletRequest request) {
		size=userList.size();
		size++;
		
		String[] objList  = request.getParameterValues("arrayList[]");
		
		if(objList!=null)
		userList.add(new Person(size,objList[0], objList[1], objList[2]));
 
		
		Gson gson = new GsonBuilder().excludeFieldsWithModifiers(
				Modifier.STATIC, Modifier.TRANSIENT, Modifier.VOLATILE)
				.create();
		return gson.toJson(userList);
	}
	private String UserList(HttpServletRequest request) {
 
		Gson gson = new GsonBuilder().excludeFieldsWithModifiers(
				Modifier.STATIC, Modifier.TRANSIENT, Modifier.VOLATILE)
				.create();
		return gson.toJson(userList);
	}
	private String UserSilme(HttpServletRequest request) {
		String id = request.getParameter("id"); 
		
		for (Person person : userList) {
			if(person.getId()==Integer.parseInt(id)){
			 userList.remove(person); 
			 break;
			 }
		} 
		size=userList.size();
 
		Gson gson = new GsonBuilder().excludeFieldsWithModifiers(
				Modifier.STATIC, Modifier.TRANSIENT, Modifier.VOLATILE)
				.create();
		return gson.toJson(userList);
	}
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
}