package kopo.poly.hanium.dto;

import lombok.Data;

@Data

public class StoryPageDTO {
    private int pageId;        // page_id
    private int storyId;       // story_id
    private int pageNumber;    // page_number
    private String contentText; // content_text
    private String contentImage; // content_image (nullable)
}
