<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
	PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
	"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<#assign beanName = table.beanName/>
<#assign tableName = table.tableName/>
<#macro mapperEl value>${r"#{"}${value}}</#macro>
<#macro orderInfo value>
		${r"${"}${value}}
</#macro>
<#macro pageInfo value>
		${r"${"}${value}}
</#macro>
<#macro findInfo value>
			${r"${"}${value}}
</#macro>
<#--<#macro batchMapperEl value>${r"#{"}${value}}</#batchMapperEl>-->
<#if table.prefix!="">
<#assign bean = conf.basePackage+"."+conf.entityPackage+"."+table.prefix+"."+beanName/>
<#assign mapper = conf.basePackage+"."+conf.daoPackage+"."+table.prefix+"."+beanName+"Mapper"/>
<#else>
<#assign bean = conf.basePackage+"."+conf.entityPackage+"."+beanName/>
<#assign mapper = conf.basePackage+"."+conf.daoPackage+"."+beanName+"Mapper"/>
</#if>
<#assign propertiesAnColumns = table.propertiesAnColumns/>
<#assign keys = propertiesAnColumns?keys/>
<#assign primaryKey = table.primaryKey/>
<#assign keys2 = primaryKey?keys/>
<#assign insertPropertiesAnColumns = table.insertPropertiesAnColumns/>
<#assign keys3 = insertPropertiesAnColumns?keys/>
<#assign keys4 = propertiesAnColumns?keys/>
<mapper namespace="${mapper}">

	<sql id="basicSelectSql">
		<#list keys as key>
		`${propertiesAnColumns["${key}"]}`<#-- AS `${key}`--><#if key_has_next>,</#if>
		</#list>
	</sql>

	<sql id="basicWhereColumn">
		<#list keys as key>
			<if test="${key} != null">
				AND `${propertiesAnColumns["${key}"]}` = <@mapperEl key/>
			</if>
		</#list>
	</sql>

	<sql id="basicWhereEntitySql">
		<where>
		<include refid="basicWhereColumn"/>
		</where>
	</sql>

	<sql id="basicWhereMapSql">
		<where>
		<include refid="basicWhereColumn"/>
		</where>
	</sql>

	<select id="getById" resultType="${bean}">
		SELECT
		<include refid="basicSelectSql"/>
		FROM `${tableName}`
		<where>
		<#list keys2 as key>
			`${key}` = <@mapperEl primaryKey["${key}"]/>
		</#list>
		</where>
		LIMIT 1;
	</select>

	<select id="getList" resultType="${bean}">
		SELECT
		<include refid="basicSelectSql"/>
		FROM `${tableName}`
		<include refid="basicWhereEntitySql"/>
		;
	</select>

    <select id="likeGetList" parameterType="com.tzy.shopp.app.biz.vo.CommonSelectVo"
            resultMap="BaseResultMap">
        SELECT
        <include refid="basicSelectSql"/>
        FROM `${tableName}`
        <where>
            <trim prefixOverrides="AND">
                <if test="queryCriteria != null">
                    and CONCAT_WS(' ',
						<#list keys as key>
							<#if key != "is_del" && key != "status">
                            IFNULL(`${propertiesAnColumns["${key}"]}`,'')<#if key_has_next>,</#if>
							</#if>
						</#list>
                    ) like CONCAT('%', <@mapperEl "queryCriteria"/>, '%')
                </if>
<#--                <if test="status != null">
				and status = <@mapperEl "status"/>
                </if>-->
                and is_del = 0
            </trim>
        </where>
    </select>

	<update id="update" parameterType="${bean}">
		UPDATE `${tableName}`
		<set>
			<#list keys3 as key>
			<#if key != "isDel" && key != "createTime" && key != "id">
			<if test="${key} != null">
				`${propertiesAnColumns["${key}"]}` = <@mapperEl key/>,
			</if>
			</#if>
			</#list>
		</set>
		<where>
		<#list keys2 as key>
			`${key}` = <@mapperEl primaryKey["${key}"]/>
		</#list>
		</where>
	</update>


	<update id="deleteById" parameterType="${bean}">
		UPDATE `${tableName}`
		SET `is_del`=1
		<where>
		<#list keys2 as key>
			`${key}` = <@mapperEl primaryKey["${key}"]/>
		</#list>
		</where>
	</update>

<#--	<insert id="add" useGeneratedKeys="true" keyProperty="id">
		INSERT INTO 
		`${tableName}`
		(<#list keys3 as key>`${insertPropertiesAnColumns["${key}"]}`<#if key_has_next>,</#if></#list>)
		VALUES 
		(<#list keys3 as key><@mapperEl key/><#if key_has_next>,</#if></#list>)
	</insert>

	<insert id="addList">
		INSERT INTO
		`${tableName}`
		(<#list keys3 as key>`${insertPropertiesAnColumns["${key}"]}`<#if key_has_next>,</#if></#list>)
		VALUES
		<foreach collection="list" item="item" index="index" separator="," >
		(<#list keys3 as key><@mapperEl "item."+key/><#if key_has_next>,</#if></#list>)
		</foreach>
	</insert>-->
    <insert id="add" useGeneratedKeys="true" keyProperty="id">
        INSERT INTO
        `${tableName}`
        (<#list keys3 as key>`${insertPropertiesAnColumns["${key}"]}`<#if key_has_next>,</#if></#list>)
        VALUES
        (<#list keys3 as key><@mapperEl key/><#if key_has_next>,</#if></#list>)
    </insert>

    <insert id="addList">
        INSERT INTO
        `${tableName}`
        (<#list keys as key>`${propertiesAnColumns["${key}"]}`<#if key_has_next>,</#if></#list>)
        VALUES
        <foreach collection="list" item="item" index="index" separator="," >
            (<#list keys4 as key><@mapperEl "item."+key/><#if key_has_next>,</#if></#list>)
        </foreach>
    </insert>


</mapper>