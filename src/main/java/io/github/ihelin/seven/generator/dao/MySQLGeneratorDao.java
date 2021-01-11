package io.github.ihelin.seven.generator.dao;


import io.github.ihelin.seven.generator.entity.ColumnEntity;
import io.github.ihelin.seven.generator.entity.TableEntity;

import java.util.List;
import java.util.Map;

/**
 * MySQL代码生成器
 *
 * @author iHelin ihelin@outlook.com
 * @since 2021-01-07 12:43
 */
public interface MySQLGeneratorDao {

    List<String> querySchemas();

    List<Map<String, Object>> queryList(Map<String, Object> map);

    TableEntity queryTable(String schemaName, String tableName);

    List<ColumnEntity> queryColumns(String schemaName, String tableName);

}
