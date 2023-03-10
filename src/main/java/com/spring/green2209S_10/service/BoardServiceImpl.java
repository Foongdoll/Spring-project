package com.spring.green2209S_10.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.green2209S_10.dao.BoardDAO;
import com.spring.green2209S_10.vo.CgvBoardVO;
import com.spring.green2209S_10.vo.CgvCommentVO;
import com.spring.green2209S_10.vo.GoodVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<CgvBoardVO> getBoardList(int startIndexNo, int pageSize) {
		return boardDAO.getBoardList(startIndexNo, pageSize);
	}

	@Override
	public int setBoardInput(CgvBoardVO vo) {
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public CgvBoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public void setBoardReadNum(int idx) {
		boardDAO.setBoardReadNum(idx);
	}

	@Override
	public void setBoardGoodPlus(int idx) {
		boardDAO.setBoardGoodPlus(idx);
	}

	@Override
	public void setGoodPlusMinus(int idx, int goodCnt) {
		boardDAO.setGoodPlusMinus(idx, goodCnt);
	}

	@Override
	public void boardGoodFlagCheck(int idx, int gFlag) {
		boardDAO.boardGoodFlagCheck(idx, gFlag);
	}

	@Override
	public GoodVO getBoardGoodCheck(int partIdx, String part, String mid) {
		return boardDAO.getBoardGoodCheck(partIdx, part, mid);
	}

	@Override
	public ArrayList<CgvBoardVO> getPrevNext(int idx) {
		return boardDAO.getPrevNext(idx);
	}

	@Override
	public void imgCheck(String content) {
		//      0         1         2         3         4         5         6
		//      01234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/javawspring/data/ckeditor/230111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
		// content?????? ??????????????? ??????????????? ????????? ?????? ?????? ????????? ??????.(src="/_____~~)
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/board/imgUpload/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = uploadPath + imgFile;
			String copyFilePath = uploadPath + "board/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);  // board????????? ????????? ??????????????? ??????.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		File origFile = new File(origFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(origFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void setBoardDeleteOk(int idx) {
		boardDAO.setBoardDeleteOk(idx);
	}

	@Override
	public void imgDelete(String content) {
		//      0         1         2         3         4         5         6
		//      01234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/javawspring/data/ckeditor/board/230111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
		// content?????? ??????????????? ??????????????? ????????? ?????? ?????? ????????? ??????.(src="/_____~~)
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/board/imgUpload/");
		
		int position = 38;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));	// ??????????????? ????????????
			
			String origFilePath = uploadPath + imgFile;
			
			fileDelete(origFilePath);  // board????????? ????????? ??????????????? ??????.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
		
	}

	@Override
	public void imgCheckUpdate(String content) {
		//      0         1         2         3         4         5         6
		//      01234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/javawspring/data/ckeditor/board/230111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
		// <img src="/javawspring/data/ckeditor/230111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
		// content?????? ??????????????? ??????????????? ????????? ?????? ?????? ????????? ??????.(src="/_____~~)
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/board/imgUpload");
		
		int position = 38;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = uploadPath + imgFile;
			String copyFilePath = request.getSession().getServletContext().getRealPath("/resources/board/" + imgFile);
			
			fileCopyCheck(origFilePath, copyFilePath);  // board????????? ????????? ??????????????? ??????.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	@Override
	public void setBoardUpdateOk(CgvBoardVO vo) {
		boardDAO.setBoardUpdateOk(vo);
	}

	@Override
	public void setGoodDBInput(GoodVO goodVo) {
		boardDAO.setGoodDBInput(goodVo);
	}

	@Override
	public void setGoodDBDelete(int idx) {
		boardDAO.setGoodDBDelete(idx);
	}

	@Override
	public void setGoodUpdate(int idx, int item) {
		boardDAO.setGoodUpdate(idx, item);
	}

	@Override
	public void setBoardReplyInput(CgvCommentVO replyVo) {
		boardDAO.setBoardReplyInput(replyVo);
	}

	@Override
	public List<CgvCommentVO> getBoardReply(int idx) {
		return boardDAO.getBoardReply(idx);
	}

	@Override
	public void setBoardReplyDeleteOk(int idx) {
		boardDAO.setBoardReplyDeleteOk(idx);
	}

	@Override
	public String getMaxLevelOrder(int boardIdx) {
		return boardDAO.getMaxLevelOrder(boardIdx);
	}

	@Override
	public void setLevelOrderPlusUpdate(CgvCommentVO replyVo) {
		boardDAO.setLevelOrderPlusUpdate(replyVo);
	}

	@Override
	public void setBoardReplyInput2(CgvCommentVO replyVo) {
		boardDAO.setBoardReplyInput2(replyVo);
	}

	@Override
	public String getMaxGroupId(int boardIdx) {
		return boardDAO.getMaxGroupId(boardIdx);
	}

	@Override
	public void setBoardReplyUpdate(int idx, String content, String hostIp) {
		boardDAO.setBoardReplyUpdate(idx, content, hostIp);
	}

}