package com.spring.green2209S_10.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.green2209S_10.vo.CgvBoardVO;
import com.spring.green2209S_10.vo.CgvCommentVO;
import com.spring.green2209S_10.vo.GoodVO;

public interface BoardService {

	public List<CgvBoardVO> getBoardList(int startIndexNo, int pageSize);

	public int setBoardInput(CgvBoardVO vo);

	public CgvBoardVO getBoardContent(int idx);

	public void setBoardReadNum(int idx);

	public void setBoardGoodPlus(int idx);

	public void setGoodPlusMinus(int idx, int goodCnt);

	public void boardGoodFlagCheck(int idx, int gFlag);

	public GoodVO getBoardGoodCheck(int partIdx, String part, String mid);

	public ArrayList<CgvBoardVO> getPrevNext(int idx);

	public void imgCheck(String content);

	public void setBoardDeleteOk(int idx);

	public void imgDelete(String content);

	public void imgCheckUpdate(String content);

	public void setBoardUpdateOk(CgvBoardVO vo);

	public void setGoodDBInput(GoodVO goodVo);

	public void setGoodDBDelete(int idx);

	public void setGoodUpdate(int idx, int item);

	public void setBoardReplyInput(CgvCommentVO replyVo);

	public List<CgvCommentVO> getBoardReply(int idx);

	public void setBoardReplyDeleteOk(int idx);

	public String getMaxLevelOrder(int boardIdx);

	public void setLevelOrderPlusUpdate(CgvCommentVO replyVo);

	public void setBoardReplyInput2(CgvCommentVO replyVo);

	public String getMaxGroupId(int boardIdx);

	public void setBoardReplyUpdate(int idx, String content, String hostIp);
}
