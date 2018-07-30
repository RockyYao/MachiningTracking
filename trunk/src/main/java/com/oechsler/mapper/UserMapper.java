package com.oechsler.mapper;

import com.oechsler.model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface UserMapper {
    int insert(User record);

    int insertSelective(User record);

    User findOneUser(Map map);

    List<User> queryUserListByParam(User user);

    int updateUser(User user);

    User checkUserInfo(User user);

    User getUserById(Integer id);

    int deleteUser(Integer id);

    User getUserByParam(User user);

    Integer getUserRole(Integer userId);

    int addUserRole(@Param("userId") Integer userId, @Param("roleId") Integer roleId);

    int updateUserRole(@Param("userId") Integer userId, @Param("roleId") Integer roleId);

    int deleteUserRoleByUserId(Integer id);

    int batchDeleteUser(String ids);

    int batchDeleteUserRole(String ids);
}