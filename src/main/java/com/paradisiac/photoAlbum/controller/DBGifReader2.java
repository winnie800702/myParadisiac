package com.paradisiac.photoAlbum.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.paradisiac.photoAlbum.service.PhotoAlbumServiceImpl;
import com.paradisiac.photoAlbum.service.PhotoAlbumService_interface;

@WebServlet("/dbg.do")
public class DBGifReader2 extends HttpServlet {
	

	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		String photoCol = null;
		
		
		if(req.getParameter("alb_no") != null) { 
			try {
				Statement stmt = con.createStatement();
				String albNo = req.getParameter("alb_no"); //相簿的id(PK)
				ResultSet rs = stmt.executeQuery(
					"select alb_photo from photo_album where alb_no =" +albNo);//alb_photo是blob照片
				if (rs.next()) {
					photoCol = "alb_photo";
					readPhoto(out, rs, photoCol);
				} else {
					res.sendError(HttpServletResponse.SC_NOT_FOUND); //404 p324, 方法p134
				}
				rs.close();
				stmt.close();
				out.close();
			} catch (Exception e) {
				System.out.println(e); //直接印出錯誤訊息
			}			
		}

		if(req.getParameter("photo_no") != null) {
			try {
				Statement stmt = con.createStatement();
				String photoNo = req.getParameter("photo_no"); 
				ResultSet rs = stmt.executeQuery(
						"select photo from phowithalb where photo_no =" +photoNo);
				if (rs.next()) {
					photoCol = "photo";
					readPhoto(out, rs, photoCol);
				} else {
					res.sendError(HttpServletResponse.SC_NOT_FOUND); //404 p324, 方法p134
				}
				rs.close();
				stmt.close();
				out.close();
			}catch (Exception e) {
			System.out.println(e); //直接印出錯誤訊息
			}
			
		}
		
		if(req.getParameter("act_no") != null) { 
			try {
				Statement stmt = con.createStatement();
				String actNo = req.getParameter("act_no"); 
				ResultSet rs = stmt.executeQuery(
					"select act_photo1 from act where act_no =" +actNo);

				if (rs.next()) {
					photoCol = "act_photo1";
					readPhoto(out, rs, photoCol);
//					BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("act_photo1"));
//					byte[] buf = new byte[4 * 1024]; // 4K buffer
//					int len;
//					while ((len = in.read(buf)) != -1) { //讀到完是-1
//						out.write(buf, 0, len); //從0
//					}
//					in.close();
				} else {
					res.sendError(HttpServletResponse.SC_NOT_FOUND); //404 p324, 方法p134
				}
				rs.close();
				stmt.close();
				out.close();
			} catch (Exception e) {
				System.out.println(e); //直接印出錯誤訊息
			}
			
		}	
	}
	private void readPhoto(ServletOutputStream out, ResultSet rs, String photoCol) throws IOException, SQLException {
        BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(photoCol));
        byte[] buf = new byte[4 * 1024]; // 4K buffer
        int len;
        while ((len = in.read(buf)) != -1) { // 讀到完是-1
            out.write(buf, 0, len); // 從0
        }
        in.close();
    }

//與資料庫連線======================================================================
	public void init() throws ServletException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei", "root", "123456");
		} catch (ClassNotFoundException e) {
			throw new UnavailableException("Couldn't load JdbcOdbcDriver");
		} catch (SQLException e) {
			throw new UnavailableException("Couldn't get db connection");
		}
	}

	public void destroy() {
		try {
			if (con != null) con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}
	

}