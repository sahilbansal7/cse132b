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

    /*
        Display all students who are enrolled in the current quarter
    */
    ResultSet rs_one = statement1.executeQuery
        ("SELECT * FROM student s, student_enrollment se WHERE se.s_ssn = s.s_ssn AND se.quarter = 'Spring' AND se.year = '2018'");
    ResultSet rs_two = statement2.executeQuery
        ("SELECT * FROM student s, student_enrollment se WHERE se.s_ssn = s.s_ssn AND se.quarter = 'Spring' AND se.year = '2018'");
%>

<%
        String action = request.getParameter("action");
        ResultSet rs_three = null;
        if (action != null && action.equals("get")) {
            int ssn = Integer.parseInt(request.getParameter("ssn"));
            String str_ssn = Integer.toString(ssn);
            Statement statement3 = conn.createStatement();
            String hour = ("interval '1 hour'");
            // Account for only the lecture time
            rs_three = statement3.executeQuery
            ("SELECT not_enrolled.title, cc.* FROM student s, class enrolled, class not_enrolled, course c, course_enrollment ce WHERE s.s_ssn = " + str_ssn + " AND s.s_ssn = ce.s_ssn AND enrolled.co_number = ce.co_number AND enrolled.section_id = ce.section_id AND ce.co_number = c.co_number AND enrolled.co_number != not_enrolled.co_number AND enrolled.day = not_enrolled.day AND (enrolled.le_time = not_enrolled.le_time OR not_enrolled.le_time > enrolled.le_time AND not_enrolled.le_time < (enrolled.le_time + " + hour + ") OR (not_enrolled.le_time + " + hour + ") > enrolled.le_time AND (not_enrolled.le_time + " + hour + ") < (enrolled.le_time + " + hour + "))");
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


<%-- -------- Iteration Code -------- --%>
        <form action="report1.jsp" method="get">
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
