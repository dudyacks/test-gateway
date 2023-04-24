package com.example.demogateway;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.server.EntityResponse;

import java.net.http.HttpResponse;
import java.util.List;

@RestController
public class HolaController {
    @GetMapping("")
    public ResponseEntity<?> getStateByCountry(){
        return ResponseEntity.ok("Hola");
    }
}
