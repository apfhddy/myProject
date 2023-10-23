package compiler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Compiler {
	private List<String> importList = new ArrayList<String>();
	
	public Compiler() {
		importList.add("import java.util.List;");
		importList.add("import java.util.ArrayList;");
	}
	
	
	public Map<String,Object> Compile(String code) {
		File compiler = new File("C:\\Users\\vavog\\Desktop\\serverFile\\compiler\\compile.java");
		FileOutputStream fos = null;
		boolean err = false;
		Map<String,Object> map = new HashMap<String, Object>();
		
		String args = "";
		for(String ipL : importList) {
			args+= ipL+"\n";
		}
	
		args +=	"\npublic class compile {\r\n"
		+ "    public static void main(String[] args) {\r\n"	
		+ "        "+code.replaceAll("\\\\\"", "\"")+"\r\n"
		+ "    }\r\n"
		+ "}";
	
		try {
			fos = new FileOutputStream(compiler);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			fos.write(args.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Process prs = null;
		String line = "";
		BufferedReader bis = null;
		try {
			prs = Runtime.getRuntime().exec("java -Dfile.encoding=UTF-8 C:\\Users\\vavog\\Desktop\\serverFile\\compiler\\compile.java");
			bis = new BufferedReader(new InputStreamReader(prs.getInputStream(),Charset.forName("UTF-8")));
			String buffer = null;
			while((buffer = bis.readLine()) != null) {
				line += buffer+"\n";
			}
		} catch (IOException e) {
			e.printStackTrace();
		} 
		if(line.isEmpty()) {
			bis = new BufferedReader(new InputStreamReader(prs.getErrorStream(),Charset.forName("UTF-8")));
			try {
				String buffer = null;
				while((buffer = bis.readLine()) != null) {
					if(buffer.contains("C:\\Users\\vavog\\Desktop\\serverFile\\compiler\\compile.java:")) {
						buffer = buffer.replace("C:\\Users\\vavog\\Desktop\\serverFile\\compiler\\compile.java:", "");
						int lineNum = Integer.parseInt(buffer.charAt(0)+"");
						buffer = buffer.substring(1);
						String mesage = "에러라인 :"+(lineNum-importList.size()-3);
						buffer  = mesage+buffer;
						err = true;
					}
					line += buffer+"\n";
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		line = line.replaceAll("\n", "<br>");
		line = line.replaceAll(" ", "&nbsp;");
		map.put("content", line);
		map.put("err", err);
		
		return map;
	}
}
