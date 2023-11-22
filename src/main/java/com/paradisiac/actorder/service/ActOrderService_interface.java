package com.paradisiac.actorder.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

import com.paradisiac.actattendees.model.ActAttendees;
import com.paradisiac.actorder.model.ActOrder;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.schd.model.SchdVO;

public interface ActOrderService_interface {
	//資料庫11欄
	int addActOrder(Integer memNo, SchdVO schdVO, EmpVO empVO, LocalDateTime orderTime, Integer aAtnNum,
			Integer orderStatus, Integer orderAmount, Set<ActAttendees> actAttendees);

	int updateActOrder(Integer actOrderNo,Integer memNo,SchdVO schdVO,EmpVO empVO,LocalDateTime orderTime,Integer aAtnNum,
			Integer orderStatus,Integer orderAmount,Set<ActAttendees> actAttendees);
	
	ActOrder getOneByActOrderNo(Integer actOrderNo);
	List<ActOrder> getAll();

	int cancelAct(SchdVO schdVO);//該檔期下所有訂單狀態改變



	
	
	
	
}
