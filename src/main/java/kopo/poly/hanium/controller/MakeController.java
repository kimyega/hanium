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

  @GetMapping("makeFairytaleList")
  public String makeFairytaleList() {
    return "make/makeFairytaleList";
  }

  @PostMapping("/setAiStoryId")
  @ResponseBody
  public int setAiStoryId(HttpServletRequest request, HttpSession session) throws Exception {

    log.info("{}.setAiStoryId Start!!", this.getClass().getSimpleName());

    String aiStoryIdStr = request.getParameter("aiStoryId");

    if (aiStoryIdStr != null && !aiStoryIdStr.isEmpty()) {

      Long aiStoryId = Long.parseLong(aiStoryIdStr);
      session.setAttribute("AI_STORY_ID", aiStoryId);

      return 1;
    }

    log.info("{}.setAiStoryId End!!", this.getClass().getSimpleName());

    return 0;
  }

  @GetMapping("makeFairytaleResultByPage")
  @ResponseBody
  public AiGeneratedStoryPagesDTO getFairytaleResult(HttpServletRequest request, HttpSession session) throws Exception {

    log.info("{}.getFairytaleResult Start!!", this.getClass().getSimpleName());

    Long aiStoryId = Optional.ofNullable(session.getAttribute("AI_STORY_ID"))
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
      session.setAttribute("AI_STORY_ID", aiStoryId);
    }

    // JSON 파싱
    ObjectMapper mapper = new ObjectMapper();
    List<AiGeneratedStoryPagesDTO> aiStoryPagesList = mapper.readValue(
            gptResult,
            new TypeReference<>() {
            }
    );

    int totalPages = aiStoryPagesList.size();
    session.setAttribute("STORY_TOTAL_PAGES", totalPages);

    for (AiGeneratedStoryPagesDTO page : aiStoryPagesList) {
      page.setAiStoryId(aiStoryId); // 전체 스토리 ID 연결
      int pageRes = makeService.insertAiGeneratedStoryPages(page); // 서비스 → Mapper → DB insert
    }

    log.info("{}.makeFairytaleRequest End!!", this.getClass().getSimpleName());

    return "/make/makeFairytaleResult";
  }

  @GetMapping("deleteAiGeneratedStories")
  @ResponseBody
  public int deleteAiGeneratedStories(HttpSession session) {

    log.info("{}.deleteAiGeneratedStories Start!!", this.getClass().getSimpleName());

    // 세션에서 삭제할 동화 ID 가져오기 (세션에 ai_story_id 저장해놨다고 가정)
    Long aiStoryId = (Long) session.getAttribute("AI_STORY_ID");

    if (aiStoryId == null) {
      log.warn("세션에 AI_STORY_ID 없음");
      return 0; // 실패
    }

    AiGeneratedStoriesDTO pDTO = new AiGeneratedStoriesDTO();
    pDTO.setAiStoryId(aiStoryId);

    int res = 0;
    try {
      // Service 호출해서 DB 삭제
      res = makeService.deleteAiGeneratedStories(pDTO);

      // 세션에서 값 제거
      session.removeAttribute("AI_STORY_ID");

    } catch (Exception e) {
      log.error("AI 동화 삭제 실패", e);
      res = 0;
    }

    log.info("결과 : {}", res);

    log.info("{}.deleteAiGeneratedStories End!!", this.getClass().getSimpleName());

    return res; // 1=성공, 0=실패
  }

  @GetMapping("getAiGeneratedStoriesList")
  @ResponseBody
  public List<AiGeneratedStoriesDTO> getAiGeneratedStoriesList(HttpSession session) throws Exception {

    log.info("{}.getAiGeneratedStoriesList Start!!", this.getClass().getSimpleName());

    String userId = (String) session.getAttribute("SS_USER_ID"); // 로그인 유저 기준 조회

    AiGeneratedStoriesDTO pDTO = new AiGeneratedStoriesDTO();
    pDTO.setUserId(userId);

    List<AiGeneratedStoriesDTO> rList = makeService.getAiGeneratedStoriesList(pDTO);

    if (rList.isEmpty()) {
      log.info("조회 결과 없음");
    } else {
      log.info("조회된 개수: {}", rList.size());
    }

    log.info("{}.getAiGeneratedStoriesList End!!", this.getClass().getSimpleName());

    return rList; // JSON 자동 변환
  }

  @PostMapping("updateFairyTaleTitle")
  @ResponseBody
  public int updateFairyTaleTitle(HttpServletRequest request, HttpSession session) {

    log.info("{}.saveFairyTaleTitle Start!!", this.getClass().getSimpleName());

    String title = request.getParameter("title");
    Long aiStoryId = (Long) session.getAttribute("AI_STORY_ID");

    if (aiStoryId == null || title == null || title.trim().isEmpty()) {
      log.warn("저장 실패: aiStoryId 또는 title 없음");
      return 0; // 실패
    }

    AiGeneratedStoriesDTO pDTO = new AiGeneratedStoriesDTO();
    pDTO.setAiStoryId(aiStoryId);
    pDTO.setTitle(title);

    int res = 0;
    try {
      res = makeService.updateAiGeneratedStories(pDTO);
      log.info("저장 결과: {}", res);
    } catch (Exception e) {
      log.error("동화 제목 저장 실패", e);
      res = 0;
    }

    log.info("{}.updateFairyTaleTitle End!!", this.getClass().getSimpleName());

    return res; // 1=성공, 0=실패
  }

}
