package ${package}.${moduleName}.service;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${package}.common.utils.PageUtils;
import ${package}.common.utils.Query;

import ${package}.${moduleName}.dao.${tableEntity.className}Dao;
import ${package}.${moduleName}.entity.${tableEntity.className}Entity;
import ${package}.${moduleName}.service.${tableEntity.className}Service;

/**
* ${tableEntity.tableComment}
*
* @author ${author} ${email}
* @since ${datetime?string('yyyy-MM-dd HH:mm:ss')}
*/
@Service
public class ${tableEntity.className}Service extends ServiceImpl<${tableEntity.className}Dao, ${tableEntity.className}Entity> {

}