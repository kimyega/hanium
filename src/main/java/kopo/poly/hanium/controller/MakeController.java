package kopo.poly.hanium.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kopo.poly.hanium.dto.AiGeneratedStoriesDTO;
import kopo.poly.hanium.dto.AiGeneratedStoryPagesDTO;
import kopo.poly.hanium.service.IMakeService;
import kopo.poly.hanium.service.impl.GptService;
import kopo.poly.hanium.util.CmmUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Slf4j
@RequestMapping(value = "/make")
@RequiredArgsConstructor
@Controller
public class MakeController {

  private final GptService gptService;
  private final IMakeService makeService;

  @GetMapping(value = "makeFairytale")
  public String makePage() {

    return "make/makeFairytale";
  }

  @GetMapping(value = "makeFairytaleResult")
  public String makeFairytaleResult() {

    return "make/makeFairytaleResult";
  }

  @GetMapping("makeFairytaleResultByPage")
  @ResponseBody
  public AiGeneratedStoryPagesDTO getFairytaleResult(HttpServletRequest request, HttpSession session) throws Exception {

    log.info("{}.getFairytaleResult Start!!", this.getClass().getSimpleName());

    Long aiStoryId = Optional.ofNullable(session.getAttribute("LAST_STORY_ID"))
            .map(id -> (Long) id)
            .orElse(0L);
    String pageNumber = CmmUtil.nvl(request.getParameter("pageNumber"));

    AiGeneratedStoryPagesDTO pDTO = new AiGeneratedStoryPagesDTO();
    pDTO.setAiStoryId(aiStoryId);
    pDTO.setPageNumber(pageNumber);

    log.info("aiStoryId: {}", aiStoryId);
    log.info("pageNumber: {}", pageNumber);

    // 페이지별 내용 조회
    AiGeneratedStoryPagesDTO rDTO = makeService.getAiGeneratedStoryPages(pDTO);

    log.info("페이지 별 내용: {}", rDTO.getContentText());

    log.info("{}.getFairytaleResult End!!", this.getClass().getSimpleName());

    return rDTO;
  }


  @PostMapping("makeFairytaleRequest")
  @ResponseBody
  public String makeFairytaleRequest(HttpServletRequest request, HttpSession session) throws Exception {

    log.info("{}.makeFairytaleRequest Start!!", this.getClass().getSimpleName());

    String userId = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

    log.info("세션 userId: {}", userId);

    // mainName 안전 처리
    String mainName = CmmUtil.nvl(request.getParameter("mainName"));

    // words 안전 처리 (null이면 빈 리스트)
    String[] wordsArray = request.getParameterValues("words");
    List<String> words = Optional.ofNullable(wordsArray)
            .map(Arrays::asList)
            .orElseGet(ArrayList::new);

    log.info("받은 DTO mainName: {} / words: {}", mainName, words);

    // GPT 프롬프트 생성

    String prompt = "다음 단어들을 사용해서 \"" + mainName + "\"를 주인공으로 하는 짧은 동화를 만들어줘.\n" +
            "총 5 ~ 7 페이지로 나누어 작성하고, 각 페이지는 3~5문장 정도로 해줘.\n" +
            "출력은 JSON 형식으로, 페이지 번호, 내용, 이미지 설명을 포함하도록 해줘.\n" +
            "출력은 절대 ```json 같은 코드 블록 없이 순수 JSON으로만 반환해줘.\n" +
            "예시 JSON 형식:\n" +
            "[\n" +
            "    {\"pageNumber\": 1, \"contentText\": \"첫 번째 페이지 내용...\", \"contentImage\": \"이미지 설명\"},\n" +
            "    {\"pageNumber\": 2, \"contentText\": \"두 번째 페이지 내용...\", \"contentImage\": \"이미지 설명\"},\n" +
            "    ...\n" +
            "]\n" +
            "사용할 단어: " + String.join(", ", words);

    log.info("GPT 프롬프트: {}", prompt);

    // GPT API 호출
    String gptResult = gptService.generateText(prompt);
    log.info("GPT 응답 결과 : {}", gptResult);

    AiGeneratedStoriesDTO pDTO = new AiGeneratedStoriesDTO();
    pDTO.setUserId(userId);
    pDTO.setCharacterName(mainName);
    pDTO.setStoryText(gptResult);
    pDTO.setImageUrl("");

    int res = makeService.insertAiGeneratedStories(pDTO);
    Long aiStoryId = pDTO.getAiStoryId();

    log.info("저장 결과 : {}", res);
    log.info("aiStoryId : {}", aiStoryId);

    if (res > 0) {
      session.setAttribute("AI_STORY_RES", res);
      session.setAttribute("LAST_STORY_ID", aiStoryId);
    }

    // JSON 파싱
    ObjectMapper mapper = new ObjectMapper();
    List<AiGeneratedStoryPagesDTO> aiStoryPagesList = mapper.readValue(
            gptResult,
            new TypeReference<>() {}
    );

    int totalPages = aiStoryPagesList.size();
    session.setAttribute("STORY_TOTAL_PAGES", totalPages);

    for (AiGeneratedStoryPagesDTO page : aiStoryPagesList) {
      page.setAiStoryId(aiStoryId); // 전체 스토리 ID 연결
      makeService.insertAiGeneratedStoryPages(page); // 서비스 → Mapper → DB insert
    }


    log.info("{}.makeFairytaleRequest End!!", this.getClass().getSimpleName());

    return "/make/makeFairytaleResult";
  }
}
