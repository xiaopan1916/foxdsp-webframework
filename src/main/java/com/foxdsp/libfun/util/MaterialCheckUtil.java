package com.foxdsp.libfun.util;

import com.alibaba.fastjson.JSONObject;
import com.flagstone.transform.Movie;
import com.flagstone.transform.MovieHeader;
import com.flagstone.transform.MovieTag;
import com.flagstone.transform.image.ImageTag;
import com.foxdsp.common.util.lang.ShellUtil;
import com.jfinal.kit.PropKit;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.DataFormatException;

//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * Created by jinyangyang on 4/13/16 11:07 AM.
 */
public class MaterialCheckUtil {

    //ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height,width  /Users/jyy/Desktop/material/n1459912744613.flv

    /**
     * 获取FFMPEG可执行文件所在的路径
     * 测试环境和正式环境的ffmpeg相对于classes目录不一样
     * @return
     */
    public static String locateFFMPEG() {
        URL url = MaterialCheckUtil.class.getResource("/");
        String path = url.getPath();
        File f = new File(path).getParentFile();
        boolean founded = false;
        int i = 0 ;
        do {
            path = f.getPath();
            File f1 = new File(path+"/ffmpeg");
            if ( f1.exists() ) {
                founded = true ;
            } else {
                f = f.getParentFile();
            }
            i++ ;
        } while ( !founded && i < 5 ) ; //最多向上查找五层

        if ( founded ){
            String os = System.getProperty("os.name").toLowerCase();
            String[] oss = {"windows","mac","linux"};
            for(String s : oss ) {
                if ( os.indexOf(s) != -1  ) {
                    return path+"/ffmpeg/"+s;
                }
            }
            return null;
        } else {
            return null ;
        }

    }

