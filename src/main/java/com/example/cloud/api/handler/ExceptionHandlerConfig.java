package com.example.cloud.api.handler;

import com.example.cloud.api.vo.DetailErrorVO;
import com.example.cloud.domain.exception.CloudException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice
@Slf4j
public class ExceptionHandlerConfig {

    @ExceptionHandler(value = CloudException.class)
    public ResponseEntity<?> cloudHandler(CloudException exception) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(
                        DetailErrorVO.builder()
                                .code(HttpStatus.BAD_REQUEST.value())
                                .date(LocalDateTime.now())
                                .message(exception.getMessage())
                                .build()
                );
    }


    @ExceptionHandler(value = HttpRequestMethodNotSupportedException.class)
    public ResponseEntity<?> httpMethodNotSupported(HttpRequestMethodNotSupportedException exception) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(
                        DetailErrorVO.builder()
                                .code(HttpStatus.BAD_REQUEST.value())
                                .date(LocalDateTime.now())
                                .message(exception.getMessage())
                                .build()
                );
    }

    @ExceptionHandler(value = Exception.class)
    public ResponseEntity<?> internalErrorHandler(Exception exception) {
        log.error(exception.getMessage());
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(
                        DetailErrorVO.builder()
                                .code(HttpStatus.INTERNAL_SERVER_ERROR.value())
                                .date(LocalDateTime.now())
                                .message(HttpStatus.INTERNAL_SERVER_ERROR.name())
                                .build()
                );
    }
}
