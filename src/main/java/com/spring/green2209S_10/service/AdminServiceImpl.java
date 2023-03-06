package com.spring.green2209S_10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_10.dao.AdminDAO;
import com.spring.green2209S_10.vo.CgvAdminMainVO;
import com.spring.green2209S_10.vo.CgvMemberVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;

	@Override
	public CgvAdminMainVO getAdminMain() {
		return adminDAO.getAdminMain();
	}

	@Override
	public List<CgvMemberVO> getMemberList(String searchStr, String part, int startIndexNo, int pageSize) {
		return adminDAO.getMemberList(searchStr,part,startIndexNo,pageSize);
	}
	
	
	
	
}
