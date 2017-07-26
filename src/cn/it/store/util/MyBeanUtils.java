package cn.it.store.util;

import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

public class MyBeanUtils {
	public static <T> T getBean(Class<T> beanClass,Map<String,String[]> properties)
	{
		try{
			//创建返回对象
			T bean=beanClass.newInstance();
			
			//注册时间日期转换器类
			DateConverter dateConverter=new DateConverter();
			dateConverter.setPatterns(new String[]{"yyyy-MM-dd","yyyy-MM-dd HH:mm:ss"});
			ConvertUtils.register(dateConverter, java.util.Date.class);
			//封装对象数据
			BeanUtils.populate(bean, properties);
			return bean;
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
}
