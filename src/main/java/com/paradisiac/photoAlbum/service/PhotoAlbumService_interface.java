package com.paradisiac.photoAlbum.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.paradisiac.photo.model.PhoWithAlbDTO;
import com.paradisiac.photoAlbum.model.PhotoAlbumVO;

public interface PhotoAlbumService_interface {
	int addPha(PhotoAlbumVO phaVO);
	
	PhotoAlbumVO updatePha(PhotoAlbumVO phaVO);
	
	void deletePha(Integer albNo);
	
	PhotoAlbumVO getPhaByPK(Integer albNo);
	
	List<PhotoAlbumVO> getAllPha(int currentPage);
	
	List<PhotoAlbumVO> getAllPha();
	
	int getPageTotal();
	
	List<PhotoAlbumVO> getPhaByCompositeQuery(Map<String, String[]> map);
	
	Integer getPhaByMem(Integer memno);
	
	
}
