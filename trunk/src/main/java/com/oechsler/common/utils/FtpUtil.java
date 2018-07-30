package com.oechsler.common.utils;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

/**
 * author:kriswang
 * date:2017/11/7 0007下午 16:35
 **/
public class FtpUtil {

    private String host = "";
    private int port = 21;
    private String username = "";
    private String password = "";

    public FtpUtil() {
        this.host = ConfigUtil.getValue("ftp.host");
        this.port = Integer.valueOf(ConfigUtil.getValue("ftp.port"));
        this.username = ConfigUtil.getValue("ftp.username");
        this.password = ConfigUtil.getValue("ftp.password");
    }

    public String getImageUrl(HttpServletRequest request) {
        String url = "";
        try {
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            MultipartFile file = multipartRequest.getFile("headImg");

            // 生成一个文件名
            // 获取旧的名字
            String oldName = file.getOriginalFilename();
            if (!"".equals(oldName)) {
                String newName = IDUtils.genImageName();
                //新名字
                newName = newName + oldName.substring(oldName.lastIndexOf("."));
                //上传的路径
                String imagePath = CommonUtils.formatTime("/yyyy/MM/dd", new Date());

                boolean result = uploadFile("", imagePath, newName, file.getInputStream());
                if (result) {
                    url = ConfigUtil.getValue("static.location.origin.images") + imagePath + "/" + newName;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }

    /**
     * Description: 向FTP服务器上传文件
     *
     * @param basePath FTP服务器基础目录
     * @param filePath FTP服务器文件存放路径。例如分日期存放：/2015/01/01。文件的路径为basePath+filePath
     * @param filename 上传到FTP服务器上的文件名
     * @param input    输入流
     * @return 成功返回true，否则返回false
     */
    public boolean uploadFile(String basePath, String filePath, String filename, InputStream input) {
        boolean result = false;
        FTPClient ftp = new FTPClient();
        try {
            int reply;
            ftp.connect(this.host, this.port);// 连接FTP服务器
            // 如果采用默认端口，可以使用ftp.connect(host)的方式直接连接FTP服务器
            ftp.login(this.username, this.password);// 登录
            reply = ftp.getReplyCode();
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftp.disconnect();
                return result;
            }
            //切换到上传目录
            if (!ftp.changeWorkingDirectory(basePath + filePath)) {
                //如果目录不存在创建目录
                String[] dirs = filePath.split("/");
                String tempPath = basePath;
                for (String dir : dirs) {
                    if (null == dir || "".equals(dir)) continue;
                    tempPath += "/" + dir;
                    if (!ftp.changeWorkingDirectory(tempPath)) {
                        if (!ftp.makeDirectory(tempPath)) {
                            return result;
                        } else {
                            ftp.changeWorkingDirectory(tempPath);
                        }
                    }
                }
            }
            //设置上传文件的类型为二进制类型
            ftp.setFileType(FTP.BINARY_FILE_TYPE);
            //上传文件
            if (!ftp.storeFile(filename, input)) {
                return result;
            }
            input.close();
            ftp.logout();
            result = true;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (ftp.isConnected()) {
                try {
                    ftp.disconnect();
                } catch (IOException ioe) {

                }
            }
        }
        return result;
    }

}
