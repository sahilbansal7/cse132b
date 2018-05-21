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
                        // INSERT the probation attributes INTO the Probation table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Probation VALUES (?,?,?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("s_ssn")));
                        pstmt.setString(2, request.getParameter("period"));
                        pstmt.setString(3, request.getParameter("reason"));
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
                    // the probation attributes FROM the probation table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student SSN</th>
                        <th>Period</th>
                        <th>Reason</th>
                    </tr>
                    <tr>
                        <form action="probation_entry.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="s_ssn" size="10"></th>
                            <th><input value="" name="period" size="10"></th>
                            <th><input value="" name="reason" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="probation_entry.jsp" method="get">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("s_ssn") %>" 
                                    name="s_ssn" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("period") %>" 
                                    name="period" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("reason") %>" 
                                    name="reason" size="10">
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