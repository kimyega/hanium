package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.QuizDTO;
import kopo.poly.hanium.dto.QuizQuestionsDTO;
import kopo.poly.hanium.dto.SignWordsDTO;

import java.util.List;

public interface IQuizService {

    // 퀴즈 리스트 불러오기
    List<QuizDTO> getQuizList() throws Exception;

    // 퀴즈 문제 불러오기
    List<SignWordsDTO> getQuizInfo(QuizQuestionsDTO pDTO) throws Exception;

}
