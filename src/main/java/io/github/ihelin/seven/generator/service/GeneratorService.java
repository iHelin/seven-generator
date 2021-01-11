package io.github.ihelin.seven.generator.service;

import freemarker.template.Template;
import io.github.ihelin.seven.generator.dao.MySQLGeneratorDao;
import io.github.ihelin.seven.generator.entity.ColumnEntity;
import io.github.ihelin.seven.generator.entity.TableEntity;
import io.github.ihelin.seven.generator.utils.RRException;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.freemarker.FreeMarkerProperties;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.io.File;
import java.io.OutputStream;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 代码生成器   工具类
 *
 * @author iHelin ihelin@outlook.com
 * @since 2021-01-07 12:43
 */
@Component
public class GeneratorService {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;

    @Autowired
    private MySQLGeneratorDao mySQLGeneratorDao;

    @Autowired
    private FreeMarkerProperties freeMarkerProperties;

    /**
     * 根据数据库名查找所有的表
     *
     * @param schemaName 数据库名
     * @return 表信息
     */
    public List<TableEntity> getTablesBySchemaName(String schemaName) {
        return mySQLGeneratorDao.queryTableBySchemaName(schemaName);
    }

    public void generatorCode(String schemaName, String[] tableNames, OutputStream outputStream) {
        ZipOutputStream zip = new ZipOutputStream(outputStream);
        for (String tableName : tableNames) {
            //查询表信息
            TableEntity tableEntity = mySQLGeneratorDao.queryTable(schemaName, tableName);
            //查询列信息
            List<ColumnEntity> columns = mySQLGeneratorDao.queryColumns(schemaName, tableName);
            //生成代码
            tableEntity.setColumns(columns);
            generatorCode(tableEntity, zip);
        }

        IOUtils.closeQuietly(zip);
    }

    /**
     * 生成代码
     */
    public void generatorCode(TableEntity tableEntity,
                              ZipOutputStream zip) {
        Configuration config = getConfig();

        //获取模板列表
        List<String> templates = getTemplates();
        for (String template : templates) {
            //渲染模板
            try {
                String codeText = generateCodeText(tableEntity, template);
                //添加到zip
                zip.putNextEntry(new ZipEntry(getFileName(template, tableEntity.getClassName(), config.getString("package"), config.getString("moduleName"))));
                IOUtils.write(codeText, zip, "UTF-8");
                zip.closeEntry();
            } catch (Exception e) {
                throw new RRException("渲染模板失败，表名：" + tableEntity.getTableName(), e);
            }
        }
    }

    /**
     * 列名转换成Java属性名
     */
    public String columnToJava(String columnName) {
        return WordUtils.capitalizeFully(columnName, new char[]{'_'}).replace("_", "");
    }

    /**
     * 表名转换成Java类名
     */
    public String tableToJava(String tableName, String[] tablePrefixArray) {
        if (null != tablePrefixArray && tablePrefixArray.length > 0) {
            for (String tablePrefix : tablePrefixArray) {
                if (tableName.startsWith(tablePrefix)) {
                    tableName = tableName.replaceFirst(tablePrefix, "");
                }
            }
        }
        return columnToJava(tableName);
    }

    /**
     * 获取配置信息
     */
    public Configuration getConfig() {
        try {
            return new PropertiesConfiguration("generator.properties");
        } catch (ConfigurationException e) {
            throw new RRException("获取配置文件失败，", e);
        }
    }

    /**
     * 获取文件名
     */
    public String getFileName(String template, String className, String packageName, String moduleName) {
        String packagePath = "main" + File.separator + "java" + File.separator;
        if (StringUtils.isNotBlank(packageName)) {
            packagePath += packageName.replace(".", File.separator) + File.separator + moduleName + File.separator;
        }
        if (template.contains("Entity.java.ftl")) {
            return packagePath + "entity" + File.separator + className + "Entity.java";
        }

        if (template.contains("Dao.java.ftl")) {
            return packagePath + "dao" + File.separator + className + "Dao.java";
        }

        if (template.contains("Service.java.ftl")) {
            return packagePath + "service" + File.separator + className + "Service.java";
        }

        if (template.contains("ServiceImpl.java.ftl")) {
            return packagePath + "service" + File.separator + "impl" + File.separator + className + "ServiceImpl.java";
        }

        if (template.contains("Controller.java.ftl")) {
            return packagePath + "controller" + File.separator + className + "Controller.java";
        }

        if (template.contains("Dao.xml.ftl")) {
            return "main" + File.separator + "resources" + File.separator + "mapper" + File.separator + moduleName + File.separator + className + "Dao.xml";
        }

        if (template.contains("menu.sql.ftl")) {
            return className.toLowerCase() + "_menu.sql";
        }

        if (template.contains("index.vue.ftl")) {
            return "main" + File.separator + "resources" + File.separator + "src" + File.separator + "views" + File.separator + "modules" +
                    File.separator + moduleName + File.separator + className.toLowerCase() + ".vue";
        }

        if (template.contains("add-or-update.vue.ftl")) {
            return "main" + File.separator + "resources" + File.separator + "src" + File.separator + "views" + File.separator + "modules" +
                    File.separator + moduleName + File.separator + className.toLowerCase() + "-add-or-update.vue";
        }

        return null;
    }

