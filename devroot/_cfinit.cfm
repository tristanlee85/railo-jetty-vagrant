<!--- Set the default passwords for the admin; these can be changes later through the web interface --->
<cfadmin 
	action="updatePassword"
	type="server"
	newPassword="railoadmin">

<cfadmin 
	action="updatePassword"
	type="web"
	newPassword="railoadmin">
