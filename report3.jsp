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
    Statement statement1 = conn.createStatement();
    Statement statement2 = conn.createStatement();
    Statement statement4 = conn.createStatement();
    Statement statement5 = conn.createStatement();
    Statement statement6 = conn.createStatement();
    Statement statement7 = conn.createStatement();

    /*
        Display all students who are enrolled in the current quarter
    */
    ResultSet rs_one = statement1.executeQuery
        ("SELECT co_number FROM course");
    ResultSet rs_two = statement2.executeQuery
        ("SELECT co_number FROM course");
    ResultSet rs_four = statement4.executeQuery
        ("SELECT f.f_name FROM faculty");
    ResultSet rs_five = statement5.executeQuery
        ("SELECT f.f_name FROM faculty");
    ResultSet rs_six = statement6.executeQuery
        ("SELECT distinct(quarter) FROM class");
    ResultSet rs_seven = statement7.executeQuery
        ("SELECT distinct(quarter) FROM class");
%>

<%
        String action = request.getParameter("action");
        ResultSet rs_three = null;
        if (action != null && action.equals("get")) {
            int ssn = Integer.parseInt(request.getParameter("ssn"));
            String str_ssn = Integer.toString(ssn);
            Statement statement3 = conn.createStatement();
            // Account for only the lecture time
            rs_three = statement3.executeQuery
            ("");
        }
%>

    <table border="1">
        <tr>
            <th>Course ID</th>
        </tr>

<%
        while ( rs_one.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_one.getString("co_number") %>" 
            name="co_number" size="10">
    </td>
    </tr>
<%
        }
%>
    </table>

    <table border="1">
        <tr>
            <th>Instructor</th>
        </tr>

<%
        while ( rs_four.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_four.getString("f.f_name") %>" 
            name="f.f_name" size="10">
    </td>
    </tr>
<%
        }
%>
    </table>

    <table border="1">
        <tr>
            <th>Quarter</th>
        </tr>

<%
        while ( rs_six.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_six.getString("quarter") %>" 
            name="quarter" size="10">
    </td>
    </tr>
<%
        }
%>
    </table>

<%-- -------- Iteration Code -------- --%>
        <form action="report3.jsp" method="get">
        <input type="hidden" value="get" name="action">
        <select name="co_number">
<%
        // Iterate over the ResultSet
        while ( rs_two.next() ) {

%>

            <option id ='co_number'> <%= rs_two.getString("co_number") %> </option>
<%
        }
%>
        </select>

        <select name="f.f_name">
<%
        // Iterate over the ResultSet
        while ( rs_five.next() ) {
%>

            <option id ='f.f_name'> <%= rs_five.getString("f.f_name") %> </option>
<%
        }
%>
        </select>

        <select name="quarter">
<%
        // Iterate over the ResultSet
        while ( rs_seven.next() ) {

%>

            <option id ='quarter'> <%= rs_seven.getString("quarter") %> </option>
<%
        }
%>
        </select>
        <button type="submit" value="submit"> Do It </button>
        </form>


<!-- REPORT -->
<table border="1">
        <tr>
            <th>Average Grade</th>
            
        </tr>

<!-- <%
        // Iterate over the ResultSet
        while (rs_three != null && rs_three.next() ) {

%>

        <tr>
                <td>
                    <input value="<%= rs_three.getString("title") %>" 
                        name="title" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getString("co_number") %>" 
                        name="co_number" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getString("conf_title") %>" 
                        name="conf_title" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getString("conf_co") %>" 
                        name="conf_co" size="10">
                </td>


        </tr>
<%
        }
%> -->
</table>

<%-- -------- Close Connection Code -------- --%>
<%
        // Close the ResultSet
        rs_one.close();
        rs_two.close();
        // Close the Statement
        statement1.close();
        statement2.close();

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
