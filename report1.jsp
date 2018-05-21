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

<%-- -------- SELECT Statement Code -------- --%>
<%
        // Create the statement
        Statement statement = conn.createStatement();

        /*
            Display all students who are enrolled in the current quarter
        */
        ResultSet rs_one = statement.executeQuery
            ("SELECT * FROM student WHERE enrolled = '1'");
        ResultSet rs_two = statement.executeQuery
            ("SELECT * FROM student WHERE enrolled = '1'");
%>

    <table border="1">
        <tr>
            <th>SSN</th>
            <th>First Name</th>
            <th>Middle Name (Optional)</th>
            <th>Last Name</th>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs.next() ) {

%>

    <tr>
    <form action="report1.jsp" method="get">
    <td>
        <!-- <select>
            <option value = "<%= rs.getInt("s_ssn") %>" name = "s_ssn" size = "10">

            </option>
        </select> -->
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
