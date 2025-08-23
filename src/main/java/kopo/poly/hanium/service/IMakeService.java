package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.AiGeneratedStoriesDTO;
import kopo.poly.hanium.dto.AiGeneratedStoryPagesDTO;

public interface IMakeService {

  int insertAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception;

  AiGeneratedStoriesDTO getAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception;

  int insertAiGeneratedStoryPages(AiGeneratedStoryPagesDTO pDTO) throws Exception;

  AiGeneratedStoryPagesDTO getAiGeneratedStoryPages (AiGeneratedStoryPagesDTO pDTO) throws Exception;
}
