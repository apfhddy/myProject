<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<html>
<head>
<style type="text/css">
/* 	div:empty:before {
   		content: attr(placeholder);
	} */
	body{
		width:100%; 
		height:100%; 
		margin:0; 
		padding:0; 
		overflow-y:scroll; 
		position:relative;
	}
	html {width:100%; height:100%; margin:0; padding:0; overflow:hidden;} /* 기본 스크롤 제거 */
	.codeConsole{
		position: absolute;
		bottom: 0;
		right: 0; 
		margin: 2%;
		border: 1px solid gray;
		border-radius: 6px;
		padding-bottom: 1%; 
		box-shadow: 1px 1px gray;
		width: 24%;
		background-color: white;
		height: 200;
		overflow-y: scroll;
	}
	.codeConsole > .header{
		margin-bottom: 5%; 
		background-color: blue;
		color: white;  
	}
	.codeConsole > .content{
		width: 90%;
		
	}
	#editor{
		  position: absolute;
          top: 0; 
          left: 0;
          width: 450px;
          height: 25px;
          background-color: white;
          transform: translate(-50%, -50%);
          display: flex;
          box-shadow: 1px 1px gray;
          border-radius: 6px;
          z-index: 99;
	}
	#contentEditor{
  		position: absolute;
        top: 0; 
        left: 21%;  
        font-size: 13px; 
		color: gray;
		display: flex;
	}
	#pageSetting{
  		position: absolute;
        top: 0; 
        left: 0;
        background-color: white;
        z-index: 1;
        width: 11%; 
        border: 1px solid #E2E2E1; 
        padding: 4px;
        border-radius: 4px;
	}
	#pictureSetting{
  		position: absolute;
        top: 0; 
        left: 0;
        background-color: white;
        z-index: 1;
        width: 11%; 
        border: 1px solid #E2E2E1; 
        padding: 4px;
        border-radius: 4px;
	}
	.pageEditorCd{
		border-radius: 4px;
		display: flex;
		padding-left: 4px;
		padding-top: 4px;
	}
	.pageEditorCd:hover{
		background-color: #D4D4D3;
	}
	#pictureEditor{
  		position: absolute;
        top: 0; 
        left: 0;
	}
 	#pictureEditor > div > div:nth-child(1){
		margin-bottom: 4px;
	}
	#pictureEditor > div > div:nth-child(2){
		cursor: e-resize; 
		width: 6px; 
		border-radius: 30px; 
		background-color: black; 
		height: 60%;
		border: 1px solid white;
	} 
	.editor-box{
		padding-top: 3px;
		padding-left: 10px;
		padding-right: 10px;
		border-right: 1pt solid #E2E2E1;
		text-align: center;
		margin: 0;
		font-size: 14px;
		cursor: pointer;
	}
	
	#side-box{
		position: fixed;
		height: 100%;
		width: 17%;
		background-color: #FBFBFA;
	}
	
	#side-box > .side-header{
		padding-top: 4px;
		padding-bottom: 4px;
		padding-left: 8px;
	}
	#side-box > .side-pages{
		margin-top: 10px;
		color: gray;
		padding-left: 10px;
		padding-right: 10px;
	}
	.pageimg{
		filter: opacity(0.5) drop-shadow(0 0 0 white);
	} 
	
	.pagesCd{
		padding-top: 0.5%;
		padding-bottom: 0.5%;
		margin-top: 2px;
		margin-bottom: 2px;
		padding-left: 10px;
		border-radius: 6px;
		cursor: pointer; 
	}
	.pagesCd > div{
		display: flex;
	}
	.pagesCd > div > div:nth-child(1){}
	.pagesCd > div > div:nth-child(2){}
	.pagesCd > div > div:nth-child(3){
		width: 60%;
		overflow: hidden;
 		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.pagesCd > div > div:nth-child(4){
		margin-left: auto;
	}
	.pagesCd > div > div:nth-child(5){
		margin-right: 1%;
		padding-left: 7px;
		padding-rigth: 7px;
	}
	#pgps > div{
		display: flex;
   	 	align-items: center;
   	 	padding-left: 6px;
   	 	padding-right: 6px;	
	}
	
	#main{
		margin-left: 17%;
		padding: 10px;  
		width: 70%;
	}
	
	#main > .header{
		margin-bottom: 140px;
		display: flex;
	}
	
	
	#main > .data > .title{
		margin-bottom: 4%;
		margin-left: 9%;
	}
	#main > .data > .title > input{
		border: 0; 
		outline: 0; 
		font-size: 40px; 
		font-weight: bold;
		width: 100%;
	}
	#border{
		border: 2px solid #A0CAF2; 
		position: absolute; 
		top: 0;
		left: 0;
		z-index: 1;
	}
	.content{
			
		width: 63.5%; 
	}
	.page{
		width: 15.8%;		
	} 
	#content{
		outline: 0;
		margin-bottom: 10%;
		margin-left: 4%;
	}
	#content > div{
		margin-left: 5%;
		margin-top: 2px;
		margin-bottom: 2px;
	}
	.pagesCd-div{
		display: flex;
   	 	align-items: center;
   	 	padding-left: 4px;
   	 	padding-right: 4px;	
   	 	border-radius: 6px;
	}
	
	.none{
		padding-left: 13px;
		color: gray;
	}
	
	.choice{
		background-color: #EFEFEF;
		font-weight: bold;
		color: black;
	}
	
	::selection{
		background-color: #c1dbf6;
		opacity: 0.5;
	}
	.noSelection{
		-ms-user-select: none; 
		-moz-user-select: -moz-none;
		-khtml-user-select: none;
		-webkit-user-select: none;
		user-select: none;
 	}
