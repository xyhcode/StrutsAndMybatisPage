package com.entity;

/**
 * @author 羡羡
 */
public class Heros {
    public int id;
    public String name;
    public String nickname;
    public int sex;
    public String first;
    public String img;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Heros() {
    }

    public Heros(String name, String nickname, int sex, String first, String img) {
        this.name = name;
        this.nickname = nickname;
        this.sex = sex;
        this.first = first;
        this.img = img;
    }

    public Heros(int id, String name, String nickname, int sex, String first, String img) {
        this.id = id;
        this.name = name;
        this.nickname = nickname;
        this.sex = sex;
        this.first = first;
        this.img = img;
    }

    @Override
    public String toString() {
        return "Heros{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", nickname='" + nickname + '\'' +
                ", sex=" + sex +
                ", first='" + first + '\'' +
                ", img='" + img + '\'' +
                '}';
    }
}
