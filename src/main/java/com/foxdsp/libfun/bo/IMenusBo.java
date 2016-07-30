package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.model.Menus;
import com.foxdsp.libfun.vo.UserInfo;

import java.util.List;

/**
 * Created by jinyangyang on 12/28/15 5:36 PM.
 */
public interface IMenusBo {

    String insert(Menus menus);

    String delete(Menus menus);

    List<Menus> getAllMenusByUserInfo(UserInfo userinfo);
}
