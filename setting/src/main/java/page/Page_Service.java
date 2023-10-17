package page;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Clob;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.WhatToWhat;
import websocket.Socket;

public class Page_Service {
	
	private Page_DAO page_dao;
	
	
	public Page_Service(Page_DAO page_dao) {
		this.page_dao = page_dao;
	}
	
	public void deleteContent(int parent,int my) {
		Map<String,Object> map = getPage(parent);
		String data = (String)map.get("DATA");
		String div = WhatToWhat.createDiv(my);
		data = data.replace(div, "");
		//System.out.println(data);
		Map<String,Object> saveMap = new HashMap<String, Object>();
		saveMap.put("data", data);
		saveMap.put("title", map.get("TITLE"));
		saveMap.put("no", map.get("PAGE_NO"));
		savePage(saveMap);
	}
	
	public void addContent(int no,int child) {
		String data = WhatToWhat.createDiv(child);
		Map<String,Object> map = new HashMap<>();
		map.put("data", data);
		map.put("no", no);
		page_dao.childrenAdd(map);
	}
	
	public List<Page_DTO> getList(int k){
		return page_dao.getList(k);
	}
	
	public Map<String,Object> getPage(int k) {
		Map<String,Object> map = page_dao.getPage(k);
		Clob c = (Clob)map.get("DATA");
		
		String data = WhatToWhat.clobToString(c);
	
		map.put("DATA", data);
		
		return map;
	}
	
	public void savePage(Map<String,Object> map){
		long now = System.currentTimeMillis();
		Date parseDate = new Date(now);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH,hh:mm");
		String[] date = sdf.format(parseDate).split(",");
		String[] arr = date[0].split("-");
		
		String path = "C:\\Users\\vavog\\Desktop\\serverFile\\userFile\\"+map.get("no")+"\\"+arr[0]+"\\"+arr[1]+"\\"+arr[2]+"\\"+arr[3];
		
		File file = new File(path);
		if(!file.exists()) {
			file.mkdirs();
		}
		file = new File(file,"save.txt");

		if(!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		try {
			FileOutputStream fos = new FileOutputStream(file);
			String data = ((String)map.get("data"));
			String title = ((String)map.get("title"));
			String JSONSave = "[time:"+date[1]+"title:"+title+"data:"+data+"]";
			try {
				fos.write(JSONSave.getBytes());
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		
		
		page_dao.savePage(map);
	}
	
	public int addPage(int k) {
		Page_DTO dto = new Page_DTO();
		dto.setData("<div><br></div>");//br태그가 있어야 입력가능
		int next = page_dao.nextSeq();
		int orderNo = page_dao.nextOrderNo(k)+1;
		
		dto.setPage_no(next);
		dto.setParent(k);
		dto.setOrderno(orderNo);
		
		page_dao.addPage(dto);
		
		if(k != 0) {
			addContent(k,next);
		}
		
		
		return next;
	}
	
	
	public int deletePage(int k) {
		
		List<Page_DTO> list = page_dao.getList(k);
		
		if(list.size() != 0 && list != null) {
			for(int i = 0; i < list.size(); i++) {
				deletePage(list.get(i).getPage_no());
			}
		}
		
		page_dao.deletePage(k);
		
		return 0;
	}
	
	public void updateOrder(String data) {
		List<Integer> list = (List<Integer>)WhatToWhat.JSONArrayToJAVAList(data);
		for(int i = 0; i < list.size(); i++) {
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("order", i+1);
			map.put("no", list.get(i));
			page_dao.updateOrder(map);
		}
	}
	
	public void updateParent(int no,int parent,int append) {//저 매개변수 parent는 바꿀부모
		Map<String,Object> map = getPage(no);
		int parentNo = Integer.parseInt(String.valueOf(map.get("PARENT")));//현재 부모
		if(parentNo != 0)
			deleteContent(parentNo, no);
		addContent(parent, no);
		Map<String,Object> map2 = new HashMap<String, Object>();
		
		map2.put("no", no);
		map2.put("parent", parent);
		page_dao.updateParent(map2);
		if(append != 0) {
			int orderno = page_dao.nextOrderNo(parent)+1;
			map2.put("order", orderno);
			page_dao.updateOrder(map2);
		}
	}

	
	
	
}
