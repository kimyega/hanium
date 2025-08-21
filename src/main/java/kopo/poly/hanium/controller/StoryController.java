package kopo.poly.hanium.controller;

import kopo.poly.hanium.dto.StoryDTO;
import kopo.poly.hanium.dto.StoryPageDTO;
import kopo.poly.hanium.service.IStoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;   // ✅ 반드시 추가
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Controller
public class StoryController {

    private final IStoryService storyService; // ✅ 필드 추가

    // 동화 목록
    @GetMapping("/fairytale/list")
    public String fairytaleList(Model model) throws Exception {
        // "아기돼지 삼형제" 데이터만 DB에서 가져오기
        StoryDTO pigStory = storyService.getStoryByTitle("아기돼지 삼형제");

        model.addAttribute("pigStory", pigStory);
        return "fairytale/fairytaleList";  // JSP 파일 경로
    }

    // 동화 읽기
    @GetMapping("/fairytale/read")
    public String readFairytale(@RequestParam("storyId") int storyId,
                                Model model) throws Exception {

        // ✅ 동화 기본 정보
        StoryDTO story = storyService.getStoryById(storyId);

        // ✅ 해당 동화 페이지들
        List<StoryPageDTO> storyPages = storyService.getPagesByStoryId(storyId);

        model.addAttribute("story", story);
        model.addAttribute("storyPages", storyPages);

        return "fairytale/readFairytale"; // ✅ JSP 이름
    }
}
