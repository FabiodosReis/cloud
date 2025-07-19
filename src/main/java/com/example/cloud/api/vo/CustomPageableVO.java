package com.example.cloud.api.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CustomPageableVO {

    int pageNumber;
    int pageSize;
    long totalElements;

    public CustomPageableVO(Integer pageNumber, Integer pageSize, long totalElements) {
        this.pageNumber = pageNumber == null ? 0 : pageNumber;
        this.pageSize = pageSize == null ? 10 : pageSize;
        this.totalElements = totalElements;
    }
}
