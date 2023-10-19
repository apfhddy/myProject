let targetIg = null;
let picttf = false;
	
pictureEditor.addEventListener("mouseover", function(e) { //얘가 마우스 위로 올라가면 사라짐 방지
	contentEditor.style.display = '';
	pictureEditor.style.display = '';
}) 
pictureEditor.addEventListener("mouseleave", function(e) { //얘가 마우스 위로 올라가면 사라짐 방지
	if(!picttf)
		contentEditor.style.display = 'none';
		pictureEditor.style.display = 'none';
})
pictureEditor.children[0].children[0].children[0].addEventListener("click",function(e) {//이벤트 순서에 따른
	pictureSetting.style.display = '';
	pictureSetting.style.left = e.x;
	pictureSetting.style.top = e.y+document.body.scrollTop;
	
	function pictureSettingEt(e){
		if(!pictureSetting.contains(e.target)){
			pictureSetting.style.display = 'none';
			document.removeEventListener("mouseup",pictureSettingEt);
		}
	}
	
	
	document.addEventListener("mouseup", pictureSettingEt);
	
})

pictureSetting.children[0].addEventListener("click",(e) => {
	content.removeChild(targetIg.parentElement);
})
pictureSetting.children[1].addEventListener("click",(e) => {
	file.click();
	
	function change(){
  			
  			function callback(s) {
				targetIg.src = s;
			}
  			
  			image(file.files[0],callback,change);
  		}
  		
  		file.addEventListener("change",change);
})


pictureEditor.children[0].children[1].addEventListener("mousedown", function(e) {
	picttf = true;	
	let wd =  targetIg.getBoundingClientRect().width;
    let etex = e.x;
	
	
	function pictureEt(e){
		e.preventDefault();
		let myx = e.x;
		let tf = myx > etex;
		let test = tf ? wd+3 : wd-3;
		etex = myx;
		let img = targetIg.getBoundingClientRect();
		
		if(img.height < 60 && test < wd || img.width > 983 && test > wd)return;
			targetIg.style.width = wd+'px';
			img = targetIg.getBoundingClientRect();
			pictureEditor.style.left = img.x;
			pictureEditor.style.top = img.y+document.body.scrollTop;
			pictureEditor.style.height  = img.height;
			pictureEditor.style.width = img.width;
			wd = test;
	}
	
	function picturedel(e){
		document.removeEventListener("mousemove",pictureEt);
		document.removeEventListener("mouseup",picturedel);
		picttf = false;
	}
	
	document.addEventListener("mousemove",pictureEt)
	document.addEventListener("mouseup",picturedel);
	
}) 
pictureEditor.children[0].children[1].addEventListener("dragstart", function(e) {//드래그 막음
	e.preventDefault();
})


function imgEt(vb) { // 객체에 이벤트거는 함수
	vb.addEventListener("mouseenter", function(e) {
		if(!picttf){
			targetIg = e.target;
			let img = targetIg.getBoundingClientRect();
			pictureEditor.style.left = img.x;
			pictureEditor.style.top = img.y+document.body.scrollTop;
			pictureEditor.style.height  = img.height;
			pictureEditor.style.width = img.width;
		}
			pictureEditor.style.display = ''; 
	});
	vb.addEventListener("mouseout", function(e) {
		if(!picttf)
			pictureEditor.style.display = 'none';
	})
}



function imgCk(ib) { // 객체가 배열인지 아닌지에따라 처리
	if(Array.isArray(ib)){
		ib.forEach( ar => {
			imgEt(ar);
		})
	}else{
		imgEt(ib);
	}
}