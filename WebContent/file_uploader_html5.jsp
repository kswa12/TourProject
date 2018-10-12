<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<% 
String sFileInfo = "";
//���ϸ� - �̱����Ͼ��ε�� �ٸ��� ��Ƽ���Ͼ��ε�� HEADER�� �Ѿ��
String name = request.getHeader("file-name");
String ext = name.substring(name.lastIndexOf(".")+1);
//���� �⺻���
String defaultPath = request.getServletContext().getRealPath("/");
//���� �⺻��� _ �󼼰��
String path = defaultPath + "upload" + File.separator;
File file = new File(path);
if(!file.exists()) {
    file.mkdirs();
}
String realname = UUID.randomUUID().toString() + "." + ext;
InputStream is = request.getInputStream();
OutputStream os=new FileOutputStream(path + realname);
int numRead;
// ���Ͼ���
byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
while((numRead = is.read(b,0,b.length)) != -1){
    os.write(b,0,numRead);
}
if(is != null) {
    is.close();
}
os.flush();
os.close();
sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/upload/"+realname;
out.println(sFileInfo);
%>

</body>
</html>