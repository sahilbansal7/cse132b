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
        "INSERT INTO student VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

pstmt.setInt(1, Integer.parseInt(request.getParameter("s_ssn")));
pstmt.setString(2, request.getParameter("first_name"));
pstmt.setString(3, request.getParameter("middle_name"));
pstmt.setString(4, request.getParameter("last_name"));
pstmt.setString(5, request.getParameter("period_of_attendance"));
pstmt.setInt(6, Integer.parseInt(request.getParameter("enrolled")));
pstmt.setString(7, request.getParameter("degrees"));
pstmt.setInt(8, Integer.parseInt(request.getParameter("california")));
pstmt.setInt(9, Integer.parseInt(request.getParameter("foreigner"))); 
pstmt.setInt(10, Integer.parseInt(request.getParameter("non_ca")));
pstmt.setInt(11, Integer.parseInt(request.getParameter("student_id")));

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
            ("SELECT * FROM student");
%>

<!-- Add an HTML table header row to format the results -->
    <table border="1">
        <tr>
            <th>SSN</th>
            <th>First Name</th>
            <th>Middle Name (Optional)</th>
            <th>Last Name</th>
            <th>Period of Attendance</th>
            <th>Enrolled</th>
            <th>Highest Degree</th>
            <th>California Resident</th>
            <th>Foreigner</th>
            <th>Non California Resident</th>
            <th>Student ID</th>
        </tr>
        <tr>
            <form action="student_entry.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="s_ssn" size="10"></th>
                <th><input value="" name="first_name" size="10"></th>
                <th><input value="" name="middle_name" size="15"></th>
                <th><input value="" name="last_name" size="15"></th>
                <th><input value="" name="period_of_attendance" size="15"></th>
                <th><input value="" name="enrolled" size="15"></th>
                <th><input value="" name="degrees" size="15"></th>
                <th><input value="" name="california" size="15"></th>
                <th><input value="" name="foreigner" size="15"></th>
                <th><input value="" name="non_ca" size="15"></th>
                <th><input value="" name="student_id" size="15"></th>
                <th><input type="submit" value="Insert"></th>
            </form>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs.next() ) {

%>

        <tr>
            <form action="student_entry.jsp" method="get">
                <td>
                    <input value="<%= rs.getInt("s_ssn") %>" 
                        name="s_ssn" size="10">
                </td>

                <td>
                    <input value="<%= rs.getString("first_name") %>" 
                        name="first_name" size="10">
                </td>

                <td>
                    <input value="<%= rs.getString("middle_name") %>"
                        name="middle_name" size="15">
                </td>

                <td>
                    <input value="<%= rs.getString("last_name") %>" 
                        name="last_name" size="15">
                </td>

                <td>
                    <input value="<%= rs.getString("period_of_attendance") %>" 
                        name="period_of_attendance" size="15">
                </td>

                <td>
                    <input value="<%= rs.getInt("enrolled") %>" 
                        name="enrolled" size="15">
                </td>
                <td>
                    <input value="<%= rs.getString("degrees") %>" 
                        name="degrees" size="10">
                </td>
                <td>
                    <input value="<%= rs.getInt("california") %>" 
                        name="california" size="10">
                </td>
                <td>
                    <input value="<%= rs.getInt("foreigner") %>" 
                        name="foreigner" size="10">
                </td>
                <td>
                    <input value="<%= rs.getInt("non_ca") %>" 
                        name="non_ca" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("student_id") %>" 
                        name="student_id" size="10">
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
