package kopo.poly.hanium.mapper;

import kopo.poly.hanium.dto.AiGeneratedStoriesDTO;
import kopo.poly.hanium.dto.AiGeneratedStoryPagesDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMakeMapper {

  int insertAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception;

  AiGeneratedStoriesDTO getAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception;

  int insertAiGeneratedStoryPages(AiGeneratedStoryPagesDTO pDTO) throws Exception;

  AiGeneratedStoryPagesDTO getAiGeneratedStoryPages (AiGeneratedStoryPagesDTO pDTO) throws Exception;

}
