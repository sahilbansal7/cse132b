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

        /*
            Display all students who are enrolled in the current quarter
        */
        ResultSet rs_one = statement1.executeQuery
            ("SELECT * FROM student s, student_enrollment se WHERE se.s_ssn = s.s_ssn AND se.quarter = 'SPRING' AND se.year = '2018'");
        ResultSet rs_two = statement2.executeQuery
            ("SELECT * FROM student s, student_enrollment se WHERE se.s_ssn = s.s_ssn AND se.quarter = 'SPRING' AND se.year = '2018'");
        ResultSet rs_three = statement3.executeQuery("SELECT 1 FROM student");
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
        <!-- <form action="report1.jsp" method="get"> -->
            <select>
                <option id ='ssn'> <%= rs_two.getInt("s_ssn") %> </option>
            </select>
            <!-- <input type = "submit">
        </form> -->
<%
        }
%>

    <button onclick = "displayCourses()">
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
    <p id ='course'>
    </p>

    </table>

</td>
</tr>
</table>
</body>

<script type="text/javascript">
    function displayCourses() {
        var course_info = <%= rs_three.getString("last_name") %>                

        document.getElementById("course").innerHTML = course_info;

        // console.log("works");
        // document.getElementById("course").innerHTML = 
        //     "<div>
        //         <%
        //             Statement statement3 = conn.createStatement();
        //             ResultSet rs_three = statement1.executeQuery
        //             ("SELECT * FROM course s, student_enrollment se WHERE se.s_ssn = s.s_ssn AND se.quarter = 'SPRING' AND se.year = '2018'");
        //         %>

        //         <table border='1'>
        //             <tr>
        //                 <th> TITLE </th>
        //                 <th> Section ID </th>
        //                 <th> LECTURE TIME </th>
        //                 <th> Discussion Time </th>
        //                 <th> Enrollment Limit </th>
        //                 <th> Discussion Mandatory </th>
        //                 <th> Faculty Name </th>
        //                 <th> Course Number </th>
        //                 <th> Review Session </th>
        //                 <th> Waitlist </th>
        //             </tr>

        //         <%
        //             // Iterate over the ResultSet
        //             while ( rs_one.next() ) {
        //         %>

        //         <tr>
        //         <td>
        //             <input value="<%= rs_one.getInt("s_ssn") %>" 
        //                 name="s_ssn" size="10">
        //         </td>

        //         <td>
        //             <input value="<%= rs_one.getString("first_name") %>" 
        //                 name="first_name" size="10">
        //         </td>

        //         <td>
        //             <input value="<%= rs_one.getString("middle_name") %>"
        //                 name="middle_name" size="15">
        //         </td>

        //         <td>
        //             <input value="<%= rs_one.getString("last_name") %>" 
        //                 name="last_name" size="15">
        //         </td>
        //         </tr>

        //         <%
        //                 }
        //         %>
        //     </div>";

        // document.getElementById("ssn").value;
    }
</script>

</html>
