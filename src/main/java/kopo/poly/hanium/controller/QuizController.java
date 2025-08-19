package kopo.poly.hanium.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
