package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.constant.PrivilegeTypes;
import com.foxdsp.libfun.model.Privilege;
import com.foxdsp.libfun.model.Role;

import java.util.List;




public interface IAuthBo {
	
	/**
	 * @param username
	 * @param type @see {@link PrivilegeTypes}
	 * @return
	 */
	List<Privilege> getUserPrivilegeByType(String username, int type);
	
	/**
	 * 查找用户角色
	 * @param username
	 * @return
	 */
	List<Role> queryRoleByUsername(String username);
	
	/**
	 * 查询用户不包含的role
	 * @param username
	 * @return
	 */
	List<Role> queryExcludedRoleByUsername(String username);
	
	/**
	 * 添加用户角色
	 */
	void insertUsersrole(String username, String[] rolenos);
	
	/**
	 * 删除用户角色
	 * @param username
	 * @param rolenos
	 */
	void deleteUsersroleByUsername(String username, String[] rolenos);
	
	/**
	 * 通过角色查找权限
	 * @param roleno
	 * @return
	 */
	List<Privilege> queryPrivilegeByRoleno(String roleno);
	
	/**
	 * 通过角色查找不具备的权限
	 * @param roleno
	 * @return
	 */
	List<Privilege> queryExcludedPrivilegeByRoleno(String roleno);
	
	/**
	 * 添加角色权限
	 * @param roleno
	 * @param privilegeids
	 */
	void insertRoleprivilegeByRoleno(String roleno, long[] privilegeids);
	
	/**
	 * 删除角色权限
	 * @param roleno
	 * @param privilegeids
	 */
	void deleteRoleprivilegeByRoleno(String roleno, long[] privilegeids);
	
//	/**
//	 * @param username
//	 * @param type
//	 * @param privlegeValue
//	 * @return
//	 */
//	boolean hasPrivlege(String username, int type, String privlegeValue);
	
	
	
	/**
	 * 查找所有spring内定义的@Service标签的bo和bo内标注@RemoteMethod的方法，如果数据库不存在则插入数据库，如果数据库存在但代码里面不存在则删除
	 */
//	void refreshServicePermission();
//	
//	boolean hasPermission(String userlogo,String className,String methodName);
//	
//	List<Users> getUsersByRoleno(String roleno);
//	
//	List<Role> getRolesByUserlogno(String userlogno);
//	
//	UserToRole insertUserToRole(UserToRole data);
//	
//	void deleteUserToRole(UserToRole data);
//	
//	void deleteUserToRoleByUserlognoAndRoleno(String userlogno,String roleno);
//	
//	List<Role> getAllRoles();
//	
//	List<Role> getRolesByPermissionid(long pid);
//	
//	/**
//	 * 得到所有权限，使用roleno过滤
//	 * @param roleno
//	 * @return
//	 */
//	List<Permission> getPermissionsByRoleno(String roleno);
//	
//	RoleToPermission insertRoleToPermission(RoleToPermission roleToPermission);
//	
//	void deleteRoleToPermission(RoleToPermission data);
//	
//	void deleteRoleToPermissionByRolenoAndPermissionid(String roleno,String permissionid);
//	
//	List<Permission> getAllPermission();
}
