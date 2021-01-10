package ${package}.${moduleName}.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

<#if hasBigDecimal==true>
    import java.math.BigDecimal;
</#if>
import java.io.Serializable;
import java.util.Date;

/**
* ${comments}
*
* @author ${author} ${email}
* @since ${datetime}
*/
@TableName("${tableName}")
public class ${className}Entity implements Serializable {
private static final long serialVersionUID = 1L;

<#list columns as column>
    /**
    * ${column.comments}
    */
    <#if column.columnName == pk.columnName>
        @TableId
    </#if>
    private ${column.attrType} ${column.attrname};
</#list>

<#list columns as column>

    public ${column.attrType} get${column.attrName}(){
        return ${column.attrname}
    }

    public set${column.attrName}(${column.attrType} ${column.attrname}){
        this.${column.attrname} = ${column.attrname}
    }
</#list>

    @Override
    public String toString() {
        return "${className}Entity{" +
<#list columns as column>
        "${column.attrname}='" + ${column.attrname} + '\'' +
</#list>
        '}';
    }

}
