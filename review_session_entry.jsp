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
                "INSERT INTO review_session VALUES (?, ?, ?)");

            pstmt.setString(
                1, request.getParameter("date"));
            pstmt.setString(2, request.getParameter("co_number"));
            pstmt.setString(3, request.getParameter("time_of_day"));
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
            ("SELECT * FROM review_session");
%>

<!-- Add an HTML table header row to format the results -->
    <table border="1">
        <tr>
            <th>Date</th>
            <th>Course Number</th>
            <th>Time</th>
        </tr>
        <tr>
            <form action="review_session_entry.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="date" size="10"></th>
                <th><input value="" name="co_number" size="10"></th>
                <th><input value="" name="time_of_day" size="10"></th>
                <th><input type="submit" value="Insert"></th>
            </form>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs.next() ) {

%>

        <tr>
            <form action="review_session_entry.jsp" method="get">
                <td>
                    <input value="<%= rs.getString("date") %>" 
                        name="date" size="10">
                </td>

                <td>
                    <input value="<%= rs.getString("co_number") %>" 
                        name="co_number" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("time_of_day") %>" 
                        name="time_of_day" size="10">
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
