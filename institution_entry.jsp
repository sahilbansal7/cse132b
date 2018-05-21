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
                "INSERT INTO institution VALUES (?, ?)");

      pstmt.setString(1, request.getParameter("i_name"));
      pstmt.setString(2, request.getParameter("location"));
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
            ("SELECT * FROM institution");
%>

<!-- Add an HTML table header row to format the results -->
    <table border="1">
        <tr>
            <th>Institution Name</th>
            <th>Location</th>
        </tr>
        <tr>
            <form action="institution_entry.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="i_name" size="10"></th>
                <th><input value="" name="location" size="10"></th>
                <th><input type="submit" value="Insert"></th>
            </form>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs.next() ) {

%>

        <tr>
            <form action="institution_entry.jsp" method="get">

                <td>
                    <input value="<%= rs.getString("i_name") %>" 
                        name="i_name" size="10">
                </td>

                <td>
                    <input value="<%= rs.getString("location") %>" 
                        name="location" size="10">
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