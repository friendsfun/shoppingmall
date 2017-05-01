function checkdata() {
	var usr = form.username.value.toLowerCase();
	var password = form.password.value;
	var password2 = form.password2.value;
	var phone = form.phone.value;
	var addr = form.addr.value;
	if(!checkUserName(usr)) {
		return false; //用户名检查
	}
	if(!checkPassword(usr, password, password2)) {
		return false;
	}

	if(!checkPhone(phone)) {
		return false;
	}
	if(!checkAddr(addr)) {
		return false;
	}	
	return true;
}

function checkPhone(phone) {
	if(phone == "") {
		alert("\请输入电话号码，电话不能为空！")
		form.phone.focus()
		return false;
	}
	return true;
}

function checkAddr(addr) {
	if(addr == "") {
		alert("\请输入地址，地址不能为空！")
		form.addr.focus()
		return false;
	}
	return true;
}


function checkUserName(usr) {
	if(usr.length <3 || usr.length > 18) {
		alert("\请输入正确的用户名,用户名长度为3-18位！")
		form.username.focus()
		return false;
	}
	if (isWhiteSpace(usr)){
		alert("\请输入正确的用户名,用户名中不能包含空格！")
		form.username.focus()
		return false;
	}
	if (!isUsrString(usr)){
		alert("\    对不起，您选择的用户名不正确或已被占用！用户名\n由a～z的英文字母(不区分大小写)、0～9的数字、点、减\n号或下划线组成，长度为3～18个字符，只能以数字或字母\n开头和结尾,例如:kyzy_001。")
		form.username.focus()
		return false;
	}
	return true;
}

function checkPassword(usr, password, password2) {
	if( strlen(password)<6 || strlen(password)>16 ) {
		alert("\正确地登录密码长度为6-16位，仅可用英文、数字、特殊字符！")
		form.password.focus()
		return false;
	}
	if( strlen2(password) ) {
		alert("\您的密码中包含了非法字符，仅可用英文、数字、特殊字符！")
		form.password.focus()
		return false;
	}
	if( password == usr ) {
		alert("\用户名和密码不能相同！")
		form.password.focus()
		return false;
	}
	if( password2 =="" ) {
		alert("\请输入密码确认！")
		form.password2.focus()
		return false;
	}
	if( password2 != password ) {
		alert("\两次密码输入不一致！")
		form.password.focus()
		return false;
	}
	return true;
}

function strlen(str) {
	var len;
	var i;
	len = 0;
	for(i = 0; i < str.length; i++) {
		if(str.charCodeAt(i) > 255) {
			len = len + 2;
		} else {
			len++;
		}
	}
	return len;
}

function strlen2(str) {
	var i;
	for(i = 0; i < str.length; i++) {
		if(str.charCodeAt(i) > 255) {
			return true;
		}
	}
	return false;
}

function isWhiteSpace(s) {
	var whitespace = " \t\n\r";
	var i;
	for(i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if(whitespace.indexOf(c) >= 0) {
			return true;
		}
	}
	return false;
}

function isUsrString(usr) {
	var re = /^[0-9a-z][\w-.]*[0-9a-z]$/i;
	if(re.test(usr)) {
		return true;
	} else {
		return false;
	}
}
