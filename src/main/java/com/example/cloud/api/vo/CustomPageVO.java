package com.example.cloud.api.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter @Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CustomPageVO<T> {
    private List<T> content;
    private CustomPageableVO pageable;

    public CustomPageVO(List<T> content, CustomPageableVO pageable) {
        this.content = content;
        this.pageable = pageable;
    }

}
