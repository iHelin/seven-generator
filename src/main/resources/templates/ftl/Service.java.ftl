package ${package}.${moduleName}.service;

import com.baomidou.mybatisplus.extension.service.IService;
import ${package}.common.utils.PageUtils;
import ${package}.${moduleName}.entity.${className}Entity;

import java.util.Map;

/**
 * ${comments}
 *
 * @author ${author} ${email}
 * @date ${datetime}
 */
public interface ${className}Service extends IService<${className}Entity> {

    PageUtils queryPage(Map<String, Object> params);
}

