package kopo.poly.hanium.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kopo.poly.hanium.dto.MsgDTO;
import kopo.poly.hanium.dto.UserInfoDTO;
import kopo.poly.hanium.service.IUserInfoService;
import kopo.poly.hanium.util.EncryptUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@RequestMapping(value = "/user")
@RequiredArgsConstructor
@Controller
public class UserInfoController {

    private final IUserInfoService userInfoService;

    @GetMapping(value = "login")
    public String loginpage() {

        return "user/login";
    }

    @ResponseBody
    @PostMapping(value = "loginProc")
    public MsgDTO loginProc(HttpServletRequest request, HttpSession session) {

        log.info("{}.loginProc Start!", this.getClass().getName());

        int res = 0;
        String msg = "";
        MsgDTO dto;

        UserInfoDTO pDTO;

        try {

            String userId = kopo.poly.util.CmmUtil.nvl(request.getParameter("userId"));
            String password = kopo.poly.util.CmmUtil.nvl(request.getParameter("password"));

            log.info("userId : {} / password : {}", userId, password);

            pDTO = new UserInfoDTO();
            pDTO.setUserId(userId);
            pDTO.setPassword(EncryptUtil.encHashSHA256(password));
//          pDTO.setPassword(password); DB에 암호화된 형태의 pw가 아니라서 테스트용으로 작성했음

            UserInfoDTO rDTO = userInfoService.getLogin(pDTO);

            if (!kopo.poly.util.CmmUtil.nvl(rDTO.getUserId()).isEmpty()) {
                res = 1;
                msg = "로그인이 성공했습니다.";

                session.setAttribute("SS_USER_ID", userId);
                session.setAttribute("SS_USER_NAME", kopo.poly.util.CmmUtil.nvl(rDTO.getName()));

            } else {
                msg = "아이디와 비밀번호가 올바르기 않습니다.";
            }

        } catch (Exception e) {
            msg = "시스템 문제로 로그인이 실패했습니다.";
            res = 2;
            log.info(e.toString());

        } finally {
            dto = new MsgDTO();
            dto.setResult(res);
            dto.setMsg(msg);

            log.info("{}.loginProc End!", this.getClass().getName());
        }

        return dto;
    }
}
