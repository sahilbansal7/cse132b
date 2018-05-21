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
            "INSERT INTO course VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

        pstmt.setString(1, request.getParameter("co_number"));
        pstmt.setString(2, request.getParameter("d_department"));
        pstmt.setInt(3, Integer.parseInt(request.getParameter("lab_work")));
        pstmt.setInt(4, Integer.parseInt(request.getParameter("s_u")));
        pstmt.setInt(5, Integer.parseInt(request.getParameter("units")));
        pstmt.setInt(6, Integer.parseInt(request.getParameter("letter_grade")));
        pstmt.setString(7, request.getParameter("category"));
        pstmt.setString(8, request.getParameter("min_avg_grade"));
        pstmt.setString(9, request.getParameter("d_degree_name"));
        pstmt.setString(10, request.getParameter("prerequisites"));
        
        
        
        

        int rowCount = pstmt.executeUpdate();

        // Commit transaction
        conn.commit();
        conn.setAutoCommit(true);
    }
%>


<%-- -------- SELECT Statement Code -------- --%>
<%
    // Create the statement
    Statement statement = conn.createStatement();

    // Use the created statement to SELECT
    // the student attributes FROM the Faculty table.
    ResultSet rs = statement.executeQuery
        ("SELECT * FROM course");
%>

<!-- Add an HTML table header row to format the results -->
<table border="1">
    <tr>
              <th>Course Name</th>
              <th>Department</th>
              <th>Lab Work</th>
              <th>S_U</th>
              <th>Number of Units</th>
               <th>Letter Grade</th>
              <th>Category</th>
              <th>Minimum Average Grade</th>
              <th>Degree Name</th>
              <th>Prerequisite</th>
             
              
          </tr>
    <tr>
         <form action="course_entry.jsp" method="get">
                  <input type="hidden" value="insert" name="action">
                  <th><input value="" name="co_number" size="10"></th>
                  <th><input value="" name="d_department" size="10"></th>
                  <th><input value="" name="lab_work" size="10"></th>
                  <th><input value="" name="s_u" size="10"></th>
                   <th><input value="" name="units" size="10"></th>
                  <th><input value="" name="letter_grade" size="10"></th>
                  <th><input value="" name="category" size="10"></th>
                  <th><input value="" name="min_avg_grade" size="10"></th>
                  <th><input value="" name="d_degree_name" size="10"></th>
                  <th><input value="" name="prerequisites" size="10"></th>

                 
                  
                  <th><input type="submit" value="Insert"></th>
              </form>
    </tr>

<%-- -------- Iteration Code -------- --%>
<%
    // Iterate over the ResultSet
    while ( rs.next() ) {

%>

    <tr>
        <form action="course_entry.jsp" method="get">

            <%-- Get the SSN, which is a number --%>
            <td>
                <input value="<%= rs.getString("co_number") %>" 
                    name="co_number" size="10">
            </td>
            <td>
                <input value="<%= rs.getString("d_department") %>"
                    name="d_department" size="15">
            </td>
            <td>
                <input value="<%= rs.getString("lab_work") %>" 
                    name="lab_work" size="15">
            </td>
            <%-- Get the ID --%>
            
            <td>
                <input value="<%= rs.getString("s_u") %>" 
                    name="s_u" size="15">
            </td>
            
            <td>
                <input value="<%= rs.getString("units") %>" 
                    name="units" size="15">
            </td>

<%-- Get the LASTNAME --%>
            

            <%-- Get the COLLEGE --%>
            <td>
                <input value="<%= rs.getString("letter_grade") %>" 
                    name="letter_grade" size="15">
            </td>

            <td>
                <input value="<%= rs.getString("category") %>" 
                    name="category" size="15">
            </td>
            <td>
                <input value="<%= rs.getString("min_avg_grade") %>" 
                    name="min_avg_grade" size="15">
            </td>
            <td>
                <input value="<%= rs.getString("d_degree_name") %>" 
                    name="d_degree_name" size="15">
            </td>

            <td>
                <input value="<%= rs.getString("prerequisites") %>" 
                    name="prerequisites" size="10">
            </td>

            <%-- Get the FIRSTNAME --%>


            <%-- Get the LASTNAME --%>
            



        </form>
    </tr>
<%
    }
%>

<%-- -------- Close Connection Code -------- --%>
<%
    // Close the ResultSet
    rs.close();

    // Close the Statement
    statement.close();

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
