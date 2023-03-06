package com.spring.green2209S_10.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.green2209S_10.dao.HomeDAO;
import com.spring.green2209S_10.dao.MovieDAO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.CgvWishListVO;
import com.spring.green2209S_10.vo.CgvMovieDetailVO;
import com.spring.green2209S_10.vo.CgvMovieStillcutVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvSeatVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvMovieChartVO;

@Service
public class MovieServiceImpl implements MovieService{

	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	MovieDAO movieDAO;

	@Autowired
	HomeDAO homeDAO;
	
	
	@Override
	public CgvTicketingVO getRegion(String movieName) {
		return movieDAO.getRegion(movieName);
	}

	@Override
	public CgvTicketingVO getTown(String strSw, String movieName) {
		return movieDAO.getTown(strSw, movieName);
	}

	@Override
	public ArrayList<CgvTicketingVO> getdateTime(String town, String movieName) {
		return movieDAO.getdateTime(town,movieName);
	}

	@Override
	public ArrayList<CgvTicketingVO> getScreenTime(String date, String town, String movieName) {
		return movieDAO.getScreenTime(date, town, movieName);
	}

	@Override
	public String getImgName(String movieName) {
		return movieDAO.getImgName(movieName);
	}

	@Override
	public int getResSeat(CgvTicketingVO vo, int sw) {
		return movieDAO.getResSeat(vo, sw);
	}

	@Override
	public ArrayList<CgvMovieChartVO> getMovieChartImg() {
		return movieDAO.getMovieChartImg();
	}

	@Override
	public CgvMovieDetailVO getMoiveDetail(String movieTitle) {
		return movieDAO.getMoiveDetail(movieTitle);
	}

	@Override
	public ArrayList<CgvMovieDetailVO> getMovieTrailer(String movieTitle) {
		return movieDAO.getMovieTrailer(movieTitle);
	}

	@Override
	public ArrayList<CgvReviewVO> getMovieReview(String movieTitle, int startIndexNo, int pageSize) {
		return movieDAO.getMovieReview(movieTitle, startIndexNo, pageSize);
	}

	@Override
	public void setReviewInput(CgvReviewVO vo) {
		movieDAO.setReviewInput(vo);
	}

	@Override
	public String getFastticketingMovieImg(String movieName) {
		return movieDAO.getFastticketingMovieImg(movieName);
	}

	@Override
	public ArrayList<CgvMovieStillcutVO> getMovieStillcut(String movieTitle) {
		return movieDAO.getMovieStillcut(movieTitle);
	}

	@Override
	public ArrayList<CgvWishListVO> getWishList(String id) {
		return movieDAO.getWishList(id);
	}

	@Override
	public int WishListAddDel(String movieTitle, String id, String img, int sw) {
		if(sw == 0) return movieDAO.WishListAdd(movieTitle,id,img);
		else if(sw == 1) return movieDAO.WishListDel(movieTitle,id);
		return sw;
	}

	@Override
	public String getMovieScreenType(String movieTitle) {
		return movieDAO.getMovieScreenType(movieTitle);
	}

	@Override
	public void setTicketCreate(CgvTicketingPaymentVO vo) {
		movieDAO.setTicketCreate(vo);
	}

