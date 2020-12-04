package common;

import java.io.File;
import java.io.FileInputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CommonService {
	
																				//응답하는 pc 		
	public File download(String filename, String filepath, HttpSession session, HttpServletResponse response) {
		File file = new File(session.getServletContext().getRealPath("resources") + filepath); //클라이언트 
	
		String mime = session.getServletContext().getMimeType(filename);
		
		response.setContentType(mime);
		
		
		try {
				filename = URLEncoder.encode(filename, "utf-8").replaceAll("\\+", "%20"); //한글이름이 있다면 utf8로 인코딩 
				response.setHeader("content-disposition", "attachment; filename=" + filename);
				ServletOutputStream out = response.getOutputStream();
				FileCopyUtils.copy(new FileInputStream(file), out); //복사해서 붙여넣기 
				out.flush();
		
		} catch (Exception e) {}
		
		
		return file;
	}
	
	
	
	
	
	public String upload(String category, MultipartFile file, HttpSession session) {
		//프로젝트의 물리적인 위치에 선택한 파일을 업로드 한다
		String resources = session.getServletContext().getRealPath("resources");
		String upload = resources + "/upload"; 
		String folder = upload + "/" + category + "/" + new SimpleDateFormat("yyyy/MM/dd").format(new Date());
		
		File f = new File(folder);
		if ( !f.exists() ) f.mkdirs();
		
		
		String uuid = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		
		
		try {
			
			file.transferTo(new File(folder, uuid));  // transferTo -> folder에 uuid를 넣는다 
		
		} catch (Exception e) {}
		
		//파일을 업로드해 둔 위치를 DB에 저장할 수 있도록 위치를 반환한다
		return folder.substring(resources.length()) + "/" + uuid;
	}
	
		
	
	
	
	
	
	
	public void sendEmail(String email, String name, HttpSession session) {
		//sendSimple(email, name);		
		//sendAttach(email, name, session);
		sendHtml(email, name, session);
	}
	
	
	private void sendHtml(String email, String name, HttpSession session) {
		HtmlEmail mail = new HtmlEmail();
		
		

		//서버지정
		mail.setHostName("smtp.naver.com");
		mail.setDebug(true);
		mail.setCharset("utf-8");
		
		//메일서버에 로그인하기
		mail.setAuthentication("zxczxc924", "makoto929##");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("zxczxc924@naver.com", "한울관리자"); //송신인
			mail.addTo(email, name); //수신인
			
			mail.setSubject("한울 IoT 가입");
			
			
			StringBuffer msg= new StringBuffer();
			
			msg.append("<html>");
			msg.append("<body>");
			msg.append("<a href='http://hanuledu.co.kr'><img src='https://ssl.pstatic.net/tveta/libs/1287/1287213/2510f9df42fda985f643_20200504115627454.jpg'></a>");
			msg.append("<h3>한울IoT과정</h3>");
			msg.append("<p>가입을 축하합니다.</p>");			
			msg.append("</body>");
			msg.append("</html>");
			
			mail.setHtmlMsg(msg.toString());
			
			
			EmailAttachment file = new EmailAttachment();
			file.setPath(session.getServletContext().getRealPath("resources")+ "/css/common.css");
			mail.attach(file); 
			
			file = new EmailAttachment();
			file.setURL(new URL("https://ssl.pstatic.net/tveta/libs/1287/1287213/2510f9df42fda985f643_20200504115627454.jpg"));
			mail.attach(file); 

			mail.send(); // 메일보내기
			
			
			
		} catch (Exception e) {
		}
		
		
		
		
		
	}
	
	private void sendAttach(String email, String name, HttpSession session) {
		MultiPartEmail mail = new MultiPartEmail();
		
		//서버지정
		mail.setHostName("smtp.naver.com");
		mail.setDebug(true);
		mail.setCharset("utf-8");
		
		//메일서버에 로그인하기
		mail.setAuthentication("zxczxc924", "makoto929##");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("zxczxc924@naver.com", "한울관리자"); //송신인
			mail.addTo(email, name); //수신인
			
			mail.setSubject("한울 IoT 가입");
			mail.setMsg(name +" 님, IoT 과정 가입을 축하합니다!");

			//파일첨부
			EmailAttachment file = new EmailAttachment();
			file.setURL( new URL("https://mvnrepository.com/assets/images/392dffac024b9632664e6f2c0cac6fe5-logo.png") );
			mail.attach(file);
			
			file = new EmailAttachment();
			file.setPath( session.getServletContext().getRealPath("resources")
							+"/images/hanul.png"  );
			mail.attach(file);
			
			mail.send(); //이메일 보내기		
		}catch(Exception e) {}
		
	}
	
	private void sendSimple(String email, String name) {
		SimpleEmail mail = new SimpleEmail();
		
		//서버지정
		mail.setHostName("smtp.naver.com");
		mail.setDebug(true);
		mail.setCharset("utf-8");
		
		//메일서버에 로그인하기
		mail.setAuthentication("zxczxc924", "makoto929##");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("zxczxc924@naver.com", "한울관리자"); //송신인
			mail.addTo(email, name); //수신인
			
			mail.setSubject("한울 IoT 가입");
			mail.setMsg(name +" 님, IoT 과정 가입을 축하합니다!");
			
			mail.send(); //이메일 보내기		
		}catch(EmailException e) {}
	}
}
