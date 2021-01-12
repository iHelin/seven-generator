package io.github.ihelin.seven.generator.controller;

import io.github.ihelin.seven.generator.entity.TableEntity;
import io.github.ihelin.seven.generator.service.GeneratorService;
import io.github.ihelin.seven.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
     * 根据数据库名称查找对应的表名
     */
    @GetMapping("/tables/{schemaName}")
    public R getTablesBySchemaName(@PathVariable String schemaName) {
        List<TableEntity> data = generatorService.getTablesBySchemaName(schemaName);
        return R.ok().put("data", data);
    }

    /**
     * 生成对应代码
     */
    @RequestMapping("/code")
    public R code(@RequestParam String schemaName,
                  @RequestParam String tableName,
                  @RequestParam String fileName) {
        String codeText = generatorService.generateCodeText(schemaName, tableName, fileName);
        return R.ok().put("data", codeText);
    }

}
