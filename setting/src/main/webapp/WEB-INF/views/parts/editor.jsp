<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="noSelection">
	<!--  <div class = "codeConsole">
		<div class = "header" align="left">[Response]</div> 
		<div class = "content">fdassdafdsafdsafdasfdsafdsafsadfdsafdasfdsafdasdsafds&nbsp;afsfsdafasdf
		<br>&ensp;&ensp;&ensp;^</div> 
	</div>   -->
	<input style="display: none" class="editor-box" type = "file" accept="image/gif,image/jpeg,image/png">
	<div id = "editor" style="display:  none;">
		<div class="editor-box" style="font-weight: bold;" onclick="sc('bold')">B</div>
		<div class="editor-box">A
		 	<div onclick = "fontC(event)" style="position: absolute; text-align: left; background-color: white; box-shadow: 1px 1px gray;">
				<div><a style="color: black;">A</a>기본색</div>
				<div><a style="color: gray;">A</a>회색</div>
				<div><a style="color: red;">A</a>빨간색</div>
				<div><a style="color: blue;">A</a>파랑색</div>
				<div><a style="color: orange;">A</a>주황색</div>
			</div>
		</div>
		<div class="editor-box" style="font-style: italic;" onclick="sc('italic')">i</div>
		<div class="editor-box" style="text-decoration: underline;" onclick="sc('underline')">U</div>
		<div class="editor-box" style="text-decoration: underline;" onclick="sc('hiliteColor',false,'red')">BC</div>
		<div class="editor-box" style="text-decoration: line-through;" onclick="sc('strikeThrough')">S</div>
	</div> 
	<div id = "contentEditor" draggable="true" style="display: none;">
		<div id = "files">  
			<img  draggable="false" class="pageimg" width="24px" src = "resources/tag/plus2.png">
		</div> 
		<div id = "contentDrag" style="cursor: grab;">
			<img draggable="false" class="pageimg" width="23px" src = "resources/tag/dot.png">
		</div>
	</div>
	<div id = "border" style="display: none;"></div>
	<div align="right" id = "pictureEditor" style="display: none;">
		<div style=" margin-right: 3%; margin-top: 2%;">
			<div><span style=" background-color: black; border-radius: 6px;  padding-right: 4px; padding-left: 4px; border: 1px solid white;"><img width="15" class="pageimg" src="resources/tag/three.png" style="filter:invert(100%);"></span></div>
			<div draggable="true"></div>
		</div>
	</div>
	<div id = "pageSetting" draggable="false" style="display: none">
		<div class="pageEditorCd"> 
			<div style="margin-right: 3%;">
				<img class = "pageimg" width="17px;" src="resources/tag/delete.png">
			</div>
			<div>
				삭제
			</div> 
		</div>
	</div>
	<div id = "pictureSetting" draggable="false" style="display: none">
		<div class="pageEditorCd"> 
			<div style="margin-right: 3%;">
				<img class = "pageimg" width="17px;" src="resources/tag/delete.png">
			</div>
			<div>
				삭제
			</div>
		</div>
		<div class="pageEditorCd"> 
			<div style="margin-right: 3%;">
				<img class = "pageimg" width="17px;" src="resources/tag/Recycle.png">
			</div>
			<div>
				변경
			</div> 
		</div>
	</div>
</div>