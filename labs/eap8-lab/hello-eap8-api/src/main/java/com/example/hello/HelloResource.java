package com.example.hello;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;

@Path("hello")
public class HelloResource {

    @GET
    public String sayHello() {
        return "Hello from EAP 8!";
    }
}