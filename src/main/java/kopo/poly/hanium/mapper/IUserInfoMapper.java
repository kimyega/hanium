package kopo.poly.hanium.mapper;

import kopo.poly.hanium.dto.UserInfoDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IUserInfoMapper {

    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;
}
