package com.foxdsp.libfun.config;

import com.jfinal.config.Plugins;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.foxdsp.libfun.model.*;

/**
 * Created by briceli on 15/8/26.
 */
public class LibfunModelConfig {
    public static void mapModel(ActiveRecordPlugin arp){
        arp.addMapping("libfun_privilege", "seqid", Privilege.class);
        arp.addMapping("libfun_role", "seqid", Role.class);
        arp.addMapping("libfun_roleprivilege", "seqid", Roleprivilege.class);
        arp.addMapping("libfun_libconfig", "seqid", Libconfig.class);
        arp.addMapping("libfun_users", "seqid", Users.class);
        arp.addMapping("libfun_usersrole", "seqid", Usersrole.class);
        arp.addMapping("libfun_menus", "menuno", Menus.class);
        arp.addMapping("libfun_libclassm", "seqid", Libclassm.class);
        arp.addMapping("libfun_libclassd", "seqid", Libclassd.class);
        arp.addMapping("libfun_usersext", "seqid", Usersext.class);
        arp.addMapping("libfun_notify_send", "seqid", NotifySend.class);
        arp.addMapping("libfun_notify_message", "seqid", NotifyMessage.class);
        arp.addMapping("libfun_syslog", "seqid", Syslog.class);
    }
}
