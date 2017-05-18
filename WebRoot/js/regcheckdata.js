function checkdata() {
	var usr = form.username.value.toLowerCase();
	var password = form.password.value;
	var password2 = form.password2.value;
	var phone = form.phone.value;
	var addr = form.addr.value;
	if(!checkUserName(usr)) {
		return false; 
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
		alert("\Please enter your phone number!")
		form.phone.focus()
		return false;
	}
	return true;
}

function checkAddr(addr) {
	if(addr == "") {
		alert("\Please enter your address!")
		form.addr.focus()
		return false;
	}
	return true;
}


function checkUserName(usr) {
	if(usr.length <3 || usr.length > 18) {
		alert("\Invalid username! The length of the username must be greater than 2 and less than 19.")
		form.username.focus()
		return false;
	}
	if (isWhiteSpace(usr)){
		alert("\Invalid username! Spaces are not allowed in your username.")
		form.username.focus()
		return false;
	}
	if (!isUsrString(usr)){
		alert("Invalid username!\n Only the 26 english characters, digits of 0~9 and the specialcharacters are allowed in username.")
		form.username.focus()
		return false;
	}
	return true;
}

function checkPassword(usr, password, password2) {
	if( strlen(password)<6 || strlen(password)>16 ) {
		alert("\The length of password must be between 6 and 16!")
		form.password.focus()
		return false;
	}
	if( strlen2(password) ) {
		alert("\Invalid characters are used in your password!")
		form.password.focus()
		return false;
	}
	if( password == usr ) {
		alert("\Password can not be the same with username.")
		form.password.focus()
		return false;
	}
	if( password2 =="" ) {
		alert("\Please enter the password again to confirm!")
		form.password2.focus()
		return false;
	}
	if( password2 != password ) {
		alert("\The two passwords are not matched!")
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
