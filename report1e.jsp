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
Statement statement3 = conn.createStatement();
Statement statement4 = conn.createStatement();

/*
    Display all students who are enrolled in the current quarter
*/

/*
    TODO :
        Update degrees to correctly indicate undergraduate, bs, ms, etc
*/
ResultSet rs_one = statement1.executeQuery
    ("SELECT * FROM student WHERE enrolled = '1' AND degrees = 'ms'");
ResultSet rs_two = statement2.executeQuery
    ("SELECT * FROM student WHERE enrolled = '1' AND degrees = 'ms'");
ResultSet rs_three = statement3.executeQuery
    ("SELECT d_department, d_degree_name FROM degree");
ResultSet rs_four = statement4.executeQuery
    ("SELECT d_department, d_degree_name FROM degree");    
%>

<%
    String action = request.getParameter("action");
    ResultSet rs_five = null;
    ResultSet rs_six = null;
    if (action != null && action.equals("get")) {
        int ssn = Integer.parseInt(request.getParameter("ssn"));
        String str_ssn = Integer.toString(ssn);
        String degree = request.getParameter("degree");
        // Completed Concentrations
        Statement statement5 = conn.createStatement();
        rs_five = statement5.executeQuery
        ("SELECT c.title FROM student s, class c, course cs, concentration ct, past_classes pc, student_ms sms, grade_conversion gc, grade_conversion ggc WHERE s.s_ssn = " + str_ssn + " AND ct.degree = '" + degree + "' AND sms.degree = ct.ms AND cs.co_number = c.co_number AND pc.section_id = c.section_id AND ct.co_number = pc.co_number AND pc.grade = gc.LETTER_GRADE AND ct.min_gpa = ggc.LETTER_GRADE AND gc.number_grade > ggc.number_grade HAVING SUM(cs.units) > ct.min_num_units");

        // Not completed courses in every concentration
        Statement statement6 = conn.createSteatment();
        rs_six = statement6.exectueQuery
        ("SELECT ct.co_number, (c.quarter, c.year) AS Offered FROM concentration ct, student s, class c WHERE s.s_ssn = " + str_ssn + " AND ct.degree = '" + degree + "' AND c.year > 2015 AND c.co_number = ct.co_number AND NOT IN (SELECT pc.co_number FROM past_classes pc WHERE pc.s_ssn = s.s_ssn AND pc.co_number = ct.co_number) GROUPBY ct.concentration");
    }
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
            <th>Name</th>
            <th>Type</th>
        </tr>

    <%-- -------- Iteration Code -------- --%>
    <%
        // Iterate over the ResultSet
        while ( rs_three.next() ) {
    %>
        <tr>
            <td>
                <input value="<%= rs_three.getString("d_department") %>" 
                    name="d_department" size="10">
            </td>

            <td>
                <input value="<%= rs_three.getString("d_degree_name") %>" 
                    name="d_degree_name" size="10">
            </td>
        </tr>
    <%
            }
    %>
    </table>

    <form action="report1e.jsp" method="get">
        <input type="hidden" value="get" name="action">
            <select name = "ssn">
            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while ( rs_two.next() ) {

            %>
                <option id ='ssn'> <%= rs_two.getInt("s_ssn") %> </option>
            <%
                }
            %>
            </select>

            <select name = "degree">
            <%
                // Iterate over the ResultSet
                while ( rs_four.next() ) {

            %>
                <option id ='d_degree_name'> <%= rs_four.getString("d_degree_name") %> </option>
            <%
                }
            %>
            </select>
        
            <button type = "submit" value = "submit">
                Click to see course information
            </button>    
    </form>

<%-- -------- Close Connection Code -------- --%>
<%
// Close the ResultSet
rs_one.close();
rs_two.close();
rs_three.close();
rs_four.close();
rs_five.close();
rs_six.close();
// Close the Statement
statement1.close();
statement2.close();
statement3.close();
statement4.close();
statement5.close();
statement6.close();

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
