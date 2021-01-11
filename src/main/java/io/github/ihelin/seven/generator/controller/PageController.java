package io.github.ihelin.seven.generator.controller;

import io.github.ihelin.seven.generator.service.GeneratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author iHelin ihelin@outlook.com
 * @since 2021/1/7 13:17
 */
@Controller
@RequestMapping("/seven")
public class PageController {

    @Autowired
    private GeneratorService generatorService;

    /**
     * 生成代码
     */
    @GetMapping("/code/{schemaName}")
    public void code(@PathVariable String schemaName, String tableNames, HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=\"seven.zip\"");
        response.setContentType("application/octet-stream; charset=UTF-8");
        generatorService.generatorCode(schemaName, tableNames.split(","), response.getOutputStream());
    }

    /**
     * test
     */
    @GetMapping("/test")
    public String test() {
        return "test";
    }
}
