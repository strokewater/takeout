package org.project.takeout.biz;

import org.project.takeout.pojo.Category;

import java.util.List;

public interface ICategoryBiz {
    List getAllCategory();
    void delete(int id);
    void add(Category category);
    void edit(Category category);
}
