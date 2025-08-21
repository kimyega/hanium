package kopo.poly.hanium.controller;

import jakarta.servlet.http.HttpServletRequest;
import kopo.poly.hanium.dto.QuizDTO;
import kopo.poly.hanium.dto.QuizQuestionsDTO;
import kopo.poly.hanium.dto.SignWordsDTO;
import kopo.poly.hanium.service.IQuizService;
import kopo.poly.hanium.util.CmmUtil;
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

    // 퀴즈 풀기 페이지
    @GetMapping(value = "quizInfo")
    public String quizInfo(HttpServletRequest request, ModelMap model) throws Exception {

        log.info("{}.quizInfo start!", this.getClass().getName());

        // 쿼리 파라미터에서 quiz_id 받아오기
        String nSeq = CmmUtil.nvl(request.getParameter("nSeq"));
        log.info("nSeq : {}", nSeq);

        // 입력 DTO (조건)
        QuizQuestionsDTO pDTO = new QuizQuestionsDTO();
        pDTO.setQuizId(nSeq);

        // word 리스트 가져오기
        List<SignWordsDTO> rList = Optional.ofNullable(quizService.getQuizInfo(pDTO))
                .orElseGet(ArrayList::new);

        // View 로 데이터 전달
        model.addAttribute("rList", rList);

        log.info("{}.quizInfo End!", this.getClass().getName());

        return "quiz/quiz";
    }
}
