package kopo.poly.hanium.service.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class GptImageService {

  @Value("${openai.api.key}")
  private String apiKey;

  private final String API_URL = "https://api.openai.com/v1/images/generations";

  /**
   * OpenAI gpt-image-1 모델을 사용하여 이미지 생성
   * @param prompt 이미지 설명 프롬프트
   * @param size 이미지 크기 (예: "256x256", "512x512", "1024x1024")
   * @return 생성된 이미지 URL
   */
  public byte[] generateImage(String prompt, String size) {

    log.info("{}.generateImage Start!!", this.getClass().getSimpleName());

    try {
      RestTemplate restTemplate = new RestTemplate();

      HttpHeaders headers = new HttpHeaders();
      headers.setContentType(MediaType.APPLICATION_JSON);
      headers.setBearerAuth(apiKey);

      Map<String, Object> body = new HashMap<>();
      body.put("model", "gpt-image-1");
      body.put("prompt", prompt);
      body.put("size", size != null ? size : "1024x1024");
      body.put("n", 1); // 1장 생성

      HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
      ResponseEntity<String> response = restTemplate.postForEntity(API_URL, request, String.class);

      ObjectMapper mapper = new ObjectMapper();
      JsonNode root = mapper.readTree(response.getBody());

      // b64_json로 이미지 데이터 가져오기
      JsonNode b64Node = root.path("data").get(0).path("b64_json");

      if (b64Node.isMissingNode() || b64Node.asText().isBlank()) {
        throw new RuntimeException("이미지 데이터를 가져오지 못했습니다.");
      }

      log.info("{}.generateImage End!!", this.getClass().getSimpleName());

      // Base64 → byte[]
      return java.util.Base64.getDecoder().decode(b64Node.asText());

    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }
}
