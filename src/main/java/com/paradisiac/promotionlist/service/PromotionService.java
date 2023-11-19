package com.paradisiac.promotionlist.service;

import java.sql.Date;

import com.paradisiac.promotionlist.model.PromotionListDAO_interface;
import com.paradisiac.promotionlist.model.PromotionListJDBCDAO;
import com.paradisiac.promotionlist.model.PromotionVO;
import com.paradisiac.util.HibernateUtil;



public class PromotionService {
	private PromotionListDAO_interface pro;

	public PromotionService() {
		pro = new PromotionListJDBCDAO(HibernateUtil.getSessionFactory());
	}
	
	public PromotionVO addPro(String proname,String prodes,Date startdate,Date enddate,Double discount,Boolean status) {

		PromotionVO proVO = new PromotionVO();

		
		proVO.setProname(proname);
		proVO.setProdes(prodes);
		proVO.setStartdate(startdate);
		proVO.setEnddate(enddate);
		proVO.setDiscount(discount);
		proVO.setStatus(status);
		Integer prono  = pro.addPromotionList(proVO);
		proVO.setProno(prono);

		return proVO;
	}

}
