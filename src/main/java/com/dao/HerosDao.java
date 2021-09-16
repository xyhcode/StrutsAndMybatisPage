package com.dao;

import com.entity.Heros;

import java.util.List;

/**
 * @author 羡羡
 */
public interface HerosDao {
    /**
     * 分页查询
     * @return
     */
    public List seheall();

    /**
     * 删除
     */
    public int delherol(int id);

    /**
     * 编辑
     * @param hes 实体Heros
     * @return
     */
    public int updateheros(Heros hes);

    /**
     * 添加
     * @param hes 实体Heros
     * @return
     */
    public int inser(Heros hes);
}
