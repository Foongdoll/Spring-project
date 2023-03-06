package com.spring.green2209S_10;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_10.dao.AdminDAO;
import com.spring.green2209S_10.dao.ChatDAO;
import com.spring.green2209S_10.dao.HomeDAO;
import com.spring.green2209S_10.dao.MovieDAO;
import com.spring.green2209S_10.pagnation.PageProcess;
import com.spring.green2209S_10.pagnation.PageVO;
import com.spring.green2209S_10.service.AdminService;
import com.spring.green2209S_10.service.HomeService;
import com.spring.green2209S_10.service.ImgCrawlingService;
import com.spring.green2209S_10.vo.CgvAdminContentVO;
import com.spring.green2209S_10.vo.CgvAdminMainVO;
import com.spring.green2209S_10.vo.CgvBoardVO;
import com.spring.green2209S_10.vo.CgvCouponVO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvMovieChartVO;
import com.spring.green2209S_10.vo.CgvReportVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.ChatContentVO;

@Controller
@RequestMapping("/admin")
public class AdminContorller {

	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	HomeDAO homeDAO;
	
	@Autowired
	MovieDAO movieDAO;
	
	@Autowired
	ImgCrawlingService crawlingService;
	
	@Autowired
	HomeService homeService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ChatDAO chatDAO;
	
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	JavaMailSender mailSender;
	
	
	@RequestMapping(value = "/adminMain", method=RequestMethod.GET)
	public String adminMainGet(Model model, HttpSession session,
			@RequestParam(name = "sw",defaultValue = "0",required = false) int sw) {
		
		List<CgvTicketingPaymentVO> tottkvos = adminDAO.getTotTicketSale();
		model.addAttribute("tottkvos",tottkvos);
		
		List<CgvReportVO> rvos = adminDAO.getAdminReport();
		model.addAttribute("rvos",rvos);

		List<CgvBoardVO> bvos = adminDAO.getAdminBoard();
		model.addAttribute("bvos",bvos);
		
		int no;
		String seatA = "";
		String nos = "";
		String[] nosArr = null;
		String nosRes = "";

		List<CgvTicketingPaymentVO> tvos = adminDAO.getTicketInforList();
		List<String> seatVos = new ArrayList<String>();
		for(int i = 0; i < tvos.size(); i++) {
			nos = tvos.get(i).getTk_seat();
			nosArr = nos.split("/");

			for(int j = 0; j < nosArr.length; j++) {
				no = Integer.parseInt(nosArr[j]);
				if(no > 144 && no < 151) seatA = "A";
				else if(no > 135 && no < 145) seatA = "B";
				else if(no > 126 && no < 136) seatA = "C";
				else if(no > 117 && no < 127) seatA = "D";
				else if(no > 108 && no < 118) seatA = "E";
				else if(no > 99 && no < 109) seatA = "F";
				else if(no > 90 && no < 100) seatA = "G";
				else if(no > 81 && no < 91) seatA = "H";
				else if(no > 72 && no < 82) seatA = "I";
				else if(no > 63 && no < 73) seatA = "J";
				else if(no > 54 && no < 64) seatA = "K";
				else if(no > 45 && no < 55) seatA = "L";
				else if(no > 36 && no < 46) seatA = "M";
				else if(no > 27 && no < 37) seatA = "N";
				else if(no > 18 && no < 28) seatA = "O";
				else if(no > 9 && no < 19) seatA = "P";
				else seatA = "Q";
				
				nosRes += seatA+no +"번&nbsp;";
			}
			seatVos.add(nosRes);
			nosRes = "";
		}
		
		model.addAttribute("seatVos",seatVos);
		List<ChatContentVO> senders = chatDAO.getChatSenderList();
		model.addAttribute("senders",senders);
		
		CgvAdminMainVO avo = adminService.getAdminMain();
		CgvMemberVO vo = homeService.getMemberIdCheck((String)session.getAttribute("sId"));
		model.addAttribute("tvos",tvos);
		model.addAttribute("avo",avo);
		model.addAttribute("vo",vo);
		model.addAttribute("sw",sw);
		
		
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/crawling/crawling", method=RequestMethod.GET)
	public String crawlingGet() {
		return "admin/crawling/crawling";
	}
	
//메인화면 이미지 db저장 및 이미지파일 리얼패스에 저장
	@RequestMapping(value = "/dbsave")
	public String crwling(HttpServletRequest request) throws Exception {
		crawlingService.setDBSave(request);
		return "home";
	}
	
	// 무비차트 정보
	@RequestMapping(value = "/dbsave2")
	public String crwling2(HttpServletRequest request) throws Exception {
		crawlingService.setDBSave2(request);
		System.out.println("전체 작업 종료 이미지 db 저장 완료");
		return "home";
	}
	
	// 영화 상세 정보 크롤링
	@RequestMapping(value = "/dbsave3")
	public String crwling3(HttpServletRequest request) throws Exception {
		crawlingService.setDBSave3(request);
		System.out.println("전체 작업 종료 영화 상세정보 DB저장 완료");
		return "home";
	}
	
	@RequestMapping(value = "/adminMember", method = RequestMethod.GET)
	public String adminMemberGet(Model model,PageVO pageVO,
			@RequestParam(name = "pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name = "pageSize",defaultValue = "8",required = false) int pageSize) {
		
		pageVO = pageProcess.getPagination(pag, pageSize, pageVO, "CGVMEMBER");
		List<CgvMemberVO> vos = adminService.getMemberList(pageVO.getSearchStr(),pageVO.getPart(),pageVO.getStartIndexNo(),pageSize);
		model.addAttribute("vos",vos);
		
		
		return "admin/adminMember";
	}
	
	@RequestMapping(value = "/admin11Contact", method = RequestMethod.GET)
	public String admin11ContactGet(Model model) {
		
		List<ChatContentVO> vos = chatDAO.getChatContentList();
		List<ChatContentVO> senders = chatDAO.getChatSenderList();
		List<CgvMemberVO> mvos = chatDAO.getMemberOnOff();
		
		
		model.addAttribute("mvos",mvos);
		model.addAttribute("senders",senders);
		model.addAttribute("vos",vos);
		return "admin/admin11Contact";
	}
	
	@RequestMapping(value = "/adminReport", method = RequestMethod.GET)
	public String adminReportGet(Model model,PageVO pageVO,
			@RequestParam(name = "pag",defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize",defaultValue = "10", required = false) int pageSize	) {
		
		pageVO = pageProcess.getPagination(pag, pageSize, pageVO, "CGVREPORT");
		List<CgvReportVO> vos = adminDAO.getReviewReportList(pageVO.getSearchStr(),pageVO.getPart(),pageVO.getStartIndexNo(),pageVO.getPageSize());
		
		model.addAttribute("vos",vos);
		
		return "admin/adminReport";
	}

	@ResponseBody
	@RequestMapping(value = "/adminMemberInfor", method = RequestMethod.POST)
	public CgvMemberVO adminMemberInforPost(String id) {
		CgvMemberVO vo = new CgvMemberVO();
		vo = homeService.getMemberIdCheck(id);
		return vo;
	}
	
	
	@SuppressWarnings("null")
	@RequestMapping(value = "/ticket", method = RequestMethod.GET)
	public String ticketGet(Model model,PageVO pageVO,
			@RequestParam(name = "pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name = "pageSize",defaultValue = "5",required = false) int pageSize) {
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO = pageProcess.getPagination(pageVO.getPag(), pageVO.getPageSize(), pageVO, "CGVTICKET");
		
		List<CgvTicketingPaymentVO> vos = adminDAO.getTicketList(pageVO.getStartIndexNo(),pageVO.getPageSize(),pageVO.getPart(),pageVO.getSearchStr());
		String seatA = "";
		String res = "";
		String[] seats = new String[vos.size()];
		int no = 0;
		for(int i = 0; i < vos.size(); i++) {
			String[] nos = vos.get(i).getTk_seat().split("/");

			for(int j = 0; j < nos.length; j++) {
				no = Integer.parseInt(nos[j]);
				if(no > 144 && no < 151) seatA = "A";
				else if(no > 135 && no < 145) seatA = "B";
				else if(no > 126 && no < 136) seatA = "C";
				else if(no > 117 && no < 127) seatA = "D";
				else if(no > 108 && no < 118) seatA = "E";
				else if(no > 99 && no < 109) seatA = "F";
				else if(no > 90 && no < 100) seatA = "G";
				else if(no > 81 && no < 91) seatA = "H";
				else if(no > 72 && no < 82) seatA = "I";
				else if(no > 63 && no < 73) seatA = "J";
				else if(no > 54 && no < 64) seatA = "K";
				else if(no > 45 && no < 55) seatA = "L";
				else if(no > 36 && no < 46) seatA = "M";
				else if(no > 27 && no < 37) seatA = "N";
				else if(no > 18 && no < 28) seatA = "O";
				else if(no > 9 && no < 19) seatA = "P";
				else seatA = "Q";
				
				res += seatA+no+"/";
			}
			seats[i] = res;
		}
		model.addAttribute("seats",seats);
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		
		return "admin/adminticket";
	}
	
	@RequestMapping(value = "/content",method = RequestMethod.GET)
	public String adminContentGet(Model model) {
		
		String[] movieTitleArr = null;
		
		List<CgvAdminContentVO> cvos = adminDAO.getMainHeaderImgGet();
		model.addAttribute("cvos",cvos);
		
		movieTitleArr = adminDAO.getMovieTitleList();
		model.addAttribute("movieTitleArr",movieTitleArr);
		
		return "admin/adminContent";
	}
	
	@RequestMapping(value = "/adminPointCoupon",method = RequestMethod.GET)
	public String adminPointCouponGet(Model model,PageVO pageVO,
			@RequestParam(name = "sw",defaultValue = "0", required = false) int sw,		
			@RequestParam(name = "pag",defaultValue = "1", required = false) int pag,		
			@RequestParam(name = "pageSize",defaultValue = "6", required = false) int pageSize) {		
		
		List<CgvMemberVO> mvos = adminDAO.getMemberAllList();
		
		System.out.println(pageVO);
		
		if(sw == 1) {
			pageVO = pageProcess.getPagination(pag, pageSize, pageVO, "CGVCOUPON");
			List<CgvCouponVO> cvos = adminDAO.getAdminCouponAllList(pageVO.getSearchStr(),pageVO.getPart(),pageVO.getStartIndexNo(),pageSize);
			model.addAttribute("cvos",cvos);
		}
		else {
			pageVO = pageProcess.getPagination(pag, pageSize, pageVO, "CGVMEMBER");
			List<CgvMemberVO> memvos = adminDAO.getMemberList(pageVO.getSearchStr(), pageVO.getPart(), pageVO.getStartIndexNo(), pageSize);
			model.addAttribute("memvos",memvos);
		}

		
		
		model.addAttribute("sw",sw);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("mvos",mvos);
		
		
		return "admin/adminPointCoupon";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/memberPointGet",method = RequestMethod.POST)
	public String memberPointGet(String id) {
		int point = adminDAO.getMemberPoint(id);
		
		return point+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ticketCancel",method = RequestMethod.POST)
	public String ticketCancelPost(String cd) {
		adminDAO.setTicketCancelCdSwUpdate(cd);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/dbFileGet",method = RequestMethod.POST)
	public CgvMovieChartVO dbFileGetPost(String movieTitle) {
		
		
		CgvMovieChartVO vo = adminDAO.getMoiveChartSelect(movieTitle);
		
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminContentInput",method = RequestMethod.POST)
	public String adminContentInputPost(String title,String content, String img, int asw) {
		
		adminDAO.setMainContetnInput(title,content,img,asw);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mainContentInput2",method = RequestMethod.POST)
	public String mainContentInput2Post(MultipartFile file,String title,String content, int asw, String location,HttpServletRequest request) throws IOException {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/img/bg-img/");
		String oFileName = "";
		String sFileName = "";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-hh-mm");
		oFileName = file.getOriginalFilename();
		sFileName = sdf.format(new Date())+"_"+UUID.randomUUID().toString().substring(0,8)+"_"+oFileName;;
		
		File f = new File(realPath+sFileName);
		
		byte[] data = file.getBytes();
		OutputStream os = new FileOutputStream(f);
		os.write(data);
		os.close();
		
		adminDAO.setMainContetnInput(title, content, sFileName, asw);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mainHeaderImgDelete",method = RequestMethod.POST)
	public String mainHeaderImgDelete(String movieTitle) {
		
		adminDAO.setMainHeaderImgDelete(movieTitle);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reportContentMemberGet",method = RequestMethod.POST)
	public CgvReviewVO reportContentMemberGetPost(int idx) {
		
		CgvReviewVO vo = adminDAO.getReportContentMemberGet(idx);
		//CgvMemberVO mvo = homeDAO.getMemberIdCheck(vo.getRe_Id()); 
		
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/reportStatusUpdate",method = RequestMethod.POST)
	public String reportStatusUpdatePost(CgvReportVO vo) {
		
		adminDAO.setReportStatusUpdate(vo);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reportMemberStatusUpdate",method = RequestMethod.POST)
	public String reportMemberStatusUpdatePost(CgvReportVO vo) {
		
		CgvReviewVO rvo = adminDAO.getReportContentMemberGet(vo.getReportContentIdx());
		CgvMemberVO mvo = homeDAO.getMemberIdCheck(rvo.getRe_Id()); 
		
		adminDAO.setMemberReportContentUpdate(vo.getReportStatus(),mvo.getMem_id());
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reportComplete",method = RequestMethod.POST)
	public String reportCompletePost(CgvReportVO vo) throws MessagingException {
		
		CgvMemberVO mvo = homeDAO.getMemberIdCheck(vo.getReporterId());
		
		CgvReviewVO rvo = adminDAO.getReportContentMemberGet(vo.getReportContentIdx());
		CgvMemberVO rmvo = homeDAO.getMemberIdCheck(rvo.getRe_Id()); 
		
		MimeMessage mm = mailSender.createMimeMessage();
		MimeMessageHelper mh = new MimeMessageHelper(mm,true,"UTF-8");
		
		mh.addTo(vo.getReporterMail());
		mh.setSubject("안녕하세요. 오늘뭐볼까?(GGV) 신고 처리완료 안내 메일입니다.");
		String content = "안녕하세요."+mvo.getMem_name()+"님\n";
		content += "지난번에 신고해주신건에 대하여 모든 절차가 끝나 처리완료가 되었음을 안내해드리는 메일을 보내드립니다. \n";
		if(rmvo.getMem_reportContent().equals("")) content += "신고해주신 게시물을 게시한 이용자는 저희쪽에서 판단한 결과 경고조치로 마무리되었습니다. \n";
		else content += "신고해주신 게시물을 게시한 이용자는 저희쪽에서 판단한결과 "+rmvo.getMem_reportContent()+" 조치로 마무리되었습니다. \n";
		content += "저희쪽에서 판단한 결과이다보니 신고해주신 이용자님께서 마음에 안드실수있지만 철저하게 검토 후 내린 결과이니 너그러운 마음으로 양해 부탁드립니다.\n";
		content += "오늘도 이용해주셔서 감사합니다.";
		
		content = content.replace("\n", "<br/>");
		
		mh.setText(content,true);
		
		mailSender.send(mm);
		return "";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/couponCreate",method = RequestMethod.POST)
	public String couponCreatePost(CgvCouponVO vo) {
		
		String cd = UUID.randomUUID().toString().substring(0,8);
		vo.setC_cd(cd);
		
		adminDAO.setAdminCreateCoupon(vo);
		
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminPointJuckLip",method = RequestMethod.POST)
	public String adminPointJuckLipPost(String id, int point) {
		
		adminDAO.setAdminMemberPointUpdate(id,point);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminCouponDelete",method = RequestMethod.POST)
	public String adminCouponDeletePost(int idx) {
		
		adminDAO.setAdminCouponDelete(idx);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminPointDeduction",method = RequestMethod.POST)
	public String adminPointDeductionPost(int idx,int point) {
		
		adminDAO.setAdminPointDeduction(idx,point);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ticketImg",method = RequestMethod.POST)
	public String ticketImg(String movieTitle) {
		String img = adminDAO.getMoiveImg(movieTitle);
		return img;
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminNavSearch",method = RequestMethod.GET)
	public String adminNavSearchGet(String searchStr,HttpSession session) {
		String[] navArr = {"대시보드","회원목록","1:1문의","1대1문의","신고내역","포인트관리","쿠폰관리","예매관리","이벤트관리","컨텐츠관리"};
		String[] urlArr = {"adminMain","adminMember","admin11Contact","admin11Contact","adminReport","adminPointCoupon","adminPointCoupon","ticket","event","content"};
		
		String id = (String)session.getAttribute("sId");
		if(id == null || id.equals("") || !id.equals("admin")) return "redirect:/msg/notadmin";
		
		String resUrl = "";
		
		for(int i = 0; i < navArr.length; i++) {
			if(navArr[i].equals(searchStr)) {
				resUrl = urlArr[i];
			}
		}
		
		return resUrl;
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminMemberDel",method = RequestMethod.POST)
	public String adminMemberDelPost(String id) {
		
		adminDAO.getAdminMemberDel(id);   	
		
		return "";
	}
	
}