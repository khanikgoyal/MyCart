<%
	String message = (String)session.getAttribute("message");
	String messageType = (String)session.getAttribute("messageType");
	if(message!=null){
		String alertClass="alert-success";
		if("warning".equals(messageType)){
			alertClass="alert-warning";
		}
%>
<div class="alert <%= alertClass %> alert-dismissible fade show" role="alert">
  <strong><%= message %></strong>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<%		
		session.removeAttribute("message");
	}
%>
