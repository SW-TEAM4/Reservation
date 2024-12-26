package config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.io.ClassPathResource;
import org.springframework.format.FormatterRegistry;
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

@Configuration
@ComponentScan(basePackages = {"kr.co"})
@EnableWebMvc
@MapperScan(basePackages = {"kr.co.team4.model.mapper"}, annotationClass = Mapper.class)
@EnableTransactionManagement
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

//    // 트랜잭션매니저 빈 등록
//    @Bean
//    public TransactionManager tm() {
//        DataSourceTransactionManager dtm =
//                new DataSourceTransactionManager(dataSource());
//        return dtm;
//    }

    // properties 설정
    @Bean
    public static PropertyPlaceholderConfigurer propreties() {
        PropertyPlaceholderConfigurer config = new PropertyPlaceholderConfigurer();
        config.setLocations(
                new ClassPathResource("db.properties"),
                new ClassPathResource("bucket.properties")
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

}
