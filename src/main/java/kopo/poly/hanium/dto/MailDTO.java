package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString // 로그확인이 편리한 어노테이션
public class MailDTO {

    String toMail;
    String title;
    String contents;
}
