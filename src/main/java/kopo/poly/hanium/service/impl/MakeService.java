package kopo.poly.hanium.service.impl;

import kopo.poly.hanium.dto.AiGeneratedStoriesDTO;
import kopo.poly.hanium.dto.AiGeneratedStoryPagesDTO;
import kopo.poly.hanium.mapper.IMakeMapper;
import kopo.poly.hanium.service.IMakeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class MakeService implements IMakeService {

  private final IMakeMapper makeMapper;

  @Override
  public int insertAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception {

    log.info("{}.insertAiGeneratedStories Start!", this.getClass().getName());

    int res = 0;

    int success = makeMapper.insertAiGeneratedStories(pDTO);

    if (success > 0) {
      res = 1;

    }

    log.info("{}.insertAiGeneratedStories End!", this.getClass().getName());

    return res;
  }

  @Override
  public AiGeneratedStoriesDTO getAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception {

    log.info("{}.getAiGeneratedStories Start!", this.getClass().getName());

    AiGeneratedStoriesDTO rDTO = makeMapper.getAiGeneratedStories(pDTO);

    log.info("{}.getAiGeneratedStories End!", this.getClass().getName());

    return rDTO;
  }

  @Override
  public int insertAiGeneratedStoryPages(AiGeneratedStoryPagesDTO pDTO) throws Exception {

    log.info("{}.insertAiGeneratedStoryPages Start!", this.getClass().getName());

    int res = 0;

    int success = makeMapper.insertAiGeneratedStoryPages(pDTO);

    if (success > 0) {
      res = 1;

    }

    log.info("{}.insertAiGeneratedStoryPages End!", this.getClass().getName());

    return res;
  }

  @Override
  public AiGeneratedStoryPagesDTO getAiGeneratedStoryPages(AiGeneratedStoryPagesDTO pDTO) throws Exception {

    log.info("{}.getAiGeneratedStoryPages Start!", this.getClass().getName());

    AiGeneratedStoryPagesDTO rDTO = makeMapper.getAiGeneratedStoryPages(pDTO);

    log.info("{}.getAiGeneratedStoryPages End!", this.getClass().getName());

    return rDTO;
  }
}
