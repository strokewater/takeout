package org.project.takeout.dao;

import org.project.takeout.pojo.Category;

import java.util.List;

public interface ICategoryDao {
    List getAllCategory();
    void delete(int id);
    void add(Category category);
    void edit(Category category);
}
