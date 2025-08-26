package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class QuizResultsDTO {
    private int result_Id;
    private String userId;
    private int quizId;
    private int score;
    private int total;
    private LocalDateTime takenAt;

    private String description;
}
