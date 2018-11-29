<#-- bean template -->
package ${conf.basePackage}.${conf.entityPackage}<#if table.prefix!="">.${table.prefix}</#if>;

import java.io.Serializable;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

<#list table.propTypePackages as package>
${package}
</#list>

/**
 * 实体bean
 * @author Heaton
 * <p>
 * 表名：${table.tableName}
 * <p>
 * 描述：${table.tableDesc}
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(description = "${table.tableDesc}Vo")
@Table(name = "${table.tableName}")
public class ${table.beanName} implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
<#--
<#assign properties = table.properties/>
<#assign propInfoMap = table.propInfoMap/>
<#assign keys = propInfoMap?keys/>
-->
<#assign properties = table.propertiesAnColumns/>
<#assign keys = properties?keys/>
<#assign allPropInfo = table.allPropInfo/>
<#list allPropInfo as prop>
	<#--/**
	 * ${prop.propertyDesc}
	 */-->

	@ApiModelProperty(value = "${prop.propertyDesc}")
	private ${prop.propertyType} ${prop.propertyName};
</#list>
<#--getset-->
<#--
<#list allPropInfo as prop>-->
	<#--/**-->
	 <#--* 获取${prop.propertyDesc}-->
	 <#--*/-->
	<#--public ${prop.propertyType} get${prop.propertyName?cap_first}() {-->
		<#--return this.${prop.propertyName};-->
	<#--}-->

	<#--/**-->
	 <#--* 设置${prop.propertyDesc}-->
	 <#--*/-->
	<#--public void set${prop.propertyName?cap_first}(${prop.propertyType} ${prop.propertyName}) {-->
		<#--this.${prop.propertyName} = ${prop.propertyName};-->
	<#--}-->

<#--</#list>
-->
<#--
<#list keys as key>
	/**
	 * 获取${propInfoMap["${key}"].propertyDesc}
	 */
	public ${properties["${key}"]} get${key?cap_first}() {
		return this.${key};
	}

	/**
	 * 设置${propInfoMap["${key}"].propertyDesc}
	 */
	public void set${key?cap_first}(${properties["${key}"]} ${key}) {
		this.${key} = ${key};
	}

</#list>
-->
	<#--public String toString() {-->
		<#--return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);-->
	<#--}-->
}
