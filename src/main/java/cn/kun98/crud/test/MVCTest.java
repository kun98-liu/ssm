package cn.kun98.crud.test;

import cn.kun98.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author LIU JIANKUN
 * @create 2021-11-30 23:21
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml" ,"file:D:\\Developer\\workspace_IDEA\\SSM_CRUD\\ssm\\src\\main\\webapp\\WEB-INF\\dispatcherServlet-servlet.xml"})
public class MVCTest {

    MockMvc mockMvc;

    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMVc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNo", "1")).andReturn();

        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码" + pageInfo.getPageNum());
        System.out.println("总页码" + pageInfo.getPages());
        int[] navigatePages = pageInfo.getNavigatepageNums();
        for (int i : navigatePages) {
            System.out.print(" " + i);
        }

        List<Employee> list = pageInfo.getList();
        for (Employee emp: list) {
            System.out.println(emp.getEmpId());
        }
    }



}
