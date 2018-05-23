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
    Statement statement8 = conn.createStatement();
    Statement statement9 = conn.createStatement();

    /*
        Display all students who are enrolled in the current quarter
    */
    ResultSet rs_one = statement1.executeQuery
        ("SELECT co_number FROM course");
    ResultSet rs_two = statement2.executeQuery
        ("SELECT co_number FROM course");
    ResultSet rs_four = statement4.executeQuery
        ("SELECT f_name FROM faculty");
    ResultSet rs_five = statement5.executeQuery
        ("SELECT f_name FROM faculty");
    ResultSet rs_six = statement6.executeQuery
        ("SELECT distinct(quarter) FROM class");
    ResultSet rs_seven = statement7.executeQuery
        ("SELECT distinct(quarter) FROM class");
    ResultSet rs_eight = statement8.executeQuery
        ("SELECT distinct(year) FROM class");
    ResultSet rs_nine = statement9.executeQuery
        ("SELECT distinct(year) FROM class");
%>
<%
        String action = request.getParameter("action");
        ResultSet rs_three = null;
        ResultSet rs_ten = null;
        ResultSet rs_eleven = null;
        if (action != null && action.equals("get")) {
            String co_number = request.getParameter("co_number");
            String f_name = request.getParameter("f_name");
            String quarter = request.getParameter("quarter");
            String year = request.getParameter("year");
            Statement statement3 = conn.createStatement();
            Statement statement10 = conn.createStatement();
            Statement statement11 = conn.createStatement();

            String query3 = "(SELECT COUNT(pc.grade) AS A FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND c.year = '" + year + "' AND c.quarter = '" + quarter + "' AND (pc.grade = 'A' OR pc.grade = 'A+' OR pc.grade = 'A-') AND pc.quarter = c.quarter AND pc.year = c.year) UNION ALL (SELECT COUNT(pc.grade) AS B FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND c.year = '" + year + "' AND c.quarter = '" + quarter + "' AND (pc.grade = 'B' OR pc.grade = 'B+' OR pc.grade = 'B-') AND pc.quarter = c.quarter AND pc.year = c.year) UNION ALL (SELECT COUNT(pc.grade) AS C FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND c.year = '" + year + "' AND c.quarter = '" + quarter + "' AND (pc.grade = 'C' OR pc.grade = 'C+' OR pc.grade = 'C-') AND pc.quarter = c.quarter AND pc.year = c.year) UNION ALL (SELECT COUNT(pc.grade) AS D FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND c.year = '" + year + "' AND c.quarter = '" + quarter + "' AND (pc.grade = 'D' OR pc.grade = 'D+' OR pc.grade = 'D-') AND pc.quarter = c.quarter AND pc.year = c.year) UNION ALL (SELECT COUNT(pc.grade) AS Other FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND c.year = '" + year + "' AND c.quarter = '" + quarter + "' AND (pc.grade = 'F' OR pc.grade = 'IN') AND pc.quarter = c.quarter AND pc.year = c.year)";
            rs_three = statement3.executeQuery
            (query3);

            String query5 = "(SELECT COUNT(pc.grade) AS A FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND (pc.grade = 'A' OR pc.grade = 'A+' OR pc.grade = 'A-')) UNION ALL (SELECT COUNT(pc.grade) AS B FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND (pc.grade = 'B' OR pc.grade = 'B+' OR pc.grade = 'B-')) UNION ALL (SELECT COUNT(pc.grade) AS C FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND  (pc.grade = 'C' OR pc.grade = 'C+' OR pc.grade = 'C-')) UNION ALL (SELECT COUNT(pc.grade) AS D FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND (pc.grade = 'D' OR pc.grade = 'D+' OR pc.grade = 'D-')) UNION ALL (SELECT COUNT(pc.grade) AS Other FROM faculty f, student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND c.f_name = f.f_name AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND f.f_name = '" + f_name + "' AND (pc.grade = 'F' OR pc.grade = 'IN'))";
            rs_eleven = statement10.executeQuery(query5);

            String query4 = "(SELECT COUNT(pc.grade) AS A FROM student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND (pc.grade = 'A' OR pc.grade = 'A+' OR pc.grade = 'A-')) UNION ALL (SELECT COUNT(pc.grade) AS B FROM student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND (pc.grade = 'B' OR pc.grade = 'B+' OR pc.grade = 'B-')) UNION ALL (SELECT COUNT(pc.grade) AS C FROM student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND (pc.grade = 'C' OR pc.grade = 'C+' OR pc.grade = 'C-')) UNION ALL (SELECT COUNT(pc.grade) AS D FROM student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND (pc.grade = 'D' OR pc.grade = 'D+' OR pc.grade = 'D-')) UNION ALL (SELECT COUNT(pc.grade) AS Other FROM student s, past_classes pc, class c WHERE pc.s_ssn = s.s_ssn AND pc.co_number = c.co_number AND c.co_number = '" + co_number + "' AND (pc.grade = 'F' OR pc.grade = 'IN'))";
            rs_ten = statement11.executeQuery(query4);
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
        <input value="<%= rs_four.getString("f_name") %>" 
            name="f_name" size="10">
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

    <table border="1">
        <tr>
            <th>Year</th>
        </tr>

<%
        while ( rs_eight.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_eight.getString("year") %>" 
            name="year" size="10">
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

        <select name="f_name">
<%
        // Iterate over the ResultSet
        while ( rs_five.next() ) {
%>

            <option id ='f_name'> <%= rs_five.getString("f_name") %> </option>
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

        <select name="year">
<%
        // Iterate over the ResultSet
        while ( rs_nine.next() ) {

%>

            <option id ='year'> <%= rs_nine.getString("year") %> </option>
<%
        }
%>
        </select>

        <button type="submit" value="submit"> Do It </button>
        </form>


<!-- REPORT -->
<table border="1">
  <tr>
                <td>
                    As
                </td>
        </tr>
        <tr>
                <td>
                    Bs
                </td>
        </tr>
        <tr>
                <td>
                    Cs
                </td>
        </tr>
        <tr>
                <td>
                    Ds
                </td>
        </tr>
        <tr>
                <td>
                    Others
                </td>
        </tr>
</table>

<p strong> Course ID X, Professor Y, Quarter Z </p>
<table border ='1'>
<%
        // Iterate over the ResultSet
        while (rs_three != null && rs_three.next() ) {

%>

        <tr>
                <td>
                    <input value="<%= rs_three.getString("A") %>"name="A" size="10">
                </td>
        </tr>
<%
        }
%>
</table>

<p strong> Course ID X, Professor Y </p>
<table border ='1'>
<%
        // Iterate over the ResultSet
        while (rs_ten != null && rs_ten.next() ) {
%>
        <tr>
                <td>
                    <input value="<%= rs_ten.getString("A") %>"name="A" size="10">
                </td>
        </tr>
<%
        }
%>
</table>

<p strong> Course ID X </p>
<table border ='1'>
<%
        // Iterate over the ResultSet
        while (rs_eleven != null && rs_eleven.next() ) {
%>
        <tr>
                <td>
                    <input value="<%= rs_eleven.getString("A") %>"name="A" size="10">
                </td>
        </tr>
<%
        }
%>
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
