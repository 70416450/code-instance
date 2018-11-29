package ${conf.basePackage}.${conf.controllerPackage}<#if table.prefix!="">.${table.prefix}</#if>;
<#assign beanName = table.beanName/>
<#assign beanNameuncap_first = beanName?uncap_first/>
<#assign implName = beanNameuncap_first+"ServiceImpl"/>
<#assign serviceName = beanNameuncap_first+"Service"/>

import ${conf.basePackage}.model.${beanName};
import ${conf.basePackage}.${conf.entityPackage}<#if table.prefix!="">.${table.prefix}</#if>.${beanName}Mapper;
import ${conf.basePackage}.${conf.servicePackage}<#if table.prefix!="">.${table.prefix}</#if>.${beanName}Service;

import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
* 接口层
* @author Heaton
* Created by noname on ${.now}
*/
@SuppressWarnings("all")
@RestController
@RequestMapping("/${beanNameuncap_first}")
@Api(value = "API - ${beanName}Controller", description = "${table.tableDesc}接口")
public class ${beanName}Controller{
	<#--
	/**
	 * logger 日志
	 */
	private static final Logger logger = LoggerFactory.getLogger(${beanName}Controller.class);
	
	private static final String BASE_PATH = "${beanNameuncap_first}/";
	-->
	@Autowired
	private ${beanName}Service ${serviceName};


    @ApiOperation(value = "添加")
    @ApiImplicitParam(name = "${beanNameuncap_first}Vos", value = "${table.tableDesc}对象集合", dataType = "${beanName}Vo", required = true, paramType = "body")
    @ApiResponses({@ApiResponse(code = 200, message = "操作成功"),
            @ApiResponse(code = 500, message = "服务器内部异常"),
            @ApiResponse(code = 999, message = "权限不足")})
    @PostMapping("/addList")
    public JsonData addList(@RequestBody List<${beanName}Vo> ${beanNameuncap_first}Vos) {
    		FluentValidatorUtil.resultAdd(${beanNameuncap_first}Vos);
			List<${beanName}> ${beanNameuncap_first}s = BeanUtil.copyList(${beanNameuncap_first}Vos, ${beanName}.class);
			${serviceName}.addList(${beanNameuncap_first}s);
            return JsonData.ok();
	}

    @ApiOperation(value = "删除", notes = "根据url的id来指定删除对象")
    @ApiImplicitParam(name = "ids", value = "${table.tableDesc}对象ID数组", dataType = "Long", required = true, paramType = "path")
    @ApiResponses({@ApiResponse(code = 200, message = "操作成功"),
            @ApiResponse(code = 500, message = "服务器内部异常"),
            @ApiResponse(code = 999, message = "权限不足")})
    @DeleteMapping("/delete/{ids}")
    public JsonData delete(@PathVariable("ids") Long[] ids) {
		${serviceName}.deleteList(ids);
    	return JsonData.ok();
    }

    @ApiOperation(value = "修改")
    @ApiImplicitParam(name = "${beanNameuncap_first}Vo", value = "学生对象集合", dataType = "${beanName}Vo", required = true, paramType = "body")
    @ApiResponses({@ApiResponse(code = 200, message = "操作成功"),
            @ApiResponse(code = 500, message = "服务器内部异常"),
            @ApiResponse(code = 999, message = "权限不足")})
    @PutMapping("/update")
    public JsonData update(@RequestBody @Validated(UpdateProject.class) ${beanName}Vo ${beanNameuncap_first}Vo) {
			${beanName} ${beanNameuncap_first} = ${beanName}.builder().build();
            BeanUtil.copyProperties(${beanNameuncap_first}Vo, ${beanNameuncap_first});
			${serviceName}.update(${beanNameuncap_first});
            return JsonData.ok();
    }

    @ApiOperation(value = "模糊查询${table.tableDesc}"<#--,notes = "{\n" +
        <#assign allPropInfo = table.allPropInfo/>
        <#list allPropInfo as prop>
        "  \"${prop.propertyName}\": ${prop.propertyType}（${prop.propertyDesc}）" +"<#if prop_has_next>,</#if>"+"\n" +
        </#list>
    "}"-->)
    @ApiImplicitParam(name = "commonSelectVo", value = "公用对象", dataType = "CommonSelectVo", required = true, paramType = "body")
    @ApiResponses({@ApiResponse(code = 200, message = "操作成功"),
    @ApiResponse(code = 500, message = "服务器内部异常"),
    @ApiResponse(code = 999, message = "权限不足")})
    @PostMapping("/select")
    public JsonData<List<${beanName}>> select(@RequestBody CommonSelectVo commonSelectVo) {
    List<${beanName}> ${beanNameuncap_first}s = ${serviceName}.likeGetList(commonSelectVo);
        return JsonData.ok(${beanNameuncap_first}s);
    }
}
