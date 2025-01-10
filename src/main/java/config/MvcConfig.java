package config;

import Interceptor.CommonDataInterceptor;
import Interceptor.SellerInterceptor;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import kr.co.team4.model.service.SellerPageService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import java.util.Properties;
import org.springframework.format.FormatterRegistry;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.internal.resource.S3BucketResource;
import javax.sql.DataSource;
import java.awt.*;
import java.util.Date;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@ComponentScan(basePackages = {"kr.co"})
@EnableWebMvc
@MapperScan(basePackages = {"kr.co.team4.model.mapper"}, annotationClass = Mapper.class)
@EnableTransactionManagement
@ComponentScan(basePackages = {"kr.co", "Interceptor"})
public class MvcConfig implements WebMvcConfigurer {


    // ViewResolver - 포워딩할 경로 앞/뒤 설정
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/views/", ".jsp");
    }

    // MultipartResolver 세팅 - 파일 업로드
    @Bean
    public MultipartResolver multipartResolver(){
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(10 * 1024 * 1024); // 10MB
        resolver.setMaxInMemorySize(4096); // 4KB
        return resolver;
    }

    @Value("${db.driver}")
    private String datasourceDriver;

    @Value("${db.url}")
    private String datasourceUrl;

    @Value("${db.username}")
    private String datasourceUsername;

    @Value("${db.password}")
    private String datasourcePassword;

    @Bean // 트랜잭션매니저 등록
    public DataSourceTransactionManager transactionManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean
    public DataSource dataSource(){

        HikariConfig config = new HikariConfig();
        config.setDriverClassName(datasourceDriver);
        config.setJdbcUrl(datasourceUrl);
        config.setUsername(datasourceUsername);
        config.setPassword(datasourcePassword);
        HikariDataSource dataSource = new HikariDataSource(config);
        return dataSource;
    }

    // MyBatis
    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean ssf = new SqlSessionFactoryBean();
        ssf.setDataSource(dataSource()); // 의존성 주입

        return ssf.getObject();
    }


    @Value("${bucket.region}")
    private String bucketRegion;
    @Value("${bucket.accessKey}")
    private String bucketAccessKey;
    @Value("${bucket.secretKey}")
    private String bucketSecretKey;

    // Aws S3 Client 등록
    @Bean
    public S3Client s3Client(){
        // AWS 자격 증명 객체 생성
        AwsBasicCredentials awsBasicCredentials = AwsBasicCredentials.create(bucketAccessKey, bucketSecretKey);
        // 자격 증명 설정
        StaticCredentialsProvider credentialsProvider = StaticCredentialsProvider.create(awsBasicCredentials);
        // S3 클라이언트 설정
        S3Client s3Client = S3Client.builder().region(Region.of(bucketRegion)).credentialsProvider(credentialsProvider).build();

        return s3Client;
    }


    // properties 설정
    @Bean
    public static PropertyPlaceholderConfigurer propreties() {
        PropertyPlaceholderConfigurer config = new PropertyPlaceholderConfigurer();

        config.setLocations(
                new ClassPathResource("db.properties"),
                new ClassPathResource("bucket.properties"),
                new ClassPathResource("imp.properties"), 
                new ClassPathResource("smtp.properties")
        );

        return config;
    }

    // 정적 리소스(이미지, CSS, 자바스크립트 파일)에 대한 접근 경로를 설정
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/img/**")
                .addResourceLocations("/img/");

        registry.addResourceHandler("/css/**")
                .addResourceLocations("/css/");

        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/");
    }

    @Value("${smtp.host}")
    private String smtpHost;
    @Value("${smtp.username}")
    private String smtpUsername;
    @Value("${smtp.password}")
    private String smtpPassword;
    @Value("${smtp.port}")
    private int smtpPort;
    // 이메일 전송
    @Bean
    public JavaMailSender javaMailService() {
        JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();

        javaMailSender.setHost(smtpHost);
        javaMailSender.setUsername(smtpUsername);
        javaMailSender.setPassword(smtpPassword);
        javaMailSender.setPort(smtpPort);

        Properties props = javaMailSender.getJavaMailProperties();
        props.put("mail.smtp.auth", "true"); // 인증 활성화
        props.put("mail.smtp.ssl.enable", "true"); // SSL 활성화
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");  // TLS 1.2 명시적 사용
        props.put("mail.debug", "true"); // 디버그 모드 활성화

        return javaMailSender;
    }

    /*2025.01.10 JDeok 추가 */
    private final SellerInterceptor sellerInterceptor;
    private final CommonDataInterceptor commonDataInterceptor;

    public MvcConfig(@Lazy SellerInterceptor sellerInterceptor, @Lazy CommonDataInterceptor commonDataInterceptor) {
        this.sellerInterceptor = sellerInterceptor;
        this.commonDataInterceptor = commonDataInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 1. LoginInterceptor 등록
        registry.addInterceptor(sellerInterceptor)
                .addPathPatterns("/lodgment/**")  // 로그인 필수 URL
                .excludePathPatterns("/auth/**", "/static/**"); // 제외 URL

        // 2. CommonDataInterceptor 등록
        registry.addInterceptor(commonDataInterceptor)
                .addPathPatterns("/lodgment/**"); // 공통 데이터 적용 URL
    }


}
