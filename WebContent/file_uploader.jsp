<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
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
String return1="";
String return2="";
String return3="";
String name = "";
if (ServletFileUpload.isMultipartContent(request)){
    ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
    //UTF-8 ���ڵ� ����
    //uploadHandler.setHeaderEncoding("UTF-8");
    List<FileItem> items = uploadHandler.parseRequest(request);
    //�� �ʵ��±׵��� FOR���� �̿��Ͽ� �񱳸� �մϴ�.
    for (FileItem item : items) {
        if(item.getFieldName().equals("callback")) {
            return1 = item.getString("UTF-8");
            System.out.println(return1);
        } else if(item.getFieldName().equals("callback_func")) {
            return2 = "?callback_func="+item.getString("UTF-8");
            System.out.println(return2);
        } else if(item.getFieldName().equals("Filedata")) {
        	System.out.println(item.getName()+"11");
            //FILE �±װ� 1���̻��� ���
            if(item.getSize() > 0) {
                String ext = item.getName().substring(item.getName().lastIndexOf(".")+1);
                //���� �⺻���
                String defaultPath = request.getServletContext().getRealPath("/");
                //���� �⺻��� _ �󼼰��
                String path = defaultPath + "upload" + File.separator;
                 
                File file = new File(path);
                 
                //���丮 �������� ������� ���丮 ����
                if(!file.exists()) {
                    file.mkdirs();
                }
                //������ ���ε� �� ���ϸ�(�ѱ۹����� ���� ���������� �ø��� �ʴ°��� ����)
                String realname = UUID.randomUUID().toString() + "." + ext;
                ///////////////// ������ ���Ͼ��� /////////////////
                InputStream is = item.getInputStream();
                OutputStream os=new FileOutputStream(path + realname);
                System.out.println(path);
                System.out.println(path + realname);
                int numRead;
                byte b[] = new byte[(int)item.getSize()];
                while((numRead = is.read(b,0,b.length)) != -1){
                    os.write(b,0,numRead);
                }
                if(is != null)  is.close();
                os.flush();
                os.close();
                ///////////////// ������ ���Ͼ��� /////////////////
                return3 += "&bNewLine=true&sFileName="+name+"&sFileURL=/upload/"+realname;
            }else {
                return3 += "&errstr=error";
            }
        }
    }
}
response.sendRedirect(return1+return2+return3);
%>
</body>
</html>