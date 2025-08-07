package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.MailDTO;

public interface IMailService {

    int doSendMail(MailDTO pDTO);
}
