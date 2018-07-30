package com.oechsler.service;

import com.oechsler.common.page.PageResult;
import com.oechsler.model.User;

/**
 * author:Kris
 * date:2017/10/20
 */
public interface UserService {

    User login(String userName,String password);

    int updateUser(User user);

    PageResult<User> getUserList(User user, int pageIndex, int pageSize);

    int addUser(User user);

    User checkUserInfo(User user);

    User getUserById(Integer id);

    int deleteUser(Integer id);

    User getUserByParam(User user);

    Integer getUserRole(Integer userId);

    int addUserRole(Integer userId,Integer roleId);

    int updateUserRole(Integer userId,Integer roleId);

    int deleteUserRoleByUserId(Integer id);

    int batchDeleteUser(String ids);

    int batchDeleteUserRole(String ids);
}
