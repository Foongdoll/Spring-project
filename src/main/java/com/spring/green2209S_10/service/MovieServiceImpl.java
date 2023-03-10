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

	// qr?????? ?????? ?????? ????????? tk_cd  tk_Id  tk_movieName tk_town tk_screenDate tk_screenTime tk_seat tk_adultno tk_teenno tk_childno tk_preferentialno tk_totPrice 
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
		// qr????????? ?????? vo ??????????????? ????????????
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String uid = UUID.randomUUID().toString().substring(0,8);
		qrCode = sdf.format(new Date())+"_"+uid;
		
		try {
			// qr ?????? ?????? ?????? ??? realPath??? ??????
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			qrContent = new String(bigo.getBytes("UTF-8"), "ISO-8859-1");
			
			int qrCodeColor = 0xFF000000;			// qr?????? ?????????(?????????)
			int qrCodeBackColor = 0xFFFFFFFF;	// qr?????? ?????????
			
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();	// QR?????? ?????? ??????(moveFlag??? ????????? ????????? qr????????? ????????????.)
			BitMatrix bitMatrix = qrCodeWriter.encode(qrContent, BarcodeFormat.QR_CODE, 200, 200);		// QR??????????????? ??????(???/??????) ??????
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCode + ".png"));
			
			cvo.setTk_QRcode(qrCode+".png");
			
			CgvMemberVO mvo = homeDAO.getMemberIdCheck(cvo.getTk_Id());
			
			
			MimeMessage mm = mailSender.createMimeMessage();
			MimeMessageHelper mh = new MimeMessageHelper(mm,true,"UTF-8");
			
			String title = "GGV(????????????????) ??????-"+cvo.getTk_movieName()+" ?????? ???????????? ??? QR?????? ??????";
			String content = "???????????????. GGV(?????? ??????????)????????? .\n";
			content += "??????????????? ????????? ???????????? ???????????????????????? ?????? ?????? ??????????????????.\n";
			content += "????????? ??????????????? ???????????? ?????? ?????????????????? QR????????? ?????????????????? ??????????????????.\n";
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

	// ?????????????????? ?????? ????????? ????????? (???????????? ??????????????? ????????? ?????? ?????? ?????? ??? ?????? ????????? ????????????????????? ????????? cgvseat?????????????????? s_seat ???????????? ???????????? ??????????????????.
	@Override
	public List<CgvTicketingPaymentVO> getReservedSeat(CgvTicketingVO vo) {
		return movieDAO.getReservedSeat(vo);
	}

	// ????????????????????? ????????? insert ?????????.
	@Override
	public void setSeatTableInput(CgvTicketingPaymentVO vo,int seatCnt) {
		seatCnt = 150 - seatCnt;
		movieDAO.setSeatTableInput(vo,seatCnt);
	}

	// ???????????????????????? ????????? ????????? res == 1 ????????? 0 ??????????????? 
	@Override
	public CgvSeatVO getSeatTable(CgvTicketingPaymentVO vo) {
		return movieDAO.getSeatTable(vo);
	}

	// ?????? ???????????????????????? cgvseat ???????????? ????????????????????? ?????????????????? 
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
