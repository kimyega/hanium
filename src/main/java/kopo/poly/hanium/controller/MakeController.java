package kopo.poly.hanium.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kopo.poly.hanium.dto.FairytaleDTO;
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

  @GetMapping(value = "makeFairytale")
  public String makePage() {

    return "make/makeFairytale";
  }

  @GetMapping(value = "makeFairytaleResult")
  public String makeFairytaleResult() {

    return "make/makeFairytaleResult";
  }

  @GetMapping("makeFairytaleResultData")
  @ResponseBody
  public Map<String, String> getFairytaleResult(HttpSession session) {

    log.info("{}.getFairytaleResult Start!!", this.getClass().getSimpleName());

    FairytaleDTO pDTO = (FairytaleDTO) session.getAttribute("fairytaleDTO");

    log.info("FairytaleDTO GPT 결과 : {}", pDTO.getGptResult());

    Map<String, String> result = new HashMap<>();

    if (pDTO != null) {
      result.put("gptResult", pDTO.getGptResult());
    } else {
      result.put("gptResult", "결과가 없습니다.");
    }

    log.info("{}.getFairytaleResult End!!", this.getClass().getSimpleName());

    return result; // 자동으로 JSON 형태로 변환됨
  }

  @PostMapping("makeFairytaleRequest")
  @ResponseBody
  public String makeFairytaleRequest(HttpServletRequest request, HttpSession session) {

    log.info("{}.makeFairytaleRequest Start!!", this.getClass().getSimpleName());

    // mainName 안전 처리
    String mainName = CmmUtil.nvl(request.getParameter("mainName"));

    // words 안전 처리 (null이면 빈 리스트)
    String[] wordsArray = request.getParameterValues("words");
    List<String> words = Optional.ofNullable(wordsArray)
            .map(Arrays::asList)
            .orElseGet(ArrayList::new);

    log.info("받은 DTO mainName: {} / words: {}", mainName, words);

    // GPT 프롬프트 생성
    String prompt = "다음 단어들을 사용해서 " + mainName +
            "을 주인공으로 하는 짧은 동화를 만들어줘: " +
            String.join(", ", words);
    log.info("GPT 프롬프트: {}", prompt);

    // GPT API 호출
    String gptResult = gptService.generateText(prompt);
    log.info("GPT 응답 결과 : {}", gptResult);

    // DTO에 담기
    FairytaleDTO dto = new FairytaleDTO();
    dto.setMainName(mainName);
    dto.setWords(words);
    dto.setGptResult(gptResult);

    // 세션에 DTO 저장
    session.setAttribute("fairytaleDTO", dto);
    log.info("DTO 세션 저장 완료: {}", dto.getGptResult());

    log.info("{}.makeFairytaleRequest End!!", this.getClass().getSimpleName());

    return "/make/makeFairytaleResult";
  }
}
