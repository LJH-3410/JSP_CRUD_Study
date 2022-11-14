<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> 서적관리 시스템 - 조회(R2)</h1>
<hr>
<h2>전체보기(부분조회 미포함, 페이징기능 포함)</h2>

<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/book_db";
 	String user = "root";
	String passwd = "password";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url,user,passwd);
	Statement stmt = con.createStatement(); 
	request.setCharacterEncoding("utf-8");	
%>

<% 
	String sql2 = "SELECT count(*) FROM books";
	ResultSet rs2 = stmt.executeQuery(sql2);
	
	int recordCnt = 0; 			//전체레코드 개수
	int pageCnt; 				//전체 페이지 수
	int startRecord = 0;		//시작 레코드	
	int limitCnt = 10;			//출력 레코드
	int currentPageNo;			//현재페이지 번호
	
	while ( rs2.next() ){
		recordCnt = rs2.getInt(1);
	}
	
	pageCnt = recordCnt/10;
	
	if ( recordCnt %10 != 0)	
		pageCnt++;
%>

<%
	int book_id;
	String title;
	String publisher;
	String year;
	int price;
	
	currentPageNo = Integer.parseInt(request.getParameter("currentPageNo"));
	
	startRecord = currentPageNo * 10;
	
	String sql = "SELECT * FROM books ORDER BY book_id limit ";
	sql += startRecord + "," + limitCnt;
	
	ResultSet rs = stmt.executeQuery(sql);

%>

	<table border ="1">
		<thead>
			<tr>
				<th>순번</th>
				<th>제목</th>
				<th>출판사</th>
				<th>출판년도</th>
				<th>가격</th>
			</tr>
		</thead>
		<tbody>

<%
	while(rs.next()){
		book_id = rs.getInt("book_id");
		title = rs.getString("title");
		publisher = rs.getString("publisher");
		year = rs.getString("year");
		price = rs.getInt("price");

%>
			<tr>
				<th><%=book_id%></th>
				<th><%=title%></th>
				<th><%=publisher%></th>
				<th><%=year%></th>
				<th><%=price%></th>
			</tr>
			
<%
	}
%>
	</tbody>
	</table>
<br>

<a href= "./book_r2.jsp?currentPageNo=0">[FIRST]</a>

<%
	if (currentPageNo > 0 ){
%>
		<a href= "./book_r2.jsp?currentPageNo=<%=(currentPageNo-1)%>">[PRE]</a>
<%
	}else{
%>	
		[PRE]
<% 
	}
	
	for (int i = 0; i < pageCnt; i++ ) {
		
		if (i == currentPageNo) {
%>		
			[<%=(i+1)%>]
<%
		}else{
%>		
			<a href= "./book_r2.jsp?currentPageNo=<%=i%>">[<%=(i+1)%>]</a>
<%
		}
	}
%>

<%
	if ( currentPageNo < pageCnt -1 ) {
%>		
		<a href= "./book_r2.jsp?currentPageNo=<%=(currentPageNo+1)%>">[NXT]</a>
<%
	}else{
%>
		[NXT]		
<%
	}
%>
<a href= "./book_r2.jsp?currentPageNo=<%=(pageCnt-1)%>">[END]</a>

<br><br><a href= "./index.jsp">홈으로 돌아가기</a>
</body>
</html>