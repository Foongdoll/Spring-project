package com.spring.green2209S_10;

import java.net.URLEncoder;
import java.net.http.HttpResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.tools.DocumentationTool.Location;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_10.dao.HomeDAO;
import com.spring.green2209S_10.pagnation.PageProcess;
import com.spring.green2209S_10.pagnation.PageVO;
import com.spring.green2209S_10.service.HomeService;
import com.spring.green2209S_10.service.ImgCrawlingService;
import com.spring.green2209S_10.service.MovieService;
import com.spring.green2209S_10.vo.CgvMainHeaderImgVO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvMovieDetailVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvSeatVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.ChatRoomsVO;
import com.spring.green2209S_10.vo.MovieCrawlingVO;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	ImgCrawlingService crawlingService;
	
	@Autowired
	HomeService homeService;
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess  pageProcess;
	
	@Autowired
	HomeDAO homeDAO;
	
	
	@RequestMapping(value = {"/","/H"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession session) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
		String now = sdf.format(date);
		
		ArrayList<MovieCrawlingVO> imgs = crawlingService.getCGV_MainImg();
		ArrayList<CgvTicketingVO> movieVOS = homeService.getTicketingMovieName(); 
		List<CgvMainHeaderImgVO> headvos = homeDAO.getHeaderImgList();
		
		
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
		
		
		model.addAttribute("headvos",headvos);
		model.addAttribute("region",region);
		model.addAttribute("movieVOS",movieVOS);
		model.addAttribute("imgs",imgs);
		model.addAttribute("now",now);
		
		return "home";
	}
	
	
	
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGet(){
		
		return "home/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPost(MultipartFile file,HttpServletRequest request,CgvMemberVO vo){
		
		
		homeDAO.setADminJoinToday();
		
		if(vo.getKakaoSw() == 1) {
			request.getSession().setAttribute("kakao","kakao");
			homeService.setJoinInput(vo,"kakao");
			return "redirect:/msg/joinOk";
		}
		else if(vo.getGoogleSw() == 1) {
			request.getSession().setAttribute("google","google");
			
			vo.setMem_pswd(passwordEncoder.encode(vo.getMem_pswd()));
			
			vo.setMem_sPhoto(vo.getMem_photo());
			vo.setMem_photo("");
			homeService.setJoinInput(vo,"google");
			return "redirect:/msg/joinOk";
		}
		else if(vo.getNaverSw() == 1) {
			request.getSession().setAttribute("naver", "naver");
			
			vo.setMem_pswd(passwordEncoder.encode(vo.getMem_pswd()));
			
			vo.setMem_sPhoto(vo.getMem_photo());
			vo.setMem_photo("");
			homeService.setJoinInput(vo, "naver");
			return "redirect:/msg/joinOk";
		}
		else {
			homeService.setJoinInput(vo,"");
			return "redirect:/msg/joinOk";
		}
		
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet(){
		return "home/login";
	}
	
//????????? ????????? ????????? ????????? ???????????? ????????????.
	@RequestMapping(value="/memberKakaoLogin", method=RequestMethod.GET)
	public String memberKakaoLoginGet(HttpSession session, HttpServletRequest request, HttpServletResponse response,Model model,CgvTicketingVO tVo,
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName,
			@RequestParam(name = "email", defaultValue = "", required = false) String email,
			@RequestParam(name = "id", defaultValue = "", required = false) String id,
			@RequestParam(name = "pswd", defaultValue = "", required = false) String pswd,
			@RequestParam(name = "idCheck", defaultValue = "", required = false) String idCheck,
			@RequestParam(name = "sw", defaultValue = "0", required = false) int sw,
			@RequestParam(name = "movieTitle", defaultValue = "", required = false) String movieTitle) {
		
		
		// ????????????????????? ????????? ?????? ?????? ??????????????? ????????????.
		// ?????? ????????? ??????????????? ???????????? ???????????? ??????, ????????? ????????? ????????? ?????? ???????????????.
		CgvMemberVO vo = homeService.getMemberNickNameEmailCheck(nickName);
		
		if(vo == null) {
			model.addAttribute("nickName",nickName);
			model.addAttribute("email",email);
			
			return "home/kakaoJoin";
		}
		else if(!vo.getMem_mStatus().equals("?????????")) return "redirect:/msg/loginNo";
		else {
			request.getSession().setAttribute("kakaoSw","kakao");
			String strLevel = "";

			homeService.setOnOff(vo.getMem_id(),0);
			
			homeService.setAdminToday();
			
			if(vo.getMem_level() == 0) strLevel = "?????????";
			else if(vo.getMem_level() == 1) strLevel = "?????????";
			else if(vo.getMem_level() == 2) strLevel = "?????????";
			else if(vo.getMem_level() == 3) strLevel = "????????????";
			else if(vo.getMem_level() == 4) strLevel = "?????????";
			
			if(strLevel.equals("?????????")) {
				ServletContext application = request.getSession().getServletContext();
				application.setAttribute("adminOnSw","?????????");
			}
			
			request.getSession().setAttribute("sStrLevel", strLevel);
			request.getSession().setAttribute("sLevel", vo.getMem_level());
			request.getSession().setAttribute("sId", vo.getMem_id());
			request.getSession().setAttribute("sName", vo.getMem_name());
			request.getSession().setAttribute("sNickName", vo.getMem_nickName());
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cId", vo.getMem_id());
				cookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i = 0; i < cookies.length; i++) {
					if(cookies[i].getValue().equals("cId")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			if(sw == 1) {
				CgvMovieDetailVO dvo = movieService.getMoiveDetail(movieTitle);
				ArrayList<CgvMovieDetailVO> vos = movieService.getMovieTrailer(movieTitle);
				int pag = 1;
				int pageSize = 5;
				PageVO pVo = new PageVO();
				pVo = pageProcess.getPagination(pag, pageSize, pVo, "CgvReview");
				ArrayList<CgvReviewVO> rVos = movieService.getMovieReview(movieTitle, pVo.getStartIndexNo(), pageSize);
				model.addAttribute("vo",dvo);
				model.addAttribute("vos",vos);
				model.addAttribute("rVos",rVos);
				
				return "movie/movieDetail";
			}
			else if(sw == 2) {
				int resSeat = 0;
				Calendar calendar = Calendar.getInstance();
				
				int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
				
				String movieImg = movieService.getImgName(tVo.getMovieName());
				
				CgvTicketingPaymentVO pvo = new CgvTicketingPaymentVO();
				pvo.setTk_movieName(tVo.getMovieName());
				pvo.setTk_town(tVo.getTown());
				pvo.setTk_screenDate(tVo.getScreenDate());
				pvo.setTk_screenTime(tVo.getScreenTime());
				
				CgvSeatVO cvo = movieService.getSeatTable(pvo);
				int sw2 = 0;
				if(cvo == null) sw2 = 0; 
				else if(cvo != null) {
					sw2 = 1;
					List<CgvTicketingPaymentVO> tvos = movieService.getTkSeatList(cvo);
					String res = "";
					for(int i = 0; i < tvos.size(); i++) {
						res += tvos.get(i).getTk_seat();
					}
						
					String[] resArr = res.split("/");
					
					model.addAttribute("resArr",resArr);
				}
				
				resSeat = movieService.getResSeat(tVo,sw2);
				
				String screenType = movieService.getMovieScreenType(tVo.getMovieName());
				model.addAttribute("screenType",screenType);
				model.addAttribute("resSeat",resSeat);
				model.addAttribute("dayOfWeek",dayOfWeek);
				model.addAttribute("movieImg",movieImg);
				model.addAttribute("vo",tVo);
				return "movie/ticketing";
			}
			String name = URLEncoder.encode(vo.getMem_id());
			return "redirect:/msg/loginOk?name="+name;
		}
	}
	
	
	
	@RequestMapping(value = "/GoogleLogin")
	public String GoogleLogin(CgvMemberVO vo,HttpSession session, HttpServletRequest request, HttpServletResponse response,Model model,CgvTicketingVO tVo,
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName,
			@RequestParam(name = "email", defaultValue = "", required = false) String email,
			@RequestParam(name = "id", defaultValue = "", required = false) String id,
			@RequestParam(name = "pswd", defaultValue = "", required = false) String pswd,
			@RequestParam(name = "idCheck", defaultValue = "", required = false) String idCheck,
			@RequestParam(name = "sw", defaultValue = "0", required = false) int sw,
			@RequestParam(name = "movieTitle", defaultValue = "", required = false) String movieTitle) {
		
		String googleNickName = vo.getMem_name();
		String googleEmail	  = vo.getMem_email();
		String googleImgUrl   = vo.getMem_photo();
		
		vo = homeDAO.getMemberIdCheckNickName(vo.getMem_name());
		
		if(vo == null) {
				 
			model.addAttribute("nickName",googleNickName);
			model.addAttribute("email",googleEmail);
			model.addAttribute("photo",googleImgUrl);
			
			return "home/googleJoin";
		}
		else if(!vo.getMem_mStatus().equals("?????????")) return "redirect:/msg/loginNo";
		else {
			request.getSession().setAttribute("googleSw","google");
			String strLevel = "";

			homeService.setOnOff(vo.getMem_id(),0);
			
			homeService.setAdminToday();
			
			if(vo.getMem_level() == 0) strLevel = "?????????";
			else if(vo.getMem_level() == 1) strLevel = "?????????";
			else if(vo.getMem_level() == 2) strLevel = "?????????";
			else if(vo.getMem_level() == 3) strLevel = "????????????";
			else if(vo.getMem_level() == 4) strLevel = "?????????";
			
			if(strLevel.equals("?????????")) {
				ServletContext application = request.getSession().getServletContext();
				application.setAttribute("adminOnSw","?????????");
			}
			
			request.getSession().setAttribute("sStrLevel", strLevel);
			request.getSession().setAttribute("sLevel", vo.getMem_level());
			request.getSession().setAttribute("sId", vo.getMem_id());
			request.getSession().setAttribute("sName", vo.getMem_name());
			request.getSession().setAttribute("sNickName", vo.getMem_nickName());
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cId", vo.getMem_id());
				cookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i = 0; i < cookies.length; i++) {
					if(cookies[i].getValue().equals("cId")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			if(sw == 1) {
				CgvMovieDetailVO dvo = movieService.getMoiveDetail(movieTitle);
				ArrayList<CgvMovieDetailVO> vos = movieService.getMovieTrailer(movieTitle);
				int pag = 1;
				int pageSize = 5;
				PageVO pVo = new PageVO();
				pVo = pageProcess.getPagination(pag, pageSize, pVo, "CgvReview");
				ArrayList<CgvReviewVO> rVos = movieService.getMovieReview(movieTitle, pVo.getStartIndexNo(), pageSize);
				model.addAttribute("vo",dvo);
				model.addAttribute("vos",vos);
				model.addAttribute("rVos",rVos);
				
				return "movie/movieDetail";
			}
			else if(sw == 2) {
				int resSeat = 0;
				Calendar calendar = Calendar.getInstance();
				
				int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
				
				String movieImg = movieService.getImgName(tVo.getMovieName());
				
				CgvTicketingPaymentVO pvo = new CgvTicketingPaymentVO();
				pvo.setTk_movieName(tVo.getMovieName());
				pvo.setTk_town(tVo.getTown());
				pvo.setTk_screenDate(tVo.getScreenDate());
				pvo.setTk_screenTime(tVo.getScreenTime());
				
				CgvSeatVO cvo = movieService.getSeatTable(pvo);
				int sw2 = 0;
				if(cvo == null) sw2 = 0; 
				else if(cvo != null) {
					sw2 = 1;
					List<CgvTicketingPaymentVO> tvos = movieService.getTkSeatList(cvo);
					String res = "";
					for(int i = 0; i < tvos.size(); i++) {
						res += tvos.get(i).getTk_seat();
					}
						
					String[] resArr = res.split("/");
					
					model.addAttribute("resArr",resArr);
				}
				
				resSeat = movieService.getResSeat(tVo,sw2);
				
				String screenType = movieService.getMovieScreenType(tVo.getMovieName());
				model.addAttribute("screenType",screenType);
				model.addAttribute("resSeat",resSeat);
				model.addAttribute("dayOfWeek",dayOfWeek);
				model.addAttribute("movieImg",movieImg);
				model.addAttribute("vo",tVo);
				return "movie/ticketing";
			}
			String name = URLEncoder.encode(vo.getMem_id());
			return "redirect:/msg/loginOk?name="+name;
		}
	}
	
	@RequestMapping(value = "/naverLogin")
	public String naverLogin(CgvMemberVO mvo,HttpSession session, HttpServletRequest request, HttpServletResponse response,Model model,CgvTicketingVO tVo,
			@RequestParam(name = "nickName", defaultValue = "", required = false) String nickName,
			@RequestParam(name = "email", defaultValue = "", required = false) String email,
			@RequestParam(name = "id", defaultValue = "", required = false) String id,
			@RequestParam(name = "pswd", defaultValue = "", required = false) String pswd,
			@RequestParam(name = "idCheck", defaultValue = "", required = false) String idCheck,
			@RequestParam(name = "sw", defaultValue = "0", required = false) int sw,
			@RequestParam(name = "movieTitle", defaultValue = "", required = false) String movieTitle) {
		
		
		CgvMemberVO vo = homeDAO.getMemberIdCheckNickName(mvo.getMem_nickName());

		if(vo == null) {
			model.addAttribute("vo",mvo);
			return "home/naverJoin";
		}
		else if(!vo.getMem_mStatus().equals("?????????")) return "redirect:/msg/loginNo";
		
			request.getSession().setAttribute("naverSw","naver");
			String strLevel = "";
			
			homeService.setOnOff(vo.getMem_id(),0);
			
			homeService.setAdminToday();
			
			if(vo.getMem_level() == 0) strLevel = "?????????";
			else if(vo.getMem_level() == 1) strLevel = "?????????";
			else if(vo.getMem_level() == 2) strLevel = "?????????";
			else if(vo.getMem_level() == 3) strLevel = "????????????";
			else if(vo.getMem_level() == 4) strLevel = "?????????";
			
			if(strLevel.equals("?????????")) {
				ServletContext application = request.getSession().getServletContext();
				application.setAttribute("adminOnSw","?????????");
			}
			
			request.getSession().setAttribute("sStrLevel", strLevel);
			request.getSession().setAttribute("sLevel", vo.getMem_level());
			request.getSession().setAttribute("sId", vo.getMem_id());
			request.getSession().setAttribute("sName", vo.getMem_name());
			request.getSession().setAttribute("sNickName", vo.getMem_nickName());
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cId", vo.getMem_id());
				cookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i = 0; i < cookies.length; i++) {
					if(cookies[i].getValue().equals("cId")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			if(sw == 1) {
				CgvMovieDetailVO dvo = movieService.getMoiveDetail(movieTitle);
				ArrayList<CgvMovieDetailVO> vos = movieService.getMovieTrailer(movieTitle);
				int pag = 1;
				int pageSize = 5;
				PageVO pVo = new PageVO();
				pVo = pageProcess.getPagination(pag, pageSize, pVo, "CgvReview");
				ArrayList<CgvReviewVO> rVos = movieService.getMovieReview(movieTitle, pVo.getStartIndexNo(), pageSize);
				model.addAttribute("vo",dvo);
				model.addAttribute("vos",vos);
				model.addAttribute("rVos",rVos);
				
				return "movie/movieDetail";
			}
			else if(sw == 2) {
				int resSeat = 0;
				Calendar calendar = Calendar.getInstance();
				
				int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
				
				String movieImg = movieService.getImgName(tVo.getMovieName());
				
				CgvTicketingPaymentVO pvo = new CgvTicketingPaymentVO();
				pvo.setTk_movieName(tVo.getMovieName());
				pvo.setTk_town(tVo.getTown());
				pvo.setTk_screenDate(tVo.getScreenDate());
				pvo.setTk_screenTime(tVo.getScreenTime());
				
				CgvSeatVO cvo = movieService.getSeatTable(pvo);
				int sw2 = 0;
				if(cvo == null) sw2 = 0; 
				else if(cvo != null) {
					sw2 = 1;
					List<CgvTicketingPaymentVO> tvos = movieService.getTkSeatList(cvo);
					String res = "";
					for(int i = 0; i < tvos.size(); i++) {
						res += tvos.get(i).getTk_seat();
					}
					
					String[] resArr = res.split("/");
					
					model.addAttribute("resArr",resArr);
				}
				
				resSeat = movieService.getResSeat(tVo,sw2);
				
				String screenType = movieService.getMovieScreenType(tVo.getMovieName());
				model.addAttribute("screenType",screenType);
				model.addAttribute("resSeat",resSeat);
				model.addAttribute("dayOfWeek",dayOfWeek);
				model.addAttribute("movieImg",movieImg);
				model.addAttribute("vo",tVo);
				return "movie/ticketing";
			}
			String name = URLEncoder.encode(vo.getMem_id());
			return "redirect:/msg/loginOk?name="+name;
		
	}
	
	@RequestMapping(value = "naverLoginTx")
	public String naverLoginTx() {
		
		return "home/naverLoginTx";
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String memberLoginPost(Model model, HttpServletRequest request, HttpServletResponse response,CgvTicketingVO tVo,
			@RequestParam(name = "id", defaultValue = "", required = false) String id,
			@RequestParam(name = "pswd", defaultValue = "", required = false) String pswd,
			@RequestParam(name = "idCheck", defaultValue = "", required = false) String idCheck,
			@RequestParam(name = "sw", defaultValue = "0", required = false) int sw,
			@RequestParam(name = "movieTitle", defaultValue = "", required = false) String movieTitle) {
		
		
		
			CgvMemberVO vo = homeService.getMemberIdCheck(id);
		
			if(vo != null && passwordEncoder.matches(pswd, vo.getMem_pswd()) && vo.getMem_mStatus().equals("?????????")) {
				// ?????? ?????? ????????? ?????? ????????? ??????? session??? ????????? ????????? ??????, ???????????????, ?????? ???????????? 1??????,??????????????? 10+
				String strLevel = "";

				homeService.setOnOff(vo.getMem_id(),0);
				
				homeService.setAdminToday();
				
				if(vo.getMem_level() == 0) strLevel = "?????????";
				else if(vo.getMem_level() == 1) strLevel = "?????????";
				else if(vo.getMem_level() == 2) strLevel = "?????????";
				else if(vo.getMem_level() == 3) strLevel = "????????????";
				else if(vo.getMem_level() == 4) strLevel = "?????????";
				
				if(strLevel.equals("?????????")) {
					ServletContext application = request.getSession().getServletContext();
					application.setAttribute("adminOnSw","?????????");
				}
				
				request.getSession().setAttribute("sStrLevel", strLevel);
				request.getSession().setAttribute("sLevel", vo.getMem_level());
				request.getSession().setAttribute("sId", vo.getMem_id());
				request.getSession().setAttribute("sName", vo.getMem_name());
				request.getSession().setAttribute("sNickName", vo.getMem_nickName());
				
				if(idCheck.equals("on")) {
					Cookie cookie = new Cookie("cId", vo.getMem_id());
					cookie.setMaxAge(60 * 60 * 24 * 7);
					response.addCookie(cookie);
				}
				else {
					Cookie[] cookies = request.getCookies();
					for(int i = 0; i < cookies.length; i++) {
						if(cookies[i].getValue().equals("cId")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
				
				if(sw == 1) {
					CgvMovieDetailVO dvo = movieService.getMoiveDetail(movieTitle);
					ArrayList<CgvMovieDetailVO> vos = movieService.getMovieTrailer(movieTitle);
					int pag = 1;
					int pageSize = 5;
					PageVO pVo = new PageVO();
					pVo = pageProcess.getPagination(pag, pageSize, pVo, "CgvReview");
					ArrayList<CgvReviewVO> rVos = movieService.getMovieReview(movieTitle, pVo.getStartIndexNo(), pageSize);
					model.addAttribute("vo",dvo);
					model.addAttribute("vos",vos);
					model.addAttribute("rVos",rVos);
					
					return "movie/movieDetail";
				}
				else if(sw == 2) {
					int resSeat = 0;
					Calendar calendar = Calendar.getInstance();
					
					int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
					
					String movieImg = movieService.getImgName(tVo.getMovieName());
					
					CgvTicketingPaymentVO pvo = new CgvTicketingPaymentVO();
					pvo.setTk_movieName(tVo.getMovieName());
					pvo.setTk_town(tVo.getTown());
					pvo.setTk_screenDate(tVo.getScreenDate());
					pvo.setTk_screenTime(tVo.getScreenTime());
					
					CgvSeatVO cvo = movieService.getSeatTable(pvo);
					int sw2 = 0;
					if(cvo == null) sw2 = 0; 
					else if(cvo != null) {
						sw2 = 1;
						List<CgvTicketingPaymentVO> tvos = movieService.getTkSeatList(cvo);
						String res = "";
						for(int i = 0; i < tvos.size(); i++) {
							res += tvos.get(i).getTk_seat();
						}
							
						String[] resArr = res.split("/");
						
						model.addAttribute("resArr",resArr);
					}
					
					resSeat = movieService.getResSeat(tVo,sw2);
					
					String screenType = movieService.getMovieScreenType(tVo.getMovieName());
					model.addAttribute("screenType",screenType);
					model.addAttribute("resSeat",resSeat);
					model.addAttribute("dayOfWeek",dayOfWeek);
					model.addAttribute("movieImg",movieImg);
					model.addAttribute("vo",tVo);
					return "movie/ticketing";
				}
				String name = URLEncoder.encode(vo.getMem_id());
				return "redirect:/msg/loginOk?name="+name;
			}
			else return "redirect:/msg/loginNo";
		}
	
	
		@RequestMapping(value = "/logout", method = RequestMethod.GET)
		public String memberLogoutGet(HttpSession session,HttpServletRequest request) {
			String name = (String)session.getAttribute("sName");
			String id = (String)session.getAttribute("sId");
				
			homeService.setOnOff(id,1);
			ServletContext application = request.getSession().getServletContext();
			application.removeAttribute("adminOnSw");
			session.invalidate();
			
			name = URLEncoder.encode(name);
			
			return "redirect:/msg/logoutOk?name="+name;
		}
		
		@ResponseBody
		@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
		public CgvMemberVO idCheckPost(String id) {
			CgvMemberVO vo = homeService.getMemberIdCheck(id);
			return vo;
		}
		
		@ResponseBody
		@RequestMapping(value = "/nickNameCheck", method = RequestMethod.POST)
		public CgvMemberVO nickNameCheckPost(String nickName) {
			CgvMemberVO vo = homeService.getMemberIdCheckNickName(nickName);
			return vo;
		}
		
		@ResponseBody
		@RequestMapping(value = "/emailCheck", method = RequestMethod.GET)
		public String emailCheckGet(String email) {
			String res = "0";
			String uid = UUID.randomUUID().toString().substring(0,8);
			
			String authEmail = homeService.getAuthEmailSearch(email);
			
			if(authEmail == null) {
				String authNumber = uid;
				String authSw = "email";
				homeService.setAuthNumber(email,authNumber,authSw); // ??????????????? ???????????? ?????????????????? ????????? insert
				
				try {
					
					String title = "GGV(?????? ??? ???????) ???????????? ????????? ?????? ?????? ??????";
					String content = "???????????????. GGV ???????????? ????????? ?????? ???????????????.\n";
					content += "???????????? : "+uid+" ?????????.\n";
					content += "3????????? ??????????????????.\n* ???????????? ????????? 3?????? ????????? ???????????????. *\n";
					content += "-----------------------------------------------------";
					
					content = content.replace("\n", "<br/>");
					MimeMessage mm = mailSender.createMimeMessage(); 
					MimeMessageHelper mh = new MimeMessageHelper(mm, true, "UTF-8");
					
					mh.setTo(email);
					mh.setSubject(title);
					mh.setText(content,true);
					
					
					mailSender.send(mm);
					
				} catch (Exception e) {e.getMessage();}
			}
			else res = "1";//??????????????? ??????????????????????????? 3????????? ???????????? ???????????? 3????????? ?????? ?????? ??????????????? ??????
			
			return res;
		}
		
		@ResponseBody//????????? ??????
		@RequestMapping(value = "/idSearch",method = RequestMethod.GET)
		public String idSearchGet(String name,String nickName, String scnumber) {
			
			String id = homeService.getIdSearch(name,nickName,scnumber);
			
			return id;
		}
		
		@ResponseBody//???????????? ??????
		@RequestMapping(value = "/pswdSearch",method = RequestMethod.GET)
		public String pswdSearchGet(String id,String nickName, String email,int pswdQ, String pswdA) {
			int res = 0;
			
			
				String pswd = homeService.getPswdSearch(id,nickName,email);
				if(pswd != null) {
					String uid = UUID.randomUUID().toString().substring(0,8)+"A@@@";
					try {
						String title = "GGV(?????? ??? ???????) ?????? ???????????? ?????? ??????";
						String content = "???????????????. GGV ?????? ???????????? ?????? ???????????????.\n";
						content += "???????????? ?????? ??????????????? : "+uid+" ?????????.\n";
						content += "????????? ????????? ????????? ?????? ???????????? ??????????????? ???????????????????????? ??????????????????.\n";
						content += "-----------------------------------------------------";
						
						content = content.replace("\n", "<br/>");
						MimeMessage mm = mailSender.createMimeMessage(); 
						MimeMessageHelper mh = new MimeMessageHelper(mm, true, "UTF-8");
						
						mh.setTo(email);
						mh.setSubject(title);
						mh.setText(content,true);
						
						mailSender.send(mm);
					} catch (Exception e) {e.getMessage();}
					
					String newPswd = passwordEncoder.encode(uid);
					homeService.setNewPswdInput(newPswd,id);
					
					res = 1;
				}
			
			return res+"";
		}
		
		@ResponseBody
		@RequestMapping(value = "/authNumberCheck", method = RequestMethod.POST)
		public String authNumberCheckPost(String rEmail,String authNumber) {
			String res = "0";
			
			
			String authNumberDB = homeService.getAuhNumberEmail(rEmail,authNumber);
			
			if(authNumberDB != null) {
				if(authNumber.equals(authNumberDB)) {
					res = "1";
				}
			}
			
			return res;
		}
		
		@ResponseBody
		@RequestMapping(value = "/memberReportContent", method = RequestMethod.POST)
		public CgvMemberVO memberReportContentPost(String id) {
			
			CgvMemberVO vo = homeDAO.getMemberReportContent(id);
			
			return vo;
		}
		
		
}