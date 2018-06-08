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
    ResultSet rs_one = statement1.executeQuery
        ("SELECT * FROM past_classes");

    Statement statement2 = conn.createStatement();
    ResultSet rs_two = statement2.executeQuery
        ("SELECT * FROM cpg");

    Statement statement3 = conn.createStatement();
    ResultSet rs_three = statement3.executeQuery
        ("SELECT * FROM cpqg");
%>

<%-- -------- INSERT Code -------- --%>
<%
        String action = request.getParameter("action");
        // Check if an insertion is requested
        if (action != null && action.equals("insert")) {
            // Begin transaction
            conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT the student attributes INTO the Faculty table.
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO past_classes VALUES (?, ?, ?, ?, ?, ?, ?)");

            pstmt.setInt(1, Integer.parseInt(request.getParameter("s_ssn")));
            pstmt.setString(2, request.getParameter("co_number"));
            pstmt.setInt(3, Integer.parseInt(request.getParameter("section_id")));
            pstmt.setInt(4, Integer.parseInt(request.getParameter("year"))); 
            pstmt.setString(5, request.getParameter("quarter"));
            pstmt.setString(6, request.getParameter("grade"));
            pstmt.setString(7, request.getParameter("f_name"));

            int rowCount = pstmt.executeUpdate();

            // Commit transaction
            conn.commit();
            conn.setAutoCommit(true);
        }
%>

<%-- -------- UPDATE Code -------- --%>
<%
        // Check if an update is requested
        if (action != null && action.equals("update")) {

            // Begin transaction
            conn.setAutoCommit(false);
                        
            PreparedStatement pstmt = conn.prepareStatement(
                "UPDATE past_classes grade = ? WHERE s_ssn = ? and co_number = ? and section_id = ? and year = ? and quarter = ?");

            pstmt.setString(1, request.getParameter("grade"));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("s_ssn")));
            pstmt.setString(3, request.getParameter("co_number"));
            pstmt.setInt(4, Integer.parseInt(request.getParameter("section_id")));
            pstmt.setInt(5, Integer.parseInt(request.getParameter("year"))); 
            pstmt.setString(6, request.getParameter("quarter"));
            int rowCount = pstmt.executeUpdate();

            // Commit transaction
                conn.commit();
            conn.setAutoCommit(true);
        }
%>


    <table border="1">
        <tr>
            <th>s_ssn</th>
            <th>co_number</th>
            <th>section_id</th>
            <th>year</th>
            <th>quarter</th>
            <th>grade</th>
            <th>f_name</th>
        </tr>

        <tr>
          <form action="past_classes_4.jsp" method="get">
          <input type="hidden" value="insert" name="action">
          <th><input value="" name="s_ssn" size="10"></th>
          <th><input value="" name="co_number" size="15"></th>
          <th><input value="" name="section_id" size="15"></th>
          <th><input value="" name="year" size="15"></th>
          <th><input value="" name="quarter" size="10"></th>
          <th><input value="" name="grade" size="10"></th>
          <th><input value="" name="f_name" size="10"></th>
          <th><input type="submit" value="Insert"></th>
          </form>
        </tr>

<%
        while ( rs_one.next() ) {
%>

    <tr>
        <form action="past_classes_4.jsp" method="get">

         <input type="hidden" value="update" name="action">
    <td>
        <input value="<%= rs_one.getInt("s_ssn") %>" 
            name="s_ssn" size="10">
    </td>
    <td>
        <input value="<%= rs_one.getString("co_number") %>" 
            name="co_number" size="10">
    </td>
    <td>
        <input value="<%= rs_one.getInt("section_id") %>" 
            name="co_number" size="10">
    </td>
    <td>
        <input value="<%= rs_one.getInt("year") %>" 
            name="year" size="10">
    </td>
    <td>
        <input value="<%= rs_one.getString("quarter") %>" 
            name="quarter" size="10">
    </td>
    <td>
        <input value="<%= rs_one.getString("grade") %>" 
            name="grade" size="10">
    </td>
    <td>
        <input value="<%= rs_one.getString("f_name") %>" 
            name="f_name" size="10">
    </td>
    <td>
        <input type="submit" value="Update">
    </td>

    </form>
    </tr>
<%
        }
%>
    </table>



<h1>cpg</h1>
<table border="1">
        <tr>
            <th>co_number</th>
            <th>f_name</th>
            <th>a</th>
            <th>b</th>
            <th>c</th>
            <th>d</th>
            <th>other</th>
            
        </tr>


<%
        while ( rs_two.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_two.getString("co_number") %>" 
            name="co_number" size="10">
    </td>
    <td>
        <input value="<%= rs_two.getString("f_name") %>" 
            name="f_name" size="10">
    </td>
    <td>
        <input value="<%= rs_two.getString("a") %>" 
            name="a" size="10">
    </td>
    <td>
        <input value="<%= rs_two.getString("b") %>" 
            name="b" size="10">
    </td>
    <td>
        <input value="<%= rs_two.getString("c") %>" 
            name="c" size="10">
    </td>
    <td>
        <input value="<%= rs_two.getString("d") %>" 
            name="d" size="10">
    </td>
    <td>
        <input value="<%= rs_two.getString("other") %>" 
            name="other" size="10">
    </td>
    </tr>
<%
        }
%>
    </table>





<h1>cpqg</h1>
<table border="1">
        <tr>
            <th>co_number</th>
            <th>f_name</th>
            <th>quarter</th>
            <th>year</th>
            <th>a</th>
            <th>b</th>
            <th>c</th>
            <th>d</th>
            <th>other</th>    
        </tr>


<%
        while ( rs_three.next() ) {
%>

    <tr>
    <td>
        <input value="<%= rs_three.getString("co_number") %>" 
            name="co_number" size="10">
    </td>
    <td>
        <input value="<%= rs_three.getString("f_name") %>" 
            name="f_name" size="10">
    </td>
    <td>
        <input value="<%= rs_three.getString("quarter") %>" 
            name="quarter" size="10">
    </td>
    <td>
        <input value="<%= rs_three.getString("year") %>" 
            name="year" size="10">
    </td>
    <td>
        <input value="<%= rs_three.getString("a") %>" 
            name="a" size="10">
    </td>
    <td>
        <input value="<%= rs_three.getString("b") %>" 
            name="b" size="10">
    </td>
    <td>
        <input value="<%= rs_three.getString("c") %>" 
            name="c" size="10">
    </td>
    <td>
        <input value="<%= rs_three.getString("d") %>" 
            name="d" size="10">
    </td>
    <td>
        <input value="<%= rs_three.getString("other") %>" 
            name="other" size="10">
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
        rs_three.close();
        // Close the Statement
        statement1.close();
        statement2.close();
        statement3.close();

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