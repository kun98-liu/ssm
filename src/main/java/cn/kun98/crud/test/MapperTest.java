package cn.kun98.crud.test;

import cn.kun98.crud.bean.Department;
import cn.kun98.crud.bean.Employee;
import cn.kun98.crud.dao.DepartmentMapper;
import cn.kun98.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/** 测试dao层
 * @author LIU JIANKUN
 * @create 2021-11-27 20:37
 *
 * 推荐使用Spring单元测试，可以自动注入组件
 * 1.导入SpringTest模块
 * 2.使用注解@ContextConfiguration
 * 3.使用@Autowire引入组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;


    /*
        测试DepartmentMapper
     */
    @Test
    public void testCRUD(){
//        System.out.println(departmentMapper);

//        departmentMapper.insertSelective(new Department(null,"dev"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
//        employeeMapper.insertSelective(new Employee(null,"jerry","M","jerry@gmail.com",3));
//
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uid,"M",uid + "@gmail.com",3));
        }
        System.out.println("batch succeed");
    }

    @Test
    public void testInsertSelective(){
//        System.out.println(departmentMapper);

//        departmentMapper.insertSelective(new Department(null,"dev"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
//        employeeMapper.insertSelective(new Employee(null,"jerry","M","jerry@gmail.com",3));
//
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        String uid = UUID.randomUUID().toString().substring(0, 5) + 10;
//        int f = mapper.insertSelective(new Employee(null, uid, "F", uid + "@gmail.com", 4));
        int i = mapper.insertSelective(new Employee(null, "wangli22", "F", "wangli@outlook.com", 3));
        System.out.println(i);
    }

}
