package org.project.takeout.controller.admin;

import org.project.takeout.biz.ICategoryBiz;
import org.project.takeout.pojo.Category;
import org.project.takeout.pojo.JsonResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller("categoryManagerController")
@RequestMapping("/admin/category")
public class CategoryManagerController {
    @Resource
    private ICategoryBiz categoryBiz;

    @RequestMapping(value = {"/", "/index"})
    public String listCategory(HttpServletRequest request) {
        List categoryList = categoryBiz.getAllCategory();
        request.setAttribute("categoryList", categoryList);

        return "admin/categoryManager.jsp";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult deleteCategory(@RequestParam("id") Integer id) {
        JsonResult result = new JsonResult();

        categoryBiz.delete(id);
        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }

    @RequestMapping("/edit")
    @ResponseBody
    public JsonResult editCategory(@RequestParam("id") Integer id,
                               @RequestParam("name") String name) {
        JsonResult result = new JsonResult();

        Category category = new Category();
        category.setId(id);
        category.setName(name);

        categoryBiz.edit(category);
        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }

    @RequestMapping("/add")
    @ResponseBody
    public JsonResult addCategory(@RequestParam("name") String name) {
        JsonResult result = new JsonResult();

        Category category = new Category();
        category.setName(name);

        categoryBiz.add(category);
        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }
}
