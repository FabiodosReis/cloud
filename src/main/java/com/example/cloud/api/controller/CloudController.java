package com.example.cloud.api.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("cloud")
@Slf4j
public class CloudController {

    private static Long requestCount = 1L;

    @GetMapping
    public String test(){
        log.info("Request Realizado com sucesso: {}", requestCount);
        requestCount++;
        return "Oi";
    }
}
