package ${package}.${moduleName}.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

<#if hasBigDecimal>
import java.math.BigDecimal;
</#if>
import java.io.Serializable;
import java.util.Date;

/**
* ${tableEntity.tableComment}
*
* @author ${author} ${email}
* @since ${datetime?string('yyyy-MM-dd HH:mm:ss')}
*/
@TableName("${tableEntity.tableName}")
public class ${tableEntity.className}Entity implements Serializable {

    private static final long serialVersionUID = 1L;

<#list tableEntity.columns as column>
    <#if column.columnComment?? && column.columnComment!=''>
    /**
    * ${column.columnComment}
    */
    </#if>
    <#if column.columnName == tableEntity.pk.columnName>
    @TableId
    </#if>
    <#if column.attrType??>
    private ${column.attrType} ${column.attrname};
    </#if>
</#list>

<#list tableEntity.columns as column>

    <#if column.attrType??>
    public ${column.attrType} get${column.attrname?cap_first?uncap_first}(){
        return ${column.attrname};
    }
    </#if>

    <#if column.attrType??>
    public void set${column.attrname?cap_first}(${column.attrType} ${column.attrname}){
        this.${column.attrname} = ${column.attrname};
    }
    </#if>
</#list>

    @Override
    public String toString() {
        return "${tableEntity.className}Entity{" +
<#list tableEntity.columns as column>
        "${column.attrname}='" + ${column.attrname} + '\'' +
</#list>
        '}';
    }

}
