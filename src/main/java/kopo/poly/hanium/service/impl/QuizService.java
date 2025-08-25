package kopo.poly.hanium.service.impl;

import kopo.poly.hanium.dto.QuizzesDTO;
import kopo.poly.hanium.dto.QuizQuestionsDTO;
import kopo.poly.hanium.dto.QuizResultsDTO;
import kopo.poly.hanium.dto.SignWordsDTO;
import kopo.poly.hanium.mapper.IQuizMapper;
import kopo.poly.hanium.service.IQuizService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class QuizService implements IQuizService {

    private final IQuizMapper quizMapper;

    // 퀴즈 문제 불러오기
    public List<SignWordsDTO> getQuizInfo(QuizQuestionsDTO pDTO) throws Exception {
        log.info("{}.getQuizInfo start!", this.getClass().getName());

        return quizMapper.getQuizInfo(pDTO);
    }

    @Override
    public int saveQuizResult(QuizResultsDTO pDTO) throws Exception {

        log.info("{}.saveQuizResult start!", this.getClass().getName());

        int res = quizMapper.saveQuizResult(pDTO);

        log.info("{}.saveQuizResult start!", this.getClass().getName());

        return res;
    }

    @Override
    public QuizResultsDTO getQuizResultByUserAndQuiz(QuizzesDTO pDTO) throws Exception {
        log.info("{}.getQuizResultByUserAndQuiz start!", this.getClass().getName());

        return quizMapper.selectQuizResultByUserAndQuiz(pDTO);
    }

    @Override
    public QuizResultsDTO getQuizResultByUserAndQuiz(String userId, int quizId) throws Exception {
        log.info("{}.getQuizResultByUserAndQuiz start!", this.getClass().getName());

        return quizMapper.selectQuizResultByUserAndQuiz(userId, quizId);
    }

    // 퀴즈 리스트 불러오기
    @Override
    public List<QuizzesDTO> getQuizList() throws Exception {

        log.info("{}.getQuizList start!", this.getClass().getName());

        return quizMapper.getQuizList();
    }
}
