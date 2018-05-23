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

    Statement statement8 = conn.createStatement();
    Statement statement9 = conn.createStatement();

    Statement statement4 = conn.createStatement();
    Statement statement5 = conn.createStatement();

    Statement statement6 = conn.createStatement();
    Statement statement7 = conn.createStatement();

    /*
        Display all students who are enrolled in the current quarter
    */
    ResultSet rs_one = statement1.executeQuery
    ("SELECT distinct(section_id) FROM course_enrollment");
    ResultSet rs_two = statement2.executeQuery
    ("SELECT distinct(section_id) FROM course_enrollment");

    ResultSet rs_eight = statement8.executeQuery
    ("SELECT f_name FROM faculty");
    ResultSet rs_nine = statement9.executeQuery
    ("SELECT f_name FROM faculty");

    //ResultSet rs_four = statement4.executeQuery
    //("SELECT date FROM may");
    ResultSet rs_five = statement5.executeQuery
    ("SELECT month,day FROM may");
    
    //ResultSet rs_six = statement6.executeQuery
    //("SELECT date FROM may");
    ResultSet rs_seven = statement7.executeQuery
    ("SELECT month,day FROM may");
    
%>



<%
    String action = request.getParameter("action");
    ResultSet rs_three = null;
    if (action != null && action.equals("get")) {
        String f_n = request.getParameter("f_name");
        int s_id = Integer.parseInt(request.getParameter("section_id"));
        String str_s_id = Integer.toString(s_id);
        String start_date = request.getParameter("start_date");
        String end_date = request.getParameter("end_date");
        Statement statement3 = conn.createStatement();
        //String f_day = start_date.split(' ')[1];
        //int first_day = Integer.parseInt(f_day);
        //String s_day = end_date.split(' ')[1];
        //int second_day = Integer.parseInt(s_day);
        String query3 = "SELECT (m.month, m.day, 'Monday', rsh.fully, c.le_ampm) AS Review_Session FROM student s, class c, faculty f, course_enrollment ce, review_session_hours rsh, may m WHERE s.s_ssn = ce.s_ssn AND m.day >= " + start_date + " AND m.day <= " + end_date + " AND ce.s_ssn = s.s_ssn AND c.le_time != rsh.beg AND c.le_ampm != rsh.ampm AND f.f_name = '" + f_n + "' AND f.f_name = c.f_name AND ce.section_id = " + str_s_id + "";
        out.println(query3);
        //rs_three = statement3.executeQuery(query3);
    }
%>

    <table border="1">
        <tr>
            <th>Instructor</th>
        </tr>


<%
        while ( rs_eight.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_eight.getString("f_name") %>" 
            name="f_name" size="10">
    </td>
    </tr>
    

<%
        }
%>
    </table>

    <table border="1">
        <tr>
            <th>Section ID</th>
        </tr>


<%
        while ( rs_one.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_one.getInt("section_id") %>" 
            name="section_id" size="10">
    </td>
    </tr>
    

<%
        }
%>
</table>

 


<%-- -------- Iteration Code -------- --%>
        <form action="report2b.jsp" method="get">
        <input type="hidden" value="get" name="action">
        <select name="f_name">
<%
        // Iterate over the ResultSet
        while ( rs_nine.next() ) {

%>

            <option id ='f_name'> <%= rs_nine.getString("f_name") %> </option>
<%
        }
%>
        </select>
        
        <select name="section_id">
<%
        // Iterate over the ResultSet
        while ( rs_two.next() ) {

%>

            <option id ='section_id'> <%= rs_two.getInt("section_id") %> </option>
<%
        }
%>
        </select>

        <select name="start_date">
<%
        // Iterate over the ResultSet
        while ( rs_five.next() ) {

%>

            <option id ='start_date'> <%= rs_five.getString("day") %> </option>
<%
        }
%>
        </select>

        <select name="end_date">
<%
        // Iterate over the ResultSet
        while ( rs_seven.next() ) {

%>

            <option id ='end_date'> <%= rs_seven.getString("day") %> </option>
<%
        }
%>
        </select>
        <button type="submit" value="submit"> Do It </button>
        </form>


<!-- 
            m.date, Monday, rsh.time, c.le_ampm) AS Review_Session
 -->
<!-- REPORT -->
<table border="1">
        <tr>
            <th> Review_Session </th>
        </tr>

<%
        // Iterate over the ResultSet
        while (rs_three != null && rs_three.next() ) {

%>

        <tr>
                <td>
                    <input value="<%= rs_three.getString("review_session") %>" 
                        name="review_session" size="10">
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
