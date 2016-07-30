package com.foxdsp.libfun.bo;

import com.foxdsp.common.util.email.EMailParams;
import com.foxdsp.libfun.constant.LoginStatus;
import com.foxdsp.libfun.model.Libconfig;
import com.foxdsp.libfun.model.Menus;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.util.UserAuthUtil;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.vo.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * @author lixin
 *         常用的一些业务，如配置获取，登录，用户菜单等
 * @since 2011-10-27 上午11:13:33
 */
@Component
public class CommonBoImpl extends BaseBo implements ICommonBo {

    private static Map<String, Object> userMap = new HashMap<String, Object>();

    //@Autowired
    //public ILibConfigBo ligConfigBo;
    @Autowired
    public IUsersBo usersBo;
    @Autowired
    public IMenusBo menusBo;
    //@Autowired
    //public IAuthBo authBo;

    @Override
    public LibfunCommonReturn getConfig() {
        LibfunCommonReturn rtn = new LibfunCommonReturn();
        List<Libconfig> configList = Libconfig.dao.find("select *  from libconfig");
        Map<String, String> configMap = new HashMap<String, String>();
        for (Libconfig lc : configList) {
            configMap.put(lc.getConfigNo(), lc.getConfigValue());
        }
        rtn.setData(configMap);
        return rtn;
    }


    @Override
    public void logout() {

    }

    @Override
    public List<Menus> getMenus(UserInfo userInfo) {
        return menusBo.getAllMenusByUserInfo(userInfo);
    }

    @Override
    public boolean hasPrivilege(UserInfo userInfo, String serviceName, String methodName) {
        if (userInfo == null) {
            return false;
        }
        boolean isSuperMan = userInfo.getUser().isSuperman() ;
        return isSuperMan || userInfo.getServicePrivilegeMap().containsKey(serviceName + "-" + methodName);
    }

    public Map<String, Object> getUserMap() {
        return userMap;
    }

    @Override
    public String resetPasswordByUsername(String username) {
        Users u = usersBo.queryUsersByUserLogNo(username);
        if (u == null) {
            return "您输入的用户名不正确！";
        }
        if (u.getEmail().equals("")) {
            return "您的账号未绑定邮箱，请与管理员联系！";
        }
        String password = genRamdomPassword();
        u.setUserPassword(password);
        //usersBo.update(u);
        u.update();

        EMailParams ep = new EMailParams();
        ep.setToaddress(u.getEmail());
        ep.setSubject("传媒管理系统-用户密码重置提醒");
        ep.setContent("你好 " + u.getTrueName() + "，你的新密码为：" + password);
        ep.setMimeContent(true);
//        new EMailUtil(CmConfigName.EMAIL_HOST, CmConfigName.EMAIL_USER, CmConfigName.EMAIL_PASS).send(ep);

        return "密码已发送至您的邮箱，请注意查收！";
    }

    /**
     * 随机生成一个十位数的密码，第一位为大写字母，第二位为数字，其他字符在[a-zA-Z0-9]中随机
     *
     * @return
     */
    private String genRamdomPassword() {
        char[] all = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
        char[] digital = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
        char[] upperChar = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};

        Random r = new Random();
        char[] pass = new char[10];
        pass[0] = upperChar[r.nextInt(26)];
        pass[1] = digital[r.nextInt(10)];
        for (int i = 2; i < 10; i++) {
            pass[i] = all[r.nextInt(62)];
        }
        String password = String.valueOf(pass);

        return password;

    }

    @Override
    public LibfunCommonReturn login(String username, String password, String ip) {
        LibfunCommonReturn libfunCommonReturn = usersBo.login(username, password, ip);
        UserInfo userInfo = (UserInfo)libfunCommonReturn.getData();
        if (userInfo != null && userInfo.getLoginStatus() == LoginStatus.OK) {
            UserAuthUtil.me.initUserInfoPrivilege(userInfo);
        }
        return libfunCommonReturn;
    }

}
