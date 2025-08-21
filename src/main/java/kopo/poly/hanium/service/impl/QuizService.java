package kopo.poly.hanium.service.impl;

import kopo.poly.hanium.dto.QuizDTO;
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

    @Override
    public List<QuizDTO> getQuizList() throws Exception {

        log.info("{}.getQuizList start!", this.getClass().getName());

        return quizMapper.getQuizList();
    }
}
