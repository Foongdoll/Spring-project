package com.spring.green2209S_10.pagnation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_10.dao.AdminDAO;
import com.spring.green2209S_10.dao.MovieDAO;

@Service
public class PageProcess {
	
	@Autowired
	MovieDAO movieDAO;
	
	@Autowired
	AdminDAO adminDAO;
	
	public PageVO getPagination(int pag, int pageSize,PageVO vo,String tableName) {
		int totRecCnt = 0;
		
		if(tableName.equals("CgvReview")) {
			totRecCnt = movieDAO.getTotRecCnt(tableName,vo.getMovieTitle()); 
		}
		else if(tableName.equals("CGVTICKET")) {
			if(vo.getSearchStr() == null) totRecCnt = adminDAO.getTotRecCnt(vo.getPart(),vo.getSearchStr(),tableName,0);
			else totRecCnt = adminDAO.getTotRecCnt(vo.getPart(),vo.getSearchStr(),tableName,1);
		}
		else if(tableName.equals("CGVMEMBER")) {
			
		if(vo.getSearchStr() == null || vo.getPart().equals("")) {
				totRecCnt = adminDAO.getTotRecCnt(vo.getPart(), vo.getSearchStr(),tableName, 0);
			}
			else {
				totRecCnt = adminDAO.getTotRecCnt(vo.getPart(), vo.getSearchStr(),tableName, 1);
			}
		}
		else if(tableName.equals("CGVREPORT")) {
			if(vo.getSearchStr() == null || vo.getPart().equals("")) {
				totRecCnt = adminDAO.getTotRecCnt(vo.getPart(), vo.getSearchStr(), tableName, 0);
			}
			else {
				totRecCnt = adminDAO.getTotRecCnt(vo.getPart(), vo.getSearchStr(), tableName, 1); 
			}
		}
		else if(tableName.equals("CGVCOUPON")) {
			if(vo.getSearchStr() == null  || vo.getPart().equals("")) {
				totRecCnt = adminDAO.getTotRecCnt(vo.getPart(), vo.getSearchStr(), tableName, 0);
			}
			else {
				totRecCnt = adminDAO.getTotRecCnt(vo.getPart(), vo.getSearchStr(), tableName, 1); 
			}
		}
		else if(tableName.equals("CGVBOARD")) {
			if(vo.getSearchStr() == null  || vo.getPart().equals("")) {
				totRecCnt = adminDAO.getTotRecCnt(vo.getPart(), vo.getSearchStr(), tableName, 0);
			}
			else {
				totRecCnt = adminDAO.getTotRecCnt(vo.getPart(), vo.getSearchStr(), tableName, 1); 
			}
		}
			
		
		int totPage = (totRecCnt % pageSize)== 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		
		return vo;
	}
}
