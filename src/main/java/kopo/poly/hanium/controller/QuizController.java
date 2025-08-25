package kopo.poly.hanium.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kopo.poly.hanium.dto.QuizQuestionsDTO;
import kopo.poly.hanium.dto.QuizResultsDTO;
import kopo.poly.hanium.dto.QuizzesDTO;
import kopo.poly.hanium.dto.SignWordsDTO;
import kopo.poly.hanium.service.IQuizService;
import kopo.poly.hanium.util.CmmUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Slf4j
@RequestMapping(value = "/quiz")
@RequiredArgsConstructor
@Controller
public class QuizController {

    private final IQuizService quizService;
    
    @GetMapping(value = "quiz")
    public String quizPage() {

        return "quiz/quiz";
    }

    // 퀴즈 결과 페이지
    @PostMapping(value = "quizResult")
    public String quizResult() {

        return "quiz/quizResult"; // 결과 JSP
    }

    @ResponseBody
    @PostMapping(value = "quizResultData")
    public Map<String, Object> quizResultData(HttpServletRequest request, HttpSession session) throws Exception {

        log.info("{}.quizResultData start!", this.getClass().getName());

        int quizId = Integer.parseInt(request.getParameter("quizId"));
        String[] words = request.getParameterValues("words");
        String[] results = request.getParameterValues("results");

        int correctCount = 0;
        int totalCount = words.length;

        for (String result : results) {
            if ("true".equals(result)) {
                correctCount++;
            }
        }

        String userId = (String) session.getAttribute("SS_USER_ID");

        QuizResultsDTO pDTO = new QuizResultsDTO();
        pDTO.setUserId(userId);
        pDTO.setQuizId(quizId);
        pDTO.setScore(correctCount);
        pDTO.setTotal(totalCount);

        quizService.saveQuizResult(pDTO);

        List<Map<String, Object>> resultList = new ArrayList<>();
        for (int i = 0; i < totalCount; i++) {
            Map<String, Object> item = new HashMap<>();
            item.put("word", words[i]);
            item.put("correct", "true".equals(results[i]));
            resultList.add(item);
        }

        int percentScore = (int) (((double) correctCount / totalCount) * 100);

        Map<String, Object> res = new HashMap<>();
        res.put("quizId", quizId);
        res.put("score", correctCount);
        res.put("total", totalCount);
        res.put("percentScore", percentScore);
        res.put("results", resultList);

        log.info("{}.quizResultData end!", this.getClass().getName());

        return res;
    }

    // 퀴즈 리스트 불러오기
    @GetMapping(value = "quizList")
    public String quizList() {

        return "quiz/quizList";
    }

    @GetMapping(value = "quizListLoad")
    @ResponseBody
    public List<QuizzesDTO> quizListLoad(HttpSession session) throws Exception {

        log.info("{}.quizListLoad start!", this.getClass().getName());

        String userId = (String) session.getAttribute("SS_USER_ID");

        log.info("userId : {}", userId);

        List<QuizzesDTO> rList = Optional.ofNullable(quizService.getQuizList()).orElseGet(ArrayList::new);

        for (QuizzesDTO quiz : rList) {
            quiz.setUserId(userId);
            QuizResultsDTO qResult = quizService.getQuizResultByUserAndQuiz(quiz);
            if (qResult != null) {
                quiz.setScore(qResult.getScore());
                quiz.setTotal(qResult.getTotal());
            }
        }

        log.info("{}.quizListLoad end!", this.getClass().getName());

        return rList; // JSON 형태로 자동 변환됨
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
        pDTO.setQuizId(Integer.parseInt(nSeq));

        // word 리스트 가져오기
        List<SignWordsDTO> rList = Optional.ofNullable(quizService.getQuizInfo(pDTO))
                .orElseGet(ArrayList::new);

        // View 로 데이터 전달
        model.addAttribute("rList", rList);

        log.info("{}.quizInfo End!", this.getClass().getName());

        return "quiz/quiz";
    }
}
