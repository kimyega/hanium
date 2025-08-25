package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AiGeneratedStoriesDTO {
  private Long aiStoryId;
  private String userId;
  private String title;
  private String characterName;
  private String storyText;
  private String imageUrl;
}
