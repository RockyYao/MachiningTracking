package com.oechsler.common.utils;

import com.oechsler.shiro.token.manager.TokenManager;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * author:Kris
 * date:2017/10/26
 */
public class CommonUtils {

    public static Date formatDate(String s, String format) {
        Date d = null;
        try {
            SimpleDateFormat dFormat = new SimpleDateFormat(format);
            d = dFormat.parse(s);
        } catch (Exception localException) {
        }
        return d;
    }

    public static String formatTime(String format, Object v) {
        if (v == null) {
            return null;
        }
        if (v.equals("")) {
            return "";
        }
        SimpleDateFormat df = new SimpleDateFormat(format);
        return df.format(v);
    }

    public static String decimalFormat(String format, String v) {
        if (v == null) {
            return null;
        }
        if (v.equals("")) {
            return "";
        }
        DecimalFormat df = new DecimalFormat(format);
        Float value = Float.parseFloat(v);
        return df.format(value);
    }

    //上传图片
    public static Map<String, Object> saveFileToServer(HttpServletRequest request, String filePath,
                                                       String saveFilePathName)
            throws Exception {
        SftpUtil sftp = new SftpUtil();
        sftp.connect();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        CommonsMultipartFile file = (CommonsMultipartFile) multipartRequest.getFile(filePath);
        Map<String, Object> map = new HashMap<String, Object>();
        if ((file != null) && (!file.isEmpty())) {
            String extend = file.getOriginalFilename()
                    .substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
            float fileSize = Float.valueOf((float) file.getSize()).floatValue();
            List<String> errors = new ArrayList<String>();
            boolean flag = true;
            if (flag) {
                try {
                    String fileName = file.getOriginalFilename();
                    String imgType = fileName.substring(
                            fileName.lastIndexOf(".") + 1).toLowerCase();
                    String sysName = UUID.randomUUID().toString().replace("-", "")
                            .toLowerCase()
                            + "." + imgType;
                    String imgPath = "";
                    if (null != TokenManager.getToken()) {
                        imgPath = "item" + File.separator + TokenManager.getToken().getId() + File.separator + saveFilePathName;
                    } else {
                        imgPath = "item" + File.separator + "other" + File.separator + saveFilePathName;
                    }
                    String savePath = ConfigUtil.getValue("static.images.root.path") + imgPath + File.separator; //文件上传路径
                    try {
                        sftp.upload(savePath.replace("\\", "/").replace("//", "/"), sysName, file.getInputStream());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if (isImg(extend)) {
                        String url = ConfigUtil.getValue("static.location.origin.images") + imgPath.replace("\\", "/").replace("//", "/") + "/" + sysName;
                        BufferedImage image = getBufferedImage(url);
                        try {
                            int w = image.getWidth();
                            int h = image.getHeight();
                            map.put("width", Integer.valueOf(w));
                            map.put("height", Integer.valueOf(h));
                        } catch (Exception localException) {
                        }
                    }
                    map.put("mime", extend);
                    map.put("fileName", sysName
                            .substring(0, sysName.lastIndexOf(".")));
                    map.put("fileSize", Float.valueOf(fileSize));
                    map.put("error", errors);
                    map.put("oldName", file.getOriginalFilename());
                    map.put("url", ConfigUtil.getValue("static.location.origin.images") + imgPath.replace("\\", "/").replace("//", "/"));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                errors.add("不允许的扩展名");
            }
        } else {
            map.put("width", Integer.valueOf(0));
            map.put("height", Integer.valueOf(0));
            map.put("mime", "");
            map.put("fileName", "");
            map.put("fileSize", Float.valueOf(0.0F));
            map.put("oldName", "");
        }
        sftp.disconnect();
        return map;
    }

    public static boolean isImg(String extend) {
        boolean ret = false;
        List<String> list = new ArrayList<String>();
        list.add("jpg");
        list.add("jpeg");
        list.add("bmp");
        list.add("gif");
        list.add("png");
        list.add("tif");
        for (String s : list) {
            if (s.equals(extend)) {
                ret = true;
            }
        }
        return ret;
    }

    /**
     * @param imgUrl 图片地址
     * @return
     */
    public static BufferedImage getBufferedImage(String imgUrl) {
        URL url = null;
        InputStream is = null;
        BufferedImage img = null;
        try {
            url = new URL(imgUrl);
            is = url.openStream();
            img = ImageIO.read(is);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {

            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return img;
    }

    public static Map getFormatTime(Date startTime, Date endTime, String relCostTime) {
        Map map = new HashMap();
        long sTime = startTime.getTime();
        long eTime = endTime.getTime();
        long costTime = eTime - sTime;
        long alreadyCostTime;
        if(relCostTime == null){
            alreadyCostTime = 0;
        }else{
            alreadyCostTime = Long.parseLong(relCostTime);
        }
        long totalTime = costTime + alreadyCostTime;
        map.put("relCostTime",totalTime);
        long hours = (totalTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
        long minutes = (totalTime % (1000 * 60 * 60)) / (1000 * 60);
        if (hours == 0) {
            if(minutes!=0){
                map.put("formatRelCostTime",minutes + "min");
            }else{
                map.put("formatRelCostTime","1min");
            }
        } else {
            map.put("formatRelCostTime",hours + "h" + minutes + "min");
        }
        return map;
    }
}
