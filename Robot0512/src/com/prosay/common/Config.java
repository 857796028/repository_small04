package com.prosay.common;

import java.util.ResourceBundle;

/**
 * 读取通用类配置
 * @author Administrator
 *
 */
public class Config {
  public  static final String APIKEY;
  public  static final String URL;
	static{
		ResourceBundle rsb = ResourceBundle.getBundle("api_config");
		APIKEY =rsb.getString("APIKEY");
		URL = rsb.getString("URL");
	   }
	
}
