<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" import="java.sql.*"%>
  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <% request.setCharacterEncoding("euc-kr"); %>

    <%
	Connection conn = null;
	PreparedStatement pstmt = null;

	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/project";

		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url,"root","1234");
		String jid = request.getParameter("pid");
    String jpw = request.getParameter("ppw");
		String jmode = request.getParameter("pmode");
		String sql = "select dpw from userdata where dgrade=1";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
    if(rs.next()) {
      // �Ķ���ͷ� �Ѿ�� pwd�� ���������� �޾ƿ� pwd�� �������� ��
  		if(jpw.equals(rs.getString("dpw"))) {
  			// ���ǰ��� ���� K, V.. �ʰ��� ������.. Ű���� ���� �������� ������
  			session.setAttribute("pid", jid);
  			// �α����� �Ǹ� main.jsp�� �̵�
  			// sendredirect�� jsp���� Ư�� �۾��� ������ �� ���ϴ� �������� �̵��ϴ� ���
        //pmode -> jmode �Ķ���� ���� ���� ������ �̵�
				if("1".equals(jmode))
				 response.sendRedirect("m_edit.jsp?pid="+jid);
				else if("2".equals(jmode))
				 response.sendRedirect("m_delete.jsp?pid="+jid);
  		} else {
  			// ��й�ȣ�� Ʋ���ٸ� �ڷ� �̵�
  			%>
      <script>
        alert("��� Ʋ��");
        history.back();
      </script>
      <%
  		}
    }
  %>
