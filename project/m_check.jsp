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
      // 파라미터로 넘어온 pwd와 쿼리문으로 받아온 pwd가 동일한지 비교
  		if(jpw.equals(rs.getString("dpw"))) {
  			// 세션값을 생성 K, V.. 맵같은 형식임.. 키값을 통해 벨류값을 가져옴
  			session.setAttribute("pid", jid);
  			// 로그인이 되면 main.jsp로 이동
  			// sendredirect는 jsp에서 특정 작업을 수행한 후 원하는 페이지로 이동하는 기능
        //pmode -> jmode 파라미터 값에 따라 페이지 이동
				if("1".equals(jmode))
				 response.sendRedirect("m_edit.jsp?pid="+jid);
				else if("2".equals(jmode))
				 response.sendRedirect("m_delete.jsp?pid="+jid);
  		} else {
  			// 비밀번호가 틀리다면 뒤로 이동
  			%>
      <script>
        alert("비번 틀림");
        history.back();
      </script>
      <%
  		}
    }
  %>
