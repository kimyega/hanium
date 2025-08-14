package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.UserInfoDTO;

public interface IUserInfoService {

    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO emailAuthNumber(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO searchUserIdOrPasswordProc(UserInfoDTO pDTO) throws Exception;

    // 아이디 중복체크
    UserInfoDTO getUserIdExists(UserInfoDTO pDTO) throws Exception;

    // 이메일 중복체크 및 인증값
    UserInfoDTO getEmailExists(UserInfoDTO pDTO) throws Exception;

    // 회원가입
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;
}
