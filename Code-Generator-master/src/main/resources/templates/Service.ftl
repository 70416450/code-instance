package ${conf.basePackage}.${conf.servicePackage}<#if table.prefix!="">.${table.prefix}</#if>;

<#assign beanName = table.beanName/>
<#--import ${conf.basePackage}.modle.${beanName};-->
import java.util.List;
import ${conf.basePackage}.${conf.entityPackage}<#if table.prefix!="">.${table.prefix}</#if>.${table.beanName};
import com.tzy.shopp.app.biz.vo.CommonSelectVo;
/**
 * 类说明:
 * @author Heaton
 * Created by noname on ${.now}
 */
public interface ${beanName}Service{


	public ${beanName} getById(Long id);


	public List<${beanName}> getList(${beanName} entity);


	public List<${beanName}> likeGetList(CommonSelectVo commonSelectVo);


	public int update(${beanName} entity);


	public int deleteById(Long id);


 	public int deleteList(Long[] ids);


	public int add(${beanName} entity);


	public int addList(List<${beanName}> entityList);

}