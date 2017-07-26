package cn.it.store.util;


public class PathUtil {
    public String getWebClassesPath() {  
        String path = getClass().getProtectionDomain().getCodeSource()  
                .getLocation().getPath();  
        path = trim(path);  
        return path;  
  
    }  
  
    public String getWebInfPath() throws IllegalAccessException {  
        String path = getWebClassesPath();  
        if (path.indexOf("WEB-INF") > 0) {  
            path = path.substring(0, path.indexOf("WEB-INF") + 8);  
            path = trim(path);  
        } else {  
            throw new IllegalAccessException("PathUtilError");  
        }  
        return path;  
    }  
  
    public String getWebRoot() throws IllegalAccessException {  
        String path = getWebClassesPath();  
        if (path.indexOf("WEB-INF") > 0) {  
            path = path.substring(0, path.indexOf("/WEB-INF/classes"));  
            path = trim(path);  
        } else {  
            throw new IllegalAccessException("PathUtilError");  
        }  
        return path;  
    }  
      
    private String trim(String s){  
        if(s.startsWith("/")||s.startsWith("\\")){  
            s = s.substring(1);  
            trim(s);  
        }  
        return s;  
    };
}
