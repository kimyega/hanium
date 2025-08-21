package kopo.poly.hanium.service.impl;

import kopo.poly.hanium.dto.QuizDTO;
import kopo.poly.hanium.dto.QuizQuestionsDTO;
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

    // 퀴즈 리스트 불러오기
    @Override
    public List<QuizDTO> getQuizList() throws Exception {

        log.info("{}.getQuizList start!", this.getClass().getName());

        return quizMapper.getQuizList();
    }
}
