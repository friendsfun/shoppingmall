<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="_sessionCheck.jsp" %>

<%
String strId = request.getParameter("id");
if(strId == null || strId.trim().equals("")) {
	out.println("There is no such product. Please try again!");
	return;
}
int id = Integer.parseInt(strId);
%>

<html>

<head>

</head>

<body>
	<br>
	<br>
	<form action="../FileUpload" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" value="<%= id %>">
		<div align="center">			
			<input type="file" name="file">
			<input type="submit" name="submit" value="Upload">
		</div>
	</form>
	<br>

	<form action="../FileUpload" method="post" enctype="multipart/form-data">
        <div align="center">
            <fieldset style="width:80%">
                <legend>Image Upload</legend><br/>
                    <div align="left">File1: <input type="file" name="file1"/></div>
                   	<br>
                    <div align="left">File2:<input type="file" name="file2"/> </div>
                    <br>         
                    <div align='left'>File1 Description: <input type="text" name="description1"/></div>
                    <br>
                    <div align='left'>File2 Description: <input type="text" name="description2"/></div>
                 	<br>
                    <div>
                        <div align='left'>
                            <input type='submit' value="Upload"/>
                        </div>
                    </div>
            </fieldset>
        </div>
    </form>

</body>

</html>