<%--
  Created by IntelliJ IDEA.
  User: bowlerm
  Date: 27/08/2019
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.time.Instant" %>
<%@ page import="java.time.Duration" %>
<%@ page import="org.apache.commons.lang3.RandomStringUtils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Java webapp with database connectivity</title>
  </head>
  <body>
    <h1>Test DB connectivity</h1>
<%--    <sql:setDataSource var="datasource" driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"--%>
<%--                       url="jdbc:sqlserver://dude-vnet-test.database.windows.net:1433;databaseName=dude-vnet-test"--%>
<%--                       user="dude"  password="Regional1"/>--%>

<%--    <sql:query dataSource="${datasource}" var="result">--%>
<%--        SELECT * from trentadm.schema_version;--%>
<%--    </sql:query>--%>

<%--    <table>--%>
<%--        <tr>--%>
<%--            <th>id</th>--%>
<%--        </tr>--%>
<%--        <c:forEach var="row" items="${result.rows}">--%>
<%--            <tr>--%>
<%--                <td><c:out value="${row.id}"/></td>--%>
<%--            </tr>--%>
<%--        </c:forEach>--%>
<%--    </table>--%>

  <%
      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
      String connectionURL = "jdbc:sqlserver://dude-vnet-test.database.windows.net:1433;databaseName=dude-vnet-test;" +
              "loginTimeout=60;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows" +
              ".net;userName=dude;password=Regional1";

      String sql = "select count(*) from trentadm.schema_version";

      List<Connection> connections = new ArrayList<>();
      String logName = "dude_" + RandomStringUtils.randomAlphanumeric(5) + ".log";
      PrintStream ps = new PrintStream("D:\\Home\\LogFiles\\" + logName);
      System.setOut(ps);
      System.setErr(ps);

      int i = 0;
      try {
          for (i = 1; i <= 4801; i++) {
              Instant connStart = Instant.now();
              Connection connection = DriverManager.getConnection(connectionURL);
              Instant connEnd = Instant.now();
              connections.add(connection);
              Statement statement = null;
              ResultSet results = null;
              try {
                  statement = connection.createStatement();
                  Instant queryStart = Instant.now();
                  results = statement.executeQuery(sql);
                  Instant queryEnd = Instant.now();
                  results.next();
                  System.out.println(i + ":" + results.getInt(1) + ":"
                          + Duration.between(connStart, connEnd).toMillis() + ":"
                          + Duration.between(queryStart, queryEnd).toMillis());
              } finally {
                  if (Objects.nonNull(results)) {
                      results.close();
                  }
                  if (Objects.nonNull(statement)) {
                      statement.close();
                  }
              }

//              try {
//                  Thread.sleep(10);
//              } catch (InterruptedException e) {
//                  e.printStackTrace();
//                  Thread.currentThread().interrupt();
//              }
          }
      } catch (SQLException e) {
          System.out.println("Exception received creating connection: " + i);
          e.printStackTrace();
      } finally {
          for (Connection c : connections) {
              c.close();
          }

      }
  %>
  <p>Number of connections created = <%=i%></p>
  </body>
</html>
