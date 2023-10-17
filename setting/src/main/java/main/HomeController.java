package main;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import compiler.Compiler;
import email.MailSendService;
import page.Page_DTO;
import page.Page_Service;
import websocket.Socket;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController extends Thread {
	
	@Autowired
	private ServletContext application;
	
	private Page_Service page_service;
	private MailSendService mailSendService;
	private Compiler codeRuntime = new Compiler();
	private Socket echoHandler;
	
	public HomeController(Page_Service page_service, MailSendService mailSendService,Socket echoHandler) {
		System.out.println("홈컨트롤러 작동");
		this.page_service = page_service;
		this.mailSendService = mailSendService;
		this.echoHandler = echoHandler;
	}
	
	/** 
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping("/")
	public String indexPage(HttpSession session) {
		session.setAttribute("id",session.getId());
		return "/WEB-INF/views/login.jsp"; 
	}
	
	
	@RequestMapping("login")
	public String home(String id ,String pw,HttpServletRequest req) {
		//if(req.getSession() != null && req.getSession().getAttribute("password") != null && id.equals("wjdgmlfkr") && req.getSession().getAttribute("password").equals(pw)) {
			List<Page_DTO> list = page_service.getList(0);
			req.setAttribute("list", list);
			req.getSession().setAttribute("login", 1);
			return "/WEB-INF/views/home.jsp";
		//}else {
		//	return "redirect:https://www.google.com/";
		//}
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
	public Map<String,Object> getPage(HttpSession sessoin,int k) {
		// 페이지 준비
		Map<String,Object> data = page_service.getPage(k); 
		
		List<Page_DTO> list = page_service.getList(k);
		Map<Integer,Object> childList = new HashMap<>();
		for(Page_DTO page : list) {
			childList.put(page.getPage_no(), page.getTitle());
		}
		
		Map<String,Object> result = new HashMap<>();
		result.put("data", data);
		result.put("child", childList);
		//페이지 준비
		//websocket 준비
		echoHandler.getSessionMap(sessoin.getId()).put("page", k);
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
	public void updateParent(int k,int kk,int append) {//바뀌는 객체 부모객체
		page_service.updateParent(k,kk,append);		
	}
	
	@RequestMapping("Start")
	@ResponseBody
	public void Start(HttpSession session) {
		if(session.getAttribute("start") == null) {
			session.setAttribute("start", 1);
			session.setAttribute("password", mailSendService.joinEmail(null));
			session.removeAttribute("start");
		}
	}
	
	
	@RequestMapping("codeRuntime")
	@ResponseBody
	public Map<String,Object> codeRuntime(String JSONarr,String code) {
		Map<String,Object> map = null;
		String request = "";
		if(JSONarr != null && !JSONarr.isEmpty()) {
			List<String> list =  (List<String>)WhatToWhat.JSONArrayToJAVAList(JSONarr);
			if(!list.isEmpty())
				for(String variable : list) {
					request+=variable+"\n";
				}
		}
		request+=code;
		if(!request.isEmpty())
			map = codeRuntime.Compile(request);
		return map;
	}
	
}
