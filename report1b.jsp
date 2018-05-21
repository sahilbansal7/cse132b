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
            ("SELECT * FROM class");
        ResultSet rs_two = statement2.executeQuery
            ("SELECT * FROM class");
%>

    <table border="1">
        <tr>
            <th>Course</th>
            <th>Section ID</th>
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
        <input value="<%= rs_one.getInt("section_id") %>" 
            name="section_id" size="10">
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
<%
        // Iterate over the ResultSet
        while ( rs_two.next() ) {

%>
        <form action="report1b.jsp" method="get" id = "form1">
            <select>
                <option id ='ssn'> <%= rs_two.getInt("s_ssn") %> </option>
            </select>
        </form>
<%
        }
%>

        <button type = "submit" form = "form1">
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

<script type="text/javascript">
    function displayCourses() {
        console.log("Hi");    
    }
</script>

</html>