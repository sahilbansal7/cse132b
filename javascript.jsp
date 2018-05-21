<!-- <script type="text/javascript">
    function displayCourses() {
        var course_info = '<div>
        <%= Statement statement3 = conn.createStatement();
            ResultSet rs_three = statement3.executeQuery("SELECT 1 FROM student");
            rs_three.getString("last_name")
            rs_three.close();
            statement3.close(); %>
        </div>';  

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
                        // <th> Discussion Time </th>
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
</script> -->