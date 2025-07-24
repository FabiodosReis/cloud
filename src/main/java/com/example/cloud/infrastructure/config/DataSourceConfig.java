package com.example.cloud.infrastructure.config;


//@Configuration
//@EnableTransactionManagement
//@ComponentScan("com.example.cloud")
//@EnableJpaRepositories(
//        basePackages = "com.example.cloud",
//        transactionManagerRef = "jdbcTransactionManager"
//)
//public class DataSourceConfig {
//
//
//    @Bean @Primary
//    @ConfigurationProperties(prefix = "cloud.datasource")
//    public DataSource dataSource() {
//        return DataSourceBuilder.create()
//                .type(HikariDataSource.class)
//                .build();
//    }
//
//    @Bean
//    @PersistenceUnit(name = "cloud-pu")
//    public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
//        LocalContainerEntityManagerFactoryBean factoryBean =
//                new LocalContainerEntityManagerFactoryBean();
//
//        JpaVendorAdapter adapter = new HibernateJpaVendorAdapter();
//        factoryBean.setJpaVendorAdapter(adapter);
//
//        factoryBean.setDataSource(dataSource());
//        factoryBean.setPersistenceUnitName("cloud-pu");
//        Properties properties = new Properties();
//        properties.setProperty("hibernate.show_sql", "false");
//        properties.setProperty("hibernate.hbm2ddl", "none");
//        factoryBean.setJpaProperties(properties);
//        factoryBean.setPackagesToScan("com.example.cloud");
//        return factoryBean;
//    }
//
//    @Primary
//    @Bean("jdbcTransactionManager")
//    public DataSourceTransactionManager transactionManager() {
//        return new JdbcTransactionManager(dataSource());
//    }
//
//    @Bean
//    public JdbcTemplate jdbcTemplate() {
//        return new JdbcTemplate(dataSource());
//    }
//
//    @Bean
//    public NamedParameterJdbcTemplate namedParameterJdbcTemplate() {
//        return new NamedParameterJdbcTemplate(dataSource());
//    }
//}
