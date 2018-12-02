<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" import="java.sql.*"%>

	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<html>
		<head>
			<meta charset="EUC-KR">
				<title>본인 확인</title>
			</head>
			<body>
				<% request.setCharacterEncoding("euc-kr");
	Connection conn = null;
	PreparedStatement pstmt = null;

	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/project";

	try{
		Class.forName(jdbc_driver);

		conn = DriverManager.getConnection(jdbc_url,"root","1234");

		String jid = request.getParameter("pid");
    String jmode = request.getParameter("pmode");
		String sql = "select did, dname from userdata where did='"+jid+"'";

		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
					%>
						<center>
							<h2>본인 확인</h2>
							<hr>
            <% while(rs.next()) { %>
                        <form method="post" action="check.jsp?pid=<%=jid%>&pmode=<%=jmode%>">
          								<table border="1">
          									<tr>
          										<td align="center" width="70">ID</td>
          										<td align="center" width="150"><%=jid%></td>
          									</tr>
          									<tr>
          										<td align="center">Name</td>
          										<td align="center"><%=rs.getString("dname")%></td>
          									</tr>
          									<tr>
          										<td align="center">PW</td>
                              <td><input type="text" name="ppw" size=20></td>
          									</tr>
          								</table>
          								<hr>
                                  <td align="center" colspan=2><input type="submit" value="확 인"></td>
                          </form>
  <%  }
		rs.close();
		pstmt.close();
		conn.close();
	}
	catch(Exception e) {
		System.out.println(e);
	}
%>
								</table>
              </form>
  </body>
</html>
