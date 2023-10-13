let nowSelection = window.getSelection();



content.addEventListener('mousedown',function(e){
	let pointer = e;
	
	function contentEt(e){
		setTimeout(function() {
	        if(nowSelection.toString().length != 0){
	        	if(editor.style.display == "none"){
			        const range = nowSelection.getRangeAt(0); // 선택된 텍스트 범위 가져오기
			        const startNode = range.startContainer; // 선택된 텍스트의 시작 노드
			        const endNode = range.endContainer; // 선택된 텍스트의 끝 노드
			        const startOffset = range.startOffset; // 시작 노드에서의 시작 오프셋
			        const endOffset = range.endOffset; // 끝 노드에서의 끝 오프셋
			        
			        // 시작 위치와 끝 위치의 좌표 구하기
			        const startRect = range.getClientRects()[0]; // 선택된 텍스트의 첫 번째 사각 영역
			        const endRect = range.getClientRects()[range.getClientRects().length - 1]; // 선택된 텍스트의 마지막 사각 영역
			
			        const startX = startRect.left; // 시작 위치의 X 좌표
			        const startY = startRect.top; // 시작 위치의 Y 좌표
			        const endX = endRect.right; // 끝 위치의 X 좌표
			        const endY = endRect.bottom; // 끝 위치의 Y 좌표
					
					let what = startY < endY;
					
					let y = what ? startY : endY;
					let x = what ? startX : startY;
					
			        const mouseX = x +200;
			        const mouseY = y+document.body.scrollTop - 30 ;
			        editor.style.left = mouseX+'px';
			        editor.style.top = mouseY+ 'px'; // y구하기
					editor.style.display = "flex";
	        	}
	        }else{
	        	if(!editor.contains(e.target)){
			        editor.style.display = "none";
			        document.removeEventListener('mouseup', contentEt);  
	        	}
	        }
		})
	}
	
	document.addEventListener('mouseup', contentEt);
})




editor.addEventListener("mousedown", (event) => {
        event.preventDefault();
        event.stopPropagation();
});

function sc(fc,tf,vb) {
	tf == undefined ? false : true;
	vb == undefined ? null : vb;
	document.execCommand(fc,tf,vb);
} 





function fontC(e) {
	let tag = e.target;
	while(true){
		if(tag.nodeName == "A")break;
		tag = tag.firstChild;
	}
	
	let fontcolor = tag.style.color;
	
	sc('foreColor',false,fontcolor);
} 


contentEditor.addEventListener("mouseup", (event) => {
   		event.preventDefault();
   		event.stopPropagation();
});