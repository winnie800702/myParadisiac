package com.paradisiac.cart;

import java.io.BufferedReader;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import redis.clients.jedis.Jedis;

@WebServlet("/Cart")
public class Cart extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		Object memnoObject = session.getAttribute("memno");// 什麼都可以存所以是object
		String memno = (String)memnoObject;
		
		Object sessionObject = session.getAttribute("cart");
		
		String action = request.getParameter("action");
// ==========是會員從redis內取得並且要取得session內的資料加在一起並且送出去=================================
		if (memno != null) {//是會員
			if(sessionObject != null) {//session內有資料
				if ("shoppingCart".equals(action) || "loadCart".equals(action)) {
					
					Jedis jedis = new Jedis("localhost", 6379);
					String redisData = jedis.get("guest1");// 之後改成memno
					
					JSONObject sessionData = new JSONObject(sessionObject);
					
					if (redisData != null) {
		                JSONObject redisDataJSON = new JSONObject(redisData);
		                for (String key : sessionData.keySet()) {    //KeySet陣列
		                    redisDataJSON.put(key, sessionData.get(key));
		                }
		                jedis.set(memno, redisDataJSON.toString());
		            } else {
		                jedis.set(memno, sessionData.toString());
		            }
					
					
					
					JSONObject cartData = new JSONObject(redisData);
	
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(cartData.toString());
					jedis.close();
				}
			}
		}
// ==========不是會員從session內取得=================================
		if (memno == null) {
			if ("shoppingCart".equals(action)  || "loadCart".equals(action)) {
//				Object cartObject = session.getAttribute("cart");// 沒有的話會是空值
				if (sessionObject != null) {
					JSONObject cart = (JSONObject) sessionObject;
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(cart.toString());
				} else {
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					JSONObject errorResponse = new JSONObject();
					errorResponse.put("error", "購物車為空");
					response.getWriter().write(errorResponse.toString());
				}
			}
		}
	}

	
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 解析post過來的json格式
		StringBuilder stringBuilder = new StringBuilder();
		BufferedReader bufferedReader = request.getReader();
		String line;
		while ((line = bufferedReader.readLine()) != null) {
			stringBuilder.append(line);
		}
		JSONObject jsonData = new JSONObject(stringBuilder.toString());
		// 取得json內的資料有action跟data
		String action = jsonData.getString("action");
		JSONObject data = jsonData.getJSONObject("data");// 購物車資訊
		
		// 取得session內的會員資料
		HttpSession session = request.getSession();
		String memno = (String) session.getAttribute("memno");// session什麼都可以存所以是object

		if (memno != null) {
			if ("checkout".equals(action)) {

				// 解析请求体中的 JSON 数据
				String jsonData2 = data.toString();// 可以存json但必須得是字串
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.set("guest1", jsonData2);//改memno
				jedis.close();

				// 返回响应（例如，可以返回处理结果的 JSON 响应）
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				JSONObject addResponse = new JSONObject();
				addResponse.put("add", "已加入購物車");
				response.getWriter().write(addResponse.toString());
			}
		}
		if(memno == null) {
			if ("checkout".equals(action)) {
					session.setAttribute("cart",data);
					System.out.println(data);
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					JSONObject addResponse = new JSONObject();
					addResponse.put("add", "已加入購物車");
					response.getWriter().write(addResponse.toString());
				}
			}
		}
	}


