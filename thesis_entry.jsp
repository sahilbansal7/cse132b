<html>

<body>
<table border="1">
<tr>
<td valign="top">
    <%-- -------- Include menu HTML code -------- --%>
    <jsp:include page="menu.html" />
</td>
<td>

<%-- Set the scripting language to Java and --%>
<%-- Import the java.sql package --%>
<%@ page language="java" import="java.sql.*" %>

<%-- -------- Open Connection Code -------- --%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        String dbURL = "jdbc:postgresql:cse132?user=postgres&password=admin";
        Connection conn = DriverManager.getConnection(dbURL);

%>

<%-- -------- INSERT Code -------- --%>
<%
        String action = request.getParameter("action");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {

            // Begin transaction
            conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT the student attributes INTO the Faculty table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO thesis VALUES (?, ?, ?, ?, ?, ?)");

      pstmt.setString(1, request.getParameter("t_name"));
      pstmt.setInt(2, Integer.parseInt(request.getParameter("s_ssn")));
      pstmt.setString(3, request.getParameter("first_professor"));
      pstmt.setString(4, request.getParameter("other"));
      pstmt.setString(5, request.getParameter("second_professor"));
      pstmt.setString(6, request.getParameter("third_professor"));
      
      int rowCount = pstmt.executeUpdate();

            // Commit transaction
            conn.commit();
            conn.setAutoCommit(true);
        }
%>


<%-- -------- SELECT Statement Code -------- --%>
<%
        // Create the statement
        Statement statement = conn.createStatement();

        // Use the created statement to SELECT
        // the student attributes FROM the Faculty table.
        ResultSet rs = statement.executeQuery
            ("SELECT * FROM thesis");
%>

<!-- Add an HTML table header row to format the results -->
    <table border="1">
        <tr>
            <th>Thesis Committee Name</th>
            <th>Student SSN</th>
            <th>#1 Instructor Name of Same Department</th>
            <th>Instructor from Different Department</th>
            <th>#2 Instructor Name of Same Department</th>
            <th>#3 Instructor Name of Same Department</th>
        </tr>
        <tr>
            <form action="thesis_entry.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="t_name" size="10"></th>
                <th><input value="" name="s_ssn" size="10"></th>
                <th><input value="" name="first_professor" size="15"></th>
                <th><input value="" name="other" size="30"></th>
                <th><input value="" name="second_professor" size="15"></th>
                <th><input value="" name="third_professor" size="15"></th>
                <th><input type="submit" value="Insert"></th>
            </form>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs.next() ) {

%>

        <tr>
            <form action="thesis_entry.jsp" method="get">

                <td>
                    <input value="<%= rs.getString("t_name") %>" 
                        name="t_name" size="10">
                </td>

                <td>
                    <input value="<%= rs.getInt("s_ssn") %>" 
                        name="s_ssn" size="10">
                </td>

                <td>
                    <input value="<%= rs.getString("first_professor") %>"
                        name="first_professor" size="15">
                </td>

                <td>
                    <input value="<%= rs.getString("other") %>" 
                        name="other" size="15">
                </td>
                <td>
                    <input value="<%= rs.getString("second_professor") %>" 
                        name="second_professor" size="30">
                </td>
                <td>
                    <input value="<%= rs.getString("third_professor") %>" 
                        name="third_professor" size="30">
                </td>

            </form>
        </tr>
<%
        }
%>

<%-- -------- Close Connection Code -------- --%>
<%
        // Close the ResultSet
        rs.close();

        // Close the Statement
        statement.close();

        // Close the Connection
        conn.close();
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
    </table>
</td>
</tr>
</table>
</body>

</html>
