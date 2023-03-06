package com.spring.green2209S_10.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_10.vo.CgvBoardVO;
import com.spring.green2209S_10.vo.CgvCommentVO;
import com.spring.green2209S_10.vo.GoodVO;

public interface BoardDAO {


	public List<CgvBoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCnt();

	public int setBoardInput(@Param("vo") CgvBoardVO vo);

	public CgvBoardVO getBoardContent(@Param("idx") int idx);

	public void setBoardReadNum(@Param("idx") int idx);

	public void setBoardGoodPlus(@Param("idx") int idx);

	public void setGoodPlusMinus(@Param("idx") int idx, @Param("goodCnt") int goodCnt);

	public void boardGoodFlagCheck(@Param("idx") int idx, @Param("gFlag") int gFlag);

	public GoodVO getBoardGoodCheck(@Param("partIdx") int partIdx, @Param("part") String part, @Param("mid") String mid);

	public ArrayList<CgvBoardVO> getPrevNext(@Param("idx") int idx);

	public void setBoardDeleteOk(@Param("idx") int idx);

	public void setBoardUpdateOk(@Param("vo") CgvBoardVO vo);

	public void setGoodDBInput(@Param("goodVo") GoodVO goodVo);

	public void setGoodDBDelete(@Param("idx") int idx);

	public void setGoodUpdate(@Param("idx") int idx, @Param("item") int item);

	public void setBoardReplyInput(@Param("replyVo") CgvCommentVO replyVo);

	public List<CgvCommentVO> getBoardReply(@Param("idx") int idx);

	public void setBoardReplyDeleteOk(@Param("idx") int idx);

	public String getMaxLevelOrder(@Param("boardIdx") int boardIdx);

	public void setLevelOrderPlusUpdate(@Param("replyVo") CgvCommentVO replyVo);

	public void setBoardReplyInput2(@Param("replyVo") CgvCommentVO replyVo);

	public String getMaxGroupId(@Param("boardIdx") int boardIdx);

	public void setBoardReplyUpdate(@Param("idx") int idx, @Param("content") String content, @Param("hostIp") String hostIp);

}
