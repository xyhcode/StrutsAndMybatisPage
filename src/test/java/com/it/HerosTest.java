package com.it;

import com.dao.HerosDao;
import com.entity.Heros;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;

public class HerosTest {
    SqlSession session;
    HerosDao her;


    @Before
    public void init() throws IOException {
        String resource = "mybatis-config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        session=sqlSessionFactory.openSession();
        her=session.getMapper(HerosDao.class);
    }

    @After
    public void ends(){
        session.commit();
        session.close();
    }

    /**
     * 测试分页查询
     */
    @Test
    public void sehealltest(){
        PageHelper.startPage(1,5);
        List seall=her.seheall();
        System.out.println(seall);
        PageInfo pa=new PageInfo(seall);
        pa.setNavigatePages(10);
        pa.setNavigateLastPage(10);
        System.out.println("总页数："+pa.getPages());
        System.out.println("当前页："+pa.getPageNum());
        int [] panum=pa.getNavigatepageNums();
        System.out.println("导航条："+ Arrays.toString(panum));
        System.out.println(pa.getTotal());
    }


    /**
     * 测试删除
     */
    @Test
    public void del(){
        int hu=her.delherol(170);
        System.out.println(hu);
    }

    /**
     * 测试更新
     */
    @Test
    public void updat(){
        Heros he=new Heros(196,"22","爱的",1,"afd","a.img");
        int cf=her.updateheros(he);
        System.out.println(cf);
    }

    /**
     * 测试添加
     */
    @Test
    public void inser(){
        Heros hi=new Heros("11","222",0,"add","cf.png");
        int hu=her.inser(hi);
        System.out.println(hu);
    }
}
