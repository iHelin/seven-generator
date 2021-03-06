package io.github.ihelin.seven.generator.entity;

/**
 * 列的属性
 *
 * @author iHelin ihelin@outlook.com
 * @since 2021-01-07 12:43
 */
public class ColumnEntity {
    //列名
    private String columnName;

    //列名类型
    private String dataType;

    //列名备注
    private String columnComment;

    private String columnKey;

    //属性名称(第一个字母小写)，如：user_name => userName
    private String attrname;

    //属性类型
    private String attrType;

    //auto_increment
    private String extra;

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getColumnComment() {
        return columnComment;
    }

    public void setColumnComment(String columnComment) {
        this.columnComment = columnComment;
    }

    public String getAttrname() {
        return attrname;
    }

    public void setAttrname(String attrname) {
        this.attrname = attrname;
    }

    public String getAttrType() {
        return attrType;
    }

    public void setAttrType(String attrType) {
        this.attrType = attrType;
    }

    public String getExtra() {
        return extra;
    }

    public void setExtra(String extra) {
        this.extra = extra;
    }

    public String getColumnKey() {
        return columnKey;
    }

    public void setColumnKey(String columnKey) {
        this.columnKey = columnKey;
    }
}
