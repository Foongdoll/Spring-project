package com.spring.green2209S_10.service;

import java.util.List;

import com.spring.green2209S_10.vo.CgvAdminMainVO;
import com.spring.green2209S_10.vo.CgvMemberVO;

public interface AdminService {

	public CgvAdminMainVO getAdminMain();

	public List<CgvMemberVO> getMemberList(String searchStr, String part, int startIndexNo, int pageSize);


}
