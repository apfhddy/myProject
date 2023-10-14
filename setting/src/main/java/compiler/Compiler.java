package compiler;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;

public class Compiler {
	
	public String Compile(String code) {
		File compiler = new File("C:\\Users\\vavog\\Desktop\\serverFile\\compiler\\compil.java");
		File err = new File("C:\\Users\\vavog\\Desktop\\err.txt");
		FileOutputStream fos = null;
		FileOutputStream errfos = null;
		BufferedInputStream bus = new BufferedInputStream(System.in);
		
		
		String args = "public class compil {\r\n"
				+ "    public static void main(String[] args) {\r\n"
				+ "        "+code+"\r\n"
				+ "        System.out.println(s);\r\n"
				+ "    }\r\n"
				+ "}";
		
		try {
			fos = new FileOutputStream(compiler);
			errfos = new FileOutputStream(err);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			fos.write(args.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String line = null;
		try {
			Process prs = Runtime.getRuntime().exec("java -Dfile.encoding=UTF-8 C:\\Users\\vavog\\Desktop\\serverFile\\compiler\\compil.java");
			BufferedReader bis = new BufferedReader(new InputStreamReader(prs.getInputStream(),Charset.forName("UTF-8")));
			line = bis.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return line;
	}
}
