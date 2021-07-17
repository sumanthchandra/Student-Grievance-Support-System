package studentSupport;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {

	Properties emailProperties;
	Session mailSession;
	MimeMessage emailMessage;
	String toEmails;
	String emailSubject;
	String emailBody;

	public SendEmail(String t, String es, String eb) {
		toEmails = t;
		emailSubject = es;
		emailBody = eb;
	}

	public void setMailServerProperties() {

		String emailPort = "587";// Gmail's SMTP port
		emailProperties = System.getProperties();
		emailProperties.put("mail.smtp.port", emailPort);
		emailProperties.put("mail.smtp.auth", "true");
		emailProperties.put("mail.smtp.starttls.enable", "true");

	}

	public void createEmailMessage() throws AddressException, MessagingException {

		mailSession = Session.getDefaultInstance(emailProperties, null);
		emailMessage = new MimeMessage(mailSession);

		// for (int i = 0; i < toEmails.length; i++) {
		emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails));
		// }

		emailMessage.setSubject(emailSubject);
		emailMessage.setContent(emailBody, "text/html");
		// for a html email
		// emailMessage.setText(emailBody);// for a text email

	}

	public void sendEmail() throws AddressException, MessagingException, IOException {
		
		Properties properties = new Properties();
        String file = "credentials.properties"; //This file should be present in classpath , in the Src folder
        InputStream inpuStream = getClass().getClassLoader().getResourceAsStream(file);
        properties.load(inpuStream);	
		String emailHost = "smtp.gmail.com";
		String fromUser = properties.getProperty("email");// just the email id alone without @gmail.com
		String fromUserEmailPassword = properties.getProperty("password");
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(emailHost, fromUser, fromUserEmailPassword);
		transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
		transport.close();
		System.out.println("Email sent successfully.");
	}
}