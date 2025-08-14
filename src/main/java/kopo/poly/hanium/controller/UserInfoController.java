package kopo.poly.hanium.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kopo.poly.hanium.dto.MsgDTO;
import kopo.poly.hanium.dto.UserInfoDTO;
import kopo.poly.hanium.service.IUserInfoService;
import kopo.poly.hanium.util.CmmUtil;
import kopo.poly.hanium.util.EncryptUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Optional;

@Slf4j
@RequestMapping(value = "/user")
@RequiredArgsConstructor
@Controller
public class UserInfoController {

    private final IUserInfoService userInfoService;

    // 로그인 페이지 이동
    @GetMapping(value = "login")
    public String loginpage() {

        return "user/login";
    }

    @GetMapping(value = "findId")
    public String findId() {

        return "user/findId";
    }

    // 회원가입 페이지 이동
    @GetMapping(value = "register")
    public String register() {
        log.info("{}.user/register", this.getClass().getName());

        return "user/register";
    }

    // 로그인시 입력한 정보를 DB에서 확인해서 결과를 리턴
    @ResponseBody
    @PostMapping(value = "loginProc")
    public MsgDTO loginProc(HttpServletRequest request, HttpSession session) {

        log.info("{}.loginProc Start!", this.getClass().getName());

        int res = 0;
        String msg = "";
        MsgDTO dto;

        UserInfoDTO pDTO;

        try {

            String userId = kopo.poly.hanium.util.CmmUtil.nvl(request.getParameter("userId"));
            String password = kopo.poly.hanium.util.CmmUtil.nvl(request.getParameter("password"));

            log.info("userId : {} / password : {}", userId, password);


            pDTO = new UserInfoDTO();
            pDTO.setUserId(userId);

//            pDTO.setPassword(EncryptUtil.encHashSHA256(password));
            pDTO.setPassword(password);
            UserInfoDTO rDTO = userInfoService.getLogin(pDTO);

            if (!kopo.poly.hanium.util.CmmUtil.nvl(rDTO.getUserId()).isEmpty()) {
                res = 1;
                msg = "로그인이 성공했습니다.";

                session.setAttribute("SS_USER_ID", userId);
                session.setAttribute("SS_USER_NAME", kopo.poly.hanium.util.CmmUtil.nvl(rDTO.getName()));

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

    @ResponseBody
    @PostMapping(value = "emailAuthNumber")
    public UserInfoDTO emailAuthNumber(HttpServletRequest request) throws Exception {

        log.info("{}.emailAuthNumber Start!", this.getClass().getName());

        String email = kopo.poly.hanium.util.CmmUtil.nvl(request.getParameter("email"));

        log.info("email : {}", email);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setEmail(email);
//        pDTO.setEmail(EncryptUtil.encAES128BCBC(email));

        UserInfoDTO rDTO = Optional.ofNullable(userInfoService.emailAuthNumber(pDTO)).orElseGet(UserInfoDTO::new);

        log.info("{}.emailAuthNumber End!", this.getClass().getName());

        return rDTO;
    }

    @ResponseBody
    @PostMapping(value = "searchUserIdProc")
    public MsgDTO searchUserIdProc(HttpServletRequest request) throws Exception {

        log.info("{}.searchUserIdProc Start!", this.getClass().getName());

        String userName = CmmUtil.nvl(request.getParameter("userName"));
        String email = CmmUtil.nvl(request.getParameter("email"));

        log.info("userName : {} / email : {}", userName, email);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setName(userName);
        pDTO.setEmail(email);

        UserInfoDTO rDTO = Optional.ofNullable(
                userInfoService.searchUserIdOrPasswordProc(pDTO)
        ).orElseGet(UserInfoDTO::new);

        MsgDTO dto = new MsgDTO();

        if (rDTO.getUserId() != null) {
            dto.setResult(1);
            dto.setMsg(rDTO.getUserId());
            dto.setName(rDTO.getName());
        } else {
            dto.setResult(0);
            dto.setMsg("존재하지 않는 사용자입니다.");
        }

        log.info("{}.searchUserIdProc End!", this.getClass().getName());

        return dto;
    }

    /*
    *  아이디 중복체크
    * */
    @ResponseBody
    @PostMapping(value = "getUserIdExists")
    public UserInfoDTO getUserExists(HttpServletRequest request) throws Exception {

        log.info("{}.getUserIdExists Start!", this.getClass().getName());

        String userId = CmmUtil.nvl(request.getParameter("userId"));

        log.info("userId : {}", userId);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUserId(userId);

        UserInfoDTO rDTO = Optional.ofNullable(userInfoService.getUserIdExists(pDTO)).orElseGet(UserInfoDTO::new);

        log.info("{}.getUserIdExists End!", this.getClass().getName());

        return rDTO;
    }

    /*
     *  이메일 중복체크
     * */
    @ResponseBody
    @PostMapping(value = "getEmailExists")
    public UserInfoDTO getEmailExists(HttpServletRequest request) throws Exception {

        log.info("{}.getEmailExists Start!", this.getClass().getName());

        String email = CmmUtil.nvl(request.getParameter("email"));

        log.info("email : {}", email);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setEmail(EncryptUtil.encAES128BCBC(email));

        UserInfoDTO rDTO = Optional.ofNullable(userInfoService.getEmailExists(pDTO)).orElseGet(UserInfoDTO::new);

        log.info("{}.getEmailExists End!", this.getClass().getName());

        return rDTO;
    }

    /*
     *  회원가입
     * */
    @ResponseBody
    @PostMapping(value = "insertUserInfo")
    public MsgDTO insertUserInfo(HttpServletRequest request) {

        log.info("{}.insertUserInfo Start!", this.getClass().getName());

        int res = 0;
        String msg = "";
        MsgDTO dto;

        UserInfoDTO pDTO;

        try {
            String userId = CmmUtil.nvl(request.getParameter("userId"));
            String password = CmmUtil.nvl(request.getParameter("password"));
            String name = CmmUtil.nvl(request.getParameter("name"));
            String email = CmmUtil.nvl(request.getParameter("email"));

            String birthYear = CmmUtil.nvl(request.getParameter("birthYear"));
            String birthMonth = CmmUtil.nvl(request.getParameter("birthMonth"));
            String birthDay = CmmUtil.nvl(request.getParameter("birthDay"));
            String birthDate = birthYear + "-" + birthMonth + "-" + birthDay;

            log.info("userId : {}", userId);
            log.info("password : {}", password);
            log.info("name : {}", name);
            log.info("email : {}", email);
            log.info("birthDate : {}", birthDate);

            pDTO = new UserInfoDTO();
            pDTO.setUserId(userId);
            pDTO.setPassword(EncryptUtil.encHashSHA256(password));
            pDTO.setName(name);
            pDTO.setEmail(EncryptUtil.encAES128BCBC(email));
            pDTO.setBirthDate(birthDate);

            res = userInfoService.insertUserInfo(pDTO);

            log.info("회원가입 결과 (res) : " + res);

            if(res == 1) {
                msg = "회원가입 되었습니다.";
            } else if (res == 2) {
                msg = "이미 가입된 아이디 입니다.";
            } else {
                msg = "오류로 인해 회원가입이 실패하였습니다.";
            }

        } catch (Exception e) {
            msg = "실패하였습니다." + e;
            log.info(e.toString());
        } finally {

            dto = new MsgDTO();
            dto.setResult(res);
            dto.setMsg(msg);

            log.info("{}.insertUserInfo End!", this.getClass().getName());
        }

        return dto;
    }


}
