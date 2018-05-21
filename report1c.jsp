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
            ("SELECT * FROM student s WHERE EXISTS (SELECT ss.s_ssn FROM student ss, student_enrollment se WHERE se.s_ssn = ss.s_ssn)");
        ResultSet rs_two = statement2.executeQuery
            ("SELECT * FROM student s WHERE EXISTS (SELECT ss.s_ssn FROM student ss, student_enrollment se WHERE se.s_ssn = ss.s_ssn)");
%>

<%
        String action = request.getParameter("action");
        ResultSet rs_three = null;
        ResultSet rs_four = null;
        if (action != null && action.equals("get")) {
            int ssn = Integer.parseInt(request.getParameter("ssn"));
            out.println(ssn);
            Statement statement3 = conn.createStatement();
            Statement statement4 = conn.createStatement();
            rs_three = statement3.executeQuery("SELECT * FROM class where EXISTS (SELECT ct.section_id FROM classes_taken ct WHERE ssn = ct.s_ssn) GROUPBY quarter, year");
            rs_four = statement4s.executeQuery ("SELECT AVG(gcv.DECIMAL) FROM past_classes pc, grade_conversion_table gdc WHERE grade != 'IN' AND pc.grade = gdc.LETTER_GRADE GROUPBY quarter, year");
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

<%-- -------- Iteration Code -------- --%>
        <form action="report1.jsp" method="get">
            <input type="hidden" value="get" name="action">
            <select name="ssn">
<%
            // Iterate over the ResultSet
            while ( rs_two.next() ) {

%>
                <option id ='ssn'> <%= rs_two.getInt("s_ssn") %></option>
<%
        }
%>

            </select>
            <button type = "submit" form = "form1">
                Click to see Grade Report
            </button>
        </form>    

<!-- REPORT -->

<%
    // Iterate over the ResultSet
    while (rs_three != null && rs_three.next() ) {
%>

    <tr>
        <td>
            <input value="<%= rs_three.getString("title") %>" 
                name="title" size="10">
        </td>
        <!-- <td>
            <input value="<%= rs_three.getString("first_name") %>" 
                name="first_name" size="10">
        </td> -->
    </tr>
<%
        }
%>

<%
    // Iterate over the ResultSet
    while (rs_four != null && rs_four.next() ) {
%>
    <tr>
        <td>
            <input value="<%= rs_four.getInt("DECIMAL") %>" 
                name="DECIMAL" size="10">
        </td>
    </tr>
<%
        }
%>

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
