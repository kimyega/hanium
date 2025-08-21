package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.QuizDTO;

import java.util.List;

public interface IQuizService {

    List<QuizDTO> getQuizList() throws Exception;
}
