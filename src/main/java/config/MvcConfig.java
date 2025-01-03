package config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@ComponentScan(basePackages = {"kr.co"})
@EnableWebMvc
@MapperScan(basePackages = {"kr.co.team4.model.mapper"}, annotationClass = Mapper.class)
@EnableTransactionManagement
public class MvcConfig implements WebMvcConfigurer {
    // 뷰리졸버 - 포워딩할 경로 앞/뒤 설정
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/views/", ".jsp");
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
        config.setLocations(new ClassPathResource("db.properties"), new ClassPathResource("smtp.properties"));

        return config;
    }

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



}