	// qr코드 생성 넣을 내용은 tk_cd  tk_Id  tk_movieName tk_town tk_screenDate tk_screenTime tk_seat tk_adultno tk_teenno tk_childno tk_preferentialno tk_totPrice 
	@Override
	public CgvTicketingPaymentVO qrCreate(String realPath, CgvTicketingPaymentVO cvo,HttpServletRequest request) {
		String qrCode = "";
		String qrContent = "";
		String jsonData = "{ \"tk_cd\":\""+cvo.getTk_cd()+"\","
											+"\"tk_Id\":\""+cvo.getTk_Id()+"\","
											+"\"tk_movieName\":\""+cvo.getTk_movieName()+"\","
											+"\"tk_town\":\""+cvo.getTk_town()+"\","
											+"\"tk_screenDate\":\""+cvo.getTk_screenDate()+"\","
											+"\"tk_screenTime\":\""+cvo.getTk_screenTime()+"\","
											+"\"tk_seat\":\""+cvo.getTk_seat()+"\","
											+"\"tk_adultno\":\""+cvo.getTk_adultno()+"\","
											+"\"tk_teenno\":\""+cvo.getTk_teenno()+"\","
											+"\"tk_childno\":\""+cvo.getTk_childno()+"\","
											+"\"tk_preferentialno\":\""+cvo.getTk_preferentialno()+"\","
											+"\"tk_totPrice\":\""+cvo.getTk_totPrice()+"\""
											+ "}";
				
	
		
		String bigo = "http://49.142.157.251:9090/green2209S_10/myPage/myPageHome?jsonData="+jsonData;
		//String bigo = "http://192.168.50.247:9090/green2209S_10/myPage/myPageHome?jsonData="+jsonData;
		// qr링크로 갈떄 vo 들고가는법 찾아야해
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String uid = UUID.randomUUID().toString().substring(0,8);
		qrCode = sdf.format(new Date())+"_"+uid;
		
		try {
			// qr 코드 생성 설정 및 realPath에 저장
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			qrContent = new String(bigo.getBytes("UTF-8"), "ISO-8859-1");
			
			int qrCodeColor = 0xFF000000;			// qr코드 전경색(글자색)
			int qrCodeBackColor = 0xFFFFFFFF;	// qr코드 배경색
			
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();	// QR코드 객체 생성(moveFlag에 저장된 정보로 qr코드를 생성한다.)
			BitMatrix bitMatrix = qrCodeWriter.encode(qrContent, BarcodeFormat.QR_CODE, 200, 200);		// QR코드저장시 크기(폭/높이) 지정
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCode + ".png"));
			
			cvo.setTk_QRcode(qrCode+".png");
			
			CgvMemberVO mvo = homeDAO.getMemberIdCheck(cvo.getTk_Id());
			
			
			MimeMessage mm = mailSender.createMimeMessage();
			MimeMessageHelper mh = new MimeMessageHelper(mm,true,"UTF-8");
			
			String title = "GGV(오늘뭐볼까?) 영화-"+cvo.getTk_movieName()+" 예매 정상처리 및 QR코드 안내";
			String content = "안녕하세요. GGV(오늘 뭐볼까?)입니다 .\n";
			content += "정상적으로 예매가 완료되어 정상처리되었다는 안내 메일 보내드립니다.\n";
			content += "그리고 입장하실때 현장발권 대신 사용가능하신 QR코드를 보내드렸으니 참고바랍니다.\n";
			content = content.replace("\n", "<br/>");
			FileSystemResource fsr = new FileSystemResource(realPath+qrCode+".png");
			
			mh.addAttachment(qrCode+".png", fsr);
			
			mh.setTo(mvo.getMem_email());
			mh.setSubject(title);
			mh.setText(content,true);
			
			mailSender.send(mm);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return cvo;
	}

	// 예매된적있는 모든 자료를 가져감 (누적해서 지금보려는 영화의 해당 날짜 시간 이 같은 영화를 조회하려한다면 있따면 cgvseat테이블에있는 s_seat 필드값을 가져가서 뿌려줘야한다.
	@Override
	public List<CgvTicketingPaymentVO> getReservedSeat(CgvTicketingVO vo) {
		return movieDAO.getReservedSeat(vo);
	}

	// 예매된적없다면 새롭게 insert 해준다.
	@Override
	public void setSeatTableInput(CgvTicketingPaymentVO vo,int seatCnt) {
		seatCnt = 150 - seatCnt;
		movieDAO.setSeatTableInput(vo,seatCnt);
	}

	// 예매된적이있는지 없는지 있다면 res == 1 없다면 0 이갈것이고 
	@Override
	public CgvSeatVO getSeatTable(CgvTicketingPaymentVO vo) {
		return movieDAO.getSeatTable(vo);
	}

	// 이미 예매된적이있으면 cgvseat 테이블에 저장되어있기에 업데이트해줌 
	@Override 
	public void setSeatTableUpdate(CgvTicketingPaymentVO vo, int seatCnt) {
		movieDAO.setSeatTableUpdate(vo,seatCnt);
	}

	@Override
	public List<CgvSeatVO> getReservedSeatAll(String date,String movieName, String town) {
		return movieDAO.getReservedSeatAll(date,movieName,town);
	}

	@Override
	public List<CgvTicketingPaymentVO> getTkSeatList(CgvSeatVO cvo) {
		return movieDAO.getTkSeatList(cvo);
	}

}
