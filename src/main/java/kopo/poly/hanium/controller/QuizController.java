package kopo.poly.hanium.controller;

import kopo.poly.hanium.dto.QuizDTO;
import kopo.poly.hanium.service.IQuizService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@RequestMapping(value = "/quiz")
@RequiredArgsConstructor
@Controller
public class QuizController {

    private final IQuizService quizService;
    
    @GetMapping(value = "quiz")
    public String quiz1Page() {

        return "quiz/quiz";
    }
    @GetMapping(value = "quizResult")
    public String quizResultPage() {

        return "quiz/quizResult";
    }

    // 퀴즈 리스트 불러오기
    @GetMapping(value = "quizList")
    public String quizList(ModelMap model)
            throws Exception {

        log.info("{}.QuizList start!", this.getClass().getName());

        List<QuizDTO> rList = Optional.ofNullable(quizService.getQuizList()).orElseGet(ArrayList::new);

        model.addAttribute("rList", rList);

        log.info("{}.QuizList end!", this.getClass().getName());

        return "quiz/quizList";
    }
}
