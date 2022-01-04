package cn.kun98.crud.controller;

import cn.kun98.crud.bean.Department;
import cn.kun98.crud.bean.Msg;
import cn.kun98.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author LIU JIANKUN
 * @create 2021-12-08 22:20
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门信息
     * @return
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> list =  departmentService.getDepts();
        return Msg.success().add("depts", list);
    }

}
