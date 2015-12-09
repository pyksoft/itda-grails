/*
 * Before working with this sample code, please be sure to read the accompanying Readme.txt file.
 * It contains important information regarding the appropriate use of and conditions for this
 * sample code. Also, please pay particular attention to the comments included in each individual
 * code file, as they will assist you in the unique and correct implementation of this code on
 * your specific platform.
 *
 */


package com.anet.api.http;

/*
 * SSL Handshake and Certificate retrieval based on Sun Microsystems InstallCert.java example
 * http://blogs.sun.com/andreas/resource/InstallCert.java 
 *
 */
 
import java.net.*;
import java.io.*;
import javax.net.SocketFactory;

import java.security.*;
import java.security.cert.*;
import javax.net.ssl.*;

public class HttpUtil{

   public static int HTTP_PORT = 80;
   public static int HTTPS_PORT = 443;
   
   public static String CERTIFICATE_FILE = "Authorize.Net.certs";
   
   private KeyStore keys = null;
   private String default_password = "example-passphrase";
   
   private boolean is_secure = false;
   private String host = null;
   private String path = null;
   
   public HttpUtil(java.net.URL url){
      host = url.getHost();
      path = url.getPath();
      String protocol = url.getProtocol();
      if(protocol.equals("https")) is_secure = true;
   }
   public void cleanup(){
      File file = new File(CERTIFICATE_FILE);
      if(file.exists()){
         //System.out.println("Cleaning up certificates");
         file.delete();
      }
   }
   public String getUrl(){
      if(is_secure){
         return GetSecureHttpSocket(host, path, null);
      }
      return GetHttpSocket(host,path,null);
   }
   public String postUrl(String data){
      if(is_secure){
         return GetSecureHttpSocket(host, path, data);
      }
      return GetHttpSocket(host,path,data);
   }
   public boolean InitializeKeyStore(String host){
      return InitializeKeyStore(default_password, host);
   }
   public boolean InitializeKeyStore(String password, String host){
      try{
         char[] certificate_password = password.toCharArray();
         
         KeyStore ks = getKeyStore(certificate_password);
         if (ks != null) {
            /*
            System.out.println("Loading KeyStore " + file + "...");
            InputStream in = new FileInputStream(file);
         
            ks.load(in, certificate_password);
            in.close();
            */
            // System.out.println("Keystore exists.");
            return true;
         }
         
         ks = KeyStore.getInstance(KeyStore.getDefaultType());
         
         // Initialize the empty keystore
         //
         ks.load(null,certificate_password);
         
         SSLContext context = SSLContext.getInstance("TLS");
         TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
         tmf.init(ks);
         X509TrustManager defaultTrustManager = (X509TrustManager)tmf.getTrustManagers()[0];
         SavingTrustManager tm = new SavingTrustManager(defaultTrustManager);
         context.init(null, new TrustManager[] {tm}, null);
         SSLSocketFactory factory = context.getSocketFactory();
         // System.out.println("Opening connection to " + host + ":" + HTTPS_PORT + "...");
         SSLSocket socket = (SSLSocket)factory.createSocket(host, HTTPS_PORT);
         
         
         socket.setSoTimeout(10000);
         try {
             // System.out.println("Starting SSL handshake...");
             socket.startHandshake();
             socket.close();
             System.out.println();
             // System.out.println("No errors, certificate is already trusted");
         } catch (SSLException e) {
             // System.out.println();
             // e.printStackTrace(System.out);
         }
         
         X509Certificate[] chain = tm.chain;
         if (chain == null || chain.length == 0) {
             System.out.println("Could not obtain server certificate chain");
             return false;
         }
         
         // System.out.println("Cert Chain: " + chain.length);
         
         for(int i= 0; i < chain.length; i++){
            X509Certificate cert = chain[i];
            String alias = host + "-" + (i + 1);
            ks.setCertificateEntry(alias, cert);
         }

         OutputStream out = new FileOutputStream(CERTIFICATE_FILE);
         ks.store(out, certificate_password);
         out.close();
         
         return true;

      }
      catch(Exception e){
         System.out.println(e);
      }
      return false;
   }

   private KeyStore getKeyStore(char[] certificate_password){
      if(keys != null) return keys;
      try{
         File file = new File(CERTIFICATE_FILE);
         KeyStore ks = KeyStore.getInstance(KeyStore.getDefaultType());
         if (file.exists() == false){
            // System.out.println("Null keystore");
            return null;
         }
         InputStream in = new FileInputStream(file);
         ks.load(in, certificate_password);
         in.close();
         keys = ks;
      }
      catch(Exception e){
         System.out.println(e);
      }
      return keys;
   }
   private String GetSecureHttpSocket(String host, String path,String post_data){
      return GetSecureHttpSocket(default_password, host, path, post_data);
   }  
   private String GetSecureHttpSocket(String password, String host, String path, String post_data){
         // Get a Socket factory 
      try{
         
         if(InitializeKeyStore(password, host) == false){
            return null;
         }
         SSLContext context = SSLContext.getInstance("TLS");
         TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
         tmf.init(getKeyStore(password.toCharArray()));
         X509TrustManager defaultTrustManager = (X509TrustManager)tmf.getTrustManagers()[0];
         SavingTrustManager tm = new SavingTrustManager(defaultTrustManager);
         context.init(null, new TrustManager[] {tm}, null);
         SSLSocketFactory factory = context.getSocketFactory();
         SSLSocket socket = (SSLSocket)factory.createSocket(host, HTTPS_PORT);
         socket.setSoTimeout(10000);
         
         try {
             //System.out.println("Starting SSL handshake...");
             socket.startHandshake();

            return doSocketTransfer(socket, path, post_data);
         }
         catch (SSLException e) {
             System.out.println();
             e.printStackTrace(System.out);
         }
      }
      catch(Exception e){
         System.out.println("Error: " + e);
      }
      return null;
   }

   private String GetHttpSocket(String host, String path, String post_data){
      try{
         
         Socket socket = new Socket(host, HTTP_PORT);
         socket.setSoTimeout(10000);
         try {
            return doSocketTransfer(socket,path,post_data);
         }
         catch (Exception e) {
             System.out.println();
             e.printStackTrace(System.out);
         }
      }
      catch(Exception e){
         System.out.println("Error: " + e);
      }
      return null;
   }
   
   private String doSocketTransfer(Socket socket, String path, String post_data) throws IOException{
      String line;
      StringBuffer sb = new StringBuffer();
      String method = "GET";
      if(post_data != null) method = "POST";
      BufferedWriter out = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
      BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
      out.write(method + " " + path + " HTTP/1.0\n");
      if(post_data != null){
         out.write("Content-Length: " + Integer.toString(post_data.length()) + "\n");
         out.write("Content-Type: text/xml; charset=\"utf-8\"\n");
      }
      out.write("\n");
      if(post_data != null){
         out.write(post_data);
      }
      out.flush();


      while((line = in.readLine()) != null) {
         sb.append(line + "\r\n");
      }
      out.close();
      in.close();
      socket.close();
      return sb.toString();
   }
   private static class SavingTrustManager implements X509TrustManager {
      private final X509TrustManager tm;
      private X509Certificate[] chain;
      
      SavingTrustManager(X509TrustManager tm) {
          this.tm = tm;
      }
        
      public X509Certificate[] getAcceptedIssuers() {
          throw new UnsupportedOperationException();
      }
        
      public void checkClientTrusted(X509Certificate[] chain, String authType)
         throws CertificateException {
          throw new UnsupportedOperationException();
      }
        
      public void checkServerTrusted(X509Certificate[] chain, String authType)
         throws CertificateException {
    	  System.out.println("calling SavingTrustManager.checkServerTrusted " + authType);
          this.chain = chain;
          tm.checkServerTrusted(chain, authType);
      }
   }
}
