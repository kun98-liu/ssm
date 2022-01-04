package cn.kun98.crud.controller;

import cn.kun98.crud.bean.Employee;
import cn.kun98.crud.bean.Msg;
import cn.kun98.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/** 处理员工增删改查的请求
 * @author LIU JIANKUN
 * @create 2021-11-30 22:50
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据， 分页查询
     * @return
     */
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(name="pageNo",defaultValue = "1")Integer pageNo, Model model){

        PageHelper.startPage(pageNo, 10);
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只要将pageInfo交给页面就行
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo", page);

        return "list";
    }

    /**
     * 用json处理请求,
     * @param pageNo
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(name="pageNo",defaultValue = "1")Integer pageNo){

        PageHelper.startPage(pageNo, 10);
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只要将pageInfo交给页面就行
        PageInfo page = new PageInfo(emps,5);
//        model.addAttribute("pageInfo", page);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 保存员工"
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/emps", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            HashMap<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError fieldError:fieldErrors){
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("fieldErrors", map);
        }else{

            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmp")
    public Msg checkEmp(@RequestParam("empName") String empName){
        String regx = "(^[a-zA-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg", "后台：用户名可以是2-5位中文字符或6-16位英文和数字");
        }
        if(employeeService.checkEmp(empName)){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg", "后台：用户名不可用");
        }
    }

    /**
     * 按照员工id查询员工
     * @param empId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg findEmp(@PathVariable("id")Integer empId){
        Employee emp = employeeService.findEmp(empId);
        if(emp != null){
            return Msg.success().add("emp", emp);
        }else {
            return Msg.fail();
        }

    }

    /**
     * 修改员工
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg modEmp(Employee employee){
//        System.out.println(employee.toString());
        employeeService.modEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            String[] str_ids = ids.split("-");
            List<Integer> del_ids = new ArrayList<>(str_ids.length);
            for(String str_id:str_ids){
                del_ids.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(del_ids);
            return Msg.success();
        }else{
            employeeService.deleteEmpById(Integer.parseInt(ids));
            return Msg.success();
        }

    }

}
