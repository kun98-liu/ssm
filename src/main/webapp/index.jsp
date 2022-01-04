<%--
  Created by IntelliJ IDEA.
  User: Liu Jiankun
  Date: 2021/11/30
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.css">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.js"></script>
</head>
<body>

<%--模态框--%>
<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form id="emp_save_form" class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span id="empName_add_input_helpblock" class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="xxx@gmail.com">
                            <span id="email_add_input_helpblock" class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_M_add_input" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_F_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-4">
                            <select id="dept_add_select" class="form-control" name="dId"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">添加</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工修改模态框 -->
<div class="modal fade" id="empModModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form id="emp_mod_form" class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_mod_static" name="empName"></p>
                            <span id="empName_mod_input_helpblock" class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_mod_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_mod_input"
                                   placeholder="xxx@gmail.com">
                            <span id="email_mod_input_helpblock" class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_M_mod_input" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_F_mod_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-4">
                            <select id="dept_mod_select" class="form-control" name="dId"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_mod_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<%--搭建页面--%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn-primary" id="emp_add_modal_button">新增</button>
            <button class="btn-danger" id="emp_del_selected_button">删除</button>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>id</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6" id="page_info_area">
        </div>
        <div class="col-md-6" id="page_nav_area">
        </div>

    </div>
</div>

<script type="text/javascript">
    var totalRecord, currentPage;
    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pageNo=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             <button class="">
             <span class="" aria-hidden="true"></span>
             编辑
             </button>
             */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("del-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //var delBtn =
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页,总" +
            result.extend.pageInfo.pages + "页,总" +
            result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    function reset_form(ele) {
        ele[0].reset();
        ele.find("*").removeClass("has-success has-error");
        ele.find(".help-block").text("");
    }

    //点击添加员工按钮后，1.获得部门信息，2.激活模态框
    $("#emp_add_modal_button").click(function () {
        // alert($("#empAddModal form")[0]);
        reset_form($("#empAddModal form"));
        //发送ajax请求，获得部门信息，填充下拉列表
        getDepts("#dept_add_select");
        //添加员工按钮激活模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //查出所有部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                $.each(result.extend.depts, function () {
                    var optionEl = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEl.appendTo(ele);
                })

            }
        })
    }

    //校验表单数据
    function validate_add_form() {
        //先拿到校验的数据。使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            show_validate_msg($("#empName_add_input"), "error", "用户名可以是2-5位中文字符或6-16位英文和数字");
            return false;
        } else {
            show_validate_msg($("#empName_add_input"), "success", "");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg($("#email_add_input"), "error", "请输入合法的邮箱地址");
            return false;
        } else {
            show_validate_msg($("#email_add_input"), "success", "");
        }
        return true;
    }

    function show_validate_msg(ele, status, msg) {
        ele.parent().removeClass("has-success has-error");
        ele.next("span").text("");
        if ("success" == status) {
            ele.parent().addClass("has-success");
            ele.next("span").text(msg);
        } else if ("error" == status) {
            ele.parent().addClass("has-error");
            ele.next("span").text(msg);
        }
    }

    //点击添加员工模态框中的保存按钮后，保存员工.
    $("#emp_save_btn").click(function () {
        //1.表单数据提交给服务器保存
        //先校验一下
        if (!validate_add_form()) {
            return false;
        }

        if ($("#emp_save_btn").attr("ajax_va") == "error") {
            return false;
        }
        // alert( $("#emp_save_form").serialize());
        //2.发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emps",
            type: "POST",
            data: $("#emp_save_form").serialize(),
            dataype: "json",
            success: function (result) {
                // alert(result.msg);
                if (result.code == 100) {

                    $("#empAddModal").modal("hide");
                    to_page(totalRecord);
                } else {
                    if (undefined != result.extend.fieldErrors.email) {
                        show_validate_msg($("#email_add_input"), "error", result.extend.fieldErrors.email);
                    }
                    if (undefined != result.extend.fieldErrors.empName) {
                        show_validate_msg($("#empName_add_input"), "error", result.extend.fieldErrors.empName);
                    }
                }
            }
        });
    });

    $("#empName_add_input").change(function () {
        var empName = $("#empName_add_input").val();
        //发送ajax请求校验用户名是否重复
        $.ajax({
            url: "${APP_PATH}/checkEmp",
            type: "POST",
            data: "empName=" + empName,
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg($("#empName_add_input"), "success", "员工姓名可用");
                    $("#emp_save_btn").attr("ajax_va", "success");
                } else {
                    show_validate_msg($("#empName_add_input"), "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax_va", "error");
                }

            }
        })

    });

    $(document).on("click", ".delete_btn", function () {
        //1.弹出确认是否删除
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        if (confirm("确认删除【" + empName + "】吗？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);

                }
            })
        }
    });

    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        $("#check_all").prop("checked",$(".check_item:checked").length == $(".check_item").length);
    });

    $("#emp_del_selected_button").click(function () {
        var empNames = "";
        var empIds = "";
        $.each($(".check_item:checked"),function () {
            empNames += " 【 " + $(this).parents("tr").find("td:eq(2)").text() + " 】 ";
            empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        empIds = empIds.substring(0,empIds.length-1);
        // alert(empNames);
        if(confirm("确认删除" + empNames)){
            $.ajax({
                url:"${APP_PATH}/emp/" + empIds,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }

            })
        }

    });



    $(document).on("click", ".edit_btn", function () {
        //1.查出员工信息，显示员工信息
        //2.查出部门信息，显示部门列表
        //3.弹出模态框
        getDepts("#dept_mod_select");
        getEmp($(this).attr("edit-id"));
        $("#emp_mod_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empModModal").modal({
            backdrop: "static"
        });
    });

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                var empData = result.extend.emp;
                $("#empName_mod_static").text(empData.empName);
                $("#email_mod_input").val(empData.email);
                $("#empModModal input[name=gender]").val([empData.gender]);
                $("#empModModal select").val([empData.dId])
            }
        })

    }

    $("#emp_mod_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#email_mod_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg($("#email_mod_input"), "error", "请输入合法的邮箱地址");
            return false;
        } else {
            show_validate_msg($("#email_mod_input"), "success", "");
        }

        //发送ajax请求，保存
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empModModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                //关闭模态框，回到页面
                $("#empModModal").modal("hide");
                to_page(currentPage);
            }
        })

    })


</script>


</body>
</html>
