<%-- $Id$ --%>

<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.lang.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%

//jsp file returns the ip list for website monitor.
try
{
	    JSONParser parser = new JSONParser();
    	String jsonurl="https://creatorapp.zohopublic.com/site24x7/location-manager/json/IP_Address_View/C80EnP71mW2fDd60GaDgnPbVwMS8AGmP85vrN27EZ1CnCjPwnm0zPB5EX4Ct4q9n3rUnUgYwgwX0BW3KFtxnBqHt60Sz1Pgntgru";
    	URL jsonIpUrl = new URL(jsonurl);
    	URLConnection urlConnection2 = jsonIpUrl.openConnection();
    	InputStream getJsonData = urlConnection2.getInputStream(); 
    	BufferedReader jsonDataBr = null;
    	jsonDataBr = new BufferedReader(new InputStreamReader(getJsonData, "UTF-8"));

    	String ipAddressData="";
    	 StringBuilder jsonDataBuilder = new StringBuilder();
    	 while ((ipAddressData = jsonDataBr.readLine()) != null)
         {
    		 jsonDataBuilder.append(ipAddressData);
         }

    	Object ipObj = parser.parse(jsonDataBuilder.toString());

    	JSONObject jsonObject = (JSONObject) ipObj;
        JSONArray jsonArray = (JSONArray) jsonObject.get("IP_Address_View");
        LinkedList<String> ipv4List=new LinkedList<String>();
        LinkedList<String> ipv6List=new LinkedList<String>();
        

        for(int i=0;i<jsonArray.size();i++){
        	 Object element = jsonArray.get(i);
        	 JSONObject singleIpRow = (JSONObject) element;
        	 if(singleIpRow.get("IPv6_Address_External").toString().isEmpty()){
        		 ipv4List.add(singleIpRow.get("external_ip").toString());
        	 }else{
        		 ipv6List.add(singleIpRow.get("external_ip").toString());
        	 }
        }

		StringBuilder result = new StringBuilder();

        for (int i=0;i<ipv6List.size();i++) {
			out.write(ipv6List.get(i));
			out.write("\n");
        }

		 for (int i=0;i<ipv4List.size();i++) {
			out.write(ipv4List.get(i));
			if(i < ipv4List.size() -1 ){
				out.write("\n");
			}
           
        }

	   //request.setAttribute("ipList",result.toString());
	   //response.setContentType("text/plain");
       //response.setCharacterEncoding("UTF-8");
       //response.getWriter().write(result.toString());

}
catch(Exception e)
{
	out.println(e);
}
finally
{
	

}
%>
