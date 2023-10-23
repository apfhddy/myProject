let start = false;
let targetDv = null;





content.addEventListener("dragstart", function(e) {//글자 드래그 막기
	event.preventDefault();
});


contentEditor.children[0].addEventListener("mousedown", function (e) {
	addImg();
})

contentEditor.children[1].addEventListener("mousedown" , function (e) {
	let borderWhat = false;
	let body = document.querySelector('body')
	let newDiv = dragClone(targetDv) 
	newDiv.style.top = e.y+document.body.scrollTop;
	newDiv.style.left = e.x;
	
	targetDv.style.backgroundColor = '#c1dbf6';
	targetDv.style.borderRadius = '6px';
	
	contentEditor.style.display = 'none';
	
	body.style.cursor = 'grabbing';
	body.appendChild(newDiv);
	
	
	
	start = true;
	let lastDv = targetDv;
	
	function contentEt(e){
		border.className = 'content';
		border.style.display = '';
		newDiv.style.top = e.y+document.body.scrollTop;//따라오느 이미지
		newDiv.style.left = e.x;
		if(!content.contains(e.target))return;
		
		let data = targetDv.getBoundingClientRect();
		let parentTop = data.top;
		let parentBot = data.bottom;
		
		
		borderWhat = e.y - parentTop   < -(e.y - parentBot); // true면 위 아니면 아래
		border.style.left = data.x;
		if(borderWhat){
			border.style.top = parentTop +document.body.scrollTop -2;
		}else{
			border.style.top = parentBot +document.body.scrollTop;			
		}
		
	}
	
	function contentDel(){
		contentEditor.style.left = '';
		
		if(lastDv != targetDv){
			targetDv.insertAdjacentElement(borderWhat ? 'beforebegin':'afterend' , lastDv)
		}
		start = false
		contentEditor.style.display = "";
		border.className = '';
		border.style.display = 'none';
		
		document.removeEventListener("mousemove",contentEt);
		document.removeEventListener("mouseup", contentDel);
		body.removeChild(newDiv);
		body.style.cursor = '';
		lastDv.style.backgroundColor = '';
		lastDv.style.borderRadius = '';
	}
	
	
	document.addEventListener("mousemove",contentEt);
	document.addEventListener("mouseup", contentDel);
	
	
	
	
})

contentEditor.addEventListener("dragstart", (e) => {//이미지 드래그 막기
	e.preventDefault();
});


contentEditor.addEventListener("mouseenter", (e) => {
		contentEditor.style.display = "";
});

content.addEventListener("mouseleave", function(e) {
	contentEditor.style.display = "none";	
});

content.addEventListener("mousemove", function(e) {
	let contentArr = Array.from(content.children);
	
	contentArr.forEach( cc => {
		let data = cc.getBoundingClientRect();
		if(data.top < e.y && data.bottom > e.y){
			targetDv = cc;
			contentEditor.style.top = (targetDv.getBoundingClientRect().y+document.body.scrollTop);
			if(!start){
				contentEditor.style.display = '';		
			}
		return;
		}
	})
	
	
	/*if(!start){
		let parent = parentFind(e.target,content);
		targetDv = parent;
		contentEditor.style.top = (parent.getBoundingClientRect().y+document.body.scrollTop);
		if(!start){
			contentEditor.style.display = '';		
		}
	}*/
});






























//content.addEventListener("keydown", function(e) {
//	let code = e.keyCode;
//	if(code == 13){
//		e.preventDefault();
//		let newDiv = document.createElement('div');
//		let parent = parentFind(nowSelection.anchorNode);
//		let newBr = document.createElement('br');
//		newDiv.appendChild(newBr);
//		contentEt(newDiv);
//		parent.insertAdjacentElement('afterend',newDiv)
//		
//		nowSelection.removeAllRanges();
//		let range = new Range();
//		range.setStart(newDiv, 0);
//		range.setEnd(newDiv, 0);
//		nowSelection.addRange(range);
//	} 
//})

/*function contentEt(vb) {//drag박스 만드는 이벤트
	vb.addEventListener("mouseenter", function(e) {
		if(!start){
			targetDv = this;
			contentEditor.style.top = (e.target.getBoundingClientRect().y+document.body.scrollTop+3);
			if(!start){
				contentEditor.style.display = '';		
			}
		}
	})
}



function contentCk(vb) {
	if(Array.isArray(vb)){
		vb.forEach( ar => {
			contentEt(ar);
		})
	}else{
		contentEt(vb);
	}
}*/