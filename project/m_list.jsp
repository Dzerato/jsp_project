<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" import="java.sql.*"%>

	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<html>
		<head>
			<meta charset="EUC-KR">
				<title>회원 정보 열람-관리자</title>
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
		String jgrade = request.getParameter("pgrade");
		String sql = "select did, dname, dgrade from userdata";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int i=1;
					%>
						<center>
							<h2>회원 정보 열람-관리자</h2>
							<hr>
								<table border="1" align="center">
									<tr>
										<th align="center">No
										</th>
										<th align="center" width="100">ID
										</th>
										<th align="center" width="80">Name
										</th>
										<th align="center">Grade
										</th>
									</tr>
									<%	while(rs.next()) {  %>
										<tr>
											<td align="center"><%=i%></td>
											<td align="center">
											<% //검색 id(did)를 파라미터 값(pid)으로 전달하여 페이지(detail.jsp) 이동 %>
												<a href="m_detail.jsp?pid=<%=rs.getString("did")%>"><%=rs.getString("did")%></a>
											</td>
											<td align="center"><%=rs.getString("dname")%></td>
											<td align="center"><%=rs.getString("dgrade")%></td>
										</tr>
										<%		i++;
		}
		rs.close();
		pstmt.close();
		conn.close();
	}
	catch(Exception e) {
		System.out.println(e);
	}
%>
										</table>
										<hr>
										<a href="main.html">로그아웃</a>
										</body>
									</html>
