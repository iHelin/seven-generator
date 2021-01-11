package io.github.ihelin.seven.generator.controller;

import io.github.ihelin.seven.generator.service.GeneratorService;
import io.github.ihelin.seven.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * 代码生成器
 *
 * @author iHelin ihelin@outlook.com
 * @since 2021-01-07 12:43
 */
@RestController
@RequestMapping("/seven")
public class SysGeneratorController {

    @Autowired
    private GeneratorService generatorService;

    /**
     * 查询所有数据库
     */
    @RequestMapping("/schemas")
    public R listAllSchema() {
        List<String> list = generatorService.listAllSchema();
        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @GetMapping("/tables/{schemaName}")
    public R list(@PathVariable String schemaName) {
        List<Map<String, Object>> data = generatorService.queryTables(schemaName);
        return R.ok().put("data", data);
    }

    /**
     * 生成对应代码
     */
    @RequestMapping("/code")
    public R code(String schemaName, String tableName, String fileName) {
        String code = generatorService.generateCode(schemaName, tableName, fileName);
        return R.ok().put("data", code);
    }

}
