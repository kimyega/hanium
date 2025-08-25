package kopo.poly.hanium.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kopo.poly.hanium.dto.QuizzesDTO;
import kopo.poly.hanium.dto.QuizQuestionsDTO;
import kopo.poly.hanium.dto.QuizResultsDTO;
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
    public String quizPage() {

        return "quiz/quiz";
    }

    // 퀴즈 결과 페이지
    @PostMapping(value = "quizResult")
    public String quizResult(HttpServletRequest request, HttpSession session) throws Exception{

        log.info("{}.quizResult start!", this.getClass().getName());

        int quizId = Integer.parseInt(request.getParameter("quizId"));
        String[] words = request.getParameterValues("words");
        String[] results = request.getParameterValues("results");

        int correctCount = 0;
        int totalCount = words.length;

        // 정답 개수 계산
        for (String result : results) {
            if ("true".equals(result)) {
                correctCount++;
            }
        }

        // 사용자 정보
        String userId = (String) session.getAttribute("SS_USER_ID");

        // DB 저장 (quiz_id는 단일 퀴즈에 대해 고정 or 생성 필요)
        QuizResultsDTO pDTO = new QuizResultsDTO();
        pDTO.setUserId(userId);
        pDTO.setQuizId(quizId); // 예시로 1번 퀴즈
        pDTO.setScore(correctCount);
        pDTO.setTotal(totalCount);

        quizService.saveQuizResult(pDTO); // 이 메서드는 아래에서 작성 예정

        // 상세 오답 단어 목록도 전달 (보기용)
        List<String> wrongWords = new ArrayList<>();
        for (int i = 0; i < totalCount; i++) {
            if (!"true".equals(results[i])) {
                wrongWords.add(words[i]);
            }
        }

        request.setAttribute("quizId", quizId);
        request.setAttribute("score", correctCount);
        request.setAttribute("total", totalCount);
        request.setAttribute("wrongWords", wrongWords);
        request.setAttribute("words", words);
        request.setAttribute("results", results);

        log.info("{}.quizResult end!", this.getClass().getName());

        return "quiz/quizResult"; // 결과 JSP
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
