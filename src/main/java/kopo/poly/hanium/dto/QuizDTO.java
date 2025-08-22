package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class QuizDTO {
    private int quizId;
    private String title;
    private String description;
    private String createdAt;

    private Integer score; // 사용자 점수
    private Integer total; // 전체 문제 수
    private LocalDateTime takenAt; // 저장한 날짜
}
