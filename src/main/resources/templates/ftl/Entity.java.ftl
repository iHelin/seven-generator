package ${package}.${moduleName}.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

<#if hasBigDecimal==true>
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
    /**
    * ${column.columnComment}
    */
    <#if column.columnName == tableEntity.pk.columnName>
        @TableId
    </#if>
    private ${column.attrType} ${column.attrname};
</#list>

<#list tableEntity.columns as column>

    public ${column.attrType} get${column.attrName}(){
        return ${column.attrname};
    }

    public void set${column.attrName}(${column.attrType} ${column.attrname}){
        this.${column.attrname} = ${column.attrname};
    }
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
