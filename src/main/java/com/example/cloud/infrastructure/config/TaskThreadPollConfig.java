package com.example.cloud.infrastructure.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

@Configuration
public class TaskThreadPollConfig {

    //não é muito aconselhavél usar o mesmo executor para executar tarefas de origem diferentes em
    //paralelo
    @Bean("taskExecutor")
    public Executor taskExecutor() {
       return Executors.newFixedThreadPool(10);
    }
}
