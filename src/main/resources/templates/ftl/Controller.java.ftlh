package ${package}.${moduleName}.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import ${package}.${moduleName}.entity.${tableEntity.className}Entity;
import ${package}.${moduleName}.service.${tableEntity.className}Service;
import ${package}.common.utils.PageUtils;
import ${package}.common.utils.R;



/**
 * ${tableEntity.tableComment}
 *
 * @author ${author} ${email}
 * @since ${datetime?string('yyyy-MM-dd HH:mm:ss')}
 */
@RestController
@RequestMapping("${moduleName}/${tableEntity.classname?lower_case}")
public class ${tableEntity.className}Controller {

    @Autowired
    private ${tableEntity.className}Service ${tableEntity.classname}Service;

    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = ${tableEntity.classname}Service.queryPage(params);

        return R.ok().put("data", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{${tableEntity.pk.attrname}}")
    public R info(@PathVariable("${tableEntity.pk.attrname}") ${tableEntity.pk.attrType} ${tableEntity.pk.attrname}){
		${tableEntity.className}Entity ${tableEntity.classname} = ${tableEntity.classname}Service.getById(${tableEntity.pk.attrname});

        return R.ok().put("data", ${tableEntity.classname});
    }

    /**
     * 新增
     */
    @PostMapping("/save")
    public R save(@RequestBody ${tableEntity.className}Entity ${tableEntity.classname}){
		${tableEntity.classname}Service.save(${tableEntity.classname});
        return R.ok();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public R update(@RequestBody ${tableEntity.className}Entity ${tableEntity.classname}){
		${tableEntity.classname}Service.updateById(${tableEntity.classname});
        return R.ok();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    public R delete(@RequestBody ${tableEntity.pk.attrType}[] ${tableEntity.pk.attrname}s){
		${tableEntity.classname}Service.removeByIds(Arrays.asList(${tableEntity.pk.attrname}s));
        return R.ok();
    }

}
