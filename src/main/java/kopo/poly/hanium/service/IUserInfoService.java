package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.UserInfoDTO;

public interface IUserInfoService {

    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;
}
