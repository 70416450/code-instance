<#import "base/date.ftl" as dt>
package ${conf.basePackage}.${conf.servicePackage}.impl<#if table.prefix!="">.${table.prefix}</#if>;

<#assign beanName = table.beanName/>
<#assign beanNameUncap_first = beanName?uncap_first/>
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
<#--import ${conf.basePackage}.modle.${beanName};
import ${conf.basePackage}.${conf.servicePackage}<#if table.prefix!="">.${table.prefix}</#if>.${beanName}Service;
import ${conf.basePackage}.${conf.daoPackage}<#if table.prefix!="">.${table.prefix}</#if>.${beanName}Mapper;-->
import java.util.List;
import java.util.Map;
import java.util.Arrays;
import tk.mybatis.mapper.entity.Example;

/**
 * 类说明:
 * @author Heaton
 * Created by noname on ${.now}
 */
@Service("${beanNameUncap_first}Service")
public class ${beanName}ServiceImpl implements ${beanName}Service {

	@Autowired
	private ${beanName}Mapper ${beanNameUncap_first}Mapper;

	@Override
	public ${beanName} getById(Long id) {
		return ${beanNameUncap_first}Mapper.getById(id);
	}

	@Override
	public List<${beanName}> getList(${beanName} entity) {
		List<${beanName}> resut = null;
		resut = ${beanNameUncap_first}Mapper.getList(entity);
		return resut;
	}

	@Override
	public List<${beanName}> likeGetList(CommonSelectVo commonSelectVo) {
		PojoPageHandler.doPagingAndSorting(commonSelectDto);
		List<${beanName}> resut = null;
		resut = ${beanNameUncap_first}Mapper.likeGetList(commonSelectVo);
		return resut;
	}

	@Override
	public int update(${beanName} entity) {
		return ${beanNameUncap_first}Mapper.update(entity);
	}

	@Override
	public int deleteById(Long id) {
		return ${beanNameUncap_first}Mapper.deleteById(id);
	}

	@Override
	public int deleteList(Long[] ids) {
		Example example = getExample(ids);
		${beanName} ${beanNameUncap_first} = ${beanName}.builder().isDel(true).build();
		return ${beanNameUncap_first}Mapper.updateByExampleSelective(${beanNameUncap_first}, example);
	}

	@Override
	public int add(${beanName} entity) {
		return ${beanNameUncap_first}Mapper.add(entity);
	}

	@Override
	public int addList(List<${beanName}> entityList) {
     	 for (${beanName} entity : entityList) {
            entity.setId(IdUtil.generateId());
            entity.setIsDel(false);
       	 }
		return ${beanNameUncap_first}Mapper.addList(entityList);
	}

  	//查询符合id集合条件的
    private Example getExample(Long[] idss) {
        if (!Validator.valid(idss)) {
            throw new BusinessException(BizErrorCode.ID_NULL);
        }
        List<Long> ids = Arrays.asList(idss);
    	Example example = new Example(${beanName}.class);
    	example.createCriteria().andIn("id", ids);
    	return example;
    }

}