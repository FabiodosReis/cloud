package com.example.cloud.api.vo;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;


@Builder @Getter
public class DetailErrorVO {

    private int code;
    private LocalDateTime date;
    private String message;

}
