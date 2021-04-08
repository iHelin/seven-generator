package ${package}.${moduleName}.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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
    @PreAuthorize("hasAuthority('${moduleName}:${tableEntity.classname?lower_case}:list')")
    public R list(@RequestParam(defaultValue = "1") Long page,
                  @RequestParam(defaultValue = "10") Long limit,
                  String key){
        QueryWrapper<${tableEntity.className}Entity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq(StringUtils.hasText(key), "id", key);
        IPage<${tableEntity.className}Entity> data = ${tableEntity.classname}Service.page(new Page<>(page, limit), queryWrapper);
        return R.ok(data);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{${tableEntity.pk.attrname}}")
    @PreAuthorize("hasAuthority('${moduleName}:${tableEntity.classname?lower_case}:info')")
    public R info(@PathVariable("${tableEntity.pk.attrname}") ${tableEntity.pk.attrType} ${tableEntity.pk.attrname}){
        ${tableEntity.className}Entity ${tableEntity.classname} = ${tableEntity.classname}Service.getById(${tableEntity.pk.attrname});
        return R.ok().put("data", ${tableEntity.classname});
    }

    /**
     * 新增
     */
    @PostMapping("/save")
    @PreAuthorize("hasAuthority('${moduleName}:${tableEntity.classname?lower_case}:save')")
    public R save(@RequestBody ${tableEntity.className}Entity ${tableEntity.classname}Entity){
        ${tableEntity.classname}Service.save(${tableEntity.classname}Entity);
        return R.ok();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    @PreAuthorize("hasAuthority('${moduleName}:${tableEntity.classname?lower_case}:update')")
    public R update(@RequestBody ${tableEntity.className}Entity ${tableEntity.classname}Entity){
        ${tableEntity.classname}Service.updateById(${tableEntity.classname}Entity);
        return R.ok();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    @PreAuthorize("hasAuthority('${moduleName}:${tableEntity.classname?lower_case}:delete')")
    public R delete(@RequestBody List<${tableEntity.pk.attrType}> ${tableEntity.pk.attrname}s){
        ${tableEntity.classname}Service.removeByIds(${tableEntity.pk.attrname}s);
        return R.ok();
    }

}