</style>
	<title>Home</title>
</head>
<body>
<!-- 에디터 및 설정 박스 -->
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
<!-- /에디터 및 설정 박스 -->
<div id = "side-box" class="noSelection">
	<div class = "side-header">정희락 노션</div>
	<div class = "side-pages">
	<div id = "page" draggable="false"> 
		<c:if test="${fn:length(list) != 0 }">
			<c:forEach var="page" items="${list }">
				<div>
					<div class="pagesCd" id = "${page.page_no }">
						<div>
							<div class="pagesCd-div">
								<img width="13" class="pageimg" src = "resources/tag/left.png">
							</div>
							<div class="pagesCd-div">
								<img width="15" class="pageimg" src = "resources/tag/document.png">
							</div>
							<div class="pagesCd-div">
								${page.title != null ? page.title : '제목 없음'  }
							</div>
							<div class="pagesCd-div" style="display: none">
								<img width="15" class="pageimg" src="resources/tag/three.png">
							</div> 
							<div class="pagesCd-div" style="display: none">
								<img width="10" class="pageimg" src="resources/tag/pluss.png">
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
		<div id = "pgps" class="pagesCd"><div><img width="10" class="pageimg" src = "resources/tag/pluss.png"><div style="margin-left: 2%;">페이지 추가</div></div></div>
	</div>
</div> 
<div id = "main">
	<div class = "header">
		<div class = "title">
			
		</div>
	</div>
	<div class = "data">
		<div class = "title">
			<input id = "sb" placeholder="제목 없음" maxlength="1000" onkeydown="test(this)" spellcheck = "false">
		</div>
		<div draggable="false" id = "content" spellcheck="false" contentEditable="true">
			<!-- <div>
				<div><input type = "text" name = "variable"></div>
			</div>	
			<div>
				<input type = "text" name = "variable">
			</div>	 -->
			<div><br></div>
			<div>
				<div><textarea id = "cs"cols="40" rows="5" style="font-size: 20;font-weight: bold;"></textarea><input type= "button" value = "실행" onclick="codeRun(this)"></div>
			</div>
		</div>
	</div>
