package com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.entity.EntityNotFoundException;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.entity.ListEntityNotFoundException;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.entity.SingleEntityNotFoundException;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.exceptions.storage.StorageException;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.errors.model.ApiError;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
public class GlobalRestControllerAdvice extends ResponseEntityExceptionHandler {

    @ExceptionHandler({StorageException.class})
    public ResponseEntity<?> handleStorageException(StorageException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(
            {EntityNotFoundException.class,
                    ListEntityNotFoundException.class,
                    SingleEntityNotFoundException.class}
    )
    public ResponseEntity<?> handleEntityNotFoundException(EntityNotFoundException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.NOT_FOUND);
    }

    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers,
                                                             HttpStatus status, WebRequest request) {
        return buildApiError(ex, request, status);
    }

    private ResponseEntity<Object> buildApiError(Exception ex, WebRequest request, HttpStatus status) {
        return ResponseEntity
                .status(status)
                .body(new ApiError(status, ex.getMessage(),
                        ((ServletWebRequest) request).getRequest().getRequestURI()));

    }
}
