package ${package}.${moduleName}.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import ${package}.${moduleName}.entity.${className}Entity;
import ${package}.${moduleName}.service.${className}Service;
import ${package}.common.utils.PageUtils;
import ${package}.common.utils.R;



/**
 * ${comments}
 *
 * @author ${author} ${email}
 * @date ${datetime}
 */
@RestController
@RequestMapping("${moduleName}/${pathName}")
public class ${className}Controller {
    @Autowired
    private ${className}Service ${classname}Service;

    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = ${classname}Service.queryPage(params);

        return R.ok().put("data", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{${pk.attrname}}")
    public R info(@PathVariable("${pk.attrname}") ${pk.attrType} ${pk.attrname}){
		${className}Entity ${classname} = ${classname}Service.getById(${pk.attrname});

        return R.ok().put("data", ${classname});
    }

    /**
     * 新增
     */
    @PostMapping("/save")
    public R save(@RequestBody ${className}Entity ${classname}){
		${classname}Service.save(${classname});

        return R.ok();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public R update(@RequestBody ${className}Entity ${classname}){
		${classname}Service.updateById(${classname});

        return R.ok();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    public R delete(@RequestBody ${pk.attrType}[] ${pk.attrname}s){
		${classname}Service.removeByIds(Arrays.asList(${pk.attrname}s));

        return R.ok();
    }

}
