<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="bbs.BbsDAO" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My_Blog 게시판</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	// 이미 로그인했으면 회원가입을 할 수 없게 한다
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('먼저 로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	else{
		// 입력이 안 된 부분이 있는지 체크한다
		if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			// 데이터베이스 오류인 경우
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('--Failed--')");
				script.println("history.back()");
				script.println("</script>");
			// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('--Complete--')");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
	}

%>
</body>
</html>