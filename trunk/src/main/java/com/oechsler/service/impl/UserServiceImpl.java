package com.oechsler.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.oechsler.common.page.PageResult;
import com.oechsler.mapper.UserMapper;
import com.oechsler.model.User;
import com.oechsler.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * author:Kris
 * date:2017/10/20
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String userName, String password) {
        Map map = new HashMap();
        map.put("userName",userName);
        map.put("password",password);
        return userMapper.findOneUser(map);
    }

    @Override
    @Transactional
    public int updateUser(User user) {
        return userMapper.updateUser(user);
    }

    @Override
    public PageResult<User> getUserList(User user, int pageIndex, int pageSize) {
        PageHelper.startPage(pageIndex, pageSize);
        List<User> data = userMapper.queryUserListByParam(user);
        PageInfo<User> pageInfo = new PageInfo<User>(data);
        PageResult<User> pageResult = new PageResult<>(data, pageIndex, pageSize, (int) pageInfo.getTotal());
        return pageResult;
    }

    @Override
    @Transactional
    public int addUser(User user) {
        return userMapper.insertSelective(user);
    }

    @Override
    public User checkUserInfo(User user) {
        return userMapper.checkUserInfo(user);
    }

    @Override
    public User getUserById(Integer id) {
        return userMapper.getUserById(id);
    }

    @Override
    public int deleteUser(Integer id) {
        return userMapper.deleteUser(id);
    }

    @Override
    public User getUserByParam(User user) {
        return userMapper.getUserByParam(user);
    }

    @Override
    public Integer getUserRole(Integer userId) {
        return userMapper.getUserRole(userId);
    }

    @Override
    public int addUserRole(Integer userId, Integer roleId) {
        return userMapper.addUserRole(userId,roleId);
    }

    @Override
    public int updateUserRole(Integer userId, Integer roleId) {
        return userMapper.updateUserRole(userId,roleId);
    }

    @Override
    public int deleteUserRoleByUserId(Integer id) {
        return userMapper.deleteUserRoleByUserId(id);
    }

    @Override
    public int batchDeleteUser(String ids) {
        return userMapper.batchDeleteUser(ids);
    }

    @Override
    public int batchDeleteUserRole(String ids) {
        return userMapper.batchDeleteUserRole(ids);
    }
}
