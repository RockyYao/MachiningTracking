package com.oechsler.common.utils;

import java.util.Enumeration;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

public class ConfigUtil {

	private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("ftpconfig");

	public static String getValue(String key) {
		try {
			return RESOURCE_BUNDLE.getString(key);
		} catch (MissingResourceException e) {
			return null;
		}
	}

	public static String getValue(String key, String defaultValue) {
		try {
			return RESOURCE_BUNDLE.getString(key);
		} catch (MissingResourceException e) {
			return defaultValue;
		}
	}

	public static Enumeration<String> keys() {
		return RESOURCE_BUNDLE.getKeys();
	}

}
