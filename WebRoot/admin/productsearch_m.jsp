<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%!
private static final int PAGE_SIZE = 3;
%>

<%

List<Category> categories = Category.getCategories();

String action = request.getParameter("action");

int pageNo = 1;
int pageCount = 0;
List<Product> products = new ArrayList<Product>();
String keyword = null;
int categoryId = 0;
int[] idArray;

double lowNormalPrice = -1;
double highNormalPrice = -1;
double lowMemberPrice = -1;
double highMemberPrice = -1;
Timestamp startDate;
Timestamp endDate;
String strStartDate = null;
String strEndDate = null;

if(action != null) {
	String strPageNo = request.getParameter("pageno");
	if(strPageNo != null && !strPageNo.trim().equals("")) {
		pageNo = Integer.parseInt(strPageNo);
	}
	keyword = request.getParameter("keyword");
	
	if(action.trim().equals("simplesearch")) {		
		
		categoryId = Integer.parseInt(request.getParameter("categoryid"));
		
		if(categoryId == 0) {
			idArray = null;
		} else {
			idArray = new int[1];
			idArray[0] = categoryId;
		}				
		
		pageCount = ProductMgr.getInstance().findProducts(products,idArray, keyword, pageNo, PAGE_SIZE);
	}

	String strCategoryIdQuery = "";
	if(action.trim().equals("simplesearch2")) {
		String[] strCategoryIds = request.getParameterValues("categoryid"); 
		int len = 0;
		
		if(strCategoryIds == null || strCategoryIds.length == 0) {
			idArray = null;
		} else {
			len = strCategoryIds.length;
			for(int i=0; i<len; i++) {
				strCategoryIdQuery = strCategoryIdQuery + "&categoryid=" + strCategoryIds[i];
			}
			idArray = new int[len];
			for(int i=0; i<len; i++) {
				idArray[i] = Integer.parseInt(strCategoryIds[i]);
			}
		}
		
		pageCount = ProductMgr.getInstance().findProducts(products,idArray, keyword, pageNo, PAGE_SIZE);
	}	
	
	if(action.trim().equals("advancedsearch")) {
		lowNormalPrice = Double.parseDouble(request.getParameter("lownormalprice"));
		highNormalPrice = Double.parseDouble(request.getParameter("highnormalprice"));
		lowMemberPrice = Double.parseDouble(request.getParameter("lowmemberprice"));
		highMemberPrice = Double.parseDouble(request.getParameter("highmemberprice"));
		categoryId = Integer.parseInt(request.getParameter("categoryid"));
		if(categoryId == 0) {
			idArray = null;
		} else {
			idArray = new int[1];
			idArray[0] = categoryId;
		}	
		
		
		strStartDate = request.getParameter("startdate");
		strEndDate = request.getParameter("enddate");
		if(strStartDate == null || strStartDate.trim().equals("")) {
			startDate = null;
		} else {
			startDate = Timestamp.valueOf(request.getParameter("startdate"));
		}
		if(strEndDate == null || strEndDate.trim().equals("")) {
			endDate = null;
		} else {
			endDate = Timestamp.valueOf(request.getParameter("enddate"));
		}	
		
		pageCount = ProductMgr.getInstance().findProducts(products, idArray, keyword, lowNormalPrice, 
		highNormalPrice, lowMemberPrice, highMemberPrice, startDate, endDate, pageNo, PAGE_SIZE);	
	}	
%>

	<html>
		<head>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	   
	    <title></title>
	    </head>
		
		<body>
		<center>Search Result</center>
		<div class="container">
	    <div class="row col-sm-12 custyle">
	    <table class="table table-striped custab">
	    <thead>
	        <tr>
	            <th>ProductID</th>
	            <th>Name</th>
	            <th>Description</th>
	            <th>NormalPrice</th>
	            <th>MemberPrice</th>
	            <th>Pdate</th>
	            <th>CategoryID</th>
	            <th>Action</th>
	        </tr>
	    </thead>
	    <%
	    for(Iterator<Product> it = products.iterator(); it.hasNext(); ) {
	    	Product p = it.next();
	     %>
	       <tr>
	           <td><%= p.getId() %></td>
	           <td><%= p.getName() %></td> 
	           <td><%= p.getDescr() %></td> 
	           <td><%= p.getNormalPrice() %></td>
	          
	           <td><%= p.getMemberPrice() %></td>
	           <td><%= p.getPdate() %></td>
	           <td><%= p.getCategoryId() %></td>
	          
	           <td>
	           	   <a href="productmodify.jsp?id=<%= p.getId() %>" target="main">Modify</a> &nbsp; &nbsp; 
	           	   <a href="productdelete.jsp?id=<%= p.getId() %>" target="main">Delete</a>
	           </td>
	                     
	       </tr> 
	    <%
	    }
	    %>   
	                 
	    </table>
	    </div>
	</div>
		<%
		if(action.trim().equals("simplesearch")) {
		%>
			<center>
			Page <%= pageNo %> &nbsp;
			Total <%= pageCount %> &nbsp;
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%>&categoryid=<%= categoryId%>&pageno=<%= 1 %>" > First Page</a> &nbsp;
			<% if(pageNo != 1) { %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%>&categoryid=<%= categoryId%>&pageno=<%= pageNo -1 %>" > Previous Page</a> &nbsp;
			<% }  %>
			
			<% if(pageNo != pageCount) { %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%>&categoryid=<%= categoryId%>&pageno=<%= pageNo + 1 %>" > Next Page</a> &nbsp;
			<% } %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%>&categoryid=<%= categoryId%>&pageno=<%= pageCount %>">Last Page</a>
			</center>
	  	<%
	  	} else if(action.trim().equals("simplesearch2")) {
	  	%>
	  		<center>
			Page <%= pageNo %> &nbsp;
			Total <%= pageCount %> &nbsp;
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%><%= strCategoryIdQuery%>&pageno=<%= 1 %>" > First Page</a> &nbsp;
			<% if(pageNo != 1) { %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%><%= strCategoryIdQuery%>&pageno=<%= pageNo -1 %>" > Previous Page</a> &nbsp;
			<% }  %>
			
			<% if(pageNo != pageCount) { %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%><%= strCategoryIdQuery%>&pageno=<%= pageNo + 1 %>" > Next Page</a> &nbsp;
			<% } %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%><%= strCategoryIdQuery%>&pageno=<%= pageCount %>">Last Page</a>
			</center>
		<%
		} else {
		%>	
	  		<center>
			Page <%= pageNo %> &nbsp;
			Total <%= pageCount %> &nbsp;
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%>&lownormalprice=<%= lowNormalPrice%>&highnormalprice=<%= highNormalPrice%>&lowmemberprice=<%= lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%= strStartDate%>&enddate=<%= strEndDate%>&categoryid=<%= categoryId%>&pageno=<%= 1 %>" > First Page</a> &nbsp;
			<% if(pageNo != 1) { %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%>&lownormalprice=<%= lowNormalPrice%>&highnormalprice=<%= highNormalPrice%>&lowmemberprice=<%= lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%= strStartDate%>&enddate=<%= strEndDate%>&categoryid=<%= categoryId%>&pageno=<%= pageNo -1 %>" > Previous Page</a> &nbsp;
			<% }  %>
			
			<% if(pageNo != pageCount) { %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%>&lownormalprice=<%= lowNormalPrice%>&highnormalprice=<%= highNormalPrice%>&lowmemberprice=<%= lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%= strStartDate%>&enddate=<%= strEndDate%>&categoryid=<%= categoryId%>&pageno=<%= pageNo + 1 %>" > Next Page</a> &nbsp;
			<% } %>
			<a href="productsearch_m.jsp?action=<%= action%>&keyword=<%= keyword%>&lownormalprice=<%= lowNormalPrice%>&highnormalprice=<%= highNormalPrice%>&lowmemberprice=<%= lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%= strStartDate%>&enddate=<%= strEndDate%>&categoryid=<%= categoryId%>&pageno=<%= pageCount %>">Last Page</a>
			</center>
	  	<% 
	  	}
	  	%>
		<br>
	
	 <!-- jQuery -->
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	
	 <!-- Bootstrap Core JavaScript -->
	 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	</body>
	</html>

<%
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
   
    <title></title>
    <script type="text/javascript">
    <!--
    	function checkdata() {
    		with(document.forms["advanced"]) {
    			if(lownormalprice.value == null || lownormalprice.value == "") {
    				lownormalprice.value = -1;
    			}
    			if(highnormalprice.value == null || highnormalprice.value == "") {
    				highnormalprice.value = -1;
    			}
    			if(lowmemberprice.value == null || lowmemberprice.value == "") {
    				lowmemberprice.value = -1;
    			}
    			
    			if(highmemberprice.value == null || highmemberprice.value == "") {
    				highmemberprice.value = -1;
    			}
    			
    		}
    	}
    -->
    </script>
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  
  	<center><h4>Simple Search</h4></center>
  	<form name="simple" action="productsearch_m.jsp" method="post">
  		<input type="hidden" name="action" value="simplesearch">
  		<table>
  			<tr>
  				<td>Category Name: &nbsp; &nbsp; </td> 
  				<td>
			  		<select name="categoryid">
			  			<option value="0">All Categories</option>
							<%
							for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
								Category c = it.next();
								String preStr = "";
								for(int i=1; i<c.getGrade(); i++) {
									preStr = preStr + "--";
								}
							%>	
								<option value=<%= c.getId() %>><%= preStr + c.getName() %></option>
							<%
							}
							%>
			  		</select> &nbsp; &nbsp;
  				</td>	
	  			<td>
			  		Keyword: &nbsp; &nbsp;
			  	</td> 
			  	<td>
		  			<input type="text" name="keyword" > &nbsp; &nbsp;
		  		</td> 
				<td>
  			 		<input type="submit" value="Search">  
  			 	</td>
  			</tr>
  		</table>		
  	</form>
  	<br>
  	
  	<center><h4>Simple Search2</h4></center>
  	<form name="simple" action="productsearch_m.jsp" method="post">
  		<input type="hidden" name="action" value="simplesearch2">
  		<table>
  			<tr>
  				<td>Category Name: &nbsp; &nbsp; </td> 
  				<td>
					<%
					for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
						Category c = it.next();
						if(c.isLeaf()) {
					%>	
							<input type="checkbox" name="categoryid" value="<%= c.getId() %>"><%= c.getName() %> &nbsp; &nbsp; <br>
					<%
						}
					}
					%>
  				</td>	
	  			<td>
			  		Keyword: &nbsp; &nbsp;
			  	</td> 
			  	<td>
		  			<input type="text" name="keyword" > &nbsp; &nbsp;
		  		</td> 
				<td>
  			 		<input type="submit" value="Search">  
  			 	</td>
  			</tr>
  		</table>		
  	</form>
  	<br>
 	
  	<center><h4>Advanced Search</h4></center>
    <form name="advanced" action="productsearch_m.jsp" method="post" onSubmit="checkdata()">
    	<input type="hidden" name="action" value="advancedsearch">
   
    	<table>
    		<tr>
    			<td>Category Name: &nbsp; &nbsp; </td>
    			<td>
    				<select name="categoryid">
    					<option value="0">All Categories</option>
    					<%
    					for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
    						Category c = it.next();
    						String preStr = "";
    						for(int i=1; i<c.getGrade(); i++) {
    							preStr = preStr + "--";
    						}
    					%>
    						<option value=<%= c.getId() %>><%= preStr + c.getName() %></option>
    					<%
    					}
    					%>
    			
    				</select>	
    			</td>
    		</tr>
    
    		<tr>
    			<td>Keyword: </td>
    			<td><input type="text" name="keyword"></td>
    		</tr>
    		<tr>
    			<td>Normal Price: </td>
    			<td>
    				From: &nbsp; &nbsp; <input type="text" name="lownormalprice" ><br>
    				To: &nbsp; &nbsp; &nbsp; &nbsp; <input type="text" name="highnormalprice">
    			</td>
    		</tr>
    		<tr>
    			<td>Member Price: </td>
    			<td>
    				From: &nbsp; &nbsp; <input type="text" name="lowmemberprice" > <br> 
    				To: &nbsp; &nbsp; &nbsp; &nbsp; <input type="text" name="highmemberprice">
    			</td>
    		</tr>
    		
    		<tr>
    			<td>Pdate: </td>
    			<td>
    				From: &nbsp; &nbsp; <input type="text" name="startdate" > <br>
    				To: &nbsp; &nbsp; &nbsp; &nbsp; <input type="text" name="enddate">
    			</td>
    		</tr>    		
    		
    		<tr>
    			<td colspan=2><input type="submit" value="Search"></td>
    		</tr>
    		
    	</table>  
    </form>
    
     <!-- jQuery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

 <!-- Bootstrap Core JavaScript -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
  </body>
</html>
