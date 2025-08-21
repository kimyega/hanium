package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuizResultsDTO {
    private int result_Id;
    private String userId;
    private int quizId;
    private int score;
    private int total;
    private int takenAt;
}
