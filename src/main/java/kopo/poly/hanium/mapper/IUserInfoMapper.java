package kopo.poly.hanium.mapper;

import kopo.poly.hanium.dto.UserInfoDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IUserInfoMapper {

    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO emailAuthNumber(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO getUserId(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getUserForPassword(UserInfoDTO pDTO) throws Exception;  // 비번 찾기 (user_id+email)

    int updateUserPassword(UserInfoDTO pDTO) throws Exception;          // 비번 변경

    int deleteUser(UserInfoDTO pDTO) throws Exception;                  // 회원 탈퇴


    // 회원가입
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;

    // 아이디 중복체크
    UserInfoDTO getUserIdExists(UserInfoDTO pDTO) throws Exception;

    // 이메일 중복체크
    UserInfoDTO getUserEmailExists(UserInfoDTO pDTO) throws Exception;
}
