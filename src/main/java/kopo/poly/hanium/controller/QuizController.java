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

        return "contents/fairytaleList";
    }
    @GetMapping(value = "hanium")
    public String haniumPage() {

        return "contents/hanium";
    }
    @GetMapping(value = "make")
    public String makePage() {

        return "contents/make";
    }
    @GetMapping(value = "makeResult")
    public String makeResultPage() {

        return "contents/makeResult";
    }
    @GetMapping(value = "quiz1")
    public String quiz1Page() {

        return "contents/quiz1";
    }
    @GetMapping(value = "quiz2")
    public String quiz2Page() {

        return "contents/quiz2";
    }
    @GetMapping(value = "quiz3")
    public String quiz3Page() {

        return "contents/quiz3";
    }
    @GetMapping(value = "quizList")
    public String quizListPage() {

        return "contents/quizList";
    }
    @GetMapping(value = "quizResult")
    public String quizResultPage() {

        return "contents/quizResult";
    }
}
