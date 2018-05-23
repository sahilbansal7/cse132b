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
            String query = "SELECT c.*, ce.units FROM class c, course_enrollment ce, student s WHERE s.s_ssn = " + str_ssn + " AND ce.s_ssn = s.s_ssn AND ce.section_id = c.section_id AND ce.co_number = c.co_number";
            out.println(query);
            rs_three = statement3.executeQuery
            (query);

            
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
            <th>le_day</th>
            <th>di</th>
            <th>enroll_limit</th>
            <th>di_mandatory</th>
            <th>f_name</th>
            <th>co_number</th>
            <th>review_session</th>
            <th>waitlist</th>
            <th>quarter</th>
            <th>year</th>
            <th>le_time</th>
            <th>le_ampm</th>
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
                    <input value="<%= rs_three.getString("le_day") %>" 
                        name="le_day" size="10">
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
                    <input value="<%= rs_three.getString("le_time") %>" 
                        name="le_time" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("le_ampm") %>" 
                        name="le_ampm" size="10">
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
