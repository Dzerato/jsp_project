<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
        <title>회원 가입</title>
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

 // 절대 경로
 String savePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/fileupload/files";
 int maxSize = 5 * 1024 * 1024; // 최대 업로드 파일 크기 5MB(메가)로 제한
 try {
  MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "euc-kr", new DefaultFileRenamePolicy());
      String jid = multi.getParameter("fid");
      String jfile = multi.getFilesystemName("ffile"); // 파일의 이름 얻기

      // checkbox를 통해 넘어온 fhobby 파라미터 값을 문자열 1개로 치환(Split : [+])
      String[] values = null;
      String jhobby = "";
      // 파라미터 값이 null인 경우 공백 입력
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
        //삽입할 학생 레코드 데이터 입력

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
        //데이터 입력 성공 여부에 따른 페이지 이동
        if (rowCount == 1){
          response.sendRedirect("main.html");
        }

        else
          out.println("학생 레코드 삽입에 문제가 있습니다.");
          response.sendRedirect("javascript:history.go(-1)");

        //다시 학생 조회
        stmt = con.createStatement();

 } catch (Exception e) {
  out.print("예외 발생 : " + e);
 }//catch
     finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
%>
                      <p>
                        <hr></body>
                      </html>
