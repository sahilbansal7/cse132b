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
    ("SELECT * FROM student s, student_ms ms, student_enrollment se WHERE se.s_ssn = s.s_ssn AND se.quarter = 'SPRING' AND se.year = '2018' AND ms.s_ssn = s.s_ssn");
ResultSet rs_two = statement2.executeQuery
    ("SELECT * FROM student s, student_ms ms, student_enrollment se WHERE se.s_ssn = s.s_ssn AND se.quarter = 'SPRING' AND se.year = '2018' AND ms.s_ssn = s.s_ssn");
ResultSet rs_three = statement3.executeQuery
    ("SELECT d_department, d_degree_name FROM degree WHERE d_degree_name = 'ms'");
ResultSet rs_four = statement4.executeQuery
    ("SELECT d_department, d_degree_name FROM degree WHERE d_degree_name = 'ms'");    
%>


<%
    String action = request.getParameter("action");
    ResultSet rs_five = null;
    ResultSet rs_six = null;
    if (action != null && action.equals("get")) {
        int ssn = Integer.parseInt(request.getParameter("ssn"));
        String str_ssn = Integer.toString(ssn);
        String degree = request.getParameter("d_department");
        // Completed Concentrations
        Statement statement5 = conn.createStatement();
        String query5 = "SELECT ct.concentration FROM student s, class c, course cs, table_concentration ct, past_classes pc, student_ms sms, grade_conversion gc, grade_conversion ggc WHERE s.s_ssn = " + str_ssn + " AND s.s_ssn = pc.s_ssn AND sms.s_ssn = s.s_ssn AND ct.ms = '" + degree + "' AND sms.degree = ct.ms AND cs.co_number = c.co_number AND pc.co_number = cs.co_number AND pc.section_id = c.section_id AND ct.co_number = pc.co_number AND pc.grade = gc.letter_grade AND ct.min_gpa = ggc.letter_grade AND gc.number_grade > ggc.number_grade group by ct.concentration, ct.min_unit_req Having SUM(cs.units) >= ct.min_unit_req";
        rs_five = statement5.executeQuery
        (query5);

        // Not completed courses in every concentration
        Statement statement6 = conn.createStatement();
        String query6 = "SELECT ct.concentration, ct.co_number, (c.quarter, c.year) AS Offered FROM table_concentration ct, student s, class c WHERE s.s_ssn = " + str_ssn + " AND ct.ms = '" + degree + "' AND c.year > 2015 AND c.co_number = ct.co_number AND ct.co_number NOT IN (SELECT pc.co_number FROM past_classes pc WHERE pc.s_ssn = s.s_ssn AND pc.co_number = ct.co_number) GROUP BY ct.co_number, (c.quarter, c.year), ct.concentration";
        rs_six = statement6.executeQuery
        (query6);
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
            <th>department</th>
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

            <select name = "d_department">
            <%
                // Iterate over the ResultSet
                while ( rs_four.next() ) {

            %>
                <option id ='d_department'> <%= rs_four.getString("d_department") %> </option>
            <%
                }
            %>
            </select>
        
            <button type = "submit" value = "submit">
                Click to see course information
            </button>    
    </form>

    <table border="1">
        <tr>
            <th>Completed concentrations</th>
        </tr>
<%
    // Iterate over the ResultSet
    while (rs_five != null && rs_five.next() ) {
%>
    <tr>
        <td>
            <input value="<%= rs_five.getString("concentration") %>" 
                name="concentration" size="10">
        </td>
    </tr>
<%
        }
%>
</table>
    <table border="1">
        <tr>
            <th>concentration</th>
            <th>co_number</th>
            <th>offered</th>
        </tr>
<%
    // Iterate over the ResultSet
    while (rs_six != null && rs_six.next() ) {
%>
    <tr>
        <td>
            <input value="<%= rs_six.getString("concentration") %>" 
                name="concentration" size="10">
        </td>
        <td>
            <input value="<%= rs_six.getString("co_number") %>" 
                name="co_number" size="10">
        </td>
        <td>
            <input value="<%= rs_six.getString("offered") %>" 
                name="offered" size="10">
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
