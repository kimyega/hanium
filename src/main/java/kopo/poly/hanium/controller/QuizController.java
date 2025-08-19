package kopo.poly.hanium.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kopo.poly.hanium.dto.MsgDTO;
import kopo.poly.hanium.dto.UserInfoDTO;
import kopo.poly.hanium.util.EncryptUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import kopo.poly.hanium.service.IUserInfoService;

@Slf4j
@RequestMapping(value = "/contents")
@RequiredArgsConstructor
@Controller
public class QuizController {


    @GetMapping(value = "fairytaleList")
    public String quizPage() {

        return "fairytale/fairytaleList";
    }
    @GetMapping(value = "readFairytale")
    public String haniumPage() {

        return "fairytale/readFairytale";
    }
    @GetMapping(value = "makeFairytale")
    public String makePage() {

        return "make/makeFairytale";
    }
    @GetMapping(value = "makeFairytaleResult")
    public String makeResultPage() {

        return "make/makeFairytaleResult";
    }
    @GetMapping(value = "quiz")
    public String quiz1Page() {

        return "quiz/quiz";
    }
    @GetMapping(value = "quizList")
    public String quizListPage() {

        return "quiz/quizList";
    }
    @GetMapping(value = "quizResult")
    public String quizResultPage() {

        return "quiz/quizResult";
    }




    @GetMapping(value = "/")
    public String indexpage() {

        return "index";
    }



    @GetMapping(value = "haniumstartpage")
    public String haniumstartpage() {

        return "contents/haniumstartpage";
    }

    @GetMapping(value = "haniumIDfound01")
    public String haniumIDfound01() {

        return "contents/haniumIDfound01";
    }

    @GetMapping(value = "haniumpassword")
    public String haniumpassword() {

        return "contents/haniumpassword";
    }

    @GetMapping(value = "hanium-login")
    public String haniumlogin() {

        return "contents/hanium-login";
    }

    @GetMapping(value = "index")
    public String index() {

        return "index";
    }

    @GetMapping(value = "mypage")
    public String myPage() {

        return "contents/mypage";
    }

    @GetMapping(value = "register")
    public String register() {

        return "contents/register";
    }
}
