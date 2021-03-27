package ${package}.${moduleName}.service;

import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import ${package}.${moduleName}.dao.${tableEntity.className}Dao;
import ${package}.${moduleName}.entity.${tableEntity.className}Entity;

/**
* ${tableEntity.tableComment}
*
* @author ${author} ${email}
* @since ${datetime?string('yyyy-MM-dd HH:mm:ss')}
*/
@Service
public class ${tableEntity.className}Service extends ServiceImpl<${tableEntity.className}Dao, ${tableEntity.className}Entity> {

}