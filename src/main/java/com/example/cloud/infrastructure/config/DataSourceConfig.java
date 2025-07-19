package com.example.cloud.infrastructure.config;

import com.zaxxer.hikari.HikariDataSource;
import jakarta.persistence.PersistenceUnit;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.support.JdbcTransactionManager;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@EnableTransactionManagement
@ComponentScan("com.example.cloud")
@EnableJpaRepositories(
        basePackages = "com.example.cloud",
        transactionManagerRef = "jdbcTransactionManager"
)
public class DataSourceConfig {


    @Bean @Primary
    @ConfigurationProperties(prefix = "cloud.datasource")
    public DataSource dataSource() {
        return DataSourceBuilder.create()
                .type(HikariDataSource.class)
                .build();
    }

    @Bean
    @PersistenceUnit(name = "cloud-pu")
    public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean factoryBean =
                new LocalContainerEntityManagerFactoryBean();

        JpaVendorAdapter adapter = new HibernateJpaVendorAdapter();
        factoryBean.setJpaVendorAdapter(adapter);

        factoryBean.setDataSource(dataSource());
        factoryBean.setPersistenceUnitName("cloud-pu");
        Properties properties = new Properties();
        properties.setProperty("hibernate.show_sql", "false");
        properties.setProperty("hibernate.hbm2ddl", "none");
        factoryBean.setJpaProperties(properties);
        factoryBean.setPackagesToScan("com.example.cloud");
        return factoryBean;
    }

    @Primary
    @Bean("jdbcTransactionManager")
    public DataSourceTransactionManager transactionManager() {
        return new JdbcTransactionManager(dataSource());
    }

    @Bean
    public JdbcTemplate jdbcTemplate() {
        return new JdbcTemplate(dataSource());
    }

    @Bean
    public NamedParameterJdbcTemplate namedParameterJdbcTemplate() {
        return new NamedParameterJdbcTemplate(dataSource());
    }
}
