package kopo.poly.hanium.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kopo.poly.hanium.dto.MsgDTO;
import kopo.poly.hanium.dto.QuizDTO;
import kopo.poly.hanium.dto.QuizResultsDTO;
import kopo.poly.hanium.dto.UserInfoDTO;
import kopo.poly.hanium.service.IQuizService;
import kopo.poly.hanium.service.IUserInfoService;
import kopo.poly.hanium.util.CmmUtil;
import kopo.poly.hanium.util.EncryptUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@RequestMapping(value = "/user")
@RequiredArgsConstructor
@Controller
public class UserInfoController {

    private final IUserInfoService userInfoService;
    private final IQuizService quizService;

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

            pDTO.setPassword(EncryptUtil.encHashSHA256(password));
            UserInfoDTO rDTO = userInfoService.getLogin(pDTO);

            if (!kopo.poly.hanium.util.CmmUtil.nvl(rDTO.getUserId()).isEmpty()) {
                res = 1;
                msg = "로그인이 성공했습니다.";

                session.setAttribute("SS_USER_ID", userId);
                session.setAttribute("SS_USER_NAME", CmmUtil.nvl(rDTO.getName()));

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

    // 로그아웃
    @PostMapping("/logout")
    @ResponseBody
    public MsgDTO logout(HttpSession session) {

        log.info("{}.logout Start!", this.getClass().getName());

        int res = 1; // 기본 성공
        String msg = "";

        MsgDTO dto = new MsgDTO();

        try {
            session.invalidate();
            msg = "성공적으로 로그아웃되었습니다.";
        } catch (Exception e) {
            res = 0;
            msg = "로그아웃 중 오류가 발생했습니다.";
        }

        dto.setResult(res);
        dto.setMsg(msg);

        log.info("{}.logout End!", this.getClass().getName());

        return dto;
    }

    @ResponseBody
    @PostMapping(value = "emailAuthNumber")
    public UserInfoDTO emailAuthNumber(HttpServletRequest request) throws Exception {

        log.info("{}.emailAuthNumber Start!", this.getClass().getName());

        String userName = CmmUtil.nvl(request.getParameter("userName"));
        String email = CmmUtil.nvl(request.getParameter("email"));

        log.info("userName : {}", userName);
        log.info("email : {}", email);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setName(userName);
        pDTO.setEmail(EncryptUtil.encAES128BCBC(email));

        log.info("암호화 email : {}", pDTO.getEmail());

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
        pDTO.setEmail(EncryptUtil.encAES128BCBC(email));

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
    @GetMapping(value = "mypage")
    public String myPage(){

        return "user/mypage";
    }

    // 퀴즈 결과만 반환하는 API (JSON 응답)
    @ResponseBody
    @GetMapping("quizHistory")
    public List<QuizDTO> getQuizHistory(HttpSession session) throws Exception {
        log.info("{}.getQuizHistory Start!", this.getClass().getName());

        String userId = (String) session.getAttribute("SS_USER_ID");

        List<QuizDTO> rList = Optional.ofNullable(quizService.getQuizList()).orElseGet(ArrayList::new);

        for (QuizDTO quiz : rList) {
            quiz.setUserId(userId);
            QuizResultsDTO qResult = quizService.getQuizResultByUserAndQuiz(quiz);
            if (qResult != null) {
                quiz.setScore(qResult.getScore());
                quiz.setTotal(qResult.getTotal());
                quiz.setTakenAt(qResult.getTakenAt());
            }
        }

        log.info("{}.getQuizHistory End!", this.getClass().getName());

        return rList;
    }


    // 비밀번호 찾기 페이지 이동
    @GetMapping(value = "findPw")
    public String findPw() {
        return "user/findPw"; // JSP: /WEB-INF/views/user/findPw.jsp
    }
    @ResponseBody
    @PostMapping(value = "searchPasswordProc")
    public MsgDTO searchPasswordProc(HttpServletRequest request) throws Exception {

        log.info("{}.searchPasswordProc Start!", this.getClass().getName());

        String userId = CmmUtil.nvl(request.getParameter("userId"));
        String email  = CmmUtil.nvl(request.getParameter("email"));

        log.info("userId : {} / email : {}", userId, email);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUserId(userId);
        pDTO.setEmail(email);

        UserInfoDTO rDTO = Optional.ofNullable(
                userInfoService.searchUserIdOrPasswordProc(pDTO) // 내부에서 userId+email 일치 확인
        ).orElseGet(UserInfoDTO::new);

        MsgDTO dto = new MsgDTO();

        if (rDTO.getUserId() != null) {
            dto.setResult(1);
            dto.setMsg("본인 확인 완료");
            // dto.setName(rDTO.getName()); // 이름 안 쓸거면 필요 없음
        } else {
            dto.setResult(0);
            dto.setMsg("입력하신 정보와 일치하는 사용자가 없습니다.");
        }

        log.info("{}.searchPasswordProc End!", this.getClass().getName());

        return dto;
    }

    @ResponseBody
    @PostMapping(value = "resetPasswordProc")
    public MsgDTO resetPasswordProc(HttpServletRequest request) {

        log.info("{}.resetPasswordProc Start!", this.getClass().getName());

        int res = 0;
        String msg;

        try {
            String userId   = CmmUtil.nvl(request.getParameter("userId"));
            String password = CmmUtil.nvl(request.getParameter("password"));

            log.info("reset target userId : {}", userId);

            if (userId.isEmpty() || password.isEmpty()) {
                msg = "잘못된 요청입니다.";
            } else {
                UserInfoDTO pDTO = new UserInfoDTO();
                pDTO.setUserId(userId);

                // ※ 실제 운영 시에는 반드시 해시 적용
                // pDTO.setPassword(EncryptUtil.encHashSHA256(password));
                pDTO.setPassword(password); // 데모/테스트용

                int i = userInfoService.updatePassword(pDTO); // IUserInfoService에 메서드 필요

                if (i > 0) {
                    res = 1;
                    msg = "비밀번호가 변경되었습니다.";
                } else {
                    msg = "비밀번호 변경에 실패했습니다.";
                }
            }
        } catch (Exception e) {
            log.error("resetPasswordProc ERROR: ", e);
            res = 2;
            msg = "시스템 문제로 비밀번호 변경에 실패했습니다.";
        }

        MsgDTO dto = new MsgDTO();
        dto.setResult(res);
        dto.setMsg(msg);

        log.info("{}.resetPasswordProc End!", this.getClass().getName());

        return dto;
    }
    // 1) 탈퇴 페이지 이동
    @GetMapping(value = "withdraw")
    public String withdrawPage() {
        return "user/withdraw";
    }

    // 2) 탈퇴 처리 (비밀번호 확인 + 삭제 + 세션종료)
    @ResponseBody
    @PostMapping(value = "withdrawProc")
    public MsgDTO withdrawProc(HttpServletRequest request, HttpSession session) {

        log.info("{}.withdrawProc Start!", this.getClass().getName());

        int res = 0;
        String msg;

        try {
            String userId = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID")); // 현재 로그인 유저
            String password = CmmUtil.nvl(request.getParameter("password"));

            if (userId.isEmpty() || password.isEmpty()) {
                msg = "잘못된 요청입니다.";
            } else {
                // 로그인과 동일한 방식으로 비번 검증
                UserInfoDTO pDTO = new UserInfoDTO();
                pDTO.setUserId(userId);

                // 로그인에서 해시쓰면 아래로 교체
                pDTO.setPassword(EncryptUtil.encHashSHA256(password));

                UserInfoDTO rDTO = userInfoService.getLogin(pDTO);

                if (rDTO != null && !CmmUtil.nvl(rDTO.getUserId()).isEmpty()) {
                    // 비밀번호 일치 → 삭제
                    UserInfoDTO dDTO = new UserInfoDTO();
                    dDTO.setUserId(userId);
                    int i = userInfoService.deleteUser(dDTO);

                    if (i > 0) {
                        res = 1;
                        msg = "회원 탈퇴가 완료되었습니다.";
                        // 세션 종료
                        session.invalidate();
                    } else {
                        msg = "회원 탈퇴에 실패했습니다.";
                    }
                } else {
                    msg = "비밀번호가 일치하지 않습니다.";
                }
            }
        } catch (Exception e) {
            log.error("withdrawProc ERROR: ", e);
            res = 2;
            msg = "시스템 문제로 탈퇴 처리에 실패했습니다.";
        }

        MsgDTO dto = new MsgDTO();
        dto.setResult(res);
        dto.setMsg(msg);

        log.info("{}.withdrawProc End!", this.getClass().getName());
        return dto;
    }
    // 비밀번호 변경 페이지 이동
    @GetMapping(value = "changePw")
    public String changePwPage() {
        return "user/changePw";
    }

    // 비밀번호 변경 처리
    @ResponseBody
    @PostMapping(value = "changePwProc")
    public MsgDTO changePwProc(HttpServletRequest request, HttpSession session) {

        log.info("{}.changePwProc Start!", this.getClass().getName());

        int res = 0;
        String msg;

        try {
            String userId    = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
            String currentPw = CmmUtil.nvl(request.getParameter("currentPw"));
            String newPw     = CmmUtil.nvl(request.getParameter("newPw"));

            if (userId.isEmpty() || currentPw.isEmpty() || newPw.isEmpty()) {
                msg = "잘못된 요청입니다.";
            } else {
                UserInfoDTO pDTO = new UserInfoDTO();
                pDTO.setUserId(userId);
                pDTO.setPassword(currentPw); // 해시 쓰면 EncryptUtil 적용

                UserInfoDTO rDTO = userInfoService.getLogin(pDTO);

                if (rDTO != null && rDTO.getUserId() != null) {
                    UserInfoDTO uDTO = new UserInfoDTO();
                    uDTO.setUserId(userId);
                    uDTO.setPassword(newPw); // 해시 쓰면 EncryptUtil 적용

                    int i = userInfoService.updatePassword(uDTO);

                    if (i > 0) {
                        res = 1;
                        msg = "비밀번호가 변경되었습니다.";
                        session.invalidate(); // 로그아웃 처리
                    } else {
                        msg = "비밀번호 변경에 실패했습니다.";
                    }
                } else {
                    msg = "현재 비밀번호가 일치하지 않습니다.";
                }
            }
        } catch (Exception e) {
            log.error("changePwProc ERROR: ", e);
            res = 2;
            msg = "시스템 문제로 비밀번호 변경에 실패했습니다.";
        }

        MsgDTO dto = new MsgDTO();
        dto.setResult(res);
        dto.setMsg(msg);

        log.info("{}.changePwProc End!", this.getClass().getName());
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

            log.info("암호화 email : {}", pDTO.getEmail());

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

    @GetMapping(value = "main")
    public String main() {

        return "user/main";
    }


}
