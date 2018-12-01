<%@ page language="java" contentType="text/html; charset=euc-kr" import="java.sql.*" pageEncoding="euc-kr" %>

  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

  <% request.setCharacterEncoding("euc-kr"); %>

    <%
 Connection conn = null;
 PreparedStatement pstmt = null;

 String jdbc_driver = "com.mysql.jdbc.Driver";
 String jdbc_url = "jdbc:mysql://localhost:3306/project";
 String jid = request.getParameter("pid");

try{
	Class.forName(jdbc_driver);
	conn=DriverManager.getConnection(jdbc_url,"root","1234");

	String sql = "delete from userdata where did = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,jid);

	if(jid != null){
		pstmt.executeUpdate();
	}
	pstmt.close();
	conn.close();
} catch(Exception e){
	System.out.println(e);
}
	out.println("<meta http-equiv='Refresh' content='1;URL=m_list.jsp'>");
%>
