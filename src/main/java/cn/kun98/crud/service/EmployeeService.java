package cn.kun98.crud.service;

import cn.kun98.crud.bean.Employee;
import cn.kun98.crud.bean.EmployeeExample;
import cn.kun98.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author LIU JIANKUN
 * @create 2021-11-30 22:55
 */
@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    public EmployeeService() {
    }

    public List<Employee> getAll() {
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.setOrderByClause("emp_id");
        return employeeMapper.selectByExampleWithDept(employeeExample);
    }

    /**
     * 员工保存
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);

    }

    /**
     * 检查empName是否可用
     * @param empName
     * @return
     */
    public boolean checkEmp(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    public Employee findEmp(Integer empId) {
        return employeeMapper.selectByPrimaryKey(empId);
    }

    public void modEmp(Employee emp) {
        employeeMapper.updateByPrimaryKeySelective(emp);
    }

    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> del_ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(del_ids);
        employeeMapper.deleteByExample(example);
    }
}
