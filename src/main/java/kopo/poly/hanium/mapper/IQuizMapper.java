package kopo.poly.hanium.mapper;

import kopo.poly.hanium.dto.QuizDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IQuizMapper {

    // 퀴즈 리스트
    List<QuizDTO> getQuizList() throws Exception;
}
