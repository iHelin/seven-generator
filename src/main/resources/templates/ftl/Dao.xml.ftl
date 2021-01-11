<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${package}.${moduleName}.dao.${tableEntity.className}Dao">

    <!-- 可根据自己的需求，是否要使用 -->
    <resultMap type="${package}.${moduleName}.entity.${tableEntity.className}Entity" id="${tableEntity.classname}Map">
        <#list tableEntity.columns as column>
            <result property="${column.attrname}" column="${column.columnName}"/>
        </#list>
    </resultMap>


</mapper>