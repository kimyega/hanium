package kopo.poly.hanium.service.impl;

import kopo.poly.hanium.dto.MailDTO;
import kopo.poly.hanium.dto.UserInfoDTO;
import kopo.poly.hanium.service.IMailService;
import kopo.poly.hanium.util.EncryptUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import kopo.poly.hanium.mapper.IUserInfoMapper;
import org.springframework.stereotype.Service;
import kopo.poly.hanium.service.IUserInfoService;

import java.util.Optional;
import java.util.concurrent.ThreadLocalRandom;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserInfoService implements IUserInfoService {

    private final IUserInfoMapper userInfoMapper;
    private final IMailService mailService;

    @Override
    public UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception {

        log.info("{}.getLogin Start!", this.getClass().getName());

        UserInfoDTO rDTO = Optional.ofNullable(userInfoMapper.getLogin(pDTO)).orElseGet(UserInfoDTO::new);

        if (!kopo.poly.hanium.util.CmmUtil.nvl(rDTO.getUserId()).isEmpty()) {

            MailDTO mDTO = new MailDTO();

//            mDTO.setToMail(EncryptUtil.decAES128BCBC(kopo.poly.util.CmmUtil.nvl(rDTO.getEmail())));
            mDTO.setToMail(rDTO.getEmail());

            mDTO.setTitle("로그인 알림!");

            mDTO.setContents(kopo.poly.util.DateUtil.getDateTime("yyyy.MM.dd hh:mm:ss") + "에 "
                    + kopo.poly.hanium.util.CmmUtil.nvl(rDTO.getName()) + "님이 로그인하였습니다.");

            mailService.doSendMail(mDTO);
        }

        log.info("{}.getLogin End!", this.getClass().getName());

        return rDTO;
    }

    @Override
    public UserInfoDTO emailAuthNumber(UserInfoDTO pDTO) throws Exception {

        log.info("{}.emailAuth Start!", this.getClass().getName());

        UserInfoDTO rDTO = Optional.ofNullable(userInfoMapper.emailAuthNumber(pDTO)).orElseGet(UserInfoDTO::new);

        log.info("rDTO : {}", rDTO);

        if (kopo.poly.hanium.util.CmmUtil.nvl(rDTO.getExistsYn()).equals("Y")) {

            int authNumber = ThreadLocalRandom.current().nextInt(100000, 1000000);
            log.info("authNumber : {}", authNumber);

            MailDTO dto = new MailDTO();

            dto.setTitle("아이디 찾기 인증번호 발송 메일");
            dto.setContents("인증번호는 " + authNumber + " 입니다.");
            dto.setToMail(kopo.poly.hanium.util.CmmUtil.nvl(pDTO.getEmail()));
//            dto.setToMail(EncryptUtil.decAES128BCBC(kopo.poly.hanium.util.CmmUtil.nvl(pDTO.getEmail())));

            mailService.doSendMail(dto);

            dto = null;

            rDTO.setAuthNumber(authNumber);
        }

        log.info("{}.emailAuth End!", this.getClass().getName());

        return rDTO;
    }

    @Override
    public UserInfoDTO searchUserIdOrPasswordProc(UserInfoDTO pDTO) throws Exception {
        log.info("{}.searchUserIdOrPasswordProc Start!", this.getClass().getName());

        UserInfoDTO rDTO = userInfoMapper.getUserId(pDTO);

        log.info("{}.searchUserIdOrPasswordProc End!", this.getClass().getName());

        return rDTO;
    }
}
