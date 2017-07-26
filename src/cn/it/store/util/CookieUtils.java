package cn.it.store.util;

import javax.servlet.http.Cookie;

public class CookieUtils {
	public static Cookie findCookie(Cookie[] cookies,String cookieName)
	{
		if(cookieName==null)
		{
			return null;
		}
		if(cookies!=null)
		{
			for(Cookie c:cookies)
			{
				if(cookieName.equals(c.getName()))
				{
					return c;
				}
			}
		}
		//没有找到 返回null;
		return null;
	}
}
