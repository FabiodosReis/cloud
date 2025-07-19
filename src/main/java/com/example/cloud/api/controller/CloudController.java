package com.example.cloud.api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("cloud")
public class CloudController {

    @GetMapping
    public String test(){
        return "Oi";
    }
}
