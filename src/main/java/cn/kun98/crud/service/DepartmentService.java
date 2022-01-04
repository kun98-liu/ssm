package cn.kun98.crud.service;

import cn.kun98.crud.bean.Department;
import cn.kun98.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author LIU JIANKUN
 * @create 2021-12-08 22:21
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public DepartmentService() {
    }


    public List<Department> getDepts() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
