package com.paradisiac.act.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.paradisiac.act.model.ActVO;
import com.paradisiac.act.service.ActServiceImpl;
import com.paradisiac.schd.model.SchdVO;

@WebServlet("/act.do")
@MultipartConfig
public class ActServlet extends HttpServlet{
	
	private ActServiceImpl actSvc;
	
	public void init() throws ServletException{
		actSvc = new ActServiceImpl();
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String forwardPath = "";

		switch (action) {
			case "getAll":
				forwardPath = getAllActs(req, res);
				break;
			case "insert":
				forwardPath = insertOrUpdate(req, res);
				break;
			case "getOne_For_Display":
				getOneForDisplay(req, res);
				forwardPath = "/back-end/act/list_one_act.jsp";
				break;
			case "getOneActAllSchd":
				getOneForDisplay(req, res);
				forwardPath = "/back-end/act/list_act_schd.jsp";
				break;
			case "getOne_For_Update":
				getOneForDisplay(req, res);
				forwardPath = "/back-end/act/update_act.jsp";
				break;
			case "update":
				forwardPath = insertOrUpdate(req, res);
				break;
			case "getAll_Front"://回傳前端活動頁面
				getAllActiveActs(req, res); 
				forwardPath = "/front-end/act_schd/select_act_front.jsp";
				break;
			case "getAllSchd_Schd": //回傳前端檔期頁面
				getAllActiveSchds(req, res);
				forwardPath = "/front-end/act_schd/select_schd_front.jsp";
				break;
			default:
				forwardPath = "/back-end/act/add_act.jsp";
		}	
		res.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = req.getRequestDispatcher(forwardPath);
		dispatcher.forward(req, res);
		
		
	}//doPost
	
	//查全部
	private String getAllActs(HttpServletRequest req, HttpServletResponse res) {
		String page = req.getParameter("page"); 
		int currentPage = (page == null) ? 1 : Integer.parseInt(page); 
		
		List<ActVO> actList = actSvc.getAllActs(currentPage);

		if (req.getSession().getAttribute("actPageQty") == null) {
			int actPageQty = actSvc.getPageTotal();
			req.getSession().setAttribute("actPageQty", actPageQty);
		}
		
		req.setAttribute("actList", actList);
		req.setAttribute("currentPage", currentPage);

		return "/back-end/act/select_act.jsp";
	}


	// 新增或修改
	private String insertOrUpdate(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		List<String> errorMsgs = new LinkedList<String>();
		Integer actNo = null;

		if (req.getParameter("actNo") != null && req.getParameter("actNo").length() != 0) { // 修改
			actNo = Integer.valueOf(req.getParameter("actNo"));			
		}
		String actName = req.getParameter("actName");
		Integer unitPrice = Integer.valueOf(req.getParameter("unitPrice"));
		Integer lowNum = Integer.valueOf(req.getParameter("lowNum"));
		Integer highNum = Integer.valueOf(req.getParameter("highNum"));
		boolean actStatus = Boolean.valueOf(req.getParameter("actStatus"));
		String actContent = req.getParameter("actContent");

		byte[] actPho1 = null;
		
		if(lowNum > highNum) {
			errorMsgs.add("成團人數須小於上限人數");
		}

		// 開始打包
		ActVO actVO = new ActVO(actName, unitPrice, actStatus, actContent);
		if (req.getParameter("actNo") != null) { // 修改要set PK
			actVO.setActNo(actNo);			
		}
		if (req.getPart("actPho1") != null) { // 有選照片1		
				Part part = req.getPart("actPho1");
				InputStream is = part.getInputStream();
				actPho1 = new byte[is.available()];
				is.read(actPho1);
				is.close();
				actVO.setActPho1(actPho1);		
		}
		
		//上架需檢查是否有有效檔期
		
		if (actStatus == true) {
System.out.println("有判斷status");
			if (actSvc.getActiveSchdByActno(actNo) == null) {
				errorMsgs.add("活動不存在有效檔期無法上架");
			}
		}
		
		//如果有錯誤處理輸出
		if (!errorMsgs.isEmpty()) {
			req.setAttribute("errorMsgs", errorMsgs); // 含有輸入格式錯誤的物件,也存入req
			req.setAttribute("actVO", actVO);
			if(req.getParameter("actNo") != null && req.getParameter("actNo").length() != 0) { //跳回修改頁面
				return "/back-end/act/update_act.jsp";
			}else {
				return "/back-end/act/add_act.jsp"; //跳回新增頁面
			}			
		}
		//開始新增或修改
		actSvc.addOrUpdateAct(actVO);
		req.setAttribute("actVO", actVO);
		String forwardPath = getAllActs(req, res);
		return forwardPath; //跳回查詢全部活動頁面
	}//新增或修改
	
	//查單筆活動與檔期
	public void getOneForDisplay(HttpServletRequest req, HttpServletResponse res) {
		Integer actNo = Integer.valueOf(req.getParameter("actNo"));
		
		Set<SchdVO> actSchdSet = actSvc.getSchdByActno(actNo);
		req.setAttribute("actSchdSet", actSchdSet);
		
		ActVO actVO = actSvc.getActByActno(actNo);
		req.setAttribute("actVO", actVO);
		
	}
	//前端-查全部上架活動
	private void getAllActiveActs(HttpServletRequest req, HttpServletResponse res) {
		String page = req.getParameter("page"); 
		int currentPage = (page == null) ? 1 : Integer.parseInt(page); 
		
		List<ActVO> actList = actSvc.getAllActiveActs(currentPage);

		if (req.getSession().getAttribute("actPageQty") == null) {
			int actPageQty = actSvc.getPageActiveTotal();
			req.getSession().setAttribute("actPageQty", actPageQty);
		}		
		req.setAttribute("actList", actList);
		req.setAttribute("currentPage", currentPage);

		

	}
	//前端-查上架活動的開放檔期
	public void getAllActiveSchds(HttpServletRequest req, HttpServletResponse res) {
		Integer actNo = Integer.valueOf(req.getParameter("actNo"));
		
		ActVO actVO = actSvc.getActByActno(actNo); //顯示在檔期頁面
		req.setAttribute("actVO", actVO);
		
		Set<SchdVO> actSchdSet = actSvc.getActiveSchdByActno(actNo); 
		req.setAttribute("actSchdSet", actSchdSet);//顯示在檔期頁面 
		
	}

	

}//class
