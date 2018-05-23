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
    ("SELECT section_id FROM course_enrollment");
    ResultSet rs_two = statement2.executeQuery
    ("SELECT section_id FROM course_enrollment");

    ResultSet rs_four = statement4.executeQuery
    ("SELECT start_date FROM may");
    ResultSet rs_five = statement5.executeQuery
    ("SELECT start_date FROM may");
    
    ResultSet rs_six = statement6.executeQuery
    ("SELECT end_date FROM may");
    ResultSet rs_seven = statement7.executeQuery
    ("SELECT end_date FROM may");
    
%>

<%
    String action = request.getParameter("action");
    ResultSet rs_three = null;
    if (action != null && action.equals("get")) {
        int ssn = Integer.parseInt(request.getParameter("ssn"));
        String str_ssn = Integer.toString(ssn);
        String start_date = request.getParameter("start_date");
        String end_date = request.getParameter("end_date");
        Statement statement3 = conn.createStatement();
        rs_three = statement3.executeQuery
        ("SELECT (m.date, Monday, rsh.time, c.le_ampm) AS Review_Session FROM student s, student_enrollment se, class c, course_enrollment ce, review_session_hours rsh, may m WHERE s.s_ssn = " + str_ssn + " AND m.date >= '" + start_date + "' AND m.date <= '" + end_date + "' AND s.s_ssn = se.s_ssn AND ce.section_id = se.section_id AND ce.co_number = se.co_number AND se.section_id = c.section_id AND se.co_number = c.co_number AND c.quarter = 'Spring' AND c.year = 2018 AND c.le_day = rsh.day AND c.le_time = rsh.beginning AND c.le_ampm = rsh.ampm");
    }
%>

    <table border="1">
        <tr>
            <th>SSN</th>
            <th>First Name</th>
            <th>Middle Name (Optional)</th>
            <th>Last Name</th>
        </tr>


<%
        while ( rs_one.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_one.getInt("s_ssn") %>" 
            name="s_ssn" size="10">
    </td>

    <td>
        <input value="<%= rs_one.getString("first_name") %>" 
            name="first_name" size="10">
    </td>

    <td>
        <input value="<%= rs_one.getString("middle_name") %>"
            name="middle_name" size="15">
    </td>

    <td>
        <input value="<%= rs_one.getString("last_name") %>" 
            name="last_name" size="15">
    </td>
    </tr>
    

<%
        }
%>
    </table>

    <table border="1">
        <tr>
            <th>Start Date</th>
        </tr>


<%
        while ( rs_four.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_four.getString("start_date") %>" 
            name="start_date" size="10">
    </td>
    </tr>
    

<%
        }
%>
    </table>

    <table border="1">
        <tr>
            <th>End Date</th>
        </tr>


<%
        while ( rs_six.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_six.getString("end_date") %>" 
            name="end_date" size="10">
    </td>
    </tr>
    

<%
        }
%>
    </table>


<%-- -------- Iteration Code -------- --%>
        <form action="report2b.jsp" method="get">
        <input type="hidden" value="get" name="action">
        <select name="ssn">
<%
        // Iterate over the ResultSet
        while ( rs_two.next() ) {

%>

            <option id ='ssn'> <%= rs_two.getInt("s_ssn") %> </option>
<%
        }
%>
        </select>

        <select name="start_date">
<%
        // Iterate over the ResultSet
        while ( rs_five.next() ) {

%>

            <option id ='start_date'> <%= rs_five.getString("start_date") %> </option>
<%
        }
%>
        </select>

        <select name="end_date">
<%
        // Iterate over the ResultSet
        while ( rs_seven.next() ) {

%>

            <option id ='end_date'> <%= rs_seven.getString("end_date") %> </option>
<%
        }
%>
        </select>
        <button type="submit" value="submit"> Do It </button>
        </form>


<!-- REPORT -->
<table border="1">
        <tr>
            <th>title</th>
            <th>section_id</th>
            <th>le</th>
            <th>di</th>
            <th>enroll_limit</th>
            <th>di_mandatory</th>
            <th>f_name</th>
            <th>co_number</th>
            <th>review_session</th>
            <th>waitlist</th>
            <th>quarter</th>
            <th>year</th>
            <th>units</th>
        </tr>

<%
        // Iterate over the ResultSet
        while (rs_three != null && rs_three.next() ) {

%>

        <tr>
                <td>
                    <input value="<%= rs_three.getString("title") %>" 
                        name="title" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getInt("section_id") %>" 
                        name="section_id" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("le") %>" 
                        name="le" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getString("di") %>" 
                        name="di" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getInt("enroll_limit") %>" 
                        name="enroll_limit" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("di_mandatory") %>" 
                        name="di_mandatory" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("f_name") %>" 
                        name="f_name" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("co_number") %>" 
                        name="co_number" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("review_session") %>" 
                        name="review_session" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("waitlist") %>" 
                        name="waitlist" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("quarter") %>" 
                        name="quarter" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("year") %>" 
                        name="year" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("units") %>" 
                        name="units" size="10">
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
