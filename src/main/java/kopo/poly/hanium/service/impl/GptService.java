package kopo.poly.hanium.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class GptService {

  @Value("${openai.api.key}")
  private String apiKey;

  private final String API_URL = "https://api.openai.com/v1/chat/completions";

  /**
   * GPT-4o 모델을 사용하여 텍스트 생성
   * @param prompt 사용자 입력/프롬프트
   * @return 생성된 텍스트
   */
  public String generateText(String prompt) {
    try {
      RestTemplate restTemplate = new RestTemplate();

      HttpHeaders headers = new HttpHeaders();
      headers.setContentType(MediaType.APPLICATION_JSON);
      headers.setBearerAuth(apiKey);

      Map<String, Object> body = new HashMap<>();
      body.put("model", "gpt-4o"); // GPT-4o 사용
      body.put("messages", new Object[]{
              Map.of("role", "user", "content", prompt)
      });
      body.put("temperature", 0.7);       // 온도 조절 가능
      body.put("max_tokens", 800);        // 토큰 수 제한

      // 요청 로그
      log.info("GPT 요청 Body: {}", new ObjectMapper().writeValueAsString(body));

      HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
      ResponseEntity<String> response = restTemplate.postForEntity(API_URL, request, String.class);

      // 응답 로그
      log.info("GPT 응답 Body: {}", response.getBody());

      ObjectMapper mapper = new ObjectMapper();
      JsonNode root = mapper.readTree(response.getBody());
      JsonNode contentNode = root.path("choices").get(0).path("message").path("content");

      if (contentNode.isMissingNode() || contentNode.asText().isBlank()) {
        return "GPT가 텍스트를 생성하지 못했습니다.";
      }

      return contentNode.asText();

    } catch (Exception e) {
      e.printStackTrace();
      return "GPT 호출 실패!";
    }
  }
}
