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
                "INSERT INTO class VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, request.getParameter("title"));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
            pstmt.setString(3, request.getParameter("le_day"));
            pstmt.setInt(4, Integer.parseInt(request.getParameter("enroll_limit"))); 
            pstmt.setInt(5, Integer.parseInt(request.getParameter("di_mandatory")));
            pstmt.setString(6, request.getParameter("f_name"));
            pstmt.setString(7, request.getParameter("co_number"));
            pstmt.setInt(8, Integer.parseInt(request.getParameter("review_session")));
            pstmt.setInt(9, Integer.parseInt(request.getParameter("waitlist")));
            pstmt.setString(10, request.getParameter("quarter"));
            pstmt.setInt(11, Integer.parseInt(request.getParameter("year")));
            pstmt.setString(12, request.getParameter("le_time"));
            pstmt.setString(13, request.getParameter("le_ampm"));
            pstmt.setString(14, request.getParameter("di_day"));
            pstmt.setString(15, request.getParameter("di_time"));
            pstmt.setString(16, request.getParameter("di_ampm"));
            pstmt.setString(17, request.getParameter("lab_day"));
            pstmt.setString(18, request.getParameter("lab_time"));
            pstmt.setString(19, request.getParameter("lab_ampm"));
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
                "UPDATE class SET title=?, section_id=?, le_day=?, enroll_limit=?, di_mandatory=?, f_name=?, co_number=?, " + 
                "review_session=?, waitlist=?, quarter=?, year=?, le_time=?, le_ampm=?, di_day=?, di_time=?, di_ampm=?, lab_day=?, " +
                "lab_time=?, lab_ampm=? WHERE section_id = ? and co_number = ?");

            pstmt.setString(1, request.getParameter("title"));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
            pstmt.setString(3, request.getParameter("le_day"));
            pstmt.setInt(4, Integer.parseInt(request.getParameter("enroll_limit"))); 
            pstmt.setInt(5, Integer.parseInt(request.getParameter("di_mandatory")));
            pstmt.setString(6, request.getParameter("f_name"));
            pstmt.setString(7, request.getParameter("co_number"));
            pstmt.setInt(8, Integer.parseInt(request.getParameter("review_session")));
            pstmt.setInt(9, Integer.parseInt(request.getParameter("waitlist")));
            pstmt.setString(10, request.getParameter("quarter"));
            pstmt.setInt(11, Integer.parseInt(request.getParameter("year")));
            pstmt.setString(12, request.getParameter("le_time"));
            pstmt.setString(13, request.getParameter("le_ampm"));
            pstmt.setString(14, request.getParameter("di_day"));
            pstmt.setString(15, request.getParameter("di_time"));
            pstmt.setString(16, request.getParameter("di_ampm"));
            pstmt.setString(17, request.getParameter("lab_day"));
            pstmt.setString(18, request.getParameter("lab_time"));
            pstmt.setString(19, request.getParameter("lab_ampm"));
            pstmt.setInt(20, Integer.parseInt(request.getParameter("section_id")));
            pstmt.setString(21, request.getParameter("co_number"));
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
            ("SELECT * FROM class where quarter = 'Spring' and year = 2018");
%>



<!-- Add an HTML table header row to format the results -->
    <table border="1">
        <tr>
            <th>Title</th>
            <th>Section ID</th>
            <th>Lecture day</th>
            <th>enroll limit</th>
            <th>di_mandatory</th>
            <th>f_name</th>
            <th>co_number</th>
            <th>review session</th>
            <th>waitlist</th>
            <th>quarter</th>
            <th>year</th>
            <th>lecture time</th>
            <th>lecture ampm</th>
            <th>discussion day</th>
            <th>discussion time</th>
            <th>discussion ampm</th>
            <th>lab day</th>
            <th>lab time</th>
            <th>lab ampm</th>
            
        </tr>
        <tr>
          <form action="class_entry_4.jsp" method="get">
          <input type="hidden" value="insert" name="action">
          <th><input value="" name="title" size="10"></th>
          <th><input value="" name="section_id" size="15"></th>
          <th><input value="" name="le_day" size="15"></th>
          <th><input value="" name="enroll_limit" size="15"></th>
          <th><input value="" name="di_mandatory" size="10"></th>
          <th><input value="" name="f_name" size="10"></th>
          <th><input value="" name="co_number" size="10"></th>
          <th><input value="" name="review_session" size="10"></th>
          <th><input value="" name="waitlist" size="15"></th>
          <th><input value="" name="quarter" size="15"></th>
          <th><input value="" name="year" size="10"></th>
          <th><input value="" name="le_time" size="15"></th>
          <th><input value="" name="le_ampm" size="15"></th>
          <th><input value="" name="di_day" size="15"></th>
          <th><input value="" name="di_time" size="10"></th>
          <th><input value="" name="di_ampm" size="10"></th>
          <th><input value="" name="lab_day" size="10"></th>
          <th><input value="" name="lab_time" size="10"></th>
          <th><input value="" name="lab_ampm" size="15"></th>
          <th><input type="submit" value="Insert"></th>
          </form>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet
        
        while ( rs.next() ) {

%>






        <tr>
            <form action="class_entry_4.jsp" method="get">

                <input type="hidden" value="update" name="action">
                <td>
                    <input value="<%= rs.getString("title") %>" 
                        name="title" size="10">
                </td>

                <td>
                    <input value="<%= rs.getInt("section_id") %>"
                        name="section_id" size="15">
                </td>

                <td>
                    <input value="<%= rs.getString("le_day") %>" 
                        name="le_day" size="15">
                </td>
                <td>
                    <input value="<%= rs.getInt("enroll_limit") %>" 
                        name="enroll_limit" size="10">
                </td>
                <td>
                    <input value="<%= rs.getInt("di_mandatory") %>" 
                        name="di_mandatory" size="10">
                </td>

                <td>
                    <input value="<%= rs.getString("f_name") %>" 
                        name="f_name" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("co_number") %>" 
                        name="co_number" size="10">
                </td>

                <td>
                    <input value="<%= rs.getInt("review_session") %>" 
                        name="review_session" size="10">
                </td>
                <td>
                    <input value="<%= rs.getInt("waitlist") %>" 
                        name="waitlist" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("quarter") %>" 
                        name="quarter" size="10">
                </td>
                <td>
                    <input value="<%= rs.getInt("year") %>" 
                        name="year" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("le_time") %>" 
                        name="le_time" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("le_ampm") %>" 
                        name="le_ampm" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("di_day") %>" 
                        name="di_day" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("di_time") %>" 
                        name="di_time" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("di_ampm") %>" 
                        name="di_ampm" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("lab_day") %>" 
                        name="lab_day" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("lab_time") %>" 
                        name="lab_time" size="10">
                </td>
                <td>
                    <input value="<%= rs.getString("lab_ampm") %>" 
                        name="lab_ampm" size="10">
                </td>
                <td>
                    <input type="submit" value="Update">
                </td>


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