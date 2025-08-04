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

    // 나머지는 생성 필요
}
