package com.oechsler.common.utils;


import com.jcraft.jsch.*;
import com.jcraft.jsch.ChannelSftp.LsEntry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.*;

/**
 * <p> Description: sftp文件操作工具类</p>
 *
 * @author hz
 */
public class SftpUtil {

    private final Logger logger = LoggerFactory.getLogger(SftpUtil.class);

    ChannelSftp sftp = null;
    private String host = "";
    private int port = 22;
    private String username = "";
    private String password = "";

    public String getHost() {
        return host;
    }

    public int getPort() {
        return port;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public SftpUtil() {
        this.host = ConfigUtil.getValue("sftp.host");
        this.port = Integer.valueOf(ConfigUtil.getValue("sftp.port"));
        this.username = ConfigUtil.getValue("sftp.username");
        this.password = ConfigUtil.getValue("sftp.password");
    }

    /**
     * 连接sftp服务器
     *
     * @throws Exception
     */
    public void connect() throws Exception {

        JSch jsch = new JSch();
        Session sshSession = jsch.getSession(this.username, this.host, this.port);
        logger.debug(SftpUtil.class + "Session created.");

        sshSession.setPassword(password);
        Properties sshConfig = new Properties();
        sshConfig.put("StrictHostKeyChecking", "no");
        sshSession.setConfig(sshConfig);
        sshSession.connect(5 * 60000);    //	设置登陆超时时间 5分钟
        logger.debug(SftpUtil.class + " Session connected.");

        logger.debug(SftpUtil.class + " Opening Channel.");
        Channel channel = sshSession.openChannel("sftp");
        channel.connect();
        this.sftp = (ChannelSftp) channel;
        logger.debug(SftpUtil.class + " Connected to " + this.host + ".");
    }

    /**
     * Disconnect with server
     *
     * @throws Exception
     */
    public void disconnect() throws Exception {
        if (this.sftp != null) {
            if (this.sftp.isConnected()) {
                this.sftp.disconnect();
            } else if (this.sftp.isClosed()) {
                logger.debug(SftpUtil.class + " sftp is closed already");
            }
        }
    }

    /**
     * 上传单个文件
     *
     * @param directory  上传的目录
     * @param uploadFile 要上传的文件
     * @throws Exception
     */
    public void upload(String directory, String uploadFile) throws Exception {
        File file = new File(uploadFile);
        this.upload(directory, file);
    }

    public void upload(File file) throws Exception {
        this.upload(file.getParent(), file.getName(), new FileInputStream(file));
    }

    public void upload(String directory, File file) throws Exception {
        this.upload(directory, file.getName(), new FileInputStream(file));
    }

    public void upload(String directory, String fileName, InputStream inputStream) throws Exception {
        createDir(directory);
        this.cd(directory);
        this.sftp.put(inputStream, fileName);
    }

    /**
     * 上传目录下全部文件
     *
     * @param directory 上传的目录
     * @throws Exception
     */
    public void uploadByDirectory(String directory) throws Exception {

        String uploadFile = "";
        List<String> uploadFileList = this.listFiles(directory);
        Iterator<String> it = uploadFileList.iterator();

        while (it.hasNext()) {
            uploadFile = it.next().toString();
            this.upload(directory, uploadFile);
        }
    }

    /**
     * 下载单个文件
     *
     * @param directory     下载目录
     * @param downloadFile  下载的文件
     * @param saveDirectory 存在本地的路径
     * @throws Exception
     */
    public void download(String directory, String downloadFile,
                         String saveDirectory) throws Exception {
        String saveFile = saveDirectory + "//" + downloadFile;

        this.sftp.cd(directory);
        File file = new File(saveFile);
        this.sftp.get(downloadFile, new FileOutputStream(file));
    }

    /**
     * 下载目录下全部文件
     *
     * @param directory     下载目录
     * @param saveDirectory 存在本地的路径
     * @throws Exception
     */
    public void downloadByDirectory(String directory, String saveDirectory)
            throws Exception {
        String downloadFile = "";
        List<String> downloadFileList = this.listFiles(directory);
        Iterator<String> it = downloadFileList.iterator();

        while (it.hasNext()) {
            downloadFile = it.next().toString();
            if (downloadFile.toString().indexOf(".") < 0) {
                continue;
            }
            this.download(directory, downloadFile, saveDirectory);
        }
    }


    /**
     * 列出目录下的文件
     *
     * @param directory 要列出的目录
     * @return list 文件名列表
     * @throws Exception
     */
    public List<String> listFiles(String directory) throws Exception {

        Vector<?> fileList;
        List<String> fileNameList = new ArrayList<String>();

        fileList = this.sftp.ls(directory);
        Iterator<?> it = fileList.iterator();

        while (it.hasNext()) {
            String fileName = ((LsEntry) it.next()).getFilename();
            if (".".equals(fileName) || "src/main".equals(fileName)) {
                continue;
            }
            fileNameList.add(fileName);
        }
        return fileNameList;
    }

    /**
     * 更改文件名
     *
     * @param directory 文件所在目录
     * @param oldFileNm 原文件名
     * @param newFileNm 新文件名
     * @throws Exception
     */
    public void rename(String directory, String oldFileNm, String newFileNm)
            throws Exception {
        this.cd(directory);
        this.sftp.rename(oldFileNm, newFileNm);
    }

    public void cd(String directory) throws Exception {
        this.sftp.cd(directory);
    }

    public void rm(String filePath) throws Exception {
        this.sftp.rm(filePath);
    }

    public InputStream get(String directory) throws Exception {
        InputStream streatm = this.sftp.get(directory);
        return streatm;
    }

    /**
     * 删除文件(使用前注意了,文件删除后不可恢复)
     *
     * @param directory  文件所在目录 例如:/bamboodata/wsc_pic/item/10004/
     * @param deleteFile 文件名 例如:S20150815113255214171.jpg
     * @throws Exception
     */
    public void delete(String directory, String deleteFile) throws Exception {
        this.sftp.cd(directory);
        this.sftp.rm(deleteFile);
    }
//	public static void main(String[] args) throws Exception{
//		SftpUtil sftp = new SftpUtil();
//		try {
//			sftp.connect();
//			sftp.delete("/bamboodata/wsc_pic/item/10004/", "S20150815113524005212.jpg");
//			sftp.disconnect();
//		} catch (Exception e) {
//			sftp.disconnect();
//			e.printStackTrace();
//		}
//	}

    public void createDir(String createpath) {
        try {
            if (isDirExist(createpath)) {
                this.sftp.cd(createpath);
            }
            String pathArry[] = createpath.split("/");
            StringBuffer filePath = new StringBuffer("/");
            for (String path : pathArry) {
                if (path.equals("")) {
                    continue;
                }
                filePath.append(path + "/");
                if (isDirExist(filePath.toString())) {
                    sftp.cd(filePath.toString());
                } else {
                    // 建立目录
                    sftp.mkdir(filePath.toString());
                    // 进入并设置为当前目录
                    sftp.cd(filePath.toString());
                }
            }
            this.sftp.cd(createpath);
        } catch (SftpException e) {

        }
    }

    /**
     * 判断目录是否存在
     */
    public boolean isDirExist(String directory) {
        boolean isDirExistFlag = false;
        try {
            SftpATTRS sftpATTRS = sftp.lstat(directory);
            isDirExistFlag = true;
            return sftpATTRS.isDir();
        } catch (Exception e) {
            if (e.getMessage().toLowerCase().equals("no such file")) {
                isDirExistFlag = false;
            }
        }
        return isDirExistFlag;
    }

}
