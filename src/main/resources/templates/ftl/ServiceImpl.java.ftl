package ${package}.${moduleName}.service.impl;

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
@Service("${tableEntity.classname}Service")
public class ${tableEntity.className}ServiceImpl extends ServiceImpl<${tableEntity.className}Dao, ${tableEntity.className}Entity> implements ${tableEntity.className}Service {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<${tableEntity.className}Entity> page = this.page(
                new Query<${tableEntity.className}Entity>().getPage(params),
                new QueryWrapper<${tableEntity.className}Entity>()
        );

        return new PageUtils(page);
    }

}