package khoaluantotnghiep.service;

public interface IEmailService {
    boolean sendEmail(String to, String subject, String content);
}
