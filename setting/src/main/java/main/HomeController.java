package main;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.Clob;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import page.Page_DTO;
import page.Page_Service;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private ServletContext application;
	
	private Page_Service page_service;
	
	
	
	
	public HomeController(Page_Service page_service) {
		System.out.println("홈컨트롤러 작동");
		this.page_service = page_service;
	}
	
	/** 
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping("/")
	public String indexPage() {
		
		return "/WEB-INF/views/login.jsp";
	}
	
	
	@RequestMapping("login")
	public String home(String id ,String pw,HttpServletRequest req) {
		if(id.equals("wjdgmlfkr") && pw.equals("112233")) {
			List<Page_DTO> list = page_service.getList(0);
			
			req.getSession().setAttribute("login",1);
			req.setAttribute("list", list);
			return "/WEB-INF/views/home.jsp";			
		}else {
			return "/";
		}
	}

	@RequestMapping(value = "fileupload",produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String fileupload(@RequestParam("file") MultipartFile file) {
		String savePath = application.getRealPath("/resources/files");
		String fileName = file.getOriginalFilename();
		
		
		File saveFile = new File(savePath, fileName);
		
		if(!saveFile.exists()) {
			saveFile.mkdir();
		}else {//이름변경 작업
			long time = System.currentTimeMillis();
			
			fileName = String.format("%s%d%s", fileName.substring(0, fileName.lastIndexOf(".")),time,fileName.substring(fileName.lastIndexOf(".")));//중간에 시간을 넣기 위한 작업
		
			saveFile = new File(savePath,fileName);
		}
		
		try {
			file.transferTo(saveFile);//이름 바꾸기?
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return "resources/files/"+fileName;
	}
	
	@RequestMapping("getPage")
	@ResponseBody
	public Map<String,Object> getPage(int k) {
		Map<String,Object> data = page_service.getPage(k); 
		
		List<Page_DTO> list = page_service.getList(k);
		Map<Integer,Object> childList = new HashMap<>();
		for(Page_DTO page : list) {
			childList.put(page.getPage_no(), page.getTitle());
		}
		
		
		Map<String,Object> result = new HashMap<>();
		result.put("data", data);
		result.put("child", childList);
		return result;
	}
	
	@RequestMapping("savePage")
	@ResponseBody
	public void savaPage(String k,String kk,int kkk) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("data",k);
		map.put("title",kk);
		map.put("no", kkk);
		page_service.savePage(map);
	}
	
	@RequestMapping("addPage")
	@ResponseBody
	public int addPage(int k) {
			
		return page_service.addPage(k);
	}
	
	@RequestMapping("getList")
	@ResponseBody
	public List<Page_DTO> getList(int k){
		List<Page_DTO> list = page_service.getList(k);
		
		return list;
	}
	
	@RequestMapping("deletePage")
	@ResponseBody
	public int deletePage(int k) {
		Map<String,Object> map = page_service.getPage(k);
		int parent = Integer.parseInt(String.valueOf(map.get("PARENT")));
		if(parent != 0) {//부모가 있다면 부모 객체 수정
			page_service.deleteContent(parent, k);
		}
		page_service.deletePage(k);
		return parent;
	}
	
	@RequestMapping("updateOrder")
	@ResponseBody
	public void updateOrder(String data) {
		page_service.updateOrder(data);
	}
	
	@RequestMapping("updateParent")
	@ResponseBody
	public void updateParent(int k,int kk) {//바뀌는 객체 부모객체
		page_service.updateParent(k,kk);		
	}
	
}
