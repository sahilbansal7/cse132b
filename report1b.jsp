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