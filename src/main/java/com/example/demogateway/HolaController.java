package com.example.demogateway;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HolaController {

    @Value("${prueba}")
    private String prueba;

    @GetMapping("/prueba")
    public ResponseEntity<?> getStateByCountry(){
        return ResponseEntity.ok(prueba);
    }
}
