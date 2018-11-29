package ${conf.basePackage}.${conf.daoPackage}<#if table.prefix!="">.${table.prefix}</#if>;

<#--
import java.util.List;
-->
import com.tzy.shopp.app.lib.MyBaseMapper;
import ${conf.basePackage}.${conf.entityPackage}<#if table.prefix!="">.${table.prefix}</#if>.${table.beanName};
import org.apache.ibatis.annotations.Mapper;

/**
 * 类说明:
 *
 * @author Heaton
 * Created by noname on ${.now}
 */
@Mapper
public interface ${table.beanName}Mapper extends MyBaseMapper<${table.beanName}> {

	${table.beanName} getById(Long id);

    List<${table.beanName}> getList(${table.beanName} entity)

    List<${table.beanName}> likeGetList(CommonSelectVo commonSelectVo);

    int update(${table.beanName} entity);

	int deleteById(Long id);

    int add(${table.beanName} entity);

	int addList(List<${table.beanName}> entityList);

}