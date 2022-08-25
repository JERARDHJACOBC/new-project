





<PRE><%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random"%>
<%@page contentType="application/vnd.ms-excel"%>
<%response.setHeader("Content-Disposition","attachment;filename=Report.xls");%>

<HEAD>




<Style>
	.row_title {
		FONT-SIZE: 8pt; BACKGROUND-COLOR: #999966 ;FONT-WEIGHT: bold; FONT-FAMILY: Verdana,Arial,helvetica,sans-serif;
	}
	.row_odd {
		FONT-SIZE: 8pt; BACKGROUND-COLOR: #c8c8c8 ;FONT-WEIGHT: normal; FONT-FAMILY: Verdana,Arial,helvetica,sans-serif;
	}
	.row_even {
		FONT-SIZE: 8pt; BACKGROUND-COLOR: #E8E8E8 ;FONT-WEIGHT: normal; FONT-FAMILY: Verdana,Arial,helvetica,sans-serif;
	}
	TABLE.notebook {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; WIDTH: 90%; BORDER-BOTTOM: 0px
	}
	Body.SC {
     scrollbar-arrow-color:#00000;
     scrollbar-base-color:#c8c8c8;
     scrollbar-face-color:#e8e8e8;
     scrollbar-darkshadow-color:#b8b8b8;
	 BACKGROUND-COLOR: #E8E8E8;
	 FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Verdana,Arial,helvetica,sans-serif;
	}
</Style>

</HEAD>
<BODY class=SC>
<h2 align=center>View Requests</h2>

<%

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	try{
			
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/prisonhouse","root","root");
			stmt =  con.createStatement();
			String Query = "Select * from interviewrequests order by `interviewid`";
			rs = stmt.executeQuery(Query);
			%>
						<table class=notebook border=1>
							<tr class=row_title>
							<th class=row_title>InterviewId</th><th class=row_title>RequestDate</th><th class=row_title>RequestedBy</th><th class=row_title>PrisonerId</th><th class=row_title>Relationship</th><th class=row_title>Address</th><th class=row_title>TimeslotFrom</th><th class=row_title>TimeslotTo</th><th class=row_title>StaffId</th><th class=row_title>RequestStatus</th><th class=row_title>Purpose</th>
							</tr>
					<%
			int rCount=0;
			while(rs.next())
			{
					%>
					<tr class= '<%=(rCount%2!=0)? "row_even" : "row_odd"%>'>
						<td><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(4)%></td><td><%=rs.getString(5)%></td><td><%=rs.getString(6)%></td><td><%=rs.getString(7)%></td><td><%=rs.getString(8)%></td><td><%=rs.getString(9)%></td><td><%=rs.getString(10)%></td><td><%=rs.getString(11)%></td>
					</tr>
					<%
				rCount++;
			}
			if( rCount == 0)	{%><tr><td colspan=11 align=center>Sorry No records Found</td></tr><% }
			rs.close();
			stmt.close();
			con.close();
		}catch(Exception e){
			//rs.close();
			stmt.close();
			con.close();
			%><%=e%><%
		}
	
%>
</BODY>

</PRE>