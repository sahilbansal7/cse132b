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
                "INSERT INTO class VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            pstmt.setString(1, request.getParameter("title"));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
            pstmt.setString(3, request.getParameter("le"));
            pstmt.setString(4, request.getParameter("di"));
            pstmt.setInt(5, Integer.parseInt(request.getParameter("enroll_limit"))); 
            pstmt.setInt(6, Integer.parseInt(request.getParameter("di_mandatory")));
            pstmt.setString(7, request.getParameter("f_name"));
            pstmt.setString(8, request.getParameter("co_number"));
            pstmt.setInt(9, Integer.parseInt(request.getParameter("review_session")));
            pstmt.setInt(10, Integer.parseInt(request.getParameter("waitlist")));
            pstmt.setString(11, request.getParameter("quarter"));

            // First check if comparing Lecture and Discussion works correctly
            
            CREATE OR REPLACE FUNCTION first()
            RETURNS trigger AS
            $$
            BEGIN
            IF POSITION('M' in New.le_day ) > 0 AND POSITION('M' in New.di_day) > 0
                THEN IF New.le_time == New.di_time AND New.le_ampm == New.di_ampm
                    THEN RAISE EXCEPTION 'OVERLAP';
                END IF; 
            ELSE IF POSITION('Tue' in New.le_day ) > 0 AND POSITION('Tue' in New.di_day) > 0
                THEN IF New.le_time == New.di_time AND New.le_ampm == New.di_ampm
                    THEN RAISE EXCEPTION 'OVERLAP';
                END IF; 
            ELSE IF POSITION('W' in New.le_day ) > 0 AND POSITION('W' in New.di_day) > 0
                THEN IF New.le_time == New.di_time AND New.le_ampm == New.di_ampm
                    THEN RAISE EXCEPTION 'OVERLAP';
                END IF; 
            ELSE IF POSITION('Thu' in New.le_day ) > 0 AND POSITION('Thu' in New.di_day) > 0
                THEN IF New.le_time == New.di_time AND New.le_ampm == New.di_ampm
                    THEN RAISE EXCEPTION 'OVERLAP';
                END IF; 
            ELSE IF POSITION('F' in New.le_day ) > 0 AND POSITION('F' in New.di_day) > 0
                THEN IF New.le_time == New.di_time AND New.le_ampm == New.di_ampm
                    THEN RAISE EXCEPTION 'OVERLAP';
                END IF; 
            ELSE 
                RAISE NOTICE 'Insertion Successful';
            END IF;
            END;
            $$
            LANGUAGE plpgsql;

            CREATE TRIGGER handle_class_time
            BEFORE INSERT OR UPDATE ON class
            FOR EACH ROW EXECUTE PROCEDURE first();


            // Inside TRIGGER
            String str = "IF POSITION('M' in New.le.day ) > 0 && POSITION('M' in New.di.day) > 0 THEN IF New.le.time == New.di.time && New.le.ampm == New.di.ampm THEN RAISE EXCEPTION 'FAILED' END IF; END IF;"

            stmatenet.executeQuery(str);
            if(NO OVERLAP) {
                int rowCount = pstmt.executeUpdate();

                // Commit transaction
                conn.commit();
                conn.setAutoCommit(true);
            }
            else {
                //Display Error Message
                out.write("INVALID");
            }

        }
%>


<%-- -------- SELECT Statement Code -------- --%>
<%
        // Create the statement
        Statement statement = conn.createStatement();

        // Use the created statement to SELECT
        // the student attributes FROM the Faculty table.
        ResultSet rs = statement.executeQuery
            ("SELECT * FROM class");
%>

<!-- Add an HTML table header row to format the results -->
    <table border="1">
        <tr>
            <th>Title</th>
            <th>Section ID</th>
            <th>Lecture Time</th>
            <th>Discussion Time</th>
            <th>Enrollment Limit</th>
            <th>Discussion Mandatory</th>
            <th>Instructor Name</th>
            <th>Course Number</th>
            <th>Review Session</th>
            <th>Number of Waitlists</th>
            <th>Quarter and Year</th>
        </tr>
        <tr>
          <form action="class_entry.jsp" method="get">
          <input type="hidden" value="insert" name="action">
          <th><input value="" name="title" size="10"></th>
          <th><input value="" name="section_id" size="15"></th>
          <th><input value="" name="le" size="15"></th>
          <th><input value="" name="di" size="15"></th>
          <th><input value="" name="enroll_limit" size="15"></th>
          <th><input value="" name="di_mandatory" size="10"></th>
          <th><input value="" name="f_name" size="10"></th>
          <th><input value="" name="co_number" size="10"></th>
          <th><input value="" name="review_session" size="10"></th>
          <th><input value="" name="waitlist" size="15"></th>
          <th><input value="" name="quarter" size="15"></th>
          <th><input type="submit" value="Insert"></th>
          </form>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet
        
        while ( rs.next() ) {

%>

        <tr>
            <form action="class_entry.jsp" method="get">

                <%-- Get the SSN, which is a number --%>
                <td>
                    <input value="<%= rs.getString("title") %>" 
                        name="title" size="10">
                </td>

                <td>
                    <input value="<%= rs.getInt("section_id") %>"
                        name="section_id" size="15">
                </td>

                <td>
                    <input value="<%= rs.getString("le") %>" 
                        name="le" size="15">
                </td>
                <td>
                    <input value="<%= rs.getString("di") %>" 
                        name="di" size="10">
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
