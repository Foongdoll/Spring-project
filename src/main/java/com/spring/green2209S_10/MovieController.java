package com.spring.green2209S_10;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.green2209S_10.dao.HomeDAO;
import com.spring.green2209S_10.dao.MovieDAO;
import com.spring.green2209S_10.pagnation.PageProcess;
import com.spring.green2209S_10.pagnation.PageVO;
import com.spring.green2209S_10.service.HomeService;
import com.spring.green2209S_10.service.ImgCrawlingService;
import com.spring.green2209S_10.service.MovieService;
import com.spring.green2209S_10.vo.CgvCouponVO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvMovieChartVO;
import com.spring.green2209S_10.vo.CgvMovieDetailVO;
import com.spring.green2209S_10.vo.CgvMovieStillcutVO;
import com.spring.green2209S_10.vo.CgvReportVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvSeatVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.CgvWishListVO;
import com.spring.green2209S_10.vo.MovieCrawlingVO;

@Controller
@RequestMapping("/movie")
public class MovieController {
	@Autowired
	MovieDAO movieDAO;

	@Autowired
	HomeDAO homeDAO;
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	ImgCrawlingService crawlingService;
	
	@Autowired
	HomeService homeService;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess pageProcess;
	
	
	@ResponseBody
	@RequestMapping(value = "/regionView", method = RequestMethod.POST)
	public String[] reignViewPost(String movieName) {
		
		CgvTicketingVO vo = movieService.getRegion(movieName);
		
		String totRegion = vo.getRegion1() + "/" + vo.getRegion2() + "/" + vo.getRegion3() + "/" + vo.getRegion4() + "/" + vo.getRegion5() + "/" + vo.getRegion6() + "/" + vo.getRegion7() + "/" + vo.getRegion8() + "/" + vo.getRegion9(); 
		String[] regionArr = totRegion.split("/");
		
		return regionArr;
	}
	
	@ResponseBody
	@RequestMapping(value = "/townView", method = RequestMethod.POST)
	public String[] townViewPost(String strSw,String movieName) {
		
		CgvTicketingVO vo = movieService.getTown(strSw,movieName);
		String [] townArr = null;
		
		if(strSw.equals("town1")) 		 townArr = vo.getTown1().split("/");
		else if(strSw.equals("town2")) townArr = vo.getTown2().split("/");
		else if(strSw.equals("town3")) townArr = vo.getTown3().split("/");
		else if(strSw.equals("town4")) townArr = vo.getTown4().split("/");
		else if(strSw.equals("town5")) townArr = vo.getTown5().split("/");
		else if(strSw.equals("town6")) townArr = vo.getTown6().split("/");
		else if(strSw.equals("town7")) townArr = vo.getTown7().split("/");
		else if(strSw.equals("town8")) townArr = vo.getTown8().split("/");
		else if(strSw.equals("town9")) townArr = vo.getTown9().split("/");
		
		return townArr;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/dateView", method = RequestMethod.POST)
	public ArrayList<CgvTicketingVO> dateViewPost(String town,String movieName) {
		ArrayList<CgvTicketingVO> vos = movieService.getdateTime(town,movieName);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/timeView", method = RequestMethod.POST)
	public ArrayList<CgvTicketingVO> timeViewPost(String date,String town,String movieName) {
		ArrayList<CgvTicketingVO> vos = movieService.getScreenTime(date,town,movieName);
		return vos;
	}
	
	@RequestMapping(value = "/ticketing", method = RequestMethod.GET)
	public String ticketingGet(Model model,CgvTicketingVO vo,
			@RequestParam(name = "strsw", defaultValue = "", required = false) String strsw) {
		
		if(vo.getMovieName() != null && strsw.equals("")) {
			
			int resSeat = 0;
			Calendar calendar = Calendar.getInstance();
			
			int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
			String movieImg = movieService.getImgName(vo.getMovieName());
			String screenType = movieService.getMovieScreenType(vo.getMovieName());
			
			CgvTicketingPaymentVO pvo = new CgvTicketingPaymentVO();
			pvo.setTk_movieName(vo.getMovieName());
			pvo.setTk_town(vo.getTown());
			pvo.setTk_screenDate(vo.getScreenDate());
			pvo.setTk_screenTime(vo.getScreenTime());
			CgvSeatVO cvo = movieService.getSeatTable(pvo);
			int sw = 0;
			if(cvo == null) sw = 0; 
			else if(cvo != null) {
				sw = 1;
				
				List<CgvTicketingPaymentVO> tvos = movieService.getTkSeatList(cvo);
				String res = "";
				for(int i = 0; i < tvos.size(); i++) {
					res += tvos.get(i).getTk_seat();
				}
					
				String[] resArr = res.split("/");
				
				model.addAttribute("resArr",resArr);
			}
			
			resSeat = movieService.getResSeat(vo,sw);
			
			model.addAttribute("screenType",screenType);
			model.addAttribute("resSeat",resSeat);
			model.addAttribute("dayOfWeek",dayOfWeek);
			model.addAttribute("movieImg",movieImg);
			model.addAttribute("vo",vo);
			return "movie/ticketing";
		}
		else {
			if(strsw.equals("home")) {
				String movie = vo.getMovieName();
				model.addAttribute("movie",movie);
			}
			
			ArrayList<MovieCrawlingVO> imgs = crawlingService.getCGV_MainImg();
			
			ArrayList<CgvTicketingVO> movieVOS = homeService.getTicketingMovieName(); 
				
			String regions = "";
			
			regions += movieVOS.get(0).getRegion1() + "/";
			regions += movieVOS.get(0).getRegion2() + "/";
			regions += movieVOS.get(0).getRegion3() + "/";
			regions += movieVOS.get(0).getRegion4() + "/";
			regions += movieVOS.get(0).getRegion5() + "/";
			regions += movieVOS.get(0).getRegion6() + "/";
			regions += movieVOS.get(0).getRegion7() + "/";
			regions += movieVOS.get(0).getRegion8() + "/";
			regions += movieVOS.get(0).getRegion9();
			
			String[] region = regions.split("/");
			
			model.addAttribute("region",region);
			model.addAttribute("movieVOS",movieVOS);
			model.addAttribute("imgs",imgs);
		}
		
		
		return "movie/ticketing";
	}
	
	@ResponseBody
	@RequestMapping(value = "/timeViewSeat", method = RequestMethod.POST)
	public List<CgvSeatVO> timeViewSeatPost(String date,String movieName, String town) {
		List<CgvSeatVO> vos = movieService.getReservedSeatAll(date,movieName,town);
		
		return vos;
	}
	
	@RequestMapping(value = "/movieChart", method = RequestMethod.GET)
	public String movieChartGet(Model model) {
		ArrayList<CgvMovieChartVO> movieChart = movieService.getMovieChartImg();
		
		model.addAttribute("movieChart",movieChart);
		
		return "movie/movieChart";
	}
	
	@RequestMapping(value = "/movieDetail", method = RequestMethod.GET)
	public String movieDetailGet(Model model,String movieTitle,
		@RequestParam(name="pag",defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize",defaultValue = "5", required = false) int pageSize,
		@RequestParam(name="sw",defaultValue = "1", required = false) int sw) {
		
		CgvMovieDetailVO vo = movieService.getMoiveDetail(movieTitle);
		
		if(sw == 1) {
			ArrayList<CgvMovieDetailVO> vos = movieService.getMovieTrailer(movieTitle);
			model.addAttribute("vos",vos);
		}
		else if(sw == 2) {
			ArrayList<CgvMovieStillcutVO> vos = movieService.getMovieStillcut(movieTitle);
			model.addAttribute("vos",vos);
		}
		
		PageVO pVo = new PageVO();
		pVo.setMovieTitle(movieTitle);
		pVo = pageProcess.getPagination(pag, pageSize, pVo, "CgvReview");
		ArrayList<CgvReviewVO> rVos = movieService.getMovieReview(movieTitle,pVo.getStartIndexNo(),pageSize);
		
		List<CgvReviewVO> rating = movieDAO.getRatingProcess(movieTitle);
		
		if(rating.get(0).getRe_cntRating() != 0) {
			double starAvg = rating.get(0).getRe_sumRating()/rating.get(0).getRe_cntRating();
			model.addAttribute("starAvg",starAvg);
		}
		
		model.addAttribute("pageVO",pVo);
		model.addAttribute("vo",vo);
		model.addAttribute("rVos",rVos);
		model.addAttribute("sw",sw);
		return "movie/movieDetail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/movieReviewInput",method = RequestMethod.GET)
	public String movieReviewInputGet(CgvReviewVO vo) {
	movieService.setReviewInput(vo);
		
		return "";
	}
	
	// 영화 포스터 이미지 가져가기 - 빠른 예매에서 선택한 영화의 포스터 가져가는 작업
	@ResponseBody
	@RequestMapping(value = "/movieImgGet",method = RequestMethod.GET)
	public String movieImgGet(String movieName) {
		System.out.println(movieName);
		String img = movieService.getFastticketingMovieImg(movieName);
		return img;
	}

	// 위시 리스트에 추가
	@ResponseBody
	@RequestMapping(value = "/wishListAdd",method = RequestMethod.GET)
	public String wishListAddGet(HttpSession session ,String movieTitle,String img) {
		int sw = 0;
		String id = (String)session.getAttribute("sId");
		
		if(id == null) sw = 3;
		else {
			ArrayList<CgvWishListVO> vos = movieService.getWishList(id);
			
			if(vos != null) {
				for(int i = 0; i < vos.size(); i++) {
					if(vos.get(i).getWi_MovieTitle().equals(movieTitle)) sw = 1;
				}
			}
			
			movieService.WishListAddDel(movieTitle,id,img,sw);
		}
		return sw+"";
	}
	
	@RequestMapping(value = "/ticketingPayment", method = RequestMethod.GET)
	public String ticketingPaymentGet(CgvTicketingPaymentVO vo,String[] seatArr,Model model,HttpSession session) {
		String id = (String)session.getAttribute("sId");
		CgvMemberVO mvo = homeService.getMemberIdCheck(id);
		vo.setTk_email(mvo.getMem_email());
		vo.setTk_tel(mvo.getMem_tel());
		
		model.addAttribute("seatArr",seatArr);
		model.addAttribute("vo",vo);
		return "movie/ticketingPayment";
	}
	
	@Transactional
	@ResponseBody
	@PostMapping("/ticketingPaymentOk")
	public String ticketingPaymentOkGet(CgvTicketingPaymentVO vo,HttpServletRequest request,Model model,HttpSession session) {
		movieDAO.setAdminTodayAmount(vo.getTk_totPrice());
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/qrcode/");
		
		String tk_cd = UUID.randomUUID().toString().substring(0,16);
		vo.setTk_cd(tk_cd);
		String tk_id = (String) session.getAttribute("sId");
		vo.setTk_Id(tk_id);

		// 밥먹고와서 QR코드 만들고 저장 시킨후 해당 지점의 해당 시간의 해당 영화의 자리를 예매한 자리의 숫자만큼 줄여줌 
		// 그 이후엔 해당 지점의 해당 시간의 해당 영화를 다른사람이 또 예매하러갔을때 DB에서 해당 영화 시간의 이미 예매된 자리를 가져와서 뿌리고 예매된 건 REPLACE로 X로 만들어줌
		
		vo = movieService.qrCreate(realPath,vo,request); // qr코드 생성 
		movieService.setTicketCreate(vo); // 티켓 테이블에 정보 저장
		
		int seatCnt = vo.getTk_seat().split("/").length; // 몇개의 좌석이 예매되었는지 카운트
		
		CgvSeatVO svo = movieService.getSeatTable(vo);
		
		 if(svo != null) movieService.setSeatTableUpdate(vo,seatCnt); 
		 else movieService.setSeatTableInput(vo,seatCnt);
		
		return "";   
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/ticketCancel",method = RequestMethod.POST)
	public String ticketCancelPost(String cd) {
		
		CgvTicketingPaymentVO vo = movieDAO.getTicketInfor(cd);
		
		int seatCnt = vo.getTk_seat().split("/").length - 1;
		movieDAO.setTicketCancelSeatMinus(seatCnt,vo);
		 
		movieDAO.getTicketCancel(cd);
		
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pointInput",method = RequestMethod.POST)
	public String pointInputPost(CgvTicketingPaymentVO vo) {

		int point = (vo.getTk_totPrice()/100) * 3;
		
		movieDAO.setPointInput(vo.getTk_Id(),point);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/usePointCheck",method = RequestMethod.POST)
	public String usePointCheckPost(int usePoint,int jucklip,HttpSession session) {
		String id = (String)session.getAttribute("sId");
				movieDAO.setMemberUsePointMinus(usePoint,id);
				movieDAO.setMemberJucklipPoint(jucklip,id);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/myCouponGet",method = RequestMethod.POST)
	public List<CgvCouponVO> myCouponGetPost(HttpSession session) {
		String id = (String)session.getAttribute("sId");
		
		List<CgvCouponVO> vos = movieDAO.getMyCouponList(id);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/movieReviewCheck",method = RequestMethod.POST)
	public String movieReviewCheckPost(String id, String movieTitle) {
		
	 String cd = movieDAO.getMovieReviewCheck(id,movieTitle);
	 if(cd == null) cd = "0";
	 
		return cd;
	}
	
	@ResponseBody
	@RequestMapping(value = "/movieReviewUpdate",method = RequestMethod.POST)
	public String movieReviewUpdatePost(CgvReviewVO vo) {

		movieDAO.setReviewUpdate(vo);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/movieReviewDelete",method = RequestMethod.POST)
	public String movieReviewDeletePost(int idx) {
		
		movieDAO.getReviewDelete(idx);	
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reviewReportOk",method = RequestMethod.POST)
	public String reviewReportOkPost(CgvReportVO vo) throws MessagingException {
		
		CgvMemberVO mvo = homeDAO.getMemberIdCheck(vo.getReporterId()); // 신고하는사람의 정보
		
		vo.setReporterMail(mvo.getMem_email());
		
		movieDAO.setReviewReport(vo);
		
		movieDAO.setReviewReportSwUpdate(vo.getReportContentIdx()); // 이건 신고당한사람 정보
		
		
		
		
		String mail = mvo.getMem_email();
		String title = "오늘뭐볼까?(GGV) 신고접수완료 확인 메일";
		String content = "안녕하세요. 오늘뭐볼까?(GGV)입니다.\n";
		content += mvo.getMem_name()+" 고객님께서 신고해주신 신고내용은 접수가 성공적으로 완료되었습니다.\n";
		content += "현재는 접수완료 상태이며 신속한 처리 이후 다시 메일로 확인 메일을 보내드리겠습니다.\n";
		content += "고객님께서 신고하신 접수건의 진행 상태가 궁금하시다면 마이페이지 -> 나의 신고 내역 \n메뉴에 들어가시면 신고하셨던 내역들과 현재진행상태를 확인하실수있으십니다.\n";
		content += "항상 고객님들의 소리에 귀기울이겠습니다. 감사합니다.";
		
		content = content.replace("\n","<br/>");
		
		MimeMessage mm = mailSender.createMimeMessage();
		MimeMessageHelper mh = new MimeMessageHelper(mm, true, "UTF-8");
				
		mh.addTo(mail);
		mh.setSubject(title);
		mh.setText(content,true);
		
		mailSender.send(mm);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/goodCheck",method = RequestMethod.POST)
	public String goodCheckPost(int idx,HttpSession session) {
		int res = 0;
		int cnt = 0;
		String sGood = "";
		sGood = (String)session.getAttribute("sGood") == null ? idx+"/" : (String)session.getAttribute("sGood") + idx + "/";  
		
		String[] sReadArr = sGood.split("/");
		for(int i = 0; i < sReadArr.length; i++) {
			if(sReadArr[i].equals(idx+"")){
				cnt++;
			}
		}
		
		session.setAttribute("sGood", sGood);
		
		if(cnt < 2) {
			movieDAO.setMovieGood(idx);
			res = 1;
		}
		
		return res+"";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/memberReportCheck",method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String memberReportCheckPost(String id) {
		String res = movieDAO.getMemberReportStatus(id);
		
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/duplicationReviewCheck",method = RequestMethod.POST)
	public String duplicationReviewCheck(String id,String movieTitle) {
		String re_id = movieDAO.getDuplicationReviewCheck(id, movieTitle);
		System.out.println(re_id);
		if(re_id == null) {
			re_id = "0";
		}
		else re_id = "1";
		
		return re_id;
	}
	
	
	
	
}
