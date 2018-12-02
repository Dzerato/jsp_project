<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" import="java.sql.*"%>

	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<html>
		<head>
			<meta charset="EUC-KR">
				<title>상세 정보 조회</title>
			</head>
			<body>

				<% request.setCharacterEncoding("euc-kr"); %>

					<%
	Connection conn = null;
	PreparedStatement pstmt = null;

	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/project";

	try{
		Class.forName(jdbc_driver);

		conn = DriverManager.getConnection(jdbc_url,"root","1234");

		String jid = request.getParameter("pid");
		String sql = "select did, dname, dphone, demail, daddr,dhobby, dgrade, dfile from userdata where did = '" + jid + "'";

		pstmt = conn.prepareStatement(sql);

		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
%>
						<center>
							<h2>상세 정보 조회</h2>
							<hr>
								<table border="1">
									<tr>
										<td align="center">ID</td>
										<td align="center" width="200"><%=rs.getString("did")%></td>
									</tr>
									<tr>
										<td align="center">Name</td>
										<td align="center"><%=rs.getString("dname")%></td>
									</tr>
									<tr>
										<td align="center">Phone</td>
										<td align="center"><%=rs.getString("dphone")%></td>
									</tr>
									<tr>
										<td align="center" width="80">Email</td>
										<td align="center" width="150"><%=rs.getString("demail")%></td>
									</tr>
									<tr>
										<td align="center">Addr</td>
										<td align="center"><%=rs.getString("daddr")%></td>
									</tr>
									<tr>
										<td align="center">Hobby</td>
										<td align="center"><%=rs.getString("dhobby")%></td>
									</tr>
									<tr>
										<td align="center">Grade</td>
										<td align="center"><%=rs.getString("dgrade")%></td>
									</tr>
									<tr>
										<% //특정 경로(첨부 파일이 저장된 경로)에서 DB(dfile)에 저장된 이름의 파일 호출 %>
											<td align="center">Image</td>
											<td align="center"><img src ="../fileupload/files/<%=rs.getString("dfile")%>" width = 150></td>
									 </tr>
								</table>
								<hr>
								<% //각 항목별 페이지 이동 - 이동시 해당 페이지에서 필요한 파라미터 값 전달 %>
									<a href="check_Q.jsp?pid=<%=rs.getString("did")%>&pmode=1">수 정</a>
									<a href="check_Q.jsp?pid=<%=rs.getString("did")%>&pmode=2">삭 제</a>
									<a href="list.jsp?pgrade=<%=rs.getString("dgrade")%>">목록으로 가기</a>
								<%
		}
		rs.close();
		pstmt.close();
		conn.close();
	}
	catch(Exception e) {System.out.println(e);}
%>
									</body>
								</html>
