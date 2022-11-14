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
<h1> 서적관리 시스템 - 조회(R3)</h1>
<hr>
<h2>전체보기(부분조회 미포함, 페이징기능개선, 출력레코드갯수 선택, 세션객체 사용안함)</h2>
<hr>

<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/book_db";
 	String user = "root";
	String passwd = "password";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url,user,passwd);
	Statement stmt = con.createStatement(); 
	request.setCharacterEncoding("utf-8");	

	String sql2 = "SELECT count(*) FROM books";
	ResultSet rs2 = stmt.executeQuery(sql2);
	
	int limitCnt= Integer.parseInt(request.getParameter("displayRecordCnt")); //출력레고드수
	int recordCnt=0;	//전체 레코드 개수
	int pageCnt;		//전체 페이지 수
	int startRecord = 0;		//시작 레코드
	int currentPageNo = Integer.parseInt(request.getParameter("currentPageNo"));	//현재페이지 번호
	int startPageNo = currentPageNo /10 * 10;	//시작페이지
	int endPageNo = startPageNo + 10;			//끝페이지
	
	while(rs2.next()){
		recordCnt= rs2.getInt(1);
	}
	
	pageCnt= recordCnt / limitCnt;
	
	if (recordCnt % limitCnt != 0){
		pageCnt++;
	}	
	
	int book_id;
	String title;
	String publisher;
	String year;
	int price;

	
	
	startRecord = currentPageNo * limitCnt;
	
	if(endPageNo > pageCnt){
		endPageNo = pageCnt;
	}
	

	String sql = "SELECT * FROM books ORDER BY book_id limit ";
	sql += startRecord + "," + limitCnt;
	
	ResultSet rs = stmt.executeQuery(sql);

%>
<h2>현재 DLSPLAY RECORDS NUMBER : <%=limitCnt%> </h2>
	<form method="post" action="./book_r3.jsp">
		디스플레이 레코드수 변경 : 
		<select name="displayRecordCnt" id="num">
			<option value="10">10</option>
			<option value="20">20</option>
			<option value="50">50</option>
			<option value="100">100</option>
		</select> <input type="hidden" name="currentPageNo" value="<%=currentPageNo%>">
		<input type="submit" value="확인">
	</form>
	<br>
<br>

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

<a href= "./book_r3.jsp?currentPageNo=0&displayRecordCnt=<%=limitCnt%>">[FIRST]</a>

<%
	if (currentPageNo > 0 ){
%>
	<a href= "./book_r3.jsp?currentPageNo=<%=(currentPageNo-1)%>&displayRecordCnt=<%=limitCnt%>">[PRE]</a>
<%
	}else{
%>	
	[PRE]
<% 
	}
	
	for (int i = startPageNo; i < endPageNo ; i++ ) {					
		
		if (i == currentPageNo) {
%>		
			[<%=(i+1)%>]
<%
			}else{
%>		
				<a href= "./book_r3.jsp?currentPageNo=<%=i%>&displayRecordCnt=<%=limitCnt%>">[<%=(i+1)%>]</a>
<%
		}
	}
%>

<%
	if ( currentPageNo < pageCnt -1 ) {
%>		
	<a href= "./book_r3.jsp?currentPageNo=<%=(currentPageNo+1)%>&displayRecordCnt=<%=limitCnt%>">[NXT]</a>
<%
	}else{
%>
	[NXT]		
<%
	}
%>
<a href= "./book_r3.jsp?currentPageNo=<%=(pageCnt-1)%>&displayRecordCnt=<%=limitCnt%>">[END]</a>

<br>
<br>
<a href= "./index.jsp">홈으로 돌아가기</a>
</body>
</html>