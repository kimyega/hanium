package kopo.poly.hanium.mapper;

import kopo.poly.hanium.dto.UserInfoDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IUserInfoMapper {

    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO emailAuthNumber(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO getUserId(UserInfoDTO pDTO) throws Exception;

    // ▼ 비밀번호 찾기: 사용자 존재 확인 (userId + name + email)
    UserInfoDTO getUserForPassword(UserInfoDTO pDTO) throws Exception;

    // ▼ 비밀번호 업데이트
    int updateUserPassword(UserInfoDTO pDTO) throws Exception;
    int deleteUser(UserInfoDTO pDTO) throws Exception;

}
