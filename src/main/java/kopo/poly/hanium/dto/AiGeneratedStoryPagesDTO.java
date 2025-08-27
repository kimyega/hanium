package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AiGeneratedStoryPagesDTO {
  private Long aiStoryId;
  private String pageNumber;
  private String contentText;
  private String contentImage;
  private String aiImageData;
}
