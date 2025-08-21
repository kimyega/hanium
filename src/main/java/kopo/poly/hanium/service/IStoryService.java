package kopo.poly.hanium.service;

import kopo.poly.hanium.dto.StoryDTO;
import kopo.poly.hanium.dto.StoryPageDTO;

import java.util.List;

public interface IStoryService {

    List<StoryDTO> getAllStories() throws Exception;

    List<StoryPageDTO> getPagesByStoryId(int storyId) throws Exception;

    StoryDTO getStoryById(int storyId) throws Exception;

    StoryDTO getStoryByTitle(String title) throws Exception;

    // ✅ Exception 추가로 일관성 유지
    StoryDTO getStoryInfo(int storyId) throws Exception;

    List<StoryPageDTO> getStoryPages(int storyId) throws Exception;
}
