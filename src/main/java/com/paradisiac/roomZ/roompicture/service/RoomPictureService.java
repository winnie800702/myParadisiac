package com.paradisiac.roomZ.roompicture.service;

import java.util.List;

import com.paradisiac.roomZ.roompicture.dao.RoomPictureDAO;
import com.paradisiac.roomZ.roompicture.entity.RoomPictureeVO;
import com.paradisiac.roomZ.roompicture.dao.RoomPictureDAOImpl;
import com.paradisiac.util.HibernateUtil;

public class RoomPictureService {
	  private RoomPictureDAO dao;
	  
		public RoomPictureService() {
			dao = new RoomPictureDAOImpl(HibernateUtil.getSessionFactory());
		}
		
		 public RoomPictureeVO addpic(
                 Integer roomTypeNo,
                 byte[] Pic
		 ) {

			 RoomPictureeVO roomPictureVO = new RoomPictureeVO();
			 roomPictureVO.setRoomTypeNo(roomTypeNo);
			 roomPictureVO.setPic(Pic);
		     dao.insert(roomPictureVO);
		     return roomPictureVO;
		 }
		 
		
			public List<RoomPictureeVO> getAllpic() {
				
				 return dao.getAll();
			}

//		 public RoomPictureVO updateAdmin(Integer roomPictureNo,
//				  
//				 Integer roomTypeNo,
//	                 byte[] Pic
//                 
//		) {
//			 RoomPictureVO roomPictureVO = dao.findByPrimaryKey(roomPictureNo); 
//		if (roomPictureVO != null) {
//			
//			 roomPictureVO.setPictureNo(roomPictureNo);
//			 roomPictureVO.setRoomTypeNo(roomTypeNo);
//			 roomPictureVO.setPic(Pic);
//		  dao.update(roomPictureVO);
//		}
//		return dao.findByPrimaryKey(roomPictureNo);
//		}
		 
}