    public static String capture( String upFilePath ) { //视频截图

        if ( upFilePath.toLowerCase().indexOf(".swf") != -1 ) { //swf的截图需要单独处理
            return transformSWFToIMG(upFilePath);
        }

        String path = locateFFMPEG();
        if ( path == null ){
            return  null ;
        }

        String fname = System.currentTimeMillis()+".jpg";
        String mediaPicPath =  PropKit.get("material_upload") + "/" + fname;

        List<String> cutpic = new ArrayList<String>();
        cutpic.add(path+"/ffmpeg");
        cutpic.add("-i");
        cutpic.add(upFilePath); // 同上（指定的文件即可以是转换为flv格式之前的文件，也可以是转换的flv文件）
        cutpic.add("-y");
        cutpic.add("-f");
        cutpic.add("image2");
        cutpic.add("-ss"); // 添加参数＂-ss＂，该参数指定截取的起始时间
        cutpic.add("2"); // 添加起始时间为第17秒
        cutpic.add("-t"); // 添加参数＂-t＂，该参数指定持续时间
        cutpic.add("0.001"); // 添加持续时间为1毫秒
        cutpic.add("-s"); // 添加参数＂-s＂，该参数指定截取的图片大小
        cutpic.add("800X280"); // 添加截取的图片大小为350*240
        cutpic.add(mediaPicPath); // 添加截取的图片的保存路径
        //System.out.print(StringUtils.join(cutpic," "));
        try {
            ShellUtil.executeShell(cutpic.toArray(new String[cutpic.size()]),System.out);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return fname;
    }


    public static String transformSWFToIMG(String swfFilePath) { //swf的截图
        Movie movie = new Movie();
        try {
            movie.decodeFromFile(new File(swfFilePath));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (DataFormatException e) {
            e.printStackTrace();
        }
        List<MovieTag> oList = movie.getObjects();
        int i = 1;
        String fname = System.currentTimeMillis()+".jpg";
        String mediaPicPath =  PropKit.get("material_upload") + "/" + fname;
        boolean success  = false ;
        for (MovieTag o : oList) {
            if (o instanceof ImageTag) {
                ImageTag imageTag = (ImageTag) o;
                try {
                    Method method = imageTag.getClass().getDeclaredMethod("getImage");
                    Object v = method.invoke(imageTag);
                    BufferedImage bio = ImageIO.read(new ByteArrayInputStream((byte[]) v));
                    FileOutputStream fos = new FileOutputStream(mediaPicPath);
//                                       JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(fos);
//                    encoder.encode(bio);

                    ImageIO.write(bio,"jpg",fos);

                    success = true ;
                } catch (NoSuchMethodException e) {
                    e.printStackTrace();
                } catch (InvocationTargetException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                i++;
                if (i > 3) { //第三帧
                    break;
                }
            }
        }
        return success ? fname : null;
    }


    public static void main(String[] args) {

//        File file  = new File( "/Users/jyy/Desktop/material/n1459912744613.flv" );
//        MaterialCheckUtil.CheckUtils c = new  MaterialCheckUtil.CheckUtils(file.getAbsolutePath());
//        capture(file.getAbsolutePath());
//        System.out.println( c.getMaterialResolution() );
//
//        file  = new File( "/Users/jyy/Desktop/material/n1460103019378.swf" );
//        c = new  MaterialCheckUtil.CheckUtils(file.getAbsolutePath());
//        //capture(file.getAbsolutePath());
//        System.out.println( c.getMaterialResolution() );
//
//        file  = new File( "/Users/jyy/Desktop/material/1.png" );
//        c = new  MaterialCheckUtil.CheckUtils(file.getAbsolutePath());
//        //capture(file.getAbsolutePath());
//        System.out.println( c.getMaterialResolution() );
//
//        file  = new File( "/Users/jyy/Desktop/material/ef9ba790c9e74742ae5898aefe9232a1.mp4" );
//        capture(file.getAbsolutePath());
//        c = new MaterialCheckUtil.CheckUtils(file.getAbsolutePath());
//        System.out.println( c.getMaterialResolution() );


        File file  = new File( "/Users/jyy/Desktop/material/n1459912744613.flv" );
        CheckUtils c = new  CheckUtils(file.getAbsolutePath());
        System.out.println( c.getMaterialDuration() );

        file  = new File( "/Users/jyy/Desktop/material/n1460103019378.swf" );
        c = new  CheckUtils(file.getAbsolutePath());
        System.out.println( c.getMaterialDuration() );

        file  = new File( "/Users/jyy/Desktop/material/1.png" );
        c = new  CheckUtils(file.getAbsolutePath());
        System.out.println( c.getMaterialDuration() );

        file  = new File( "/Users/jyy/Desktop/material/ef9ba790c9e74742ae5898aefe9232a1.mp4" );
        c = new CheckUtils(file.getAbsolutePath());
        System.out.println( c.getMaterialDuration() );
    }



    public static class CheckUtils {

        public CheckUtils(String fileName) {
            this.fileName = fileName;
            this.materialFile = new File ( this.fileName );
            this.fileExtName = FilenameUtils.getExtension( this.fileName );
        }

        private File materialFile;
        private String fileName;
        private String fileExtName;//文件的扩展名


        /*
		 * 校验素材的分辨率是否合法 合法返回值为一个map
		 * map中有两个元素：result和message，result的值为：true-校验通过；confirm-需要确认是否通过；false-校验不通过
		 * message为提示信息，校验通过时没有提示信息
		 */
        public JSONObject getMaterialResolution() {
			/*
			 * 使用反射调用相应类型的检查分辨率的方法
			 * 检查分辨率的方法规范是“check”+类型名的大写+"Resolution"，如jpg对应的检查方法命
			 * ：checkJPGResolution() 如果反射找到不到该方法，说明该素材类型不用检查分辨率
			 */

            Map<String,String> convert = new HashMap<String,String>();
            convert.put("GIF","Picture");
            convert.put("JPG","Picture");
            convert.put("BMP","Picture");
            convert.put("PNG","Picture");

            convert.put("MP4","FLV");

            String ext = this.fileExtName.toUpperCase();

            return invokeMethod("get" +  ( convert.containsKey(ext) ? convert.get(ext) : ext ) + "Resolution");
        }


        private JSONObject getPictureResolution(){
            try {
                BufferedImage biFile = ImageIO.read(materialFile);
                return compareResolution(biFile.getWidth(), biFile.getHeight());
            } catch (IOException e) {
                e.printStackTrace();
                return genCheckResult("false", "校验图片尺寸出错，原因："+e.getMessage()+"，请联系开发人员");
            }
        }


//        /*
//		 * 校验GIF分辨率
//		 */
//        protected JSONObject getGIFResolution(){
//            return this.getPictureResolution();
//        }
//
//        /*
//         * 校验JPG分辨率
//         */
//        protected JSONObject getJPGResolution(){
//            return this.getPictureResolution();
//        }
//
//        /*
//         * 校验BMP分辨率
//         */
//        protected JSONObject getBMPResolution(){
//            return this.getPictureResolution();
//        }
//
//        /*
//         * 校验PNG分辨率
//         */
//        protected JSONObject getPNGResolution(){
//            return this.getPictureResolution();
//        }

//        /*
//         * 校验FLV分辨率
//         */
//        protected JSONObject getFLVResolution() {
//            try {
//                Encoder encoder = new Encoder();
//                MultimediaInfo m = encoder.getInfo(materialFile);
//
//                if(m.getVideo() != null){
//                    VideoSize vSize = m.getVideo().getSize();
//                    return compareResolution(vSize.getWidth(), vSize.getHeight());
//                }else{
//                    return genCheckResult("false", "校验FLV分辨率出错，原因：当前上传文件【"+this.fileName+"】含有未知音频格式，请联系开发人员");
//                }
//            } catch (InputFormatException e) {
//                e.printStackTrace();
//                return genCheckResult("false", "校验FLV分辨率出错，原因："+e.getMessage()+"，请联系开发人员");
//            } catch (EncoderException e) {
//                e.printStackTrace();
//                return genCheckResult("false", "校验FLV分辨率出错，原因："+e.getMessage()+"，请联系开发人员");
//            }
//        }

        /*
         * 校验FLV分辨率
         */
        protected JSONObject getFLVResolution() {

            String path = locateFFMPEG();
            if ( path == null ){
                return genCheckResult("false", "找不到ffmpeg的可执行文件,请联系开发人员");
            }

            String suffix = System.getProperty("os.name").toLowerCase().contains("windows") ? ".exe" : "";

            String cmd = path+"/ffprobe"+suffix+" -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height,width "+fileName;
            Map<String,String> map = new HashMap<String,String>();
            String[] attrs = {"width","height"};
            try {
                ShellUtil.ExecuteResult executeResult = ShellUtil.executeShell(cmd,null);
                List<String> results =  executeResult.getOutputList();
                for( String result : results ) {
                    for( String attr : attrs ) {
                        if ( result.indexOf(attr) != -1 ) {
                            map.put(attr,result.split("=")[1]);
                            break ;
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if ( !map.containsKey("width") || !map.containsKey("height") ) {
                return genCheckResult("false", "获取宽高失败,请联系开发人员");
            }
            return compareResolution( Integer.parseInt(map.get("width")) , Integer.parseInt(map.get("height")) );

        }


        /*
         * 校验SWF分辨率
         */
        protected JSONObject getSWFResolution() {
            try {
                Movie movie = new Movie();
                movie.decodeFromFile(materialFile);
                MovieHeader header = null;
                for (MovieTag tag : movie.getObjects()) {
                    // 获取记录SWF基本信息的头文件
                    if (tag instanceof MovieHeader) {
                        header = (MovieHeader) tag;
                        break;
                    }
                }
                return compareResolution(header.getFrameSize().getWidth() / 20, header.getFrameSize().getHeight() / 20);
            } catch(DataFormatException e){
                e.printStackTrace();
                return genCheckResult("false", "校验SWF分辨率出错，原因：" + e.getMessage() + "，请联系开发人员");
            } catch(IOException e){
                 return genCheckResult("false", "校验SWF分辨率出错，原因：" + e.getMessage() + "，请联系开发人员");
            }
        }

        /**
         * 校验视频播放时长，只检查FLV格式视频时长
         * @return
         */
        public long getMaterialDuration(){
            String path = locateFFMPEG();
            if ( path == null ){
                return -1;
            }
            String suffix = System.getProperty("os.name").toLowerCase().contains("windows") ? ".exe" : "";
            String cmd = path+"/ffprobe"+suffix+" -v quiet -print_format json -show_format -show_streams "+fileName;
            try {
                ShellUtil.ExecuteResult executeResult = ShellUtil.executeShell(cmd, null);
                List<String> results = executeResult.getOutputList();
                JSONObject jsonObject = JSONObject.parseObject(StringUtils.join(results,""));
                if ( jsonObject != null && jsonObject.containsKey("format") ) {
                    JSONObject format = jsonObject.getJSONObject("format");
                    if ( format.containsKey("duration") ) {
                        return Math.round( format.getDouble("duration") );
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
            return -1;
        }





        /*
     * 判断分辨率是否符合
     */
        private JSONObject compareResolution(int width,int height){
//            //当前广告位是贴片广告
//            if(isMainMaterial && this.getTiePianMap().containsKey(positionId)){
//                List<String> list = mapTiePian.get(positionId);
//                for (int i = 0; i < list.size(); i++) {
//                    String[] strList = list.get(i).split("x");
//                    int setWidth = Integer.valueOf(strList[0]);
//                    int setHeight = Integer.valueOf(strList[1]);
//
//                    int absWidth = Math.abs(width - setWidth);
//                    int absHeight = Math.abs(height - setHeight);
//
//                    if (absWidth == 0 && absHeight == 0) {
//                        return genCheckResult("true", "");
//                    } else if (absWidth <= this.floatTiePianPX
//                            && absHeight <= this.floatTiePianPX) {
//                        return genCheckResult("confirm", "当前上传文件【"+this.fileName+"】尺寸[" + width + "x"
//                                + height + "] 不符合广告位置规定的[" + setWidth + "x"
//                                + setHeight + "]，但在允许范围（上下浮动"+this.floatTiePianPX+"px）内");
//                    } else {
//                        if(i == (list.size()-1)){
//                            return genCheckResult("false", "当前上传文件【"+this.fileName+"】尺寸[" + width + "x"
//                                    + height + "] 不符合广告位置规定的多个尺寸"+list+"中任何一个");
//                        }
//                    }
//                }
//            } else {
//                //如果当前广告位没有设置分辨率，则不检测
//                if(this.heightReq <= 0 || this.widthReq <= 0){
//                    return genCheckResult("true", "");
//                }else{
//                    int absWidth = Math.abs(width - this.widthReq);
//                    int absHeight = Math.abs(height - this.heightReq);
//
//                    if (absWidth == 0 && absHeight == 0) {
//                        return genCheckResult("true", "");
//                    } else if (absWidth <= this.floatFeiTiePianPX
//                            && absHeight <= this.floatFeiTiePianPX) {
//                        return genCheckResult("confirm", "当前上传文件【"+this.fileName+"】尺寸[" + width + "x" + height
//                                + "] 不符合广告位置规定的[" + this.widthReq + "x" + this.heightReq
//                                + "]，但在允许范围（上下浮动"+this.floatFeiTiePianPX+"px）内");
//                    } else {
//                        return genCheckResult("false", "当前上传文件【"+this.fileName+"】尺寸[" + width + "x" + height
//                                + "] 不符合广告位置规定的[" + this.widthReq + "x" + this.heightReq+ "]");
//                    }
//                }
//            }
            JSONObject jsonObject = genCheckResult("true", "");
            jsonObject.put("height",height);
            jsonObject.put("width",width);
            jsonObject.put("size",this.materialFile.length());
            long duration = getMaterialDuration();
            if ( duration > 0  ) {
                jsonObject.put("duration",duration );
            }

            return jsonObject;
        }

        /*
		 * 反射调用
		 */
        private JSONObject invokeMethod(String methodName){
            JSONObject result = genCheckResult("false", "调用方法【"+methodName+"】出错") ;
            try {
                Method method = CheckUtils.class.getDeclaredMethod(methodName);
                result = (JSONObject) method.invoke(this);
            } catch (IllegalArgumentException e1) {
                e1.printStackTrace();
            } catch (IllegalAccessException e1) {
                e1.printStackTrace();
            } catch (InvocationTargetException e1) {
                e1.printStackTrace();
            } catch (SecurityException e2) {
                e2.printStackTrace();
            } catch (NoSuchMethodException e2) {
                return genCheckResult("false", "找不到当前上传文件【"+this.fileName+"】对应类型素材类型的检测方法");
            }

            return result;
        }

        /*
         * 初始化校验结果
         */
        private static JSONObject genCheckResult(String state,String message){
            return genCheckResult(state, message ,"");
        }

        /*
         * add by ting，增加detail字段，返回前台信息
         * 初始化校验结果，
         */
        private static JSONObject genCheckResult(String state,String message,String detail){
            JSONObject result = new JSONObject();
            result.put("state", state);
            result.put("msg", message);
            result.put("detail", detail);

            return result;
        }




    }

}
