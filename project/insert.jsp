<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
        <title>ȸ�� ����</title>
      </head>
      <body>

        <%@ page import="com.oreilly.servlet.MultipartRequest"%>
        <%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
        <%@ page import="java.sql.*" %>
        <% request.setCharacterEncoding("euc-kr"); %>
          <center>
          <%
    Connection con = null;
    PreparedStatement pstmt = null;
	  Statement stmt = null;
    StringBuffer sql = new StringBuffer("insert into userdata(did, dpw, dname, dphone, demail, daddr, dhobby, dfile, dgrade) ");
    sql.append("values (?, ?, ?, ?, ?, ?, ?, ?, ?)");


	String driverName = "org.gjt.mm.mysql.Driver";
  String dbURL = "jdbc:mysql://localhost:3306/project";

 // ���� ���
 String savePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/fileupload/files";
 int maxSize = 5 * 1024 * 1024; // �ִ� ���ε� ���� ũ�� 5MB(�ް�)�� ����
 try {
  MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "euc-kr", new DefaultFileRenamePolicy());
      String jid = multi.getParameter("fid");
      String jfile = multi.getFilesystemName("ffile"); // ������ �̸� ���

      // checkbox�� ���� �Ѿ�� fhobby �Ķ���� ���� ���ڿ� 1���� ġȯ(Split : [+])
      String[] values = null;
      String jhobby = "";
      // �Ķ���� ���� null�� ��� ���� �Է�
      if(multi.getParameterValues("fhobby") != null){
        values = multi.getParameterValues("fhobby");
        jhobby = values[0];
        for(int i=1; i<values.length; i++)
          jhobby = jhobby + "+" + values[i];
      }else
        jhobby = "";


		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "1234");
 //       pstmt = con.prepareStatement(sql);
 //       pstmt.executeUpdate();

        pstmt = con.prepareStatement(sql.toString());
        //������ �л� ���ڵ� ������ �Է�

        pstmt.setString(1,jid);
      	pstmt.setString(2,multi.getParameter("fpw"));
      	pstmt.setString(3,multi.getParameter("fname"));
      	pstmt.setString(4,multi.getParameter("fphone"));
      	pstmt.setString(5,multi.getParameter("femail"));
      	pstmt.setString(6,multi.getParameter("faddr"));
      	pstmt.setString(7,jhobby);
      	pstmt.setString(8,jfile);
      	pstmt.setString(9,"3");

        out.println(pstmt.toString());
    		int rowCount = pstmt.executeUpdate();
        //������ �Է� ���� ���ο� ���� ������ �̵�
        if (rowCount == 1){
          response.sendRedirect("main.html");
        }

        else
          out.println("�л� ���ڵ� ���Կ� ������ �ֽ��ϴ�.");
          response.sendRedirect("javascript:history.go(-1)");

        //�ٽ� �л� ��ȸ
        stmt = con.createStatement();

 } catch (Exception e) {
  out.print("���� �߻� : " + e);
 }//catch
     finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
%>
                      <p>
                        <hr></body>
                      </html>
