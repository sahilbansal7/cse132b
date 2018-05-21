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
                "INSERT INTO degree VALUES (?, ?, ?, ?, ?)");

            pstmt.setString(
                1, request.getParameter("d_department"));
            pstmt.setString(2, request.getParameter("d_degree_name"));
            pstmt.setInt(3, Integer.parseInt(request.getParameter("total_units")));
           pstmt.setInt(4, Integer.parseInt(request.getParameter("min_lower_div")));
            pstmt.setString(5, request.getParameter("concentration"));

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
            ("SELECT * FROM degree");
%>

<!-- Add an HTML table header row to format the results -->
    <table border="1">
        <tr>
            <th>Department</th>
            <th>Degree</th>
            <th>Total Number of Units Required</th>
            <th>Minimum Lower Division Units</th>
            <th>Concentraion</th>
        </tr>
        <tr>
            <form action="degree_entry.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="d_department" size="10"></th>
                <th><input value="" name="d_degree_name" size="10"></th>
                <th><input value="" name="total_units" size="15"></th>
                <th><input value="" name="min_lower_div" size="15"></th>
                <th><input value="" name="concentration" size="15"></th>
                <th><input type="submit" value="Insert"></th>
            </form>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs.next() ) {

%>

        <tr>
            <form action="degree_entry.jsp" method="get">

                <td>
                    <input value="<%= rs.getString("d_department") %>" 
                        name="d_department" size="10">
                </td>

                <td>
                    <input value="<%= rs.getString("d_degree_name") %>"
                        name="d_degree_name" size="15">
                </td>

                <td>
                    <input value="<%= rs.getInt("total_units") %>" 
                        name="total_units" size="15">
                </td>

                <td>
                    <input value="<%= rs.getInt("min_lower_div") %>" 
                        name="min_lower_div" size="15">
                </td>

                <td>
                    <input value="<%= rs.getString("concentration") %>" 
                        name="concentration" size="15">
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
