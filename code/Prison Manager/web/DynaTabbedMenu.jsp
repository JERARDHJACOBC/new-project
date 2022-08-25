
<%@ page import="java.util.Properties,javax.mail.*, javax.mail.internet.*,java.sql.*" %>
<%@ page language="java" %>
<%@ page session="true" %>
<%@ page errorPage="errorPage.jsp" %>


<html>
    <%
        int i=0;
        int iCnt=0;
        String AuthGroup = (String)session.getAttribute("Auth");
        System.out.println("AuthGroup->"+AuthGroup);
        if(AuthGroup==null){
                 session.invalidate();
		%><script language=javascript>window.opener = top; window.opener.location.replace("sessiontimeout.jsp");</script><%
        }
        Connection con=null;
        Statement stmt=null;
        ResultSet rs=null;

        String sql = "select  a.menuid ,a.Label,d.TargetFrame,d.Executable " +
                "from menu_base a, menuitem_relationship b,menu_role_relationship c,menu_frame_executable_mapping d " +
                "where  b.menulevel=0 " +
                "and b.childMenuId=a.menuid " +
                "and b.parentMenuId=0 " +
                "and c.role=\'"+AuthGroup+"\'" +
                "and b.childMenuId = c.menurelationshipid " +
                "and b.childMenuId = d.menurelationshipid "+
               /* "group by a.label " +*/
                "order by a.menuid";
        String[] menuRelationshipId= new String[30];
        String[] label= new String[30];
        String[] targetFrame= new String[30];
        String[] executable= new String[30];
       System.out.println("sql-->"+sql);
        try
	{
		con = com.PrisonManager.ConnectionPool.getConnection();
		stmt =  con.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			menuRelationshipId[i] = rs.getString(1);
			label[i] = rs.getString(2);
                        System.out.println("label[i]--"+label[i]);
			targetFrame[i] = rs.getString(3);
			executable[i] = rs.getString(4);
                        i++;
                        iCnt++;
		}
		rs.close();
		stmt.close();
		con.close();
	}
	catch(Exception e)
	{
		if(rs!=null){
			rs.close();
		}
		if(stmt!=null){
			stmt.close();
		}
		if(con!=null){
			con.close();
		}
        	throw new Exception(e);
        }
    %>
    
    <HEAD>
        <link href='styles/styles.css' rel="stylesheet"/>
        <script langusge='javascript'>
            function fn_changeColor(obj,mouseEvent){
          /* if(mouseEvent==1)
               obj.style.background='#fffff';
           else
              obj.style.background='#008bd3';*/
              
        }
        function fn_activateTab(obj){
            
            obj.style.background='#999999';
            obj.style.color='black';
            var menuName=obj.id;
            
             <%
             for(i=0;i<iCnt;i++)
                    {
                       
                        %>
                            
                        if(menuName=='<%=label[i]%>')
                         {
                             //parent.LeftPane.location.replace('LeftPane.html');
                             parent.<%=targetFrame[i]%>.location.replace('<%=executable[i] %>');
                         }
                        <%
                    }
             %>
            //changing the color of the remaining tabs[other thatn active tab to defualt menu color
            <%
             for(i=0;i<iCnt;i++)
                    {
                        %>
                        if(menuName!='<%=label[i]%>')
                         {
                            document.getElementById('<%=label[i]%>').style.background='#008bd3';
                            document.getElementById('<%=label[i]%>').style.color='#ffffff';
                         }else{
                            document.getElementById('<%=label[i]%>').style.background='#ffffff';
                            document.getElementById('<%=label[i]%>').style.color='#000000';
                         }
                        <%
                    }
             %>
       }
          </script>
    </HEAD>
    <BODY  Class="tabbedmenu" onload="fn_activateTab(<%=label[0]%>);">
        <DIV CLASS=menu>
            <table cellspacing= 2 cellpadding=0 align=left border=0>
                <tr >
               <%
                for(i=0;i<iCnt;i++)
                {
                    System.out.println(i+"--"+label[i]+"--"+iCnt);
                    if(i==0){
                    %><td class=tdclass1 id='<%=label[i]%>'      ONMOUSEOUT="fn_changeColor(this,2);" ONMOUSEOVER="fn_changeColor(this,1);" ONCLICK='fn_activateTab(this);' ><B>&nbsp;&nbsp;&nbsp; <%=label[i]%> &nbsp;&nbsp;&nbsp;</B></td><%     
                    }
                    if(i>0 && label[i].equals(label[i-1])==false){
                   %><td class=tdclass1 id='<%=label[i]%>'      ONMOUSEOUT="fn_changeColor(this,2);" ONMOUSEOVER="fn_changeColor(this,1);" ONCLICK='fn_activateTab(this);' ><B>&nbsp;&nbsp;&nbsp; <%=label[i]%> &nbsp;&nbsp;&nbsp;</B></td><% 
                   }
                }
                    
                %>
                </tr>
             </table>
        </DIV>
 
    </BODY>  
  
<html>
