package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuizDTO {
    private int quizId;
    private String title;
    private String description;
    private String createdAt;
}
