package kopo.poly.hanium.config;


import kopo.poly.hanium.interceptor.AuthInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AuthInterceptor())
                .addPathPatterns("/contents/**", "/user/mypage", "/user/withdraw") // 로그인 필요 경로
                .excludePathPatterns("/user/login", "/user/loginProc", "/user/register", "/user/findId", "/user/findPw"); // 로그인 제외
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 정적 리소스(css, js 등) 무시 처리 (필요 시)
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/static/");
    }
}
