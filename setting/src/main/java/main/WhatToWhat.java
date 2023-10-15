package main;

import java.io.BufferedReader;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.List;

public class WhatToWhat{
	public static String clobToString(Clob c) {
		String data = "";
		BufferedReader br = null;
		StringBuffer sb = new StringBuffer();
		try {
			br =  new BufferedReader(c.getCharacterStream());
			while((data = br.readLine()) != null) {
				sb.append(data);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	public static String createDiv(int no,String title) {
		return "<div><div id=\""+no+"\" class=\"pagesCd\" contenteditable=\"false\" style=\"display: flex;\"><div><img width=\"20\" class=\"pageimg\" src=\"resources/tag/document.png\"></div><div>"+title+"</div></div></div>";
	}
	public static String createDiv(int no) {
		return "<div><div id=\""+no+"\" class=\"pagesCd\" contenteditable=\"false\" style=\"display: flex;\"><div><img width=\"20\" class=\"pageimg\" src=\"resources/tag/document.png\"></div><div></div></div></div>";
	}
	
	public static Object JSONArrayToJAVAList(String JSONstringify){
		List<Object> list = new ArrayList<>();
		JSONstringify = JSONstringify.substring(2).substring(0,JSONstringify.length()-4);
		String[] data = JSONstringify.split("\",\"");
    	for(String dt : data) {
    		list.add(dt);
    	}
		
		return list;
	}

	
	
}
