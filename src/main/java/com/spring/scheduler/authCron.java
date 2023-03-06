package com.spring.scheduler;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.green2209S_10.dao.AdminDAO;
import com.spring.green2209S_10.dao.HomeDAO;
import com.spring.green2209S_10.vo.CgvMemberVO;

@Component
@Service
public class authCron {

	@Autowired
	HomeDAO homeDAO;
	
	@Autowired
	AdminDAO adminDAO;
	
	// DB에 INSERT된지 3분지난 데이터를 삭제
	public void emailAuthDelete() {
		homeDAO.Auth3MinitSearch();
	}

	// 오늘 방문자수 매일 낮 12시에 초기화, 제제내용이있는 멤버 제재 일수 확인 후 업데이트
	public void todayReset() {
		adminDAO.todayReset();
		adminDAO.todayAmountReset();
		
		List<CgvMemberVO> vos = adminDAO.getMemberAllList();
		List<CgvMemberVO> mvos = new ArrayList<CgvMemberVO>();
		
		
		for(int i = 0 ; i < vos.size(); i++) {
			if(!vos.get(i).getMem_reportContent().equals("")) {
				mvos.add(vos.get(i));
			}
		}
		
		for(int i = 0; i < mvos.size(); i++) {
			System.out.println(mvos.get(i));
			if(mvos.get(i).getMem_reportContent().equals("1일 게시물 게시정지")) {
				adminDAO.setMemberReportContentUpdateCron(mvos.get(i).getMem_id(),mvos.get(i).getMem_reportDate(),1);
			}
			else if(mvos.get(i).getMem_reportContent().equals("3일 게시물 게시정지")) {
				adminDAO.setMemberReportContentUpdateCron(mvos.get(i).getMem_id(),mvos.get(i).getMem_reportDate(),3);
			} 
			else if(mvos.get(i).getMem_reportContent().equals("한달 게시물 게시정지")) {
				adminDAO.setMemberReportContentUpdateCron(mvos.get(i).getMem_id(),mvos.get(i).getMem_reportDate(),30);
			} 
			
		}
		
		
		
		
		
		
		
		
		
		
		
	}
	
	
}
