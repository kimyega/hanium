package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserInfoDTO {
    private String userId;
    private String password;
    private String name;
    private String email;
    private String birthDate;
    private String createdAt;

    private String existsYn; // 중복 가입을 방지하기 위해 사용할 변수
    private int authNumber; // 메일 중복체크를 위한 인증번호
}
