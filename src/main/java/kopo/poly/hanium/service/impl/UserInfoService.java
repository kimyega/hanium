package kopo.poly.hanium.service.impl;

import kopo.poly.hanium.dto.UserInfoDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import kopo.poly.hanium.mapper.IUserInfoMapper;
import org.springframework.stereotype.Service;
import kopo.poly.hanium.service.IUserInfoService;

import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserInfoService implements IUserInfoService {

    private final IUserInfoMapper userInfoMapper;

    @Override
    public UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception {

        log.info("{}.getLogin Start", this.getClass().getName());

        // 로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기 위한 mapper 호출하기
        // userInfoMapper.getUserLoginCheck(pDTO) 함수 실행과 NUll 발생하면, UserInfoDTO 메모리에 올리기
        UserInfoDTO rDTO = Optional.ofNullable(userInfoMapper.getLogin(pDTO)).orElseGet(UserInfoDTO::new);

        log.info("{}.getLogin End!", this.getClass().getName());

        return rDTO;
    }
}
