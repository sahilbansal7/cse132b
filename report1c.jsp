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
        /* QUERY
            // ssn comes from user selection
            ResultSet rs_three = statement3.executeQuery
                ("SELECT * FROM class where EXISTS (SELECT ct.section_id FROM classes_taken ct WHERE ssn = ct.s_ssn) GROUPBY quarter, year");
            // Add grade conversion table 
            ResultSet rs_four = statement4.executeQuery
                ("SELECT AVG(gcv.DECIMAL) FROM past_classes pc, grade_conversion_table gdc WHERE grade != 'IN' AND pc.grade = gdc.LETTER_GRADE GROUPBY quarter, year");
        */ 
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
    <!-- <form action="report1.jsp" method="get"> -->
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
    <!-- </form> -->
    </tr>
    </table>

<%
        }
%>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet
        while ( rs_two.next() ) {

%>
        <form action="report1.jsp" method="get" id = "form1">
            <select>
                <option id ='ssn'> <%= rs_two.getInt("s_ssn") %> </option>
            </select>
        </form>
<%
        }
%>

        <button type = "submit" form = "form1">
            Click to see Grade Report
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