</div>
<script src="resources/js/content.js?ver=1312222"></script>
<script src="resources/js/pictureEditor.js?ver=22221213"></script>
<script src="resources/js/contentEditor.js?ver=2112221"></script>
<script type="text/javascript">
	let sock = new SockJS("http://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/echo");
	function sendMessage() {
	    sock.send($("#message").val());
	    $('#message').val('')
	}
	
	function on() {
		sendMessage();			
	}
	
	
	
	
	sock.onmessage = function(e){
		$("#chat").append(e.data + "<br/>");
	}
	
	sock.onclose = function(){
		$("#chat").append("연결 종료");
	}
		
	
	
	let targetpg = null; //플러스 설정 버튼을 설정한 마지막 dom을 가져오기 위한 변수
	let now = null; //페이지 리스트에 내페이지가 없으면 null
	let file = document.querySelector('input[type = "file"]');
	let pno = 0;//얘는 페이지리스트에 있든없는 값이 있어야함
	
	let pgb = Array.from(page.querySelectorAll(' .pagesCd')); //그냥 페이지와 곂치는 이벤트 갈르려고
	let pg = Array.from(document.querySelectorAll(' .pagesCd'));
	pageCk(pgb);
	pageHover(pg);
	
	
	let	Cnpgig = document.querySelectorAll(".pageimg"); // 다른 이미지들 드래그를 막기위한
	Cnpgig.forEach( i => {
		setting(i);
	}) 
	
	
	
	function setting(pg) {//여기서 이미지 드래그 막음
		pg.addEventListener("dragstart", function(e) {
			e.preventDefault();
		});
	} 
	
	
	function pageHover(pg) {//이런식인건 자동으로 이벤트 추가할려는것
		if(Array.isArray(pg)){
			pg.forEach( ar => {
				pageH(ar); 
			})
		}else{
			pageH(pg);
		}
	}
	function pageH(pg) {
		pg.addEventListener("mouseenter", function(e) {
			if(!pageE && !start)
				pg.style.backgroundColor = '#EFEFEF';
		});
		pg.addEventListener("mouseleave", function(e) {
			pg.style.backgroundColor = '';
		});
	}
	function pageCk(pgb) {//이런식인건 자동으로 이벤트 추가할려는것
		if(Array.isArray(pgb)){
			pgb.forEach( ar => {
				pageEt(ar);
			})
		}else{
			pageEt(pgb);
		}
	}
	
	function noneChild() {
		let newDiv = document.createElement('div');
		newDiv.className = "none"
		newDiv.innerText = '하위 페이지 없음';
		return newDiv;
	}
	
	pageSetting.children[0].addEventListener("click", function(e) { // 페이지 삭제
		let delno = targetpg.children[0].id;
		$.ajax({
			url:"${pageContext.request.contextPath}/deletePage",
			data:{k:delno},
			type:"POST",
			success: function (no) {
				let parent = targetpg.parentElement;
				targetpg.parentElement.removeChild(targetpg);
				cleanOrder(parent);
				if(Array.from(parent.children).length == 0 && parent.id != 'page'){
					parent.appendChild(noneChild());
				}
				if(no == now.id){
					content.removeChild(parentFind(document.getElementById(delno),content));
				}
				pageSetting.style.display = 'none'
			}
		})
	})
	
	
	
	function test(t) { // 제목 이벤트
		if(now != null)
			setTimeout(function() {//keydown은 반응이 너무 빨라서 입력한 키가 씹힌다. setTimout으로 반응을 좀 늦춘것
				let value = t.value;
				now.children[0].children[2].innerText = value != "" ? value : "제목 없음";				
			}, 20)
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	let pageE = false;
	
	function leftORbottom(div) { // false 면 안 펼쳐진거 true면 펼쳐진거
		let what = div.children[0].src;
		let start = what.lastIndexOf('/')+1; 
		let end = what.lastIndexOf('.')-start; 
		what = what.substr(start,end);
		return what != 'left';
	}
	
	
	function pageEt(pgb) {//버튼들 에게 이벤트 거기 것
		let chVb = pgb.children[0]; 
		for(let i = 0; i < chVb.children.length; i++){ //자식 버튼들한태 이벤트
			if(i == 2)continue;
			else{
				chVb.children[i].addEventListener("mouseenter", function(e) {
					if(!pageE)
						this.style.backgroundColor = '#D4D4D3';
				})
				chVb.children[i].addEventListener("mouseleave", function(e) {
					this.style.backgroundColor = ''	;				
				})
			}
		} 
		
		pgb.parentElement.addEventListener("mouseenter", function(e) {
			targetpg = this; // 그한행을 타켓으로 지정
		})
		pgb.addEventListener("mouseenter", function(e) {
			this.children[0].children[3].style.display = '';
			this.children[0].children[4].style.display = '';
		})
		pgb.addEventListener("mouseleave", function(e) {
			this.children[0].children[3].style.display = 'none';
			this.children[0].children[4].style.display = 'none';
		})
		
		pgb.addEventListener("mousedown", function(e1) {
			let target = this.parentElement; //수정을 할 타켓
			let newDiv = null;//드래그 이미지라 생각
			let what = 0;//1,3이면 위아래 2번은 가운데
			let last = null;//마지막 타겟
			function pageDragEvent(e){//마우스 움직이는 이벤트
				if(newDiv == null){
					pageE = true;
					newDiv = dragClone(target)
					document.body.appendChild(newDiv);
					border.className = "page";
					newDiv.style.width = "16%";
				}
				newDiv.style.top = e.y - e1.y + target.getBoundingClientRect().y + document.body.scrollTop;
				newDiv.style.left = e.x - e1.x + target.getBoundingClientRect().x;
				
				if(last != null)
					last.style.backgroundColor = '';
				last = targetpg;
				last = last.parentElement.id != "page" && e.target.id != "border" && !last.contains(e.target) ? last.parentElement.parentElement : last
							 
				if(target == last)return;
				border.style.display = '';
				
				
				let data = last.getBoundingClientRect();
				border.style.left = e.x;
				let parentTop = data.top;
				let parentBot = data.bottom;
				
				let top = e.y - parentTop;
				let bottom = -(e.y - parentBot);
				if( top > 8 && bottom > 8){
					what = 2;
					border.style.display = 'none';
					last.style.backgroundColor = '#DDEAF7';
				}else{
					last.style.backgroundColor = '';
					borderWhat = top   < bottom;
					border.style.left = data.x;
					if(borderWhat){
						what = 1;
						border.style.top = parentTop +document.body.scrollTop -2;
					}else{
						border.style.top = parentBot +document.body.scrollTop;	
						what = 3;
					}
				}
				
			}
			function pageDragDel(e) {
				pageE = false;
				if(newDiv != null){
					document.body.removeChild(newDiv);
					last.style.backgroundColor = '';
					border.style.display = 'none';
					border.className = '';
					if(target != last){
						let no = target.children[0].id
						let parentDiv = last.parentElement.parentElement.parentElement;
						let targetDiv = target.parentElement;
						parentDiv = last.children[1]; 
						
						switch (what) {//html로 보여야할것
						case 1:
							last.insertAdjacentElement('beforebegin' , target);							
							break;
						case 2:
							if(leftORbottom(last.children[0].children[0].children[0])){//접혀있는지 펴져있는지
								parentDiv = last.children[1];
								if(parentDiv.children[0].className == "none"){
									parentDiv.innerHTML = '';
								}
								parentDiv.appendChild(target);
							}else{
								target.parentElement.removeChild(target);
							}
							break;
						case 3:
							last.insertAdjacentElement('afterend' , target);							
							break;
						}
						
						let append = 0;
						
						/* if(what != 2 && target.parentElement.id == 'page'){// 데이터베이스로 수정해야 할것
							parent = 0;
						}else{//자식페이지로 들어갈때
							if(parentDiv != null){
								if(parentDiv != targetDiv)
									cleanOrder(parentDiv);								
							}else{
								parent = last.children[0].id;
								append = 1;
							}
						}
						cleanOrder(target.parentElement == null ? targetDiv : target.parentElement);
						if(targetDiv.id != "page" && targetDiv.children.length == 0){
							targetDiv.appendChild(noneChild())
						} 
						 $.ajax({
							url:"updateParent",
							data:{k:no,kk:parent,append:append},
							type:"post"	
						})  */
					}
				}
				document.removeEventListener("mousemove", pageDragEvent);
				document.removeEventListener("mouseup",pageDragDel);
			}
			document.addEventListener("mousemove", pageDragEvent); //자리 바꾸는 이벤트
			document.addEventListener("mouseup",pageDragDel);
		})	
		
		let pe = pgb.children[0];
		//아래화살표
		pe.children[0].addEventListener("click", function(e) {
			if(leftORbottom(this)){
				let parent = this.parentElement.parentElement.parentElement;
				parent.removeChild(parent.children[1]);
				this.children[0].src = "resources/tag/left.png";
			}else{
				this.children[0].src = "resources/tag/bottom.png";
				let target = this.parentElement.parentElement
				let no =  target.id;
				$.ajax({
					url:"${pageContext.request.contextPath}/getList",
					type:"POST",
					data:{k:no},
					success: function sc(s) {
						let childDiv = document.createElement('div');
						childDiv.style.paddingLeft = '22px';
						if(s.length == 0){
							childDiv.appendChild(noneChild());
						}else{
							let list = s;
							list.forEach(l => {
								let newDiv = createPage(l.page_no, l.title)
								childDiv.appendChild(newDiv);
							})
						}
						target.parentElement.insertAdjacentElement('beforeEnd',childDiv);
					}
				})
			}
		});
		// /아래화살표
		// 제목
		pe.children[2].addEventListener("click", function(e) {
			let target = this.parentElement.parentElement;
			no = target.id;
			open(no);
		})
		// /제목
		// 설정
		pe.children[3].addEventListener("click", function (e) {
			if(pageSetting.style.display =='none'){
				function pageEditorCk(e){
					if(!pageSetting.contains(e.target)){
						pageSetting.style.display ='none'
						document.removeEventListener("mouseup",pageEditorCk);
					}
				}
				
				document.addEventListener("mouseup",pageEditorCk);
			}
			
			pageSetting.style.left = e.x;
			pageSetting.style.top = e.y;
			pageSetting.style.display = '';
			
			 
		})
		// /설정
		//plus버튼
		pe.children[4].addEventListener("click", function(e) {
			let parent = this.parentElement.parentElement;
			let no = parent.id
			let child0 = this.parentElement.children[0];
			pagePlus(no,child0)
		})
	}
	
	
	
	function open(no){
		if(now == null || no != pno){ // 현재 페이지와 다르냐?
			content.innerHTML = '';
			target = document.getElementById(no);
			if(target != null){
				target.classList.add('choice')			
			}
			if(now != null)
				now.classList.remove('choice');
			now = target;
			pno = no;
			$.ajax({
				url:"${pageContext.request.contextPath}/getPage",
				data:{k:no},
				type:"POST",
				context: this,
				success: function(map) {
					let child = map['child'];
					let data = map['data'];
					content.innerHTML = data.DATA
					let vb = Array.from(content.querySelectorAll('#content > div'));
					let ib = Array.from(content.querySelectorAll('#content > div > img'));
					let cb = content.querySelectorAll('.pagesCd');
					Array.from(cb).forEach(c => {
						c.children[1].innerText = child[c.id] == null ? "제목 없음" : child[c.id];
						pageHover(c);
						c.addEventListener("click", () => {
							open(c.id);
						})
					})
					imgCk(ib);
					sb.value = data.TITLE == undefined ? '' : data.TITLE; 
					nowSelection.removeAllRanges();
				}
			})				
		}
	} 
	
	
	
	
	
	
	
	
	

	
	
	function savePage() {//페이지를 저장하기 위한
		let data = content.cloneNode(true);// true면 자식 노드도 복제
		let setting = Array.from(data.querySelectorAll('.pagesCd'));
		setting.forEach(pg => {
			pg.children[1].innerText = '';
			pg.style.backgroundColor = '';
		}) 
		let header = sb.value;
		$.ajax({
			url:"${pageContext.request.contextPath}/savePage",
			data:{k:data.innerHTML,kk:header,kkk:pno},
			type:"POST"
		})
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
  	
  	
	document.addEventListener("keydown", function(e) { //키 이벤트 변조
		let code = e.keyCode;
		
		/* if(code == 123){
			e.preventDefault();
		} */ 
		if(e.ctrlKey && code === 83){// cnt s 저장
			e.preventDefault();
			savePage();
		}
		if(content.contains(e.target)){
			if(e.code == "Backspace"){//지우기
				let target = parentFind(nowSelection.anchorNode);
				let block = false;
				 
			/* 	if(target.innerText.length == 1){//placeholder 기능 지월때 자동으로 br태그가 생기는걸 막는법이다
					target.setAttribute("placeholder", "시발");
					target.innerHTML = '';
					e.preventDefault();
				} */
				
				if(content.children[0] != target && target.innerText.length == 1){
					let before = content.children[Array.from(content.children).indexOf(target)-1] 
					if(before.children.length != 0)
						if(before.children[0].nodeName == "IMG" || before.children[0].nodeName == "DIV")
							block = true;							
				}
				
				if(!block && content.children[0] != target && targetDv != null && targetDv.innerText == "\n"){
					contentEditor.style.display = 'none';		
				} 
				if(block || content.children[0] == target &&  content.children[0].innerText.length == 1){
					e.preventDefault();
					if(block == false){
						content.children[0].innerHTML = '<br>';						
					}else{
						target.innerHTML = "<br>";
					}
				}
			}
			if(code == 9 ){//탭
				e.preventDefault();
					let nbspNode = document.createTextNode("\u2003\u2003");
				if(e.target.nodeName == "TEXTAREA" || e.target.nodeName == "INPUT"){
					   let textarea = cs;
					   let start = textarea.selectionStart;
					   let end = textarea.selectionEnd;

					   let tabCharacter = '    ';
					   let textToInsert = tabCharacter;

					   let textBefore = textarea.value.substring(0, start);
					   let textAfter = textarea.value.substring(end);
				       textarea.value = textBefore + textToInsert + textAfter;

				       textarea.selectionStart = start + textToInsert.length;
				       textarea.selectionEnd = start + textToInsert.length;
				}else{
					nowSelection.getRangeAt(0).insertNode(nbspNode)
					nowSelection.getRangeAt(0).setStartAfter(nbspNode)
					nowSelection.getRangeAt(0).setEndAfter(nbspNode)
				}
			}
		}
	})
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	function parentFind(node,parent) { // 최상위 div를 찾는 함수
		if(parent != null){
			while (true) {
				if(node.nodeType == 1 && node.nodeName == "DIV" && Array.from(parent.children).indexOf(node) != -1)//텍스트 노드를 거르기 위한
					break;
				node = node.parentElement;
			}			
		}else{
	  		while (true) {
				if(node.nodeType == 1 && node.nodeName == "DIV")//텍스트 노드를 거르기 위한
					break;
				node = node.parentElement;
			}
		}
		return node;
	}
	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	function addImg(){
  		file.click();
  		
  		function add(){
  			
  			function callback(s) {
  				let newDiv = document.createElement('div');
				newDiv.setAttribute("contentEditable", false)
				let newImg = document.createElement('img');
				newImg.style.border =  '1px solid #E2E2E1 ';
				newImg.style.borderRadius = '4px';
				imgCk(newImg);
				newImg.setAttribute("src", s);
				newDiv.appendChild(newImg)
				content.appendChild(newDiv); 
			}
  			
  			image(file.files[0],callback,add);
  		}
  		
  		file.addEventListener("change",add)
  	}
  	
  	
  	
	function image(value,callbackF,removeF) {
		let data = new FormData();
		data.append('file', value);
		let extendedName = value.name.substr(value.name.lastIndexOf('.')+1);
		if(extendedName == 'jpg' || extendedName == 'png' || extendedName == 'gif'){
			$.ajax({
				url:"${pageContext.request.contextPath}/fileupload",
				type:"POST",
				contentType:false, // 파일을 넘길때는 false   비동기 파일을 넘길때는 두가지가 필수
				processData:false, //  폼 데이터를 &변수=값&변수=값... 형식으로 변경되는 것을 막음
				data:data,
				success: function (s) {
					callbackF(s);
					file.removeEventListener("change",removeF);
					
					
					file.value = null;
				}
			})
 		}else{
 			alert("사진형식이 아닙니다"); 	
 		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	pgps.addEventListener("click", function(e) {//메인 페이지를 만들기위한
		pagePlus(0);
	})
	
	
	
	function pagePlus(no,child) {
		savePage();
 		
  		$.ajax({
 			url:"${pageContext.request.contextPath}/addPage",
 			data:{k:no},
 			type:"POST",
 			success: function sc(s) {
 				let newDiv = createPage(s, null);
 				
		 		if(no == 0){
					page.appendChild(newDiv);
			 		newDiv.children[0].children[0].children[2].click();
		 		}else{
 					if(!leftORbottom(child)){
 						child.click();
 						setTimeout(() => {
 							console.log(document.getElementById(s));
							document.getElementById(s).children[0].children[2].click();
						}, 200); 
 					}else{
 						let childbox = child.parentElement.parentElement.parentElement.children[1];
 						if(Array.from(childbox.children).length == 1 && childbox.children[0].className == 'none')
 							childbox.removeChild(childbox.children[0]);
 						childbox.appendChild(newDiv);
				 		newDiv.children[0].children[0].children[2].click();
 					}
 				}
						
			}
  		})
	}		 
	
	
	
	
	
	
	function codeRun(t) {
		let code = t.parentElement.children[0].value;
		let variable = Array.from(content.querySelectorAll("input[name='variable']"));
		let arr = [];
		variable.forEach( f => {
			arr.push(f.value);
		})
		$.ajax({
			url:"${pageContext.request.contextPath}/codeRuntime",
			data:{JSONarr:(arr.length != 0 ? JSON.stringify(arr) : "") ,code : code},
			type:"POST",
			success: function sc(s) {
				if(s != ""){
					let newDiv = document.createElement("div");
					newDiv.setAttribute("class","codeConsole");
					newDiv.innerHTML = '<div class = "header" align="left">[Response]</div> <div class = "content"></div>';
					newDiv.children[1].innerHTML = '<font style = "color: '+(s['err'] ? 'red' : 'green')+'">'+s['content']+'</font>'
					document.body.appendChild(newDiv);
					console.log(s['content']);
					setTimeout(function() {
						document.body.removeChild(newDiv);
					},10000);
				}
			}
		}) 
	}
	
	
	
	function cleanOrder(targetParent){
		let arr = Array.from(targetParent.children);
		//console.log(arr);
		passArr = [];
		arr.forEach( d => {
			passArr.push(d.children[0].id)
		})
	 	if(passArr.length != 0){
			$.ajax({
				url:"updateOrder",
				data:{data:JSON.stringify(passArr)},
				type:"post"
			})
		} 
	}
	
	
	
	
	function dragClone(DOM){
		let newDiv = document.createElement('div');
		newDiv.style.position = 'absolute';
		newDiv.style.pointerEvents = 'none';
		newDiv.style.opacity = '0.7';
		newDiv.innerHTML = DOM.innerHTML;
		return newDiv;
	}
	
	
	
  	function createPage(no,title) { //페이지 생성하는 
  			title = title == null ? "제목 없음" : title; 
			
	 		
	 		
			let mainDiv = document.createElement('div');
			let newDiv1 = document.createElement('div');
			let newDiv2 = document.createElement('div');
			
			let newSp1 = document.createElement('div'); 
			let newSp2 = document.createElement('div'); 
			let newSp3 = document.createElement('div'); 
			let newSp4 = document.createElement('div'); 
			let newSp5 = document.createElement('div');
			
			newSp1.className = "pagesCd-div";
			newSp2.className = "pagesCd-div";
			newSp3.className = "pagesCd-div"; 
			newSp4.className = "pagesCd-div";
			newSp5.className = "pagesCd-div";
			
			let newig1 = document.createElement('img');
			let newig2 = document.createElement('img');
			let newig3 = document.createElement('img');
			let newig4 = document.createElement('img');

			newDiv1.setAttribute("class","pagesCd");
			newDiv1.setAttribute("id",no);
			
			newig1.setAttribute("width", 13);
			newig1.setAttribute('class',"pageimg");
			newig1.setAttribute('src',"resources/tag/left.png");
			newSp1.appendChild(newig1);
			
			newig2.setAttribute("width", 15);
			newig2.setAttribute('class',"pageimg");
			newig2.setAttribute('src',"resources/tag/file.png");
			newSp2.appendChild(newig2);
			
			newSp3.innerText = title;
			
			newig3.setAttribute("width", 15);
			newig3.setAttribute('class',"pageimg");
			newig3.setAttribute('src',"resources/tag/three.png");
			
			newig4.setAttribute("width", 10);
			newig4.setAttribute('class',"pageimg");
			newig4.setAttribute('src',"resources/tag/pluss.png");
			
			newSp4.style.display = "none";
			newSp4.appendChild(newig3);
			
			newSp5.appendChild(newig4);
			newSp5.style.display = "none";
			
			newDiv2.appendChild(newSp1);
			newDiv2.appendChild(newSp2);
			newDiv2.appendChild(newSp3);
			newDiv2.appendChild(newSp4);
			newDiv2.appendChild(newSp5);
			
			newDiv1.appendChild(newDiv2);
			
			mainDiv.appendChild(newDiv1)
			pageHover(newDiv1)
			pageCk(newDiv1);
			let patch =  newDiv1.querySelectorAll('.pageimg');
			patch.forEach( i => {
				setting(i)
			})
			
			
			return mainDiv;
			
		}
  		
	//처음 접속하면 바로 상위 메모장 여는 명령어
	//if(page.children[0] != null)
		//page.children[0].children[0].children[0].children[2].click();   
  	
	
</script> 
</body>
</body>
</html>

 	