<html>
<head>
<title>Shibboleth Attributes - <%= Request.ServerVariables("SERVER_NAME") %></title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="-1">
<script language"JavaScript" type="text/JavaScript">
<!--
  function decodeAttributeResponse() {
 	var textarea = document.getElementById("attributeResponseArea");
  	var base64str = textarea.value;
	var decodedMessage = decode64(base64str);
	textarea.value = tidyXml(decodedMessage);
	textarea.rows = 15;
	document.getElementById("decodeButtonBlock").style.display='none';
  }

  function tidyXml(xmlMessage) {
	//put newline before closing tags of values inside xml blocks
	xmlMessage = xmlMessage.replace(/([^>])</g,"$1\n<");
	//put newline after every tag
	xmlMessage = xmlMessage.replace(/>/g,">\n");
	var xmlMessageArray = xmlMessage.split("\n");
	xmlMessage="";
	var nestedLevel=0;
	for (var n=0; n < xmlMessageArray.length; n++) {
		if ( xmlMessageArray[n].search(/<\//) > -1 ) {
			nestedLevel--;
		}
		for (i=0; i<nestedLevel; i++) {
			xmlMessage+="  ";
		}
		xmlMessage+=xmlMessageArray[n]+"\n";
		if ( xmlMessageArray[n].search(/\/>/) > -1 ) {
			//level status the same
		}
		else if ( ( xmlMessageArray[n].search(/<\//) < 0 ) && (xmlMessageArray[n].search(/</) > -1) ) {
			//only increment if this was a tag, not if it is a value
			nestedLevel++;
		}
	}
  	return xmlMessage;
  }

  var base64Key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
  function decode64(encodedString) {
    var decodedMessage = "";
    var char1, char2, char3;
    var enc1, enc2, enc3, enc4;
    var i = 0;

    //remove all characters that are not A-Z, a-z, 0-9, +, /, or =
    encodedString = encodedString.replace(/[^A-Za-z0-9\+\/\=]/g, "");
    do {
	enc1 = base64Key.indexOf(encodedString.charAt(i++));
	enc2 = base64Key.indexOf(encodedString.charAt(i++));
	enc3 = base64Key.indexOf(encodedString.charAt(i++));
	enc4 = base64Key.indexOf(encodedString.charAt(i++));

	char1 = (enc1 << 2) | (enc2 >> 4);
	char2 = ((enc2 & 15) << 4) | (enc3 >> 2);
	char3 = ((enc3 & 3) << 6) | enc4;

	decodedMessage = decodedMessage + String.fromCharCode(char1);
	if (enc3 != 64) {
		decodedMessage = decodedMessage + String.fromCharCode(char2);
	}
	if (enc4 != 64) {
		decodedMessage = decodedMessage + String.fromCharCode(char3);
	}
    } while (i < encodedString.length);
    return decodedMessage;
  }
// -->
</script>
</head>


<body>

<b>-all SHIB headers-</b> (<code>HTTP_SHIB_ATTRIBUTES</code> is not shown in this list)
<table>
<% For Each strKey In Request.ServerVariables %>
<% if InStr(1, strKey, "SHIB", 1) and not strKey="HTTP_SHIB_ATTRIBUTES"  then %>
<tr>
<td><%= strKey %></td>
<td><%= Request.ServerVariables(strKey) %></td>
</tr>
<% end if %>
<% Next %>
<tr><td>(REMOTE_USER)</td><td><%= Request.ServerVariables("REMOTE_USER") %></td></tr>
<tr><td>(HTTP_REMOTE_USER)</td><td><%= Request.ServerVariables("HTTP_REMOTE_USER") %></td></tr>
</table>
<br/>

attribute response from the IdP (<code>HTTP_SHIB_ATTRIBUTES</code>):<br/>
<textarea id="attributeResponseArea" onclick="select()" rows="1" cols="130"><%= Request.ServerVariables("HTTP_SHIB_ATTRIBUTES") %></textarea><br/>
<span id="decodeButtonBlock"><input type="button" id="decodeButton" value="decode base64 encoded attribute response using JavaScript" onClick="decodeAttributeResponse();"><br/></span>

<br/>

<small>
notes:<br/>
The AAP throws away invalid values (eg an unscopedAffiliation of value "myBoss@&lt;yourdomain&gt;" or a value with an invalid scope which scope is checked)<br/>
The raw attribute response (<code>HTTP_SHIB_ATTRIBUTES</code>) is NOT filtered by the AAP and should therefore be disabled for most applications (<code>exportAssertion=false</code>).<br/>
</small>


<br/>
<hr/>
<br/>


<table>
<% For Each strKey In Request.ServerVariables %>
<tr>
<td><%= strKey %></td>
<td><%= Request.ServerVariables(strKey) %></td>
</tr>
<% Next %>
</table>

</body>
</html>

