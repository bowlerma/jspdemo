<%--
  Created by IntelliJ IDEA.
  User: bowlerm
  Date: 27/08/2019
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Java webapp with database connectivity</title>
  </head>
  <body>
    <h1>Test DB connectivity</h1>
    <sql:setDataSource var="datasource" driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                       url="jdbc:sqlserver://dude-vnet-test.database.windows.net:1433;databaseName=dude-vnet-test"
                       user="dude"  password="Regional1"/>

    <sql:query dataSource="${datasource}" var="result">
        SELECT * from trentadm.schema_version;
    </sql:query>

    <table>
        <tr>
            <th>id</th>
        </tr>
        <c:forEach var="row" items="${result.rows}">
            <tr>
                <td><c:out value="${row.id}"/></td>
            </tr>
        </c:forEach>
    </table>
  </body>
</html>
