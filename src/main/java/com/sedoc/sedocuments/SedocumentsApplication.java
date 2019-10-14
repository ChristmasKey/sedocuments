package com.sedoc.sedocuments;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan
public class SedocumentsApplication {

    public static void main(String[] args) {
        SpringApplication.run(SedocumentsApplication.class, args);
    }

}
