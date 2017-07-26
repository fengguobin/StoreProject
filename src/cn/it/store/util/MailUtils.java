package cn.it.store.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class MailUtils {

	public static void sendMail(String email, String emailMsg)
			throws AddressException, MessagingException {
		
		// 1.创建一个程序与邮件服务器会话对象 Session
		Properties props = new Properties();
		
		/*//使用本地localhost邮箱服务器时可省略这些配置
		props.setProperty("mail.transport.protocol", "SMTP");
		props.setProperty("mail.host", "smtp.163.com");
		props.setProperty("mail.smtp.auth", "true");// 指定验证为true
		 */
		
		// 1.1创建验证器  邮件服务器帐号和密码(sevice 111)
		Authenticator auth = new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("service", "111");
			}
		};

		Session session = Session.getInstance(props, auth);
		//session.setDebug(true);显示发送时候的验证信息
		
		// 2.创建一个Message，它相当于是邮件内容
		Message message = new MimeMessage(session);
		// 2.1设置发件人
		message.setFrom(new InternetAddress("service@store.com")); // 设置发送者
		// 2.2设置收件人
		message.setRecipient(RecipientType.TO, new InternetAddress(email)); // 设置发送方式与接收者
		// 2.3设置邮件主题
		message.setSubject("用户激活");
		// 2.5设置邮件内容
		// message.setText("这是一封激活邮件，请<a href='#'>点击</a>");
		message.setContent(emailMsg, "text/html;charset=utf-8");

		// 3.创建 Transport用于将邮件发送
		Transport.send(message);
		
	}
	
	public static void main(String[] args) {
		try {
			MailUtils.sendMail("user01@store.com","哈哈哈");
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
