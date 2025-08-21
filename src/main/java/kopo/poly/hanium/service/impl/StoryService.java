package kopo.poly.hanium.service.impl;

import kopo.poly.hanium.dto.StoryDTO;
import kopo.poly.hanium.dto.StoryPageDTO;
import kopo.poly.hanium.mapper.StoryMapper;
import kopo.poly.hanium.service.IStoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StoryService implements IStoryService {

    private final StoryMapper storyMapper;

    @Override
    public List<StoryDTO> getAllStories() throws Exception {
        return storyMapper.getAllStories();
    }

    @Override
    public List<StoryPageDTO> getPagesByStoryId(int storyId) throws Exception {
        return storyMapper.getPagesByStoryId(storyId);
    }

    @Override
    public StoryDTO getStoryById(int storyId) throws Exception {
        return storyMapper.getStoryById(storyId);
    }

    @Override
    public StoryDTO getStoryByTitle(String title) throws Exception {
        return storyMapper.getStoryByTitle(title);
    }

    @Override
    public StoryDTO getStoryInfo(int storyId) throws Exception {
        return storyMapper.selectStoryInfo(storyId);
    }

    @Override
    public List<StoryPageDTO> getStoryPages(int storyId) throws Exception {
        return storyMapper.getPagesByStoryId(storyId);
    }
}
