package kopo.poly.hanium.mapper;

import kopo.poly.hanium.dto.QuizDTO;
import kopo.poly.hanium.dto.QuizQuestionsDTO;
import kopo.poly.hanium.dto.QuizResultsDTO;
import kopo.poly.hanium.dto.SignWordsDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IQuizMapper {

    // 퀴즈 리스트
    List<QuizDTO> getQuizList() throws Exception;

    // 퀴즈 문제 불러오기
    List<SignWordsDTO> getQuizInfo(QuizQuestionsDTO pDTO) throws Exception;

    // 퀴즈 결과 저장
    void saveQuizResult(QuizResultsDTO pDTO) throws Exception;

    // 퀴즈 점수 불러오기
    QuizResultsDTO selectQuizResultByUserAndQuiz(String userId, int quizId) throws Exception;
}
