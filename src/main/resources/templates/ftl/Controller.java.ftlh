package ${package}.${moduleName}.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import ${package}.${moduleName}.entity.${tableEntity.className}Entity;
import ${package}.${moduleName}.service.${tableEntity.className}Service;
import ${package}.common.utils.R;

import java.util.List;


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
    public R list(@RequestParam(defaultValue = "1") Long page, @RequestParam(defaultValue = "10") Long limit, String key){
        QueryWrapper<${tableEntity.className}Entity> queryWrapper = new QueryWrapper<>();
        if (StringUtils.hasText(key)) {
            queryWrapper.eq("id", key);
        }
        IPage<${tableEntity.className}Entity> data = ${tableEntity.classname}Service.page(new Page<>(page, limit), queryWrapper);
        return R.ok(data);
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
    public R delete(@RequestBody List<${tableEntity.pk.attrType}> ${tableEntity.pk.attrname}s){
		${tableEntity.classname}Service.removeByIds(${tableEntity.pk.attrname}s);
        return R.ok();
    }

}
