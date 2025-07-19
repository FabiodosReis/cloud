package com.example.cloud.domain.service;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;
import java.util.concurrent.Semaphore;

@Service
public class ExecutorService {

    private final Executor taskExecutor;
    private final List<Integer> list;

    public ExecutorService(@Qualifier("taskExecutor") Executor taskExecutor, List<Integer> list) {
        this.taskExecutor = taskExecutor;
        this.list = list;
    }

    // o uso do async aqui é devido para o chamador do método não precisar esperar
    // o método run terminar
    @Async
    public void run() {
        List<CompletableFuture<Void>> futures = list.stream()
                .map(item ->
                        CompletableFuture.runAsync(() -> {
                            var resultado = process(item);
                            System.out.println("Number " + item + " processado: " + resultado);
                        }, taskExecutor)
                )
                .toList();

        // Espera todas terminarem
        CompletableFuture.allOf(futures.toArray(new CompletableFuture[0])).join();
        System.out.println("Todos os itens foram processados!");
    }


    private static Integer process(Integer number) {
        try {
            Thread.sleep(200); // Simula delay
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        return number * 10;
    }

}
