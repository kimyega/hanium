package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.UserInfoDTO;

public interface IUserInfoService {

    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO emailAuthNumber(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO searchUserIdOrPasswordProc(UserInfoDTO pDTO) throws Exception;
}
