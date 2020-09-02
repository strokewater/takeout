package org.project.takeout.pojo;

import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.Set;

@Component("category")
public class Category {
    private int id;
    private String name;
    private Set<Good> goods;


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

    public Set<Good> getGoods() {
        return goods;
    }

    public void setGoods(Set<Good> goods) {
        this.goods = goods;
    }
}