    /**
     * 查询所有数据库
     *
     * @return 数据库名称
     */
    public List<String> listAllSchema() {
        return mySQLGeneratorDao.querySchemas();
    }

    public String generateCodeText(String schemaName, String tableName, String filename) {
        //查询表信息
        TableEntity tableEntity = mySQLGeneratorDao.queryTable(schemaName, tableName);

        //查询列信息
        List<ColumnEntity> columns = mySQLGeneratorDao.queryColumns(schemaName, tableName);
        tableEntity.setColumns(columns);
        return generateCodeText(tableEntity, filename);
    }

    /**
     * 生成代码片段
     *
     * @param tableEntity tableEntity
     * @param filename    文件名
     * @return 代码片段
     */
    public String generateCodeText(TableEntity tableEntity, String filename) {
        Configuration config = getConfig();

        //表名转换成Java类名
        String className = tableToJava(tableEntity.getTableName(), config.getStringArray("tablePrefix"));
        tableEntity.setClassName(className);
        tableEntity.setClassname(StringUtils.uncapitalize(className));

        //配置信息
        boolean hasBigDecimal = false;
        boolean hasList = false;

        //列信息
        for (ColumnEntity columnEntity : tableEntity.getColumns()) {
            //列名转换成Java属性名
            String attrName = columnToJava(columnEntity.getColumnName());
            columnEntity.setAttrName(attrName);
            columnEntity.setAttrname(StringUtils.uncapitalize(attrName));

            //列的数据类型，转换成Java类型
            String attrType = config.getString(columnEntity.getDataType());
            columnEntity.setAttrType(attrType);

            if (!hasBigDecimal && "BigDecimal".equals(attrType)) {
                hasBigDecimal = true;
            }
            if (!hasList && "array".equals(columnEntity.getExtra())) {
                hasList = true;
            }
            //是否主键
            if ("PRI".equalsIgnoreCase(columnEntity.getColumnKey()) && tableEntity.getPk() == null) {
                tableEntity.setPk(columnEntity);
            }

        }

        //没主键，则第一个字段为主键
        if (tableEntity.getPk() == null) {
            tableEntity.setPk(tableEntity.getColumns().get(0));
        }

        //封装模板数据
        Map<String, Object> map = new HashMap<>();
        map.put("tableEntity", tableEntity);
        map.put("hasBigDecimal", hasBigDecimal);
        map.put("hasList", hasList);
        map.put("package", config.getString("package"));
        map.put("moduleName", config.getString("moduleName"));
        map.put("author", config.getString("author"));
        map.put("email", config.getString("email"));
        map.put("datetime", new Date());
        //渲染模板
        String resultString = "";
        try {
            Template freemarkerTemplate = freeMarkerConfigurer.getConfiguration().getTemplate("ftl/" + filename + freeMarkerProperties.getSuffix());
            resultString = FreeMarkerTemplateUtils.processTemplateIntoString(freemarkerTemplate, map);
        } catch (Exception e) {
            logger.warn("解析freemarker异常", e);
        }
        return resultString;
    }

    private static List<String> getTemplates() {
        List<String> templates = new ArrayList<>();
        templates.add("add-or-update.vue");
        templates.add("Controller.java");
        templates.add("Dao.java");
        templates.add("Dao.xml");
        templates.add("Entity.java");
        templates.add("index.vue");
        templates.add("menu.sql");
        templates.add("Service.java");
        templates.add("ServiceImpl.java");
        return templates;
    }
}
