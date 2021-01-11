package ${package}.${moduleName}.service;

import com.baomidou.mybatisplus.extension.service.IService;
import ${package}.common.utils.PageUtils;
import ${package}.${moduleName}.entity.${tableEntity.className}Entity;

import java.util.Map;

/**
 * ${tableEntity.tableComment}
 *
 * @author ${author} ${email}
 * @since ${datetime?string('yyyy-MM-dd HH:mm:ss')}
 */
public interface ${tableEntity.className}Service extends IService<${tableEntity.className}Entity> {

    PageUtils queryPage(Map<String, Object> params);
}

