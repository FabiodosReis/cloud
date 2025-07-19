package com.example.cloud.domain.exception;

public abstract class CloudException extends RuntimeException {

    public CloudException(String message){
        super(message);
    }

    public CloudException(String message, Throwable throwable){
        super(message, throwable);
    }
}
