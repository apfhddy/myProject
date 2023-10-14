package email;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailSendService {
	
    private JavaMailSenderImpl mailSender;
    
    public MailSendService(JavaMailSenderImpl gmlfkrd) {
    	this.mailSender = gmlfkrd;
    }
    
    public MailSendService() {} 
    
    private String getKey(int size) {
		String key = "";
		for(int i = 0; i < size; i ++) {
			switch (RAN(0, 2)) {
			case 0:
				int a = 0;
				switch(RAN(0, 1)) {
				case 0:
					a = RAN(65, 90);
					break;
				case 1:
					a = RAN(97, 122);
					break;
				}
				char c = (char)a;
				key += c;
				break;
			case 1:
				key += RAN(0, 9);
				break;
			case 2:
				 c = (char)RAN(33, 47);
				 key += c;
				break;

			}
		}
    	
    	
        return key;//(int)(Math.random()*Integer.parseInt(num))+Integer.parseInt(ps)+"";  //6개 숫자 랜덤 만들어보세요 0 ~ 89999
    }

    
	public String joinEmail(String email) {
		String a = getKey(12);
		String setFrom = ".com"; // email-config에 설정한 자신의 이메일 주소를 입력 
		String toMail = email;
		String title = "회원 가입 인증 이메일 입니다."; // 이메일 제목 
		String content = 
				"홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 ! 
                "<br><br>" + 
			    "인증 번호는 " + a + "입니다." + 
			    "<br>" + 
			    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
		mailSend(setFrom, toMail, title, content);
		return a;
	}
	
	//이메일 전송 메소드
	public void mailSend(String setFrom, String toMail, String title, String content) { 
		MimeMessage message = mailSender.createMimeMessage();
		// true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo("vavogmlfkr4@gmail.com");
			helper.setSubject("myProject 인증번호");
			// ** true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
			helper.setText(content,true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
    public  int RAN(int min,int max) { /// 1 10
    	max = max - min +1;
    	return (int)(Math.random()*max)+min;
    }
}