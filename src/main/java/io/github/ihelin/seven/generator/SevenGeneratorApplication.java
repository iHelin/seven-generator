package io.github.ihelin.seven.generator;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Seven 代码生成器
 *
 * @author iHelin ihelin@outlook.com
 * @since 2021-01-07 12:43
 */
@SpringBootApplication
@MapperScan("io.github.ihelin.seven.generator.dao")
public class SevenGeneratorApplication {

    public static void main(String[] args) {
        SpringApplication.run(SevenGeneratorApplication.class, args);
    }
}
