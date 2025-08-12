package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.UserInfoDTO;

public interface IUserInfoService {

    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO emailAuthNumber(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO searchUserIdOrPasswordProc(UserInfoDTO pDTO) throws Exception;
    // IUserInfoService.java 에 추가
    int updatePassword(UserInfoDTO pDTO) throws Exception;
    int deleteUser(UserInfoDTO pDTO) throws Exception;



}
