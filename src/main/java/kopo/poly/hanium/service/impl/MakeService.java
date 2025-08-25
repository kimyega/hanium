package kopo.poly.hanium.service.impl;

import kopo.poly.hanium.dto.AiGeneratedStoriesDTO;
import kopo.poly.hanium.dto.AiGeneratedStoryPagesDTO;
import kopo.poly.hanium.mapper.IMakeMapper;
import kopo.poly.hanium.service.IMakeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

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
  public List<AiGeneratedStoriesDTO> getAiGeneratedStoriesList(AiGeneratedStoriesDTO pDTO) throws Exception {

    log.info("{}.getAiGeneratedStories Start!", this.getClass().getName());

    List<AiGeneratedStoriesDTO> rDTO = makeMapper.getAiGeneratedStoriesList(pDTO);

    if (rDTO.isEmpty()) {
      log.info("조회 결과 없음");
    } else {
      log.info("조회된 개수: {}", rDTO.size());
    }

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

  @Override
  public int deleteAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception {

    log.info("{}.deleteAiGeneratedStories Start!", this.getClass().getName());

    int res = makeMapper.deleteAiGeneratedStories(pDTO);

    log.info("{}.deleteAiGeneratedStories End!", this.getClass().getName());

    return res;
  }

  @Override
  public int updateAiGeneratedStories(AiGeneratedStoriesDTO pDTO) throws Exception {

    log.info("{}.updateAiGeneratedStories Start!", this.getClass().getName());

    int res = makeMapper.updateAiGeneratedStories(pDTO);

    log.info("{}.updateAiGeneratedStories End!", this.getClass().getName());

    return res;
  }
}
