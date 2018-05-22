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
            ("SELECT c.title, c.quarter, c.year FROM class c");
        ResultSet rs_two = statement2.executeQuery
            ("SELECT c.title, c.quarter, c.year FROM class c");
%>

<%
        String action = request.getParameter("action");
        ResultSet rs_three = null;
        if (action != null && action.equals("get")) {
            String title = request.getParaneter("title")l
            Statement statement3 = conn.createStatement();
            rs_three = statement3.executeQuery
            ("SELECT s.*, c.units, cs.grading_option FROM student s, cource c, class cs, course_enrollment ce WHERE cs.title = " + title + " AND cs.co_number = c.co_number AND ce.co_number = cs.co_number AND ce.s_ssn = s.s_ssn");
        }
%>

<%
        String action = request.getParameter("action");
        ResultSet rs_three = null;
        if (action != null && action.equals("get")) {
            String title = request.getParameter("title");
            Statement statement3 = conn.createStatement();
            String query = "SELECT DISTINCT(s.*), c.units, c.grade_option FROM student s, course c, class cs, course_enrollment ce WHERE cs.title = '" + title + "' AND cs.co_number = c.co_number AND ce.co_number = cs.co_number AND ce.s_ssn = s.s_ssn";
            rs_three = statement3.executeQuery
            (query);

            
        }
%>

    <table border="1">
        <tr>
            <th>Course</th>
            <th>Quarter</th>
            <th>Year</th>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs_one.next() ) {

%>

    <tr>
    <!-- <form action="report1.jsp" method="get"> -->
    <td>
        <input value="<%= rs_one.getString("title") %>" 
            name="title" size="10">
    </td>
    <td>
        <input value="<%= rs_one.getString("quarter") %>" 
            name="quarter" size="10">
    </td>

    <td>
        <input value="<%= rs_one.getInt("year") %>"
            name="year" size="15">
    </td>

    <!-- </form> -->
    </tr>
    

<%
        }
%>
</table>
<%-- -------- Iteration Code -------- --%>
        <form action="report1b.jsp" method="get">
        <input type="hidden" value="get" name="action">
        <select name="title">
<%
        // Iterate over the ResultSet
        while ( rs_two.next() ) {

%>

            <option id ='title'> <%= rs_two.getString("title") %> </option>
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
                    <input value="<%= rs_three.getInt("s_ssn") %>" 
                        name="s_ssn" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("first_name") %>" 
                        name="first_name" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("middle_name") %>" 
                        name="middle_name" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("last_name") %>" 
                        name="last_name" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getString("period_of_attendance") %>" 
                        name="period_of_attendance" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getInt("enrolled") %>" 
                        name="enrolled" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("degrees") %>" 
                        name="degrees" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("california") %>" 
                        name="california" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("foreigner") %>" 
                        name="foreigner" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("non_ca") %>" 
                        name="non_ca" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("student_id") %>" 
                        name="student_id" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("units") %>" 
                        name="units" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("grade_option") %>" 
                        name="grade_option" size="10">
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