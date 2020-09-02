package org.project.takeout.controller.admin;

import org.hibernate.Session;
import org.project.takeout.biz.ICategoryBiz;
import org.project.takeout.biz.IGoodBiz;
import org.project.takeout.pojo.Category;
import org.project.takeout.pojo.Good;
import org.project.takeout.pojo.JsonResult;
import org.project.takeout.util.ContextHolderUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.util.List;
import java.util.UUID;

@Controller("goodManager")
@RequestMapping("/admin/good")
public class GoodManagerController {
    @Resource
    private IGoodBiz goodBiz;

    @Resource
    private ICategoryBiz categoryBiz;

    @RequestMapping(value = {"/", "/index"})
    public String showGoodList(@RequestParam(value = "page", defaultValue = "1") Integer page,
                               HttpServletRequest request) {
        List lst = goodBiz.getGoodByPage(page);
        request.setAttribute("goods", lst);
        request.setAttribute("totalPage", goodBiz.getGoodTotalPageNum());

        return "admin/goodManager.jsp";
    }

    @RequestMapping("/add")
    public String showAddPage(HttpServletRequest request) {
        List categoryList = categoryBiz.getAllCategory();
        request.setAttribute("categoryList", categoryList);

        return "admin/goodAdd.jsp";
    }

    @RequestMapping("/detail")
    public String showGoodDetailPage(@RequestParam("id") Integer id,
                                     HttpServletRequest request) {
        Good good = goodBiz.getGoodByID(id);
        request.setAttribute("good", good);

        return "admin/goodDetail.jsp";
    }

    @RequestMapping("/doAdd")
    public String doAddGood(@RequestParam("categoryID") int categoryID,
                            @RequestParam("goodName") String goodName,
                            @RequestParam("goodDescription") String goodDescription,
                            @RequestParam("file1") MultipartFile goodImageFile,
                            @RequestParam("goodPrice") double goodPrice) {
        Good good = new Good();
        Category category = new Category();

        category.setId(categoryID);

        good.setCategory(category);
        good.setName(goodName);
        good.setDescription(goodDescription);
        good.setPrice(goodPrice);
        good.setImgFileName(getUploadFileName(goodImageFile));
        goodBiz.add(good);

        return "redirect:/admin/good/index";
    }

    private String getUploadFileName(MultipartFile uploadFile) {
        HttpServletRequest request = ContextHolderUtils.getRequest();

        String imgDirPath = request.getServletContext().getRealPath("/") + "img/";
        String originFileName = uploadFile.getOriginalFilename();
        String suffix = originFileName.substring(originFileName.lastIndexOf(".") + 1);

        String uuid = UUID.randomUUID().toString().replace("-", "");
        String storeFileName = uuid + "." + suffix;
        String storePath = imgDirPath + storeFileName;

        try {
            uploadFile.transferTo(new File(storePath));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return  storeFileName;
    }

    @RequestMapping("/edit")
    public String showEditPage(@RequestParam("id") Integer id,
                               HttpServletRequest request) {
        List categoryList = categoryBiz.getAllCategory();
        Good good = goodBiz.getGoodByID(id);

        request.setAttribute("good", good);
        request.setAttribute("categoryList", categoryList);

        return "admin/goodEdit.jsp";
    }

    @RequestMapping("/doEdit")
    public String editGood(@RequestParam("categoryID") int categoryID,
                           @RequestParam("goodID") int goodID,
                           @RequestParam("goodName") String goodName,
                           @RequestParam("goodDescription") String goodDescription,
                           @RequestParam("file1") MultipartFile goodImageFile,
                           @RequestParam("goodPrice") double goodPrice) {
        Good good = new Good();
        Category category = new Category();

        category.setId(categoryID);

        good.setId(goodID);
        good.setName(goodName);
        good.setCategory(category);
        good.setDescription(goodDescription);

        if (goodImageFile.isEmpty()) {
            Good tempGood = goodBiz.getGoodByID(goodID);
            good.setImgFileName(tempGood.getImgFileName());
        } else
            good.setImgFileName(getUploadFileName(goodImageFile));

        good.setPrice(goodPrice);

        goodBiz.update(good);

        return "redirect:/admin/good/index";
    }

    @RequestMapping("/doDelete")
    @ResponseBody
    public JsonResult deleteGood(@RequestParam("id") Integer id) {
        JsonResult result = new JsonResult();
        goodBiz.delete(id);

        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }
}
