package ${package}.${moduleName}.controller;

import java.util.Arrays;
import java.util.Map;

//import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
    @RequestMapping("/list")
    // @RequiresPermissions("${moduleName}:${pathName}:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = ${classname}Service.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{${pk.attrname}}")
    //@RequiresPermissions("${moduleName}:${pathName}:info")
    public R info(@PathVariable("${pk.attrname}") ${pk.attrType} ${pk.attrname}){
		${className}Entity ${classname} = ${classname}Service.getById(${pk.attrname});

        return R.ok().put("${classname}", ${classname});
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("${moduleName}:${pathName}:save")
    public R save(@RequestBody ${className}Entity ${classname}){
		${classname}Service.save(${classname});

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("${moduleName}:${pathName}:update")
    public R update(@RequestBody ${className}Entity ${classname}){
		${classname}Service.updateById(${classname});

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("${moduleName}:${pathName}:delete")
    public R delete(@RequestBody ${pk.attrType}[] ${pk.attrname}s){
		${classname}Service.removeByIds(Arrays.asList(${pk.attrname}s));

        return R.ok();
    }

}
