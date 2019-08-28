<%--
  Created by IntelliJ IDEA.
  User: bowlerm
  Date: 27/08/2019
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>JSP Demo</title>
  </head>
  <body>
    <h1>JSP Demo</h1>
    <a href="${pageContext.request.contextPath}/conntest.jsp"> Test DB connectivity</a>
  </body>
</html>
