package com.example.demogateway;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@SpringBootApplication
@EnableDiscoveryClient
@RestController
public class DemoGatewayApplication {

    @Autowired
    RestTemplate restTemplate;

    @Autowired
    private DiscoveryClient discoveryClient;

    @GetMapping("/")
    @ResponseBody
    public String hello() {
        return "GatewayApplication says hello!";
    }

    @GetMapping("/test")
    @ResponseBody
    public String invokeTestService() {
        List<ServiceInstance> testServiceInstances = this.discoveryClient.getInstances("test-service");
        return restTemplate.getForObject(testServiceInstances.get(0).getUri(), String.class);
    }

    @GetMapping("/services")
    public List<String> services() {
        return this.discoveryClient.getServices();
    }

    @GetMapping("/services/{serviceId}")
    public List<ServiceInstance> servicesById(@PathVariable("serviceId") String serviceId) {
        return this.discoveryClient.getInstances(serviceId);
    }

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    public static void main(String[] args) {
        SpringApplication.run(DemoGatewayApplication.class, args);
    }

}
