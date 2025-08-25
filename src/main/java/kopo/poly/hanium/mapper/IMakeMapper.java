package kopo.poly.hanium.mapper;

import kopo.poly.hanium.dto.AiGeneratedStoriesDTO;
import kopo.poly.hanium.dto.AiGeneratedStoryPagesDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IMakeMapper {

  int insertAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception;

  int insertAiGeneratedStoryPages(AiGeneratedStoryPagesDTO pDTO) throws Exception;

  AiGeneratedStoryPagesDTO getAiGeneratedStoryPages (AiGeneratedStoryPagesDTO pDTO) throws Exception;

  int deleteAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception;

  int updateAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception;

  List<AiGeneratedStoriesDTO> getAiGeneratedStoriesList(AiGeneratedStoriesDTO pDTO) throws Exception;

}
