<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>

  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <%@ page import="com.oreilly.servlet.MultipartRequest"%>
  <%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
  <%@ page import="java.sql.*" %>
  <% request.setCharacterEncoding("euc-kr"); %>

    <%
 Connection conn = null;
 PreparedStatement pstmt = null;

 String jdbc_driver = "com.mysql.jdbc.Driver";
 String jdbc_url = "jdbc:mysql://localhost:3306/project";
 String jid = request.getParameter("pid");
 String jfile_temp = "";
 String sql="";

 String savePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/fileupload/files";
 int maxSize = 5 * 1024 * 1024;
try{
  MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "euc-kr", new DefaultFileRenamePolicy());
  String jfile = multi.getFilesystemName("ffile");

  String[] values = null;
  String jhobby = "";
  if(multi.getParameterValues("fhobby") != null){
    values = multi.getParameterValues("fhobby");
    jhobby = values[0];
    for(int i=1; i<values.length; i++)
      jhobby = jhobby + "+" + values[i];
  }else
    jhobby = "";

	Class.forName(jdbc_driver);
	 conn=DriverManager.getConnection(jdbc_url,"root","1234");

   sql = "select dfile from userdata where did ='" + jid + "'";
   pstmt = conn.prepareStatement(sql);
   ResultSet rs = pstmt.executeQuery();
   while(rs.next()) {
     jfile_temp = rs.getString("dfile");
   }
  pstmt.close();

	sql = "update userdata set dpw=?, dphone=?, demail=?, daddr=?, dhobby=?, dgrade=?, dfile=? where did ='" + jid + "'";
	pstmt = conn.prepareStatement(sql);

	pstmt.setString(1,multi.getParameter("fpw"));
	pstmt.setString(2,multi.getParameter("fphone"));
	pstmt.setString(3,multi.getParameter("femail"));
	pstmt.setString(4,multi.getParameter("faddr"));
	pstmt.setString(5,jhobby);
	pstmt.setString(6,multi.getParameter("fgrade"));

  if(jfile != null)
   pstmt.setString(7,jfile);
  else
   pstmt.setString(7,jfile_temp);

	if(jid != null){
		pstmt.executeUpdate();
	}
	pstmt.close();
	conn.close();
} catch(Exception e){
	System.out.println(e);
}
	String surl = "m_detail.jsp?pid=" + jid;
	out.println("<meta http-equiv='Refresh' content='1;URL=" + surl + "'>");
%>
