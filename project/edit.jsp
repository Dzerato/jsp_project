<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" import="java.sql.*"%>
<%@ page import="java.lang.String" %>

  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

  <html>
    <head>
      <meta charset="EUC-KR">
        <title>ȸ�� ���� ����</title>
      </head>
      <body>
        <% request.setCharacterEncoding("euc-kr"); %>
          <%
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/project";

	try{
		Class.forName(jdbc_driver);
		Connection conn = DriverManager.getConnection(jdbc_url,"root","1234");
		String jid = request.getParameter("pid");
		String sql = "select * from userdata where did = '" + jid + "'";
	  PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		while(rs.next()) {
      //[+] �������� dhobby ���ڿ� ���� �� �� ���� jhobby �迭�� ����
      String str = rs.getString("dhobby");
      String jhobby[] = str.split("[+]");
      int count=0;
      String jfile=rs.getString("dfile"); %>
            <center>
              <h2>ȸ�� ���� ����</h2>
              <hr>
                <form method="post" action="update.jsp?pid=<%=jid%>" enctype="multipart/form-data">
                  <table border="1">
                    <tr>
                      <td align="center" width=60>ID &nbsp;</td>
                      <td align="center"><%=rs.getString("did")%></td>
                    </tr>
                    <tr>
                      <td align="center">PW</td>
                      <td>
                      <input type="text" size="35" name="fpw" value="<%=rs.getString("dpw")%>">
                      </td>
                    </tr>
                    <tr>
                      <td align="center">Name </td>
                      <td align="center"><%=rs.getString("dname")%>
                      </td>
                    </tr>
                    <tr>
                      <td align="center">Phone </td>
                      <td>
                      <input type="text" size="35" name="fphone" value="<%=rs.getString("dphone")%>">
                      </td>
                    </tr>
                    <tr>
                      <td align="center">Email </td>
                      <td>
                      <input type="text" size="35" name="femail" value="<%=rs.getString("demail")%>"></td>
                    </tr>
                    <tr>
                      <td align="center">Addr </td>
                      <td>
                      <input type="text" size="35" name="faddr" value="<%=rs.getString("daddr")%>"></td>
                    </tr>

                    <tr>
                      <td align="center">Hobby </td>
                        <td align="center">
                        <% //jhobby �迭 �� ���� ���� check�ڽ� üũ �ǽ� %>
                          <input type="checkbox" name="fhobby" value="�" <% for(count=0; count < jhobby.length; count++){
                            if("�".equals(jhobby[count])) { %>checked=""<% }} %> >�&nbsp;&nbsp;&nbsp;
                          <input type="checkbox" name="fhobby" value="��ȭ����" <% for(count=0; count < jhobby.length; count++){
                            if("��ȭ����".equals(jhobby[count])) { %>checked=""<% }} %> >��ȭ����
                          <br>
                          <input type="checkbox" name="fhobby" value="����" <% for(count=0; count < jhobby.length; count++){
                            if("����".equals(jhobby[count])) { %>checked=""<% }} %> >����&nbsp;&nbsp;&nbsp;
                          <input type="checkbox" name="fhobby" value="����" <% for(count=0; count < jhobby.length; count++){
                            if("����".equals(jhobby[count])) { %>checked=""<% }} %> >����
                        </td>

                        <tr>
                          <td align="right">Image : </td>
                          <td align="left"><input type="file" name="ffile"></td>
                        </tr>
                  </table>
                  <br>
                      <td colspan="2" align="center">
                      <input type="submit" value="����">&nbsp;&nbsp;&nbsp;&nbsp;
                      <input type="reset" value="���Է�"></td>

                </form>
                <hr>
              </body>
            </html>
  <% }
		rs.close();
		pstmt.close();
		conn.close();	}
	catch(Exception e) {	System.out.println(e); }
%>
                        </body>
                      </html>
