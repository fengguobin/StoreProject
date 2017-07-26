package cn.it.store.util;

import java.util.UUID;

public class CommonsUtils {

	//得到一个随机数
	public static String getUUID(){
		return UUID.randomUUID().toString().replace("-","");
	}
}
