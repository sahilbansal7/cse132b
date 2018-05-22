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

        /*
            TODO :
                Update degrees to correctly indicate undergraduate, bs, ms, etc
        */
        ResultSet rs_one = statement1.executeQuery
            ("SELECT * FROM student WHERE enrolled = '1' AND degrees = 'hs'");
        ResultSet rs_two = statement2.executeQuery
            ("SELECT * FROM student WHERE degrees = 'hs' OR 'bs'");
        ResultSet rs_three = statement3.executeQuery
            ("SELECT d_department, d_degree_name FROM degree");
%>

<%
        // First HTML SELECT Prompt
        String action = request.getParameter("action");
        ResultSet rs_four = null;
        if (action != null && action.equals("get")) {
            int ssn = Integer.parseInt(request.getParameter("ssn"));
            out.println(ssn);
            Statement statement4 = conn.createStatement();
            rs_four = statement4.executeQuery
            ("");
        }
        
        // Second HTML SELECT Prompt
        String action = request.getParameter("action2");
        ResultSet rs_five = null;
        if (action != null && action.equals("get")) {
            int ssn = Integer.parseInt(request.getParameter("ssn"));
            out.println(ssn);
            Statement statement5 = conn.createStatement();
            rs_five = statement5.executeQuery 
            ("SELECT AVG(gcv.DECIMAL) FROM past_classes pc, grade_conversion_table gdc WHERE grade != 'IN' AND pc.grade = gdc.LETTER_GRADE GROUPBY quarter, year");
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
