package kopo.poly.hanium.mapper;

import kopo.poly.hanium.dto.StoryDTO;
import kopo.poly.hanium.dto.StoryPageDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IStoryMapper {

    List<StoryDTO> getAllStories() throws Exception;

    List<StoryPageDTO> getPagesByStoryId(int storyId) throws Exception;

    StoryDTO getStoryById(int storyId) throws Exception;

    // ✅ 추가
    StoryDTO getStoryByTitle(String title) throws Exception;
    StoryDTO selectStoryInfo(int storyId) throws Exception;

}
