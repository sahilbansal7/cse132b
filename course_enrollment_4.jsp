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
                            "INSERT INTO course_enrollment VALUES (?, ?, ?, ?)");

            pstmt.setInt(1, Integer.parseInt(request.getParameter("s_ssn")));
            pstmt.setString(2, request.getParameter("co_number"));
            pstmt.setInt(3, Integer.parseInt(request.getParameter("section_id")));
            pstmt.setInt(4, Integer.parseInt(request.getParameter("units")));

            int rowCount = pstmt.executeUpdate();

            // Commit transaction
            conn.commit();
            conn.setAutoCommit(true);
        }
%>

<%-- -------- UPDATE Code -------- --%>
<%
        // Check if an update is requested
        if (action != null && action.equals("update")) {
            // Begin transaction
            conn.setAutoCommit(false);
                        
            PreparedStatement pstmt = conn.prepareStatement(
                "UPDATE course_enrollment SET s_ssn = ?, co_number = ?, section_id = ?, units = ? WHERE s_ssn = ? and section_id = ? and co_number = ?");

            pstmt.setInt(1, Integer.parseInt(request.getParameter("s_ssn")));
            pstmt.setString(2, request.getParameter("new_course_name"));
            pstmt.setInt(3, Integer.parseInt(request.getParameter("new_section_id")));
            pstmt.setInt(4, Integer.parseInt(request.getParameter("units")));
            pstmt.setInt(5, Integer.parseInt(request.getParameter("s_ssn")));
            pstmt.setInt(6, Integer.parseInt(request.getParameter("section_id")));
            pstmt.setString(7, request.getParameter("co_number"));
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
            ("SELECT * FROM course_enrollment");
%>

<!-- Add an HTML table header row to format the results -->
    <table border="1">
        <tr>
               <th>Student SSN</th>
               <th>Course Name</th>
               <th>Section Number</th>
               <th>Unit</th>
               <th>New Course Name</th>
               <th>New Section ID</th>
           </tr>
           <tr>
               <form action="course_enrollment_4.jsp" method="get">
                   <input type="hidden" value="insert" name="action">
                   <th><input value="" name="s_ssn" size="10"></th>
                   <th><input value="" name="co_number" size="10"></th>
                   <th><input value="" name="section_id" size="10"></th>
                   <th><input value="" name="units" size="10"></th>
                   <th><input type="submit" value="Insert"></th>
               </form>
           </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs.next() ) {

%>

        <tr>
            <form action="course_enrollment_4.jsp" method="get">
                <input type="hidden" value="update" name="action">

                <%-- Get the SSN, which is a number --%>
                <td>
                    <input value="<%= rs.getInt("s_ssn") %>" 
                        name="s_ssn" size="10">
                </td>

                <td>
                    <input value="<%= rs.getString("co_number") %>" 
                        name="co_number" size="10">
                </td>

                <td>
                    <input value="<%= rs.getInt("section_id") %>"
                        name="section_id" size="15">
                </td>

                <td>
                    <input value="<%= rs.getInt("units") %>" 
                        name="units" size="15">
                </td>
                <td>
                    <input value=""
                        name="new_course_name" size="15">
                </td>

                <td>
                    <input value="" 
                        name="new_section_id" size="15">
                </td>
                <td>
                    <input type="submit" value="Update">
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