package kopo.poly.hanium.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class FairytaleDTO {
  private String mainName;
  private List<String> words;
  private String gptResult;
}
