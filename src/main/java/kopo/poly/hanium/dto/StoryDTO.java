package kopo.poly.hanium.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class StoryDTO {
    private int storyId;          // story_id
    private String title;         // title
    private String summary;       // summary
    private String coverImage;    // cover_image
    private LocalDateTime createdAt; // created_at
}
