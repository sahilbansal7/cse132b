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

/*
    TODO :
        Update degrees to correctly indicate undergraduate, bs, ms, etc
*/
ResultSet rs_one = statement1.executeQuery
    ("SELECT * FROM student WHERE enrolled = '1' AND degrees = 'ms'");
ResultSet rs_two = statement2.executeQuery
    ("SELECT d_department, d_degree_name FROM degree");
%>

<%
// First HTML SELECT Prompt
String action = request.getParameter("action");
ResultSet rs_three = null;
ResultSet rs_four = null;
if (action != null && action.equals("get")) {
    int ssn = Integer.parseInt(request.getParameter("ssn"));
    String str_ssn = Integer.toString(ssn);
    String concentration = request.getParameter("concentration");
    // Completed Concentrations
    Statement statement3 = conn.createStatement();
    rs_three = statement3.executeQuery
    ("SELECT c.title FROM student s, class c, course cs, concentration ct, past_classes pc, student_ms sms WHERE s.s_ssn = " + str_ssn + " AND ct.concentration = '" + concentration + "' AND sms.degree = ct.ms AND cs.co_number = c.co_number AND pc.section_id = c.section_id AND ct.co_number = pc.co_number AND pc.grade <= ct.min_gpa HAVING SUM(cs.units) > ct.min_num_units");

    Statement statement4 = conn.createSteatment();
    rs_four = statement4.exectueQuery
    ("");
}
/*
// Second HTML SELECT Prompt
String action = request.getParameter("action2");
ResultSet rs_five = null;
if (action2 != null && action.equals("get")) {
    int ssn = Integer.parseInt(request.getParameter("ssn"));
    String str_ssn = Integer.toString(ssn);
    String degree = request.getParameter("d_department");
    Statement statement5 = conn.createStatement();
    rs_five = statement5.executeQuery 
    ("SELECT min_lower - SUM(c.units) FROM student s, degree d, course c, past_classes pc WHERE s.s_ssn = " + str_ssn + " AND s.degrees = '" + degree + "' AND pc.co_number = c.co_number AND pc.grade != 'F' AND c.category = 'lower'");
}*/
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

<form action="report1d.jsp" method="get">
<input type="hidden" value="get" name="action">
    <select>
<%-- -------- Iteration Code -------- --%>
<%
// Iterate over the ResultSet
while ( rs_one.next() ) {

%>
    <option id ='ssn'> <%= rs_two.getInt("s_ssn") %> </option>
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
        <th>Name</th>
        <th>Type</th>
    </tr>

<%-- -------- Iteration Code -------- --%>
<%
    // Iterate over the ResultSet
    while ( rs_two.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_one.getString("d_department") %>" 
            name="d_department" size="10">
    </td>

    <td>
        <input value="<%= rs_one.getString("d_degree_name") %>" 
            name="d_degree_name" size="10">
    </td>
    </tr>

<%
        }
%>
    </table>

<%-- -------- Iteration Code -------- --%>
    <form action="report1d.jsp" method="get">
    <input type="hidden" value="get" name="action">
        <select>
<%
    // Iterate over the ResultSet
    while ( rs_two.next() ) {

%>
        <option id ='d_degree_name'> <%= rs_two.getString("d_degree_name") %> </option>
<%
        }
%>

        </select>
    </form>
    <button type = "submit" value = "submit">
        Click to see course information
    </button>  

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
