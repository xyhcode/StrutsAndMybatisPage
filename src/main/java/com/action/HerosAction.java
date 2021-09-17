package com.action;

import com.dao.HerosDao;
import com.entity.GetSqlSession;
import com.entity.Heros;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @author 羡羡
 */
public class HerosAction extends ActionSupport {
    /**
     * 搜索
     */
    String soname;


    PageInfo pa;
    /**
     * 第几页
     */
    int page=1;
    /**
     * id
     */
    int id;
    /**
     * form表单的文件上传框name
     */
    File myFile;
    /**
     * 文件类型
     */
    String myFileContentType;
    /**
     * 文件名
     */
    String myFileFileName;
    /**
     * 储存路径
     */
    String destPath;
    /**
     * 文件原名称
     */
    String filnae;

    /**
     * name
     */
    String name;
    /**
     * id
     */
    int herid;
    /**
     * nickname
     */
    String nickname;
    /**
     * sex
     */
    int sex;
    /**
     * first
     */
    String first;

    public String getSoname() {
        return soname;
    }

    public void setSoname(String soname) {
        this.soname = soname;
    }

    public String getFilnae() {
        return filnae;
    }

    public void setFilnae(String filnae) {
        this.filnae = filnae;
    }

    public File getMyFile() {
        return myFile;
    }

    public void setMyFile(File myFile) {
        this.myFile = myFile;
    }

    public String getMyFileContentType() {
        return myFileContentType;
    }

    public void setMyFileContentType(String myFileContentType) {
        this.myFileContentType = myFileContentType;
    }

    public String getMyFileFileName() {
        return myFileFileName;
    }

    public void setMyFileFileName(String myFileFileName) {
        this.myFileFileName = myFileFileName;
    }

    public String getDestPath() {
        return destPath;
    }

    public void setDestPath(String destPath) {
        this.destPath = destPath;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getHerid() {
        return herid;
    }

    public void setHerid(int herid) {
        this.herid = herid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getFirst() {
        return first;
    }

    public void setFirst(String first) {
        this.first = first;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public PageInfo getPa() {
        return pa;
    }

    public void setPa(PageInfo pa) {
        this.pa = pa;
    }

    //分页显示
    public String show() throws IOException {
        SqlSession session= GetSqlSession.getsSession();
        HerosDao herdao=session.getMapper(HerosDao.class);
        PageHelper.startPage(page,5);
        System.out.println(soname);
        List seall=herdao.seheall(soname);
        pa=new PageInfo(seall);
        return SUCCESS;
    }

    //删除
    public String del() throws IOException {
        SqlSession session= GetSqlSession.getsSession();
        HerosDao herdao=session.getMapper(HerosDao.class);
        System.out.println(id);
        int desu=herdao.delherol(id);
        session.commit();
        session.close();
        show();
        return SUCCESS;
    }

    //修改
    public String update() throws IOException {
        HttpServletRequest request= ServletActionContext.getRequest();
        //得到ID
        String id=request.getParameter("herid");
        herid=Integer.parseInt(id);
        //name
        name=request.getParameter("name");
        //nickname
        nickname=request.getParameter("nickname");
        //sex
        String sein=request.getParameter("sex");
        sex=Integer.parseInt(sein);
        //first
        first=request.getParameter("first");
        //filename
        filnae=request.getParameter("filnae");
        SqlSession session= GetSqlSession.getsSession();
        //如果用户没有修改图片
        if(myFile==null){
            HerosDao herdao=session.getMapper(HerosDao.class);
            //实体构造方法
            Heros hi=new Heros(herid,name,nickname,sex,first,filnae);
            //执行修改方法
            int cf=herdao.updateheros(hi);
        }else{
            //修改图片
            destPath= ServletActionContext.getServletContext().getRealPath("/herosimg");
            System.out.println("Src File name: " + myFile);
            System.out.println("Dst File name: " + myFileFileName);
            File destFile  = new File(destPath, myFileFileName);
            FileUtils.copyFile(myFile, destFile);
            //dao层
            HerosDao herdao=session.getMapper(HerosDao.class);
            //实体类构造方法
            Heros hi=new Heros(herid,name,nickname,sex,first,myFileFileName);
            int cf=herdao.updateheros(hi);
        }
        //提交事务
        session.commit();
        //关闭
        session.close();
        //执行分页方法
        show();
        return SUCCESS;
    }

    //添加
    public String inshero() throws IOException {
        HttpServletRequest request= ServletActionContext.getRequest();
        //name
        name=request.getParameter("name");
        //nickname
        nickname=request.getParameter("nickname");
        //sex
        String sein=request.getParameter("sex");
        sex=Integer.parseInt(sein);
        //first
        first=request.getParameter("first");
        SqlSession session= GetSqlSession.getsSession();
        if(myFile==null){
            HerosDao herdao=session.getMapper(HerosDao.class);
            Heros hi=new Heros(name,nickname,sex,first,null);
            int cf=herdao.inser(hi);
        }else{
            destPath= ServletActionContext.getServletContext().getRealPath("/herosimg");
            System.out.println("Src File name: " + myFile);
            System.out.println("Dst File name: " + myFileFileName);
            File destFile  = new File(destPath, myFileFileName);
            FileUtils.copyFile(myFile, destFile);
            HerosDao herdao=session.getMapper(HerosDao.class);
            Heros hi=new Heros(name,nickname,sex,first,myFileFileName);
            int cf=herdao.inser(hi);
        }
        session.commit();
        session.close();
        show();
        return SUCCESS;
    }
}
