# ************************************************************
# Sequel Pro SQL dump
# Version 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.40)
# Database: foxdsp_webframework
# Generation Time: 2016-07-09 06:49:43 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table libfun_libclassd
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_libclassd`;

CREATE TABLE `libfun_libclassd` (
  `SeqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClassNo` varchar(20) NOT NULL DEFAULT '',
  `ItemNo` varchar(20) NOT NULL DEFAULT '',
  `ClassItemId` varchar(40) NOT NULL DEFAULT '',
  `ItemName` varchar(40) NOT NULL DEFAULT '',
  `ItemOrder` int(11) NOT NULL DEFAULT '1000',
  `ItemValue` varchar(255) DEFAULT NULL,
  `Remark` varchar(255) DEFAULT NULL,
  `EditBy` varchar(30) NOT NULL DEFAULT '',
  `EditTime` varchar(19) NOT NULL DEFAULT '',
  PRIMARY KEY (`SeqId`),
  KEY `libclassd_idx1` (`ClassNo`),
  KEY `libclassd_idx2` (`ItemNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

LOCK TABLES `libfun_libclassd` WRITE;
/*!40000 ALTER TABLE `libfun_libclassd` DISABLE KEYS */;

INSERT INTO `libfun_libclassd` (`SeqId`, `ClassNo`, `ItemNo`, `ClassItemId`, `ItemName`, `ItemOrder`, `ItemValue`, `Remark`, `EditBy`, `EditTime`)
VALUES
	(10,'PlatformStatus','N','PlatformStatusN','正常',1,'N','','jasonzhang','2009-12-21 13:29:02'),
	(11,'PlatformStatus','C','PlatformStatusC','关闭',2,'C','','jasonzhang','2010-01-18 11:29:52'),
	(19,'PositionType','A','PositionTypeA','通栏',1,'','','zc','2009-12-28 14:03:14'),
	(20,'PositionType','B','PositionTypeB','按钮',2,'','','zc','2009-12-28 14:03:10'),
	(21,'AdType','A','','常规广告',1,'A','re','jinyangyang','2015-12-07 17:40:51'),
	(22,'AdType','B','AdTypeB','贴片广告',2,'B','','jasonzhang','2009-12-23 12:56:08'),
	(23,'AdType','C','AdTypeC','特殊资源',3,'C','','wujing','2010-01-04 16:22:35'),
	(29,'MaterialType','2','MaterialType2','jpg',1000,'','','jasonzhang','2009-12-23 13:53:42'),
	(33,'PositionStatus','A','PositionStatusA','正常',1000,'','','jasonzhang','2009-12-23 14:39:16'),
	(34,'PositionStatus','B','PositionStatusB','测试',1000,'','','jasonzhang','2009-12-23 14:39:22'),
	(35,'PositionStatus','C','PositionStatusC','暂停',1000,'','','jasonzhang','2009-12-23 14:39:29'),
	(36,'PositionStatus','D','PositionStatusD','失效',1000,'','','jasonzhang','2009-12-23 14:39:36'),
	(37,'MaterialType','3','MaterialType3','jpeg',1000,'','','jasonzhang','2009-12-23 17:43:27'),
	(38,'MaterialType','4','MaterialType4','png',1000,'','','jasonzhang','2009-12-23 17:43:36'),
	(39,'MaterialType','5','MaterialType5','swf',1000,'','','jasonzhang','2009-12-23 17:43:41'),
	(41,'MaterialType','7','MaterialType7','wmv',1000,'','','jasonzhang','2009-12-23 17:43:53'),
	(42,'MaterialType','8','MaterialType8','flv',1000,'','','zc','2010-01-19 17:32:30'),
	(43,'MaterialType','9','MaterialType9','tab',1000,'','','zc','2010-01-19 17:32:45'),
	(54,'CustomStatus','N','CustomStatusN','正常',1000,'','','jasonzhang','2009-12-25 11:05:40'),
	(55,'CustomStatus','C','CustomStatusC','关闭',1000,'','','jasonzhang','2009-12-25 11:05:46'),
	(59,'AutoIncrement','orderid','AutoIncrementorderid','订单号',1000,'34774','','onizukaspm','2010-01-25 17:11:07'),
	(65,'PositionType','C','PositionTypeC','文字链',1000,'','','zc','2009-12-28 12:50:29'),
	(66,'PositionType','D','PositionTypeD','INMEDIA',1000,'','','zc','2009-12-28 12:50:36'),
	(67,'PositionType','E','PositionTypeE','标签页',1000,'','','zc','2009-12-28 12:50:43'),
	(68,'PositionType','F','PositionTypeF','特殊文字链',1000,'','','zc','2009-12-28 12:50:49'),
	(69,'PositionType','G','PositionTypeG','挂角',1000,'','','zc','2009-12-28 12:50:56'),
	(70,'PositionType','H','PositionTypeH','跑马灯',1000,'','','zc','2009-12-28 12:51:05'),
	(71,'PositionType','I','PositionTypeI','暂停',1000,'','','zc','2009-12-28 12:51:13'),
	(72,'PositionType','J','PositionTypeJ','拉幕',1000,'','','zc','2009-12-28 12:51:20'),
	(79,'SaleType','A','SaleTypeA','销售',1000,'1','','liheng','2012-08-07 13:52:32'),
	(80,'SaleType','B','SaleTypeB','测试',1000,'1','','liheng','2012-08-07 13:52:36'),
	(82,'SaleType','D','SaleTypeD','赔偿',1000,'1','','liheng','2012-08-07 13:52:53'),
	(83,'SaleType','F','SaleTypeF','内部合作(非保护)',1000,'1','','liheng','2012-08-07 13:53:00'),
	(84,'SaleType','G','SaleTypeG','特殊资源(软性销售)',1000,'2','','liheng','2012-08-07 13:53:28'),
	(85,'SaleType','E','SaleTypeE','内部合作(保护)',1000,'1','','liheng','2012-08-07 13:52:56'),
	(93,'AreaNo','1156370000','AreaNo1156370000','山东',1,'117.019896,36.669227','S_山东_SHANDONG_P','wangyan','2011-01-17 17:10:42'),
	(94,'AreaNo','1156520000','AreaNo1156520000','贵州',1,'106.706927,26.598435','G_贵州_GUIZHOU_P','betatong','2010-04-13 20:29:29'),
	(95,'AreaNo','1156360000','AreaNo1156360000','江西',1,'115.90893,28.674628','J_江西_JIANGXI_P','betatong','2010-04-13 20:27:17'),
	(96,'AreaNo','1156500000','AreaNo1156500000','重庆',1,'106.548425,29.5549144','C_重庆_CHONGQING_P','wangyan','2010-12-30 16:06:26'),
	(97,'AreaNo','1156150000','AreaNo1156150000','内蒙古',1,'111.674121,40.823542','N_内蒙古_NEIMENGGU_P','betatong','2010-04-13 20:26:33'),
	(98,'AreaNo','1156420000','AreaNo1156420000','湖北',1,'114.341719,30.54565','H_湖北_HUBEI_P','wangyan','2011-01-17 17:10:46'),
	(99,'AreaNo','1156430000','AreaNo1156430000','湖南',1,'112.983521,28.113053','H_湖南_HUNAN_P','betatong','2010-04-13 20:26:18'),
	(100,'AreaNo','1156220000','AreaNo1156220000','吉林',1,'125.325766,43.896289','J_吉林_JILIN_P','betatong','2010-04-13 20:26:10'),
	(101,'AreaNo','1156350000','AreaNo1156350000','福建',1,'119.295863,26.101062','F_福建_FUJIAN_P','betatong','2010-04-13 20:26:00'),
	(102,'AreaNo','1156310000','AreaNo1156310000','上海',1,'121.6759159,31.2243531','S_上海_SHANGHAI_P','betatong','2010-04-13 20:30:43'),
	(103,'AreaNo','1156110000','AreaNo1156110000','北京',1,'116.408198,39.904667','B_北京_BEIJING_P','betatong','2010-04-13 20:30:37'),
	(104,'AreaNo','1156450000','AreaNo1156450000','广西',1,'108.327697,22.815547','G_广西_GUANGXI_P','betatong','2010-04-13 20:30:30'),
	(105,'AreaNo','1156440000','AreaNo1156440000','广东',1,'113.266558,23.131614','G_广东_GUANGDONG_P','wangyan','2011-01-17 17:10:51'),
	(106,'AreaNo','1156510000','AreaNo1156510000','四川',1,'104.076418,30.650892','S_四川_SICHUAN_P','wangyan','2011-01-17 17:10:56'),
	(107,'AreaNo','1156530000','AreaNo1156530000','云南',1,'102.709809,25.045254','Y_云南_YUNNAN_P','betatong','2010-04-13 20:30:05'),
	(108,'AreaNo','1156630000','AreaNo1156630000','青海',1,'101.780334,36.620988','Q_青海_QINHAI_P','betatong','2010-04-13 20:29:58'),
	(109,'AreaNo','1156620000','AreaNo1156620000','甘肃',1,'103.826363,36.0593','G_甘肃_GANSU_P','betatong','2010-04-13 20:29:50'),
	(110,'AreaNo','1156130000','AreaNo1156130000','河北',1,'114.469259,38.037252','H_河北_HEBEI_P','betatong','2010-04-13 20:29:43'),
	(111,'AreaNo','1158000000','AreaNo1158000000','台湾',1,'120.960515,23.69781','T_台湾_TAIWAN_P','betatong','2010-04-13 20:29:36'),
	(112,'AreaNo','1156330000','AreaNo1156330000','浙江',1,'120.15383,30.266214','Z_浙江_ZHEJIANG_P','wangyan','2011-01-17 17:11:01'),
	(113,'AreaNo','1156320000','AreaNo1156320000','江苏',1,'118.7727814,32.0476151','J_江苏_JIANGSU_P','wangyan','2011-01-17 17:10:34'),
	(114,'AreaNo','1156230000','AreaNo1156230000','黑龙江',1,'126.66268,45.742352','H_黑龙江_HEILONGJIANG_P','betatong','2010-04-13 20:28:22'),
	(115,'AreaNo','1156210000','AreaNo1156210000','辽宁',1,'123.437162,41.836521','L_辽宁_LIAONING_P','betatong','2010-04-13 20:28:14'),
	(116,'AreaNo','1156120000','AreaNo1156120000','天津',1,'117.7523808,39.3038561','T_天津_TIANJIN_P','betatong','2010-04-13 20:28:06'),
	(117,'AreaNo','1156640000','AreaNo1156640000','宁夏',1,'106.25868,38.47117','N_宁夏_NINGXIA_P','betatong','2010-04-13 20:27:59'),
	(118,'AreaNo','1156340000','AreaNo1156340000','安徽',1,'117.2847,31.860611','A_安徽_ANHUI_P','betatong','2010-04-13 20:27:51'),
	(119,'AreaNo','1156140000','AreaNo1156140000','山西',1,'112.562537,37.873464','S_山西_SHANXI_P','betatong','2010-04-13 20:27:40'),
	(120,'AreaNo','1156460000','AreaNo1156460000','海南',1,'110.356808,20.029341','H_海南_HAINAN_P','betatong','2010-04-13 20:27:32'),
	(121,'AreaNo','1156410000','AreaNo1156410000','河南',1,'113.687816,34.767884','H_河南_HENAN_P','betatong','2010-04-13 20:27:24'),
	(122,'AreaNo','1156610000','AreaNo1156610000','陕西',1,'108.954132,34.265173','S_陕西_SHANXI3_P','betatong','2010-04-13 20:36:42'),
	(123,'AreaNo','1156650000','AreaNo1156650000','新疆',1,'87.627546,43.793147','X_新疆_XINJIANG_P','betatong','2010-04-13 20:27:01'),
	(124,'AreaNo','1446000000','AreaNo1446000000','澳门',1,NULL,'A_澳门_AOMEN_P','',''),
	(125,'AreaNo','1344000000','AreaNo1344000000','香港',1,NULL,'X_香港_XIANGGANG_P','',''),
	(126,'AreaNo','1156540000','AreaNo1156540000','西藏',1,'91.117006,29.647951','X_西藏_XIZANG_P','betatong','2010-04-13 20:26:48'),
	(127,'AreaNo','1156440100','AreaNo1156440100','广州市',1,'','G_广东_GUANGDONG_C','jasonzhang','2009-12-30 14:50:41'),
	(128,'AreaNo','1156440300','AreaNo1156440300','深圳市',1,'','G_广东_GUANGDONG_C','wangyan','2011-01-17 17:11:06'),
	(138,'AdType','D','AdTypeD','CPM',1000,'D',' 的','wangyan','2010-07-30 15:18:56'),
	(139,'AreaNo','0','AreaNo0','大陆',1,'','D','wangyan','2011-01-17 16:53:07'),
	(143,'PositionType','Z','PositionTypeZ','测试',1000,'','','jasonzhang','2010-01-11 15:33:06'),
	(147,'MaterialCheckStatus','A','MaterialCheckStatusA','未审核',1000,'','','wujing','2010-01-14 19:59:10'),
	(148,'MaterialCheckStatus','B','MaterialCheckStatusB','审核通过',1000,'','','wujing','2010-01-14 19:59:21'),
	(149,'MaterialCheckStatus','C','MaterialCheckStatusC','审核不过',1000,'','','wujing','2010-01-14 19:59:34'),
	(150,'MaterialCheckStatus','D','MaterialCheckStatusD','直接上线',1000,'','','wujing','2010-01-14 19:59:43'),
	(196,'AdverTemplate','CornerAd.vm','AdverTemplateCornerAd.vm','角标-普通',1000,'CornerAd.vm','4808a5ecbe0adcb846a1f8f66b7cc856','zc','2010-01-19 11:40:23'),
	(197,'AdverTemplate','CornerAdGVOD.vm','AdverTemplateCornerAdGVOD.vm','角标-GVOD',1000,'CornerAdGVOD.vm','e229d2ac42c8b1a7e6fdf07463907157','zc','2010-01-19 11:40:15'),
	(198,'AdverTemplate','cpmcorner.vm','AdverTemplatecpmcorner.vm','角标-CPM',1000,'cpmcorner.vm','d4083b9afff3d3c1d3d8bffe65ba76ec','zc','2010-01-19 11:40:02'),
	(199,'AdverTemplate','cpmpause.vm','AdverTemplatecpmpause.vm','暂停-CPM',1000,'cpmpause.vm','bcb5e68945ea092a98eb9bbbdf3ae094','zc','2010-01-19 11:39:54'),
	(200,'AdverTemplate','pause.vm','AdverTemplatepause.vm','暂停-普通',1000,'pause.vm','3a72e647c483d7696af96ecfbb63af9a','zc','2010-01-19 11:38:28'),
	(201,'AdverTemplate','curtain.vm','AdverTemplatecurtain.vm','挂角-普通',1000,'curtain.vm','1278053babdf3d9ae2f26b7c7c83fab3','zc','2010-01-19 11:37:53'),
	(202,'AdverTemplate','kankan.vm','AdverTemplatekankan.vm','跑马灯-看看',1000,'kankan.vm','1bf257c400a6a05212abcbccb58325e2','zc','2010-01-19 11:38:02'),
	(203,'AdverTemplate','kankanmovie.vm','AdverTemplatekankanmovie.vm','贴片-普通',1000,'kankanmovie.vm','ee2547ba7168cd0de0cba04af914624b','zc','2010-01-19 11:38:09'),
	(204,'AdverTemplate','livemovie.vm','AdverTemplatelivemovie.vm','贴片-直播',1000,'livemovie.vm','ed658ff47ddbcd362ce2131a00b5805c','zc','2010-01-19 11:38:15'),
	(205,'AdverTemplate','moviead.vm','AdverTemplatemoviead.vm','贴片-CPM',1000,'moviead.vm','83884102dd49bf534f0cb0440de92df5','zc','2010-01-19 11:38:22'),
	(206,'AdverTemplate','RedirectAd.vm','AdverTemplateRedirectAd.vm','网页跳转-直跳',1000,'RedirectAd.vm','212d74a1ac5f5d513c302b70dd165793','zc','2010-01-19 11:38:34'),
	(208,'AdverTemplate','RollingAd.vm','AdverTemplateRollingAd.vm','通栏-轮播',1000,'RollingAd.vm','fa82d731e63b8c52568fed9138eeaa19','zc','2010-01-19 11:38:39'),
	(214,'AdverTemplate','RollingRedirectAd.vm','AdverTemplateRollingRedirectAd.vm','网页跳转-轮播',1000,'RollingRedirectAd.vm','2a6fe58940103d7ff01a19c0c9f01535','zc','2010-01-19 11:41:24'),
	(215,'AdverTemplate','RollingTxtMarqueeAd.','AdverTemplateRollingTxtMarqueeAd.','文字链-轮播-跑马灯',1000,'RollingTxtMarqueeAd.vm','854f261c9cc0a81606342279952c872c','zc','2010-01-19 11:41:54'),
	(216,'AdverTemplate','RollingWebThunderAd.','AdverTemplateRollingWebThunderAd.','通栏-WEB迅雷',1000,'RollingWebThunderAd.vm','01472e86cb2ea5de0cfe40cf59bbdb76','zc','2010-01-19 11:42:12'),
	(217,'AdverTemplate','RollingLaMuAd.vm','AdverTemplateRollingLaMuAd.vm','通栏-轮播-拉幕',1000,'RollingLaMuAd.vm','d8e22d82fa56c9fbd778c9a25d3dbce9','zc','2010-01-19 11:43:00'),
	(218,'AdverTemplate','RollingTxtAd.vm','AdverTemplateRollingTxtAd.vm','文字链-轮播',1000,'RollingTxtAd.vm','ee55c01f86c7ea5174167be6670be20d','zc','2010-01-19 11:43:15'),
	(221,'PositionType','P','PositionTypeP','贴片通投',1000,'','','onizukaspm','2010-01-25 17:37:30'),
	(222,'PositionType','K','PositionTypeK','角标',1000,'','','onizukaspm','2010-01-25 17:40:13'),
	(223,'PositionType','L','PositionTypeL','迅雷5',1000,'','','onizukaspm','2010-01-25 17:40:27'),
	(224,'PositionType','M','PositionTypeM','迅雷看看',1000,'','','onizukaspm','2010-01-25 17:40:39'),
	(225,'PositionType','N','PositionTypeN','WEB迅雷',1000,'','','onizukaspm','2010-01-25 17:40:51'),
	(226,'PositionType','O','PositionTypeO','贴片定向',1000,'','','onizukaspm','2010-01-25 17:41:05'),
	(242,'AdverTemplate','cpm.vm','AdverTemplatecpm.vm','CPM[角标-暂停-贴片]',1000,'cpm.vm','1dae1a98237365f8dce3d17443bad863','onizukaspm','2010-01-28 10:51:14'),
	(247,'AdverTemplate','downloadlefttxt.vm','AdverTemplatedownloadlefttxt.vm','文字链-下载页左侧',1000,'downloadlefttxt.vm','5f374dff79825cba2b226b77f2d20a65','onizukaspm','2010-01-30 16:20:33'),
	(249,'AdverTemplate','listtxt.vm','AdverTemplatelisttxt.vm','文字链-列表',1000,'listtxt.vm','cd40b91342ca82048350c5e898e7ed6e','onizukaspm','2010-01-30 16:21:25'),
	(250,'AdverTemplate','RollingInmediaAd.vm','AdverTemplateRollingInmediaAd.vm','通栏-轮播-inmedia',1000,'RollingInmediaAd.vm','c78d92a0055a5d86e7522950e25a376f','onizukaspm','2010-01-30 16:21:52'),
	(251,'AdverTemplate','RollingInmediaDeskto','AdverTemplateRollingInmediaDeskto','通栏-轮播-桌面新闻inmedia',1000,'RollingInmediaDesktopAd.vm','66750247fcae92e23110e935f71d4ffc','onizukaspm','2010-01-30 16:22:16'),
	(252,'AdverTemplate','searchpagetxt_2col.v','AdverTemplatesearchpagetxt_2col.v','文字链-2列',1000,'searchpagetxt_2col.vm','4220acd4fe6966702af4ef40f5f7ad90','onizukaspm','2010-01-30 16:22:37'),
	(253,'AdverTemplate','searchpagetxt_3col.v','AdverTemplatesearchpagetxt_3col.v','文字链-3列',1000,'searchpagetxt_3col.vm','57abb9fbdbfaf509cb40000c453765e1','onizukaspm','2010-01-30 16:22:48'),
	(254,'AdverTemplate','searchpagetxt_4col.v','AdverTemplatesearchpagetxt_4col.v','文字链-4列',1000,'searchpagetxt_4col.vm','6e592f0344ec5520b634a4df14149147','onizukaspm','2010-01-30 16:23:06'),
	(256,'AdverTemplate','welcome_show.vm','AdverTemplatewelcome_show.vm','图文-迅雷5欢迎界面',1000,'welcome_show.vm','6286bfe168a18bbb09326835cd9da68e','onizukaspm','2010-01-30 16:24:04'),
	(258,'AdverTemplate','button.vm','AdverTemplatebutton.vm','按钮-列表',1000,'button.vm','34bf904594370ec5bf8e93927629b1c6','onizukaspm','2010-01-30 17:01:42'),
	(259,'AdverTemplate','thunder5.vm','AdverTemplatethunder5.vm','迅雷5配置-旧版',1000,'thunder5.vm','94f6345ac3fbf39b47c3e7e7cf85fc97','onizukaspm','2010-01-30 20:23:21'),
	(260,'AdverTemplate','thunder5_2.vm','AdverTemplatethunder5_2.vm','迅雷5配置-新版',1000,'thunder5_2.vm','577f89fef8c4d5e1e9ddaacad48df65d','onizukaspm','2010-01-30 20:23:38'),
	(261,'AdverTemplate','neomain.vm','AdverTemplateneomain.vm','光影魔术手配置',1000,'neomain.vm','730b396753fa2d67d15579833db545c3','onizukaspm','2010-01-30 20:24:07'),
	(262,'AdverTemplate','neomenu.vm','AdverTemplateneomenu.vm','光影魔术手-菜单',1000,'neomenu.vm','3f993f48f5b53b97452aa27b63a297b1','onizukaspm','2010-01-30 20:24:26'),
	(269,'AdverTemplate','searchbanner.vm','AdverTemplatesearchbanner.vm','狗狗配置-通栏',1000,'searchbanner.vm','629be8121acda808aff6984582e27551','onizukaspm','2010-03-12 16:58:20'),
	(270,'AdverTemplate','searchtop.vm','AdverTemplatesearchtop.vm','狗狗配置-文字链',1000,'searchtop.vm','9b65a65a11790fdfc81c09e9a281b04b','onizukaspm','2010-03-12 16:58:45'),
	(271,'AdverTemplate','searchspecialtop.vm','AdverTemplatesearchspecialtop.vm','狗狗配置-异型通栏',1000,'searchspecialtop.vm','261e6656f5ee09e3138622d0b91eefe9','onizukaspm','2010-03-12 16:59:50'),
	(272,'AdverTemplate','picforgou.vm','AdverTemplatepicforgou.vm','狗狗配置-图片',1000,'picforgou.vm','5ddcfa4478c0867a3e7fc2e0942b6f46','onizukaspm','2010-03-12 17:00:10'),
	(273,'AdverTemplate','wordforgou.vm','AdverTemplatewordforgou.vm','狗狗配置-文字链2',1000,'wordforgou.vm','75051c17c0500a5bdbe56349b00ac825','onizukaspm','2010-03-12 17:00:30'),
	(274,'AdverTemplate','thunder7.vm','AdverTemplatethunder7.vm','迅雷7配置',1000,'thunder7.vm','6dd8cb1092c6713aa8e7b98b702e78ac','onizukaspm','2010-03-20 10:44:49'),
	(323,'AdverTemplate','richmedia.vm','AdverTemplaterichmedia.vm','富媒体JSON',1000,'richmedia.vm','ffcd7e9c0c4ee0c6e30822bee984c9f3','onizukaspm','2010-04-21 11:12:14'),
	(331,'AdverTemplate','discount_focus.vm','AdverTemplatediscount_focus.vm','折扣商城-大焦点图',1000,'discount_focus.vm','828c4c8a91906151e7a0be05254ea723','onizukaspm','2010-05-06 15:01:03'),
	(332,'AdverTemplate','discount_focus2.vm','AdverTemplatediscount_focus2.vm','折扣商城-小焦点图',1000,'discount_focus2.vm','570e55bbeb5bf8b9666ddcea81e2a82d','onizukaspm','2010-05-06 15:01:19'),
	(333,'AdverTemplate','discount_imagelist_a','AdverTemplatediscount_imagelist_a','折扣商城-图列表A',1000,'discount_imagelist_a.vm','d8ad0b276106d8aa5c27ca6d45119bb5','onizukaspm','2010-05-06 15:01:52'),
	(334,'AdverTemplate','discount_imagelist_l','AdverTemplatediscount_imagelist_l','折扣商城-图列表LI',1000,'discount_imagelist_li.vm','407ede43a851cb67e4759a49a456319f','onizukaspm','2010-05-06 15:10:38'),
	(335,'AdverTemplate','discount_scroll.vm','AdverTemplatediscount_scroll.vm','折扣商城-滚动条',1000,'discount_scroll.vm','0c4d150e558e21bafea2f96447ae4c2d','onizukaspm','2010-05-06 15:11:05'),
	(336,'AdverTemplate','discount_textlist.vm','AdverTemplatediscount_textlist.vm','折扣商城-文字列表',1000,'discount_textlist.vm','5e20717e9193da6c5cdc26f0d6325d4b','onizukaspm','2010-05-06 15:12:04'),
	(337,'AdverTemplate','discount_toplist.vm','AdverTemplatediscount_toplist.vm','折扣商城-排行榜',1000,'discount_toplist.vm','1e86efcbf8f10e4157f446a903d1b13d','onizukaspm','2010-05-06 15:12:20'),
	(338,'OrderTradeType','1','OrderTradeType1','品牌',1000,'','','wujing','2010-05-07 14:46:35'),
	(339,'OrderTradeType','2','OrderTradeType2','网游',1000,'','','wujing','2010-05-07 14:46:44'),
	(340,'OrderTradeType','3','OrderTradeType3','网服',1000,'原本这个叫电商','','yaoboquan','2012-01-17 10:37:14'),
	(341,'OrderTradeType','4','OrderTradeType4','非电商',1000,'','','wujing','2010-05-07 14:47:00'),
	(349,'OrderTradeType','5','OrderTradeType5','剩余资源',1000,'','','wujing','2010-05-28 17:28:34'),
	(350,'OrderTradeType','6','OrderTradeType6','内部',1000,'原本这个叫其它','','yaoboquan','2012-01-17 10:36:49'),
	(351,'AdverTemplate','seedvideo.vm','AdverTemplateseedvideo.vm','种子视频',1000,'seedvideo.vm','7874497488a22d045c5ada6707750e2b','onizukaspm','2010-05-31 15:28:30'),
	(357,'OrderTradeType','7','OrderTradeType7','看看特别组',1000,'','','wujing','2010-06-01 17:48:39'),
	(358,'CPMType','30','CPMType30','30秒',1000,'','','onizukaspm','2011-01-22 15:53:03'),
	(359,'CPMType','15','CPMType15','15秒',1000,'','','onizukaspm','2011-01-22 15:53:13'),
	(366,'AreaNo','1156420100','AreaNo1156420100','武汉市',1,'','H_湖北_HUBEI_C','wujing','2010-06-09 15:29:49'),
	(367,'AreaNo','1156370100','AreaNo1156370100','济南市',1,'','S_山东_SHANDONG_C','wujing','2010-06-09 15:30:09'),
	(368,'AreaNo','1156510100','AreaNo1156510100','成都市',1,'','S_四川_SICHUAN_C','wujing','2010-06-09 15:30:25'),
	(369,'AreaNo','1156441900','AreaNo1156441900','东莞市',1,'','G_广东_GUANGDONG_C','wujing','2010-06-09 15:30:39'),
	(370,'AreaNo','1156440600','AreaNo1156440600','佛山市',1,'','G_广东_GUANGDONG_C','wujing','2010-06-09 15:30:51'),
	(372,'AreaNo','1156440400','AreaNo1156440400','珠海市',1,'','G_广东_GUANGDONG_C','onizukaspm','2010-06-11 14:58:27'),
	(379,'CPMType','5','CPMType5','05秒',1000,'','','onizukaspm','2011-01-22 15:53:08'),
	(498,'AdverTemplate','taiwan_thunder5_2.vm','AdverTemplatetaiwan_thunder5_2.vm','台湾-迅雷5配置-新版',1000,'taiwan_thunder5_2.vm','3f8081bad3bb391cab898433d39659a5','onizukaspm','2010-07-19 15:48:42'),
	(499,'AdverTemplate','taiwan_RollingAd.vm','AdverTemplatetaiwan_RollingAd.vm','台湾-通栏-轮播',1000,'taiwan_RollingAd.vm','c33e19bf6ba58aa8c9ff833b303c2f9a','onizukaspm','2010-07-19 15:49:20'),
	(567,'AdverTemplate','focustab.vm','AdverTemplatefocustab.vm','购物标签-焦点图',1000,'focustab.vm','dd3a63387804ecb45e0ddc3b1775a520','onizukaspm','2010-07-27 18:15:50'),
	(636,'AdverTemplate','taiwan_RollingLaMuAd','AdverTemplatetaiwan_RollingLaMuAd','台湾-通栏-轮播-拉幕',1000,'taiwan_RollingLaMuAd.vm','c12c61d6f7b9465fd9f8f85b6a74ef8b','onizukaspm','2010-08-04 15:41:49'),
	(666,'AdverTemplate','tips.vm','AdverTemplatetips.vm','网页TIPS',1000,'tips.vm','cd9714ac6c1b2eff381d0b36fa4515ed','onizukaspm','2010-08-06 17:20:03'),
	(941,'AdverTemplate','kankan_pause.vm','AdverTemplatekankan_pause.vm','看看800,588',1000,'kankan_pause.vm','3990d54c758d962019eb860a70997c42','zhangweikai','2010-08-17 11:06:25'),
	(967,'AdverTemplate','RollingRedirectAdJs','AdverTemplateRollingRedirectAdJs','网页-轮播-JS',1000,'RollingRedirectAdJs.vm','a8a015a83ddb0dc3b54cb368194069e3','onizukaspm','2010-09-18 14:38:22'),
	(971,'MaterialType','12','MaterialType12','ico',999,'','','onizukaspm','2010-10-16 14:24:07'),
	(972,'PositionType','Q','PositionTypeQ','图标',1000,'','','onizukaspm','2010-10-16 14:29:30'),
	(973,'AdverTemplate','DeskIconADs.vm','AdverTemplateDeskIconADs.vm','XMP桌面图标',1000,'DeskIconADs.vm','0ca54a716258a9c5800d538e3d814b1d','onizukaspm','2010-10-16 15:11:21'),
	(981,'AreaNo','1156210100','AreaNo1156210100','沈阳',1,'','L_辽宁_LIAONING_C','onizukaspm','2010-10-22 15:52:16'),
	(1030,'AdverTemplate','RollingAdNoMarsking.','AdverTemplateRollingAdNoMarsking.','通栏-轮播-无遮罩',1000,'RollingAdNoMarsking.vm','062a08b44fb1752e5ca192e24ba17120','onizukaspm','2010-10-29 15:39:49'),
	(1032,'StatItem','chooser','StatItemchooser','选择器',1000,'920,933','','wangyan','2010-11-03 15:11:40'),
	(1033,'StatItem','brand','StatItembrand','样板广告',1,'920,933','','wangyan','2010-11-03 15:11:56'),
	(1034,'StatItem','1','StatItem1','富媒体',1,'922','','wangyan','2010-11-12 17:44:51'),
	(1035,'StatItem','0','StatItem0','小广告',1,'922','','wangyan','2010-11-03 16:23:10'),
	(1036,'AreaNo','1156370200','AreaNo1156370200','青岛市',1,'','S_山东_SHANDONG_C','onizukaspm','2010-11-05 11:01:57'),
	(1037,'AreaNo','1156430100','AreaNo1156430100','长沙市',1,'','H_湖南_HUNAN_C','onizukaspm','2010-11-05 11:02:15'),
	(1038,'AreaNo','1156220100','AreaNo1156220100','长春市',1,'','J_吉林_JILIN_C','onizukaspm','2010-11-05 11:02:32'),
	(1039,'AreaNo','1156350200','AreaNo1156350200','厦门市',1,'','F_福建_FUJIAN_C','onizukaspm','2010-11-05 11:02:47'),
	(1040,'AreaNo','1156530100','AreaNo1156530100','昆明市',1,'','Y_云南_YUNNAN_C','onizukaspm','2010-11-05 11:03:00'),
	(1041,'AreaNo','1156330100','AreaNo1156330100','杭州市',1,'','Z_浙江_ZHEJIANG_C','onizukaspm','2010-11-05 11:03:12'),
	(1042,'AreaNo','1156320500','AreaNo1156320500','苏州市',1,'','J_江苏_JIANGSU_C','onizukaspm','2010-11-05 11:03:24'),
	(1043,'AreaNo','1156210200','AreaNo1156210200','大连市',1,'','L_辽宁_LIAONING_C','onizukaspm','2010-11-05 11:03:51'),
	(1051,'AdverTemplate','gamehall.vm','AdverTemplategamehall.vm','游戏大厅',1000,'gamehall.vm','f5d8e29c9509137527b46fc962432824','onizukaspm','2010-11-10 14:24:11'),
	(1053,'OrderTradeType','8','OrderTradeType8','非品牌渠道',1000,'','','wangyan','2010-11-11 17:46:07'),
	(1063,'AdverTemplate','minigame.vm','AdverTemplateminigame.vm','小游戏模板',1000,'minigame.vm','d2deb4105146a1d65b74de1a77886efb','zhangweikai','2010-11-18 11:01:14'),
	(1068,'AreaNo','1156410100','AreaNo1156410100','郑州市',1,'','H_河南_HENAN_C','onizukaspm','2010-12-01 12:24:40'),
	(1083,'AreaNo','1156610100','AreaNo1156610100','西安市',1,'','S_陕西_SHANXI3_C','wangyan','2010-12-29 16:55:40'),
	(1091,'AreaNo','1156371300','AreaNo1156371300','临沂市',1,'','S_山东_SHANDONG_C','onizukaspm','2010-12-31 11:47:56'),
	(1097,'AreaNo','1156320100','AreaNo1156320100','南京市',1,'','J_江苏_JIANGSU_C','onizukaspm','2011-01-07 14:45:46'),
	(1098,'AreaNo','1156650100','AreaNo1156650100','乌鲁木齐市',1,'','X_新疆_XINJIANG_C','onizukaspm','2011-01-07 14:46:00'),
	(1101,'AreaNo','1156330400','AreaNo1156330400','嘉兴市',1,'','Z_浙江_ZHEJIANG_C','onizukaspm','2011-01-17 10:14:09'),
	(1102,'AreaNo','1156320600','AreaNo1156320600','南通市',1,'','J_江苏_JIANGSU_C','onizukaspm','2011-01-17 10:14:14'),
	(1103,'AreaNo','1156130100','AreaNo1156130100','石家庄市',1,'','H_河北_HEBEI_C','onizukaspm','2011-01-17 10:14:17'),
	(1104,'AreaNo','1156360100','AreaNo1156360100','南昌市',1,'','J_江西_JIANGXI_C','onizukaspm','2011-01-17 10:14:20'),
	(1105,'AreaNo','1156330200','AreaNo1156330200','宁波市',1,'','Z_浙江_ZHEJIANG_C','onizukaspm','2011-01-17 11:00:53'),
	(1106,'CPMPlayType','1','CPMPlayType1','普通贴片',1000,'1','','onizukaspm','2011-01-22 15:28:50'),
	(1107,'CPMPlayType','2','CPMPlayType2','普通全景(矮版)',1000,'2','','onizukaspm','2011-01-22 15:28:58'),
	(1108,'CPMPlayType','3','CPMPlayType3','普通全景(高版)',1000,'3','','onizukaspm','2011-01-22 15:29:06'),
	(1109,'CPMPlayType','4','CPMPlayType4','疯狂全景(矮版)',1000,'4','','onizukaspm','2011-01-22 15:29:14'),
	(1110,'CPMPlayType','5','CPMPlayType5','疯狂全景(高版)',1000,'5','','onizukaspm','2011-01-22 15:29:25'),
	(1111,'CPMPlayType','6','CPMPlayType6','超高清贴片',1000,'6','','onizukaspm','2011-01-22 15:29:33'),
	(1202,'AreaNo','1156130600','AreaNo1156130600','保定市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:55:34'),
	(1203,'AreaNo','1156130400','AreaNo1156130400','邯郸市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:55:50'),
	(1204,'AreaNo','1156131000','AreaNo1156131000','廊坊市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:56:03'),
	(1205,'AreaNo','1156130200','AreaNo1156130200','唐山市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:56:16'),
	(1206,'AreaNo','1156130700','AreaNo1156130700','张家口市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:56:31'),
	(1207,'AreaNo','1156130300','AreaNo1156130300','秦皇岛市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:56:44'),
	(1208,'AreaNo','1156130500','AreaNo1156130500','邢台市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:56:56'),
	(1209,'AreaNo','1156131100','AreaNo1156131100','衡水市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:57:20'),
	(1210,'AreaNo','1156130900','AreaNo1156130900','沧州市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:57:31'),
	(1211,'AreaNo','1156130800','AreaNo1156130800','承德市',1,'','H_河北_HEBEI_C','onizukaspm','2011-02-17 09:57:44'),
	(1213,'AreaNo','1156350100','AreaNo1156350100','福州市',1,'','F_福建_FUJIAN_C','onizukaspm','2011-03-18 09:52:50'),
	(1221,'AdverTemplate','plugintips.vm','AdverTemplateplugintips.vm','富媒体及第三方插件',1000,'plugintips.vm','dce1035348a9ed6a5b67b5ee18402ba0','onizukaspm','2011-03-05 11:26:32'),
	(1222,'AdverTemplate','xl7bottomlist.vm','AdverTemplatexl7bottomlist.vm','迅雷7底部文字链',1000,'xl7bottomlist.vm','e1b52ba2ffd5ff22409d10ee5bf1978f','lixin','2011-03-07 21:53:00'),
	(1223,'AdverTemplate','XMPSetupOK.vm','AdverTemplateXMPSetupOK.vm','XMP安装完成弹出',1000,'XMPSetupOK.vm','0335500a2fc18b788a4deb9166b2bf9c','lixin','2011-03-08 15:27:18'),
	(1257,'AdverTemplate','gougoutemp.vm','AdverTemplategougoutemp.vm','狗狗搜索临时使用',1000,'gougoutemp.vm','9f276cbcd2961ecc2e0b26355f6b8353','lixin','2011-03-13 14:55:04'),
	(1264,'AdverTemplate','RollingAd3.vm','AdverTemplateRollingAd3.vm','通栏-轮播-切换加载',1000,'RollingAd3.vm','757115c4d52e0b35fcaf5caacf03e420','onizukaspm','2011-03-28 18:12:01'),
	(1274,'AreaNo','1156330300','AreaNo1156330300','温州市',1,'','Z_浙江_ZHEJIANG_C','onizukaspm','2011-04-02 11:54:13'),
	(1276,'AreaNo','1156320300','AreaNo1156320300','徐州市',1,'','J_江苏_JIANGSU_C','lixin','2011-04-07 11:17:12'),
	(1277,'AreaNo','1156320200','AreaNo1156320200','无锡市',1,'','J_江苏_JIANGSU_C','lixin','2011-04-07 11:17:40'),
	(1278,'AreaNo','1156320400','AreaNo1156320400','常州市',1,'','J_江苏_JIANGSU_C','lixin','2011-04-07 11:17:57'),
	(1279,'AreaNo','1156330600','AreaNo1156330600','绍兴',1,'','Z_浙江_ZHEJIANG_C','lixin','2011-04-07 11:18:15'),
	(1281,'AreaNo','1156210800','AreaNo1156210800','营口',1,'','L_辽宁_LIAONING_C','lixin','2011-04-07 11:19:27'),
	(1282,'AreaNo','1156230600','AreaNo1156230600','大庆',1,'','H_黑龙江_HEILONGJIANG_C','lixin','2011-04-07 11:19:41'),
	(1283,'AreaNo','1156150500','AreaNo1156150500','通辽',1,'','N_内蒙古_NEIMENGGU_C','lixin','2011-04-07 11:19:57'),
	(1284,'AreaNo','1156150100','AreaNo1156150100','呼市',1,'','N_内蒙古_NEIMENGGU_C','lixin','2011-04-07 11:20:28'),
	(1285,'AreaNo','1156140100','AreaNo1156140100','太原',1,'','S_山西_SHANXI_C','lixin','2011-04-07 11:20:43'),
	(1286,'AreaNo','1156150600','AreaNo1156150600','鄂尔多斯',1,'','N_内蒙古_NEIMENGGU_C','lixin','2011-04-07 11:20:58'),
	(1287,'AreaNo','1156141000','AreaNo1156141000','临汾',1,'','S_山西_SHANXI_C','lixin','2011-04-07 11:21:17'),
	(1288,'AreaNo','1156140200','AreaNo1156140200','大同',1,'','S_山西_SHANXI_C','lixin','2011-04-07 11:21:35'),
	(1289,'AreaNo','1156630100','AreaNo1156630100','西宁',1,'','Q_青海_QINHAI_C','lixin','2011-04-07 11:21:51'),
	(1290,'AreaNo','1156620100','AreaNo1156620100','兰州',1,'','G_甘肃_GANSU_C','lixin','2011-04-07 11:22:06'),
	(1291,'AreaNo','1156640100','AreaNo1156640100','银川',1,'','N_宁夏_NINGXIA_C','lixin','2011-04-07 11:22:20'),
	(1292,'AreaNo','1156510700','AreaNo1156510700','绵阳',1,'','S_四川_SICHUAN_C','lixin','2011-04-07 11:23:13'),
	(1293,'AreaNo','1156530300','AreaNo1156530300','曲靖',1,'','Y_云南_YUNNAN_C','lixin','2011-04-07 11:23:27'),
	(1294,'AreaNo','1156511300','AreaNo1156511300','南充',1,'','S_四川_SICHUAN_C','lixin','2011-04-07 11:23:42'),
	(1295,'AreaNo','1156530400','AreaNo1156530400','玉溪',1,'','Y_云南_YUNNAN_C','lixin','2011-04-07 11:24:00'),
	(1296,'AreaNo','1156511100','AreaNo1156511100','乐山',1,'','S_四川_SICHUAN_C','lixin','2011-04-07 11:24:16'),
	(1297,'AreaNo','1156450100','AreaNo1156450100','南宁',1,'','G_广西_GUANGXI_C','lixin','2011-04-07 11:24:35'),
	(1298,'AreaNo','1156450200','AreaNo1156450200','柳州',1,'','G_广西_GUANGXI_C','lixin','2011-04-07 11:24:51'),
	(1299,'AreaNo','1156340100','AreaNo1156340100','合肥',1,'','A_安徽_ANHUI_C','lixin','2011-04-07 11:25:07'),
	(1300,'AreaNo','1156341200','AreaNo1156341200','阜阳',1,'','A_安徽_ANHUI_C','lixin','2011-04-07 11:25:21'),
	(1301,'AreaNo','1156341500','AreaNo1156341500','六安',1,'','A_安徽_ANHUI_C','lixin','2011-04-07 11:25:34'),
	(1302,'AreaNo','1156340600','AreaNo1156340600','淮北',1,'','A_安徽_ANHUI_C','lixin','2011-04-07 11:25:47'),
	(1303,'AreaNo','1156340300','AreaNo1156340300','蚌埠',1,'','A_安徽_ANHUI_C','lixin','2011-04-07 11:25:59'),
	(1304,'AreaNo','1156350500','AreaNo1156350500','泉州',1,'','F_福建_FUJIAN_C','lixin','2011-04-07 11:26:10'),
	(1305,'AreaNo','1156350800','AreaNo1156350800','龙岩',1,'','F_福建_FUJIAN_C','lixin','2011-04-07 11:26:23'),
	(1306,'AreaNo','1156370700','AreaNo1156370700','潍坊',1,'','S_山东_SHANDONG_C','lixin','2011-04-07 11:26:38'),
	(1307,'AreaNo','1156410200','AreaNo1156410200','开封',1,'','H_河南_HENAN_C','lixin','2011-04-07 11:26:55'),
	(1308,'AreaNo','1156410800','AreaNo1156410800','焦作',1,'','H_河南_HENAN_C','lixin','2011-04-07 11:27:09'),
	(1309,'AreaNo','1156460100','AreaNo1156460100','海口',1,'','H_海南_HAINAN_C','lixin','2011-04-07 11:27:22'),
	(1311,'AreaNo','1458000000','AreaNo1458000000','马来西亚',1,'','M_马来西亚_MALAIXIYA_P','lixin','2011-04-07 14:37:15'),
	(1312,'AreaNo','1156520100','AreaNo1156520100','贵阳',1,'','G_贵州_GUIZHOU_C','lixin','2011-04-08 16:21:25'),
	(1313,'AreaNo','1156360700','AreaNo1156360700','赣州',1,'','J_江西_JIANGXI_C','lixin','2011-04-08 16:21:46'),
	(1314,'AreaNo','1156421000','AreaNo1156421000','荆州',1,'','H_湖北_HUBEI_C','lixin','2011-04-08 16:22:00'),
	(1315,'AreaNo','1156430400','AreaNo1156430400','衡阳',1,'','H_湖南_HUNAN_C','123','2013-09-24 16:00:25'),
	(1316,'AreaNo','1156370300','AreaNo1156370300','淄博',1,'','S_山东_SHANDONG_C','lixin','2011-04-08 16:22:25'),
	(1317,'AreaNo','1156411400','AreaNo1156411400','商丘',1,'','H_河南_HENAN_C','lixin','2011-04-08 16:22:39'),
	(1325,'AdverTemplate','RollingLaMuAdPre.vm','AdverTemplateRollingLaMuAdPre.vm','看看-拉幕-预加载',1000,'RollingLaMuAdPre.vm','56ebd45016f9342880f972d894b78644','zoujun','2011-04-22 17:24:41'),
	(1327,'AdverTemplate','KanKanIndexHtml.vm','AdverTemplateKanKanIndexHtml.vm','看看-首页-通栏-HTML模板',1000,'KanKanIndexHtml.vm','bcc11f4555c18b315a1ecc438c1bc0c8','yaoboquan','2011-04-27 16:55:06'),
	(1332,'AreaNo','1156230100','AreaNo1156230100','哈尔滨',1,'','H_黑龙江_HEILONGJIANG_C','123','2013-09-24 15:59:41'),
	(1339,'AdverTemplate','screen.vm','AdverTemplatescreen.vm','宽屏富媒体',1000,'screen.vm','e5b6deccc447e56fb946a16e6e1fc5c9','onizukaspm','2011-05-24 14:58:10'),
	(1344,'AdverTemplate','gamebox.vm','AdverTemplategamebox.vm','首页边看边玩',1000,'gamebox.vm','0b689abceaf06f04cc99b8bc8a27624e','onizukaspm','2011-05-26 11:07:40'),
	(1346,'AdverTemplate','thunder7_dlbanner.vm','AdverTemplatethunder7_dlbanner.vm','迅雷7下载频道banner',1000,'thunder7_dlbanner.vm','b899ff8a3fd32ee6ebe044612567ef8f','onizukaspm','2011-05-27 12:47:00'),
	(1348,'CPMPlayType','0','CPMPlayType0','无',1000,'0','','yaoboquan','2011-05-31 10:39:20'),
	(1361,'AdverTemplate','title_content.vm','AdverTemplatetitle_content.vm','标题-内容-文字链',1000,'title_content.vm','9829d632a166afa6e7f30ce8088ec9dd','yaoboquan','2011-06-14 10:11:55'),
	(1624,'SaleType','I','SaleTypeI','补量',1000,'1','','liheng','2012-08-07 13:53:05'),
	(1625,'SaleType','J','SaleTypeJ','补偿',1000,'1','','liheng','2012-08-07 13:53:09'),
	(1629,'AdverTemplate','RollingAd_miaozhe.vm','AdverTemplateRollingAd_miaozhe.vm','通栏-轮播-秒针',1000,'RollingAd_miaozhen.vm','d834d96dde07f19ad2debd3f1600e819','lixin','2011-07-18 17:40:48'),
	(1659,'AreaNo','1156442000','AreaNo1156442000','中山',1,'','G_广东_GUANGDONG_C','lixin','2011-08-15 10:22:54'),
	(1676,'AutoIncrement','materialid','AutoIncrementmaterialid','素材id',1000,'13101150','','yaoboquan','2011-08-25 02:20:14'),
	(1710,'AreaNo','1156210700','AreaNo1156210700','锦州',1,'','L_辽宁_LIAONING_C','yaoboquan','2011-08-30 10:38:40'),
	(1766,'PositionType','R','PositionTypeR','富媒体弹出',1000,'','','yaoboquan','2011-10-11 16:35:24'),
	(1771,'PositionType','S','PositionTypeS','虚拟CPM广告位',1000,'','','yaoboquan','2011-10-13 11:00:59'),
	(1790,'AutoIncrement','tagid','AutoIncrementtagid','自定义标签',1000,'52','','yaoboquan','2011-11-04 16:38:19'),
	(1821,'PositionLimitCpm','656','PositionLimitCpm656','看看_片商提供片源_片头通投',1000,'100000','1000=1CPM','zhaoliang','2011-12-06 11:00:26'),
	(1822,'PositionLimitCpm','0','PositionLimitCpm0','默认CPM量',1000,'2000000','1000=1CPM','yaoboquan','2012-06-20 10:07:10'),
	(1826,'PositionLimitCpm','1028','PositionLimitCpm1028','看看_普通全景广告_高版',1001,'100000','','zhaoliang','2011-12-06 11:07:04'),
	(1827,'PositionLimitCpm','1253','PositionLimitCpm1253','XMP_片商提供片源_暂停广告_CPM',1000,'1000000','','zhaoliang','2011-12-06 11:05:37'),
	(1828,'PositionLimitCpm','1252','PositionLimitCpm1252','XMP_片商提供片源_暂停贴片_CPM',1000,'1000000','','zhaoliang','2011-12-06 11:06:02'),
	(1829,'PositionLimitCpm','966','PositionLimitCpm966','XMP_片商提供片源_片头通投',1000,'100000','','zhaoliang','2011-12-06 11:06:37'),
	(1830,'PositionLimitCpm','697','PositionLimitCpm697','看看_角标广告',1000,'100000','','zhaoliang','2011-12-06 11:08:07'),
	(1831,'PositionLimitCpm','1240','PositionLimitCpm1240','看看_首页_弹出富媒体_CPM',1000,'1','','zhaoliang','2011-12-06 11:10:55'),
	(1832,'PositionLimitCpm','1181','PositionLimitCpm1181','看看_片商提供片源_暂停贴片_CPM',1000,'200000','','zhaoliang','2011-12-06 11:09:49'),
	(1833,'PositionLimitCpm','1088','PositionLimitCpm1088','看看_片商提供片源_暂停广告_CPM',1000,'500000','','zhaoliang','2011-12-06 11:10:45'),
	(1834,'PositionLimitCpm','1130','PositionLimitCpm1130','拉幕广告_CPM',1000,'1','','zhaoliang','2011-12-06 11:12:39'),
	(1838,'PositionLimitCpm','922','PositionLimitCpm922','迅雷7富媒体',1000,'100000','','zhaoliang','2011-12-07 23:49:14'),
	(1844,'PositionType','T','PositionTypeT','CPM文字链',1000,'','','yaoboquan','2011-12-12 17:33:51'),
	(1846,'AdverTemplate','desktopnews.html','AdverTemplatedesktopnews.html','迅雷7桌面新闻',1000,'desktopnews.html','8927311eb62f225d142a44bf02c79508','yaoboquan','2011-12-22 16:00:28'),
	(1867,'AreaNo','35300','AreaNo35300','重点城市',1,'','Z_重点城市_ZHONGDIAN_P','yaoboquan','2011-12-30 10:47:54'),
	(1870,'AdverTemplate','DuiLianAd.vm','AdverTemplateDuiLianAd.vm','对联广告模板',1000,'DuiLianAd.vm','29c098c1ef7677219b9dc7729d7ee871','yaoboquan','2011-12-30 15:01:39'),
	(1887,'AdverTemplate','cpmclient.vm','AdverTemplatecpmclient.vm','迅雷7CPM',1000,'cpmclient.vm','6265a03475e8a7df4815932e99231a15','yaoboquan','2012-02-23 15:12:40'),
	(1905,'AdverTemplate','onlinegame.vm','AdverTemplateonlinegame.vm','网游加速器',1000,'onlinegame.vm','4221d4177db32a1908d9ab04529b9af2','liheng','2012-04-05 09:50:17'),
	(1917,'StatItem','2','StatItem2','320*590富媒体广告',1000,'922','','liheng','2012-03-01 15:13:07'),
	(1918,'StatItem','3','StatItem3','420*590富媒体广告',1000,'922','','liheng','2012-03-01 15:14:45'),
	(1919,'StatItem','4','StatItem4','点击富媒体弹出浮层图',1000,'922','','liheng','2012-03-01 15:25:37'),
	(1920,'StatItem','6','StatItem6','点击浮层图链接',1000,'922','非游戏类型素材点击浮层图跳转','liheng','2012-03-01 15:26:16'),
	(1939,'AdverTemplate','tiptask.vm','AdverTemplatetiptask.vm','客户端Tips',1000,'tiptask.vm','933d41c4998a4979d82df71912701ae0','yaoboquan','2012-03-05 17:18:02'),
	(1952,'AreaNo','360','AreaNo360','迅雷',1000,'','X_迅雷_XUNLEI_C','yaoboquan','2012-03-06 14:33:17'),
	(1954,'PositionType','U','PositionTypeU','Tips',1000,'','','yaoboquan','2012-03-09 11:13:31'),
	(1957,'AdverTemplate','RollingRedirectAdJs3','AdverTemplateRollingRedirectAdJs3','网页-轮播-JS-列表页',1000,'RollingRedirectAdJs3.vm','b11c6d9df32d8cc4f6781ba2d520dbb5','zoujun','2012-03-14 15:26:47'),
	(1970,'AdverTemplate','xmp_pause_icons.vm','AdverTemplatexmp_pause_icons.vm','XMP暂停下方图标',1000,'xmp_pause_icons.vm','1fa67f1ebcc719c8febee4f791b55a1d','zoujun','2012-03-23 09:50:12'),
	(1975,'IPTable','xunlei','IPTablexunlei','迅雷',1000,'DIC_GEO_ALL','','jinyangyang','2012-05-22 18:08:36'),
	(1976,'IPTable','miaozhen','IPTablemiaozhen','秒针',1000,'DIC_GEO_MIAOZHEN','','yaoboquan','2012-05-03 11:01:00'),
	(1977,'AreaNo','1156441300','AreaNo1156441300','惠州市',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-03-26 16:22:47'),
	(1978,'AreaNo','1156440700','AreaNo1156440700','江门市',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-03-26 16:23:23'),
	(1979,'AreaNo','1156420500','AreaNo1156420500','宜昌市',1,'','H_湖北_HUBEI_C','yaoboquan','2012-03-26 16:25:05'),
	(1980,'AreaNo','1156430600','AreaNo1156430600','岳阳市',1,'','H_湖南_HUNAN_C','yaoboquan','2012-03-26 16:25:36'),
	(1981,'AreaNo','1156321000','AreaNo1156321000','扬州市',1,'','J_江苏_JIANGSU_C','yaoboquan','2012-03-26 16:27:01'),
	(2003,'AdverTemplate','gamelist_pre_tips.vm','AdverTemplategamelist_pre_tips.vm','迅雷7网游下载器预约Tips',1000,'gamelist_pre_tips.vm','734649bcfc3bba491d8485dcadc72df4','liheng','2012-03-29 20:50:21'),
	(2004,'AdverTemplate','gamelist_sc_tips.vm','AdverTemplategamelist_sc_tips.vm','迅雷7网游下载器售后Tips',1000,'gamelist_sc_tips.vm','4b98a7a8b5c0195c550cd8ae4668173f','liheng','2012-03-29 20:50:51'),
	(2005,'PositionLimitCpm','1313','PositionLimitCpm1313','迅雷7_动态Tip',1000,'100000','','yaoboquan','2012-03-29 21:09:32'),
	(2022,'AreaNo','1156420600','AreaNo1156420600','襄樊市',1,'','H_湖北_HUBEI_C','yaoboquan','2012-04-13 10:44:25'),
	(2023,'AreaNo','1156320700','AreaNo1156320700','连云港市',1,'','J_江苏_JIANGSU_C','yaoboquan','2012-04-13 10:45:39'),
	(2024,'AreaNo','1156430700','AreaNo1156430700','常德',1,'','H_湖南_HUNAN_C','yaoboquan','2012-04-13 14:00:00'),
	(2025,'AreaNo','1156431000','AreaNo1156431000','郴州',1,'','H_湖南_HUNAN_C','yaoboquan','2012-04-13 14:00:00'),
	(2026,'AreaNo','1156510500','AreaNo1156510500','泸州',1,'','S_四川_SICHUAN_C','yaoboquan','2012-04-13 14:00:00'),
	(2027,'AreaNo','1156511500','AreaNo1156511500','宜宾',1,'','S_四川_SICHUAN_C','yaoboquan','2012-04-13 14:00:00'),
	(2028,'AreaNo','1156420200','AreaNo1156420200','黄石',1,'','H_湖北_HUBEI_C','yaoboquan','2012-04-13 14:00:00'),
	(2029,'AreaNo','1156410500','AreaNo1156410500','安阳',1,'','H_河南_HENAN_C','yaoboquan','2012-04-13 14:00:00'),
	(2030,'AreaNo','1156410300','AreaNo1156410300','洛阳',1,'','H_河南_HENAN_C','yaoboquan','2012-04-13 14:00:00'),
	(2031,'AreaNo','1156410700','AreaNo1156410700','新乡',1,'','H_河南_HENAN_C','yaoboquan','2012-04-13 14:00:00'),
	(2032,'AreaNo','1156460200','AreaNo1156460200','三亚',1,'','H_海南_HAINAN_C','yaoboquan','2012-04-13 14:00:00'),
	(2033,'AreaNo','1156140300','AreaNo1156140300','阳泉',1,'','S_山西_SHANXI_C','yaoboquan','2012-04-13 14:00:00'),
	(2034,'AreaNo','1156140400','AreaNo1156140400','长治',1,'','S_山西_SHANXI_C','yaoboquan','2012-04-13 14:00:00'),
	(2035,'AreaNo','1156371000','AreaNo1156371000','威海',1,'','S_山东_SHANDONG_C','123','2013-08-09 17:11:45'),
	(2036,'AreaNo','1156370600','AreaNo1156370600','烟台',1,'','S_山东_SHANDONG_C','yaoboquan','2012-07-31 15:00:10'),
	(2037,'AreaNo','1156150200','AreaNo1156150200','包头',1,'','N_内蒙古_NEIMENGGU_C','yaoboquan','2012-04-13 14:00:00'),
	(2038,'AreaNo','1156320900','AreaNo1156320900','盐城',1,'','J_江苏_JIANGSU_C','yaoboquan','2012-04-13 14:00:00'),
	(2039,'AreaNo','1156340200','AreaNo1156340200','芜湖',1,'','A_安徽_ANHUI_C','yaoboquan','2012-04-13 14:00:00'),
	(2040,'AreaNo','1156231100','AreaNo1156231100','黑河',1,'','H_黑龙江_HEILONGJIANG_C','yaoboquan','2012-04-13 14:00:00'),
	(2041,'AreaNo','1156230800','AreaNo1156230800','佳木斯',1,'','H_黑龙江_HEILONGJIANG_C','yaoboquan','2012-04-13 14:00:00'),
	(2042,'AreaNo','1156230200','AreaNo1156230200','齐齐哈尔',1,'','H_黑龙江_HEILONGJIANG_C','yaoboquan','2012-04-13 14:00:00'),
	(2043,'AreaNo','1156445100','AreaNo1156445100','潮州',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-04-13 14:00:00'),
	(2044,'AreaNo','1156445200','AreaNo1156445200','揭阳',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-04-13 14:00:00'),
	(2045,'AreaNo','1156520300','AreaNo1156520300','遵义',1,'','G_贵州_GUIZHOU_C','yaoboquan','2012-04-13 14:00:00'),
	(2052,'AreaNo','1156330700','AreaNo1156330700','金华',1,'','Z_浙江_ZHEJIANG_C','yaoboquan','2012-04-18 15:30:59'),
	(2067,'AreaNo','1156440800','AreaNo1156440800','湛江',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-04-23 13:50:27'),
	(2068,'AreaNo','1156321100','AreaNo1156321100','镇江',1,'','J_江苏_JIANGSU_C','yaoboquan','2012-04-24 16:04:36'),
	(2073,'PositionType','V','PositionTypeV','精准',1000,'','','liheng','2012-04-27 11:17:08'),
	(2076,'AreaNo','1156441200','AreaNo1156441200','肇庆',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-05-02 15:33:59'),
	(2077,'AreaNo','1156340800','AreaNo1156340800','安庆',1,'','A_安徽_ANHUI_C','yaoboquan','2012-05-02 18:55:25'),
	(2080,'IPTable','admaster','IPTableadmaster','Admaster',1000,'DIC_GEO','','yaoboquan','2012-05-03 11:04:25'),
	(2098,'AdverTemplate','searchpagetxt_5col.v','AdverTemplatesearchpagetxt_5col.v','文字链-5列',1000,'searchpagetxt_5col.vm','80a2d3db28568736812013947d23ff12','yaoboquan','2012-05-09 14:51:08'),
	(2099,'AdverTemplate','listtxt1.vm','AdverTemplatelisttxt1.vm','文字链-列表1',1000,'listtxt1.vm','438a54256a0f4ad0d4363bae3b86647e','yaoboquan','2012-05-09 14:53:31'),
	(2113,'AdverTemplate','RollingLaMuHtml.vm','AdverTemplateRollingLaMuHtml.vm','通栏_轮播_拉幕(html)',1000,'RollingLaMuHtml.vm','25cfd7bac59a6902e19df153a7c30cb7','jinyangyang','2012-05-16 15:30:53'),
	(2114,'AdverTemplate','RollingLaMuAdPreH.vm','AdverTemplateRollingLaMuAdPreH.vm','看看-拉幕-预加载(html)',1000,'RollingLaMuAdPreH.vm','43240dbca0e69eb51db8d0b070989124','jinyangyang','2012-05-16 15:31:28'),
	(2117,'AreaNo','1156540100','AreaNo1156540100','拉萨',1,'','X_西藏_XIZANG_C','yaoboquan','2012-05-22 10:07:02'),
	(2135,'AreaNo','1156340700','AreaNo1156340700','铜陵',1,'','A_安徽_ANHUI_C','yaoboquan','2012-06-06 14:01:02'),
	(2136,'AreaNo','1156341800','AreaNo1156341800','宣城',1,'','A_安徽_ANHUI_C','yaoboquan','2012-06-06 14:01:47'),
	(2137,'AreaNo','26565','AreaNo26565','巢湖',1,'','A_安徽_ANHUI_C','yaoboquan','2012-06-06 14:03:49'),
	(2149,'PositionLimitCpm','1241','PositionLimitCpm1241','看看播放页虚拟广告位',1000,'100000','','yaoboquan','2012-06-19 13:49:54'),
	(2160,'AreaNo','1156320800','AreaNo1156320800','淮安',1,'','J_江苏_JIANGSU_C','yaoboquan','2012-06-25 16:54:19'),
	(2161,'AreaNo','1156440200','AreaNo1156440200','韶关',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-06-25 18:41:15'),
	(2162,'AreaNo','1156441800','AreaNo1156441800','清远',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-06-25 18:41:58'),
	(2163,'AreaNo','1156440500','AreaNo1156440500','汕头',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-06-25 18:42:24'),
	(2164,'AreaNo','1156331000','AreaNo1156331000','台州',1,'','Z_浙江_ZHEJIANG_C','yaoboquan','2012-06-25 18:43:26'),
	(2165,'AreaNo','1156331100','AreaNo1156331100','丽水',1,'','Z_浙江_ZHEJIANG_C','yaoboquan','2012-06-25 18:43:55'),
	(2166,'AreaNo','1156330900','AreaNo1156330900','舟山',1,'','Z_浙江_ZHEJIANG_C','yaoboquan','2012-06-25 18:44:19'),
	(2167,'AreaNo','1156330800','AreaNo1156330800','衢州',1,'','Z_浙江_ZHEJIANG_C','yaoboquan','2012-06-25 18:44:55'),
	(2168,'AreaNo','1156330500','AreaNo1156330500','湖州',1,'','Z_浙江_ZHEJIANG_C','yaoboquan','2012-06-26 11:01:29'),
	(2177,'AreaNo','1156621000','AreaNo1156621000','庆阳',1,'','G_甘肃_GANSU_C','yaoboquan','2012-07-03 10:58:57'),
	(2206,'AdverTemplate','xmp_tips.vm','AdverTemplatexmp_tips.vm','xmp_tips_静态',1000,'xmp_tips.vm','6f2d4ad394f39c96490c9551313c51f7','liheng','2012-07-12 10:13:13'),
	(2238,'AreaNo','1156370800','AreaNo1156370800','济宁',1,'','S_山东_SHANDONG_C','yaoboquan','2012-07-31 14:59:37'),
	(2248,'SaleType','K','SaleTypeK','软性测试',1000,'2','','liheng','2012-08-07 13:53:53'),
	(2249,'SaleType','L','SaleTypeL','软性配送',1000,'2','','liheng','2012-08-07 13:55:56'),
	(2250,'SaleType','M','SaleTypeM','软性补偿',1000,'2','','jinyangyang','2012-12-08 21:00:12'),
	(2294,'PositionType','AA','PositionTypeAA','ipad',1000,'','','jinyangyang','2012-09-12 13:59:20'),
	(2300,'AreaNo','1156411300','AreaNo1156411300','南阳',1,'','H_河南_HENAN_C','yaoboquan','2012-09-14 17:11:24'),
	(2301,'AreaNo','1156450300','AreaNo1156450300','桂林',1,'','G_广西_GUANGXI_C','yaoboquan','2012-09-14 17:11:57'),
	(2302,'AreaNo','1156340400','AreaNo1156340400','淮南',1,'','A_安徽_ANHUI_C','yaoboquan','2012-09-14 17:14:21'),
	(2303,'AreaNo','1156140800','AreaNo1156140800','运城',1,'','S_山西_SHANXI_C','yaoboquan','2012-09-14 17:37:19'),
	(2311,'AdverTemplate','JSRollingBannerAllTy','AdverTemplateJSRollingBannerAllTy','JS通栏-所有类型',1000,'JSRollingBannerAllType.vm','23a2ccd500b00756b35c3f434129b4cc','jinyangyang','2012-09-20 11:22:22'),
	(2324,'AreaNo','1156321300','AreaNo1156321300','宿迁',1,'','J_江苏_JIANGSU_C','yaoboquan','2012-09-25 11:23:38'),
	(2325,'AreaNo','1156341300','AreaNo1156341300','宿州',1,'','A_安徽_ANHUI_C','yaoboquan','2012-09-25 11:24:50'),
	(2326,'AreaNo','1156441600','AreaNo1156441600','河源',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-09-25 11:25:35'),
	(2327,'AreaNo','1156441400','AreaNo1156441400','梅州',1,'','G_广东_GUANGDONG_C','yaoboquan','2012-09-25 11:26:30'),
	(2328,'AreaNo','1156210400','AreaNo1156210400','抚顺',1,'','L_辽宁_LIAONING_C','yaoboquan','2012-09-25 11:27:56'),
	(2338,'AdverTemplate','ipad_rolling.vm','AdverTemplateipad_rolling.vm','ipad轮播图',1000,'ipad_rolling.vm','7f14ffa44b2e70bde7beed8ffd15628e','jinyangyang','2012-10-10 09:48:59'),
	(2371,'AreaNo','1156341100','AreaNo1156341100','滁州',1,'','A_安徽_ANHUI_C','qiwei','2012-10-24 15:27:09'),
	(2372,'AreaNo','1156210300','AreaNo1156210300','鞍山',1,'','L_辽宁_LIAONING_C','qiwei','2012-10-24 15:44:22'),
	(2373,'AreaNo','1156210600','AreaNo1156210600','丹东',1,'','L_辽宁_LIAONING_C','qiwei','2012-10-24 15:52:14'),
	(2374,'AreaNo','1156210500','AreaNo1156210500','本溪',1,'','L_辽宁_LIAONING_C','qiwei','2012-10-24 15:48:53'),
	(2375,'AreaNo','1156211400','AreaNo1156211400','葫芦岛',1,'','L_辽宁_LIAONING_C','qiwei','2012-10-24 15:49:31'),
	(2376,'AreaNo','1156211300','AreaNo1156211300','朝阳',1,'','L_辽宁_LIAONING_C','qiwei','2012-10-25 15:14:50'),
	(2377,'AreaNo','1156211200','AreaNo1156211200','铁岭',1,'','L_辽宁_LIAONING_C','qiwei','2012-10-25 15:14:59'),
	(2383,'AdverTemplate','RollingTxtAd_in.vm','AdverTemplateRollingTxtAd_in.vm','文字链-轮播_inline',1000,'RollingTxtAd_in.vm','80d0d1dc1acfff274ef1d670ba1a079a','jinyangyang','2012-10-30 14:55:50'),
	(2384,'AreaNo','1156211000','AreaNo1156211000','辽阳',1,'','L_辽宁_LIAONING_C','qiwei','2012-10-30 15:18:33'),
	(2389,'AdverTemplate','RollingAd4.vm','AdverTemplateRollingAd4.vm','大全_首页_爆点',1000,'RollingAd4.vm','8bc7c123ff23294112962e8bb8f03449','jinyangyang','2012-10-31 20:30:06'),
	(2391,'AreaNo','1156321200','AreaNo1156321200','泰州',1,'','J_江苏_JIANGSU_C','qiwei','2012-11-01 17:32:03'),
	(2392,'AreaNo','1156441500','AreaNo1156441500','汕尾',1,'','G_广东_GUANGDONG_C','qiwei','2012-11-01 17:31:49'),
	(2393,'AreaNo','1156441700','AreaNo1156441700','阳江',1,'','G_广东_GUANGDONG_C','qiwei','2012-11-01 17:31:43'),
	(2400,'AreaNo','1156340500','AreaNo1156340500','马鞍山',1,'','A_安徽_ANHUI_C','qiwei','2012-11-05 14:11:02'),
	(2418,'AreaNo','1156440900','AreaNo1156440900','茂名',1,'','G_广东_GUANGDONG_C','qiwei','2012-11-14 15:36:43'),
	(2419,'AreaNo','1156445300','AreaNo1156445300','云浮',1,'','G_广东_GUANGDONG_C','qiwei','2012-11-14 15:38:15'),
	(2420,'AreaNo','1156510400','AreaNo1156510400','攀枝花',1,'','S_四川_SICHUAN_C','qiwei','2012-11-14 15:39:45'),
	(2421,'AdverTemplate','JSRollingBannerAllT1','AdverTemplateJSRollingBannerAllT1','JS通栏-所有类型-不轮播',1000,'JSRollingBannerAllType1.vm','3899aa85a08b82e9e76f8b5d316252ad','jinyangyang','2012-11-14 19:28:05'),
	(2426,'AdverTemplate','cpmUnionRedirect.vm','AdverTemplatecpmUnionRedirect.vm','看看联盟-版主跳转',1000,'cpmUnionRedirect.vm','058707a9fde08d352f581185395db337','lixin','2012-11-24 21:27:19'),
	(2475,'AreaNo','1156370500','AreaNo1156370500','东营',1,'','S_山东_SHANDONG_C','qiwei','2012-12-24 17:49:56'),
	(2476,'AreaNo','1156371500','AreaNo1156371500','聊城',1,'','S_山东_SHANDONG_C','qiwei','2012-12-24 17:51:37'),
	(2481,'AdverTemplate','RollingTxtAd1.vm','AdverTemplateRollingTxtAd1.vm','文字链-轮播-新',1000,'RollingTxtAd1.vm','7cd5207f1d3890eedb8c7d2aa523d668','tangchao','2012-12-28 14:47:59'),
	(2494,'AreaNo','1156430200','AreaNo1156430200','株洲',1,'','H_湖南_HUNAN_C','qiwei','2013-01-04 20:07:33'),
	(2495,'AreaNo','1156430300','AreaNo1156430300','湘潭',1,'','H_湖南_HUNAN_C','qiwei','2013-01-04 20:08:50'),
	(2499,'PositionType','AB','PositionTypeAB','Iphone',1000,'','','yuanzhigao','2013-01-08 10:38:44'),
	(2500,'PositionType','AC','PositionTypeAC','安卓',1000,'','','yuanzhigao','2013-01-08 10:39:09'),
	(2505,'AreaNo','1156350600','AreaNo1156350600','漳州',1,'','F_福建_FUJIAN_C','qiwei','2013-01-14 19:14:21'),
	(2507,'AreaNo','1156371400','AreaNo1156371400','德州',1,'','S_山东_SHANDONG_C','qiwei','2013-01-16 15:47:30'),
	(2508,'AreaNo','1156370400','AreaNo1156370400','枣庄',1,'','S_山东_SHANDONG_C','qiwei','2013-01-16 15:48:44'),
	(2509,'AreaNo','1156370900','AreaNo1156370900','泰安',1,'','S_山东_SHANDONG_C','qiwei','2013-01-16 15:49:27'),
	(2510,'AreaNo','1156411700','AreaNo1156411700','驻马店',1,'','H_河南_HENAN_C','qiwei','2013-01-16 15:50:30'),
	(2511,'AreaNo','1156410900','AreaNo1156410900','濮阳',1,'','H_河南_HENAN_C','qiwei','2013-01-16 15:50:50'),
	(2512,'AreaNo','1156411600','AreaNo1156411600','周口',1,'','H_河南_HENAN_C','qiwei','2013-01-16 15:51:12'),
	(2513,'AreaNo','1156411000','AreaNo1156411000','许昌',1,'','H_河南_HENAN_C','qiwei','2013-01-16 15:51:34'),
	(2514,'AreaNo','1156411100','AreaNo1156411100','漯河',1,'','H_河南_HENAN_C','qiwei','2013-01-16 15:51:51'),
	(2515,'AreaNo','1156410400','AreaNo1156410400','平顶山',1,'','H_河南_HENAN_C','qiwei','2013-01-16 15:52:10'),
	(2516,'AreaNo','1156411200','AreaNo1156411200','三门峡',1,'','H_河南_HENAN_C','qiwei','2013-01-16 15:52:25'),
	(2517,'AreaNo','1156410600','AreaNo1156410600','鹤壁',1,'','H_河南_HENAN_C','qiwei','2013-01-16 15:52:44'),
	(2518,'AreaNo','1156430500','AreaNo1156430500','邵阳',1,'','H_湖南_HUNAN_C','qiwei','2013-01-16 15:53:22'),
	(2519,'AreaNo','1156431300','AreaNo1156431300','娄底',1,'','H_湖南_HUNAN_C','qiwei','2013-01-16 15:53:47'),
	(2520,'AreaNo','1156430800','AreaNo1156430800','张家界',1,'','H_湖南_HUNAN_C','qiwei','2013-01-16 15:54:06'),
	(2521,'AreaNo','1156420900','AreaNo1156420900','孝感',1,'','H_湖北_HUBEI_C','qiwei','2013-01-16 15:54:52'),
	(2522,'AreaNo','1156421100','AreaNo1156421100','黄冈',1,'','H_湖北_HUBEI_C','qiwei','2013-01-16 15:55:34'),
	(2523,'AreaNo','1156361100','AreaNo1156361100','上饶',1,'','J_江西_JIANGXI_C','qiwei','2013-01-16 15:57:48'),
	(2524,'AreaNo','1156360400','AreaNo1156360400','九江',1,'','J_江西_JIANGXI_C','qiwei','2013-01-16 15:58:26'),
	(2525,'AreaNo','1156361000','AreaNo1156361000','抚州',1,'','J_江西_JIANGXI_C','qiwei','2013-01-16 15:58:43'),
	(2526,'AreaNo','1156360800','AreaNo1156360800','吉安',1,'','J_江西_JIANGXI_C','qiwei','2013-01-16 15:59:01'),
	(2527,'AreaNo','1156450900','AreaNo1156450900','玉林',1,'','G_广西_GUANGXI_C','qiwei','2013-01-16 16:00:44'),
	(2528,'AreaNo','1156371700','AreaNo1156371700','菏泽',1,'','S_山东_SHANDONG_C','qiwei','2013-01-16 16:04:33'),
	(2548,'AreaNo','1156510800','AreaNo1156510800','广元',1,'','S_四川_SICHUAN_C','qiwei','2013-01-30 18:29:40'),
	(2549,'AreaNo','1156511000','AreaNo1156511000','内江',1,'','S_四川_SICHUAN_C','qiwei','2013-01-30 18:30:16'),
	(2570,'PositionType','JJ','PositionTypeJJ','新版-拉幕',1000,'','','jinyangyang','2013-02-26 11:07:20'),
	(2577,'StatItem','14','StatItem14','倒计时',1000,'656','','jinyangyang','2013-02-26 14:02:09'),
	(2594,'AreaNo','1156411500','AreaNo1156411500','信阳',1,'','H_河南_HENAN_C','qiwei','2013-03-04 14:05:15'),
	(2602,'AdverTemplate','mobile_cpm.vm','AdverTemplatemobile_cpm.vm','手机助手-CPM',1000,'mobile_cpm.vm','b1b953a9f325578e4e820c1ebb7ae8bb','jinyangyang','2013-03-06 16:56:29'),
	(2615,'AreaNo','1156371100','AreaNo1156371100','日照',1,'','S_山东_SHANDONG_C','qiwei','2013-03-06 17:24:41'),
	(2619,'AreaNo','1156510600','AreaNo1156510600','德阳',1,'','S_四川_SICHUAN_C','qiwei','2013-03-08 15:52:25'),
	(2629,'AdverTemplate','XMP_install.vm','AdverTemplateXMP_install.vm','XMP_安装页_轮播图',1000,'XMP_install.vm','81b33fc3d1ca4723bfe991cfce108ac5','tangchao','2013-03-18 16:18:05'),
	(2690,'AdverTemplate','JsRollingCpe.vm','AdverTemplateJsRollingCpe.vm','通栏CPE类型',1000,'JsRollingCpe.vm','fd4be0effd37319360a55a2fd64d2398','tangchao','2013-03-29 10:26:07'),
	(2705,'AdverTemplate','xmp_tips_5.vm','AdverTemplatexmp_tips_5.vm','xmp_tips_静态5',1000,'xmp_tips_5.vm','b1d97fa3cdc137e7dbfc8dee88b57f76','tangchao','2013-04-01 18:19:25'),
	(2711,'AdverTemplate','XMP_welcome.vm','AdverTemplateXMP_welcome.vm','XMP欢迎页广告',1000,'XMP_welcome.vm','289672adf885c72feee06d12c6c242d1','tangchao','2013-04-07 11:02:00'),
	(2720,'AreaNo','1156220200','AreaNo1156220200','吉林市',1,'','J_吉林_JILIN_C','123','2013-04-10 14:19:58'),
	(2729,'AdverTemplate','KK_jiaobiao.vm','AdverTemplateKK_jiaobiao.vm','角标静态广告',1000,'KK_jiaobiao.vm','ecdc7e3093d93e9d1f009a37793d27bc','tangchao','2013-04-15 17:19:14'),
	(2756,'AdverTemplate','XMP_pause.vm','AdverTemplateXMP_pause.vm','XMP暂停广告',1000,'XMP_pause.vm','b910df0912e973fd5b1ad2659b8ff58a','tangchao','2013-05-11 14:12:48'),
	(2757,'AdverTemplate','XMP_list.vm','AdverTemplateXMP_list.vm','XMP列表广告',1000,'XMP_list.vm','2d2c0589c6cdb6e8fe466eefab72e8d2','tangchao','2013-05-11 14:14:45'),
	(2758,'AdverTemplate','XMP_hc.vm','AdverTemplateXMP_hc.vm','XMP缓冲广告',1000,'XMP_hc.vm','aa887e3aa74ef6fc75c0c8dd0a95bc0a','tangchao','2013-05-11 14:15:58'),
	(2806,'AdverTemplate','JsRollingAllType.vm','AdverTemplateJsRollingAllType.vm','通栏所有类型',1000,'JsRollingAllType.vm','ac8cf6f77c0c0281b153758b93ad74c5','tangchao','2013-05-17 16:39:11'),
	(2809,'SaleType','N','SaleTypeN','后结算',1000,'1','','fanzhifang','2013-05-20 17:21:47'),
	(2813,'AdverTemplate','JSRollingBanner.vm','AdverTemplateJSRollingBanner.vm','微电影通栏',1000,'JSRollingBanner.vm','d687501944a3841192dc79c1d789b4af','tangchao','2013-05-29 14:41:02'),
	(2819,'AreaNo','1156610500','AreaNo1156610500','渭南市',1,'','S_陕西_SHANXI3_C','qiwei','2013-05-31 18:53:24'),
	(2828,'AdverTemplate','wzlink.vm','AdverTemplatewzlink.vm','文字链数组',1000,'wzlink.vm','a42a8de2e08c16de92385d844b267d60','tangchao','2013-06-04 16:05:53'),
	(2831,'AdverTemplate','XMP_play_end.vm','AdverTemplateXMP_play_end.vm','XMP片尾广告',1000,'XMP_play_end.vm','40ed5895b4a8baee511238dbcc5822be','tangchao','2013-06-06 16:20:00'),
	(2864,'AdverTemplate','JsRollingCpe1040.vm','AdverTemplateJsRollingCpe1040.vm','第三通栏模版',1000,'JsRollingCpe1040.vm','14b3e1e5ffd71e8479e4e7a6d6340c27','tangchao','2013-06-17 21:16:54'),
	(2865,'AdverTemplate','JsRollingCpe1042.vm','AdverTemplateJsRollingCpe1042.vm','第五通栏模版',1000,'JsRollingCpe1042.vm','332f0c30049ea2f0602fa5d53b05a6ba','tangchao','2013-06-17 21:17:59'),
	(2873,'AdverTemplate','JsRollingCpe1457.vm','AdverTemplateJsRollingCpe1457.vm','电影首页第一通栏',1000,'JsRollingCpe1457.vm','df17b5e24b491f9024e594feb441b49b','tangchao','2013-06-25 16:39:58'),
	(2876,'AreaNo','1156530700','AreaNo1156530700','丽江',1,'','Y_云南_YUNNAN_C','123','2013-09-24 15:59:49'),
	(2877,'AreaNo','1156532900','AreaNo1156532900','大理',1,'','Y_云南_YUNNAN_C','123','2013-09-24 15:59:58'),
	(2908,'AdverTemplate','Mini_index.vm','AdverTemplateMini_index.vm','迷你首页标签',1000,'Mini_index.vm','776c6a28bee1d6aa671a4eef25b0b6d2','tangchao','2013-07-04 10:37:49'),
	(2909,'AdverTemplate','mini_fc.vm','AdverTemplatemini_fc.vm','迷你首页富媒体',1000,'mini_fc.vm','e4300164c64d8e40f960c21780ce5d3c','tangchao','2013-07-04 10:39:25'),
	(2912,'AdverTemplate','RollingTxtAd2.vm','AdverTemplateRollingTxtAd2.vm','文字链轮播不冲突',1000,'RollingTxtAd2.vm','cbb46c2a293c0e67effc33467483c9c0','tangchao','2013-07-04 11:11:00'),
	(2918,'AdverTemplate','JsRollingCpe1461.vm','AdverTemplateJsRollingCpe1461.vm','电视剧频道第一通栏定向',1000,'JsRollingCpe1461.vm','d234ceaca5bb5f14ecc3d9413bc45631','tangchao','2013-07-09 16:09:13'),
	(2924,'AdverTemplate','JsRollingCpe1359.vm','AdverTemplateJsRollingCpe1359.vm','综艺频道第一通栏定向',1000,'JsRollingCpe1359.vm','95bc398e14faec243ae2a9c664c3fc4b','tangchao','2013-07-10 15:11:42'),
	(2925,'AdverTemplate','XMP_db.vm','AdverTemplateXMP_db.vm','XMP底部树广告',1000,'XMP_db.vm','fcea8f737ec84be1e7a78b1a6c9c9380','tangchao','2013-07-11 15:49:42'),
	(2951,'AreaNo','1156350900','AreaNo1156350900','宁德',1,'','F_福建_FUJIAN_C','123','2013-07-19 15:33:13'),
	(2984,'PositionStatus','E','PositionStatusE','销测',1000,'','','fanzhifang','2013-08-08 15:57:49'),
	(2991,'AdverTemplate','indexRolling.vm','AdverTemplateindexRolling.vm','首页焦点图',1000,'indexRolling.vm','ff2890c006ec9f5b07d50f2a3a968fdf','tangchao','2013-08-17 11:18:01'),
	(3002,'AdverTemplate','XMP_label.vm','AdverTemplateXMP_label.vm','XMP二级标签',1000,'XMP_label.vm','082279d446df19c6bba13283dc8190f7','tangchao','2013-08-22 10:26:54'),
	(3061,'AdverTemplate','piankuRolling.vm','AdverTemplatepiankuRolling.vm','片库大图模版',1000,'piankuRolling.vm','71f17000d165c26e0bc4ccfcdc78d6a1','tangchao','2013-09-04 17:41:52'),
	(3062,'AdverTemplate','desk_wzl.vm','AdverTemplatedesk_wzl.vm','桌面新闻文字链',1000,'desk_wzl.vm','d17cfbf3443811d3c3cd23ebd61db741','tangchao','2013-09-06 13:48:10'),
	(3063,'AdverTemplate','desk_tuwen.vm','AdverTemplatedesk_tuwen.vm','桌面新闻图文标签',1000,'desk_tuwen.vm','8c23c3d783e8d2df68b1889b7c4745cb','tangchao','2013-09-06 13:50:01'),
	(3072,'AdverTemplate','indexsoft.vm','AdverTemplateindexsoft.vm','看看首页软性广告位',1000,'indexsoft.vm','e0ad87c12a5835f768f112236e06733a','liangxiaoyun','2013-09-13 14:45:14'),
	(3076,'AreaNo','1156451200','AreaNo1156451200','河池市',1,'','G_广西_GUANGXI_C','123','2013-09-24 15:58:15'),
	(3077,'AreaNo','1156451000','AreaNo1156451000','百色',1,'','G_广西_GUANGXI_C','123','2013-09-24 15:58:11'),
	(3078,'AreaNo','1156511700','AreaNo1156511700','达州',1,'','S_四川_SICHUAN_C','123','2013-09-24 15:59:05'),
	(3079,'AreaNo','1156512000','AreaNo1156512000','资阳',1,'','S_四川_SICHUAN_C','123','2013-09-24 15:59:28'),
	(3178,'AreaNo','1036000000','AreaNo1036000000','澳大利亚',1,'','A_澳大利亚_AODALIYA_P','fanzhifang','2013-11-21 16:51:44'),
	(3179,'AreaNo','890','AreaNo890','香港',1000,'','X_香港_XIANGGANG_P','fanzhifang','2013-11-21 16:53:01'),
	(3180,'AreaNo','895','AreaNo895','澳门',1000,'','A_澳门_AOMEN_P','fanzhifang','2013-11-21 16:53:53'),
	(3181,'AreaNo','928','AreaNo928','全球',1000,'','Q_全球_QUANQIU_P','fanzhifang','2013-11-21 16:55:37'),
	(3335,'AdverTemplate','RollingAdJsName.vm','AdverTemplateRollingAdJsName.vm','JS-PIP-文件名',1000,'RollingAdJsName.vm','d10f2e61e1480539bc2b7baed35796e1','tangchao','2014-03-04 10:02:36'),
	(3336,'AdverTemplate','RollingAdJsName1.vm','AdverTemplateRollingAdJsName1.vm','JS-PIP-文件名-特殊',1000,'RollingAdJsName1.vm','dfaea1422a9f5c3f6a1e51b2f4cf216f','tangchao','2014-03-04 15:29:59'),
	(3340,'AreaNo','1156530500','AreaNo1156530500','保山市',1,'','Y_云南_YUNNAN_C','qiwei','2014-03-13 12:07:35'),
	(3341,'AdverTemplate','BannerAllType3.vm','AdverTemplateBannerAllType3.vm','桌面新闻_擎天柱',1000,'JSRollingBannerAllType3.vm','fb2412ffd2a63b1ddd7b1b67f434fd0b','jinyangyang','2014-03-20 15:42:26'),
	(3374,'AdverTemplate','JSRollingAdMaster.vm','AdverTemplateJSRollingAdMaster.vm','JS通栏-轮播AdMaster统计',1000,'JSRollingBannerAllTypeAdMaster.vm','dfaa9bd7a7968a17b793312573d5ee70','tangchao','2014-04-04 16:55:42'),
	(3381,'OrderwfStatusNew','J','OrderwfStatusNewJ','传媒待审',1000,'','','fanzhifang','2014-01-14 11:19:33'),
	(3386,'OrderwfStatusNew','O','OrderwfStatusNewO','释放库存待审',1000,'','','fanzhifang','2014-01-14 11:20:36'),
	(3387,'OrderwfStatusNew','Q','OrderwfStatusNewP','大区待审',1000,'','','fanzhifang','2014-01-15 15:30:54'),
	(3388,'OrderwfStatusNew','R','OrderwfStatusNewR','修改待审',1000,'','','fanzhifang','2014-01-21 10:57:10'),
	(3391,'OrderwfStatusNew','B','OrderwfStatusNewB','预定撤单完成',1000,'','','fanzhifang','2014-02-20 16:06:12'),
	(3392,'OrderwfStatusNew','S','OrderwfStatusNewS','传媒客户邮件确认',1000,NULL,'','fanzhifang','2014-02-20 16:06:12'),
	(3393,'OrderwfStatusNew','P','OrderwfStatusNewP','已回款',1000,'','','fanzhifang','2014-02-20 16:05:15'),
	(3394,'OrderwfStatusNew','I','OrderwfStatusNewI','草稿',1000,'','','fanzhifang','2014-01-14 11:17:37'),
	(3395,'OrderwfStatusNew','C','OrderwfStatusNewC','合同待审',1000,'','','fanzhifang','2014-01-14 11:17:55'),
	(3396,'OrderwfStatusNew','F','OrderwfStatusNewF','审核完毕',1000,'','','fanzhifang','2014-01-14 11:18:40'),
	(3397,'OrderwfStatusNew','G','OrderwfStatusNewG','撤单待审',1000,'','','fanzhifang','2014-01-14 11:18:53'),
	(3398,'OrderwfStatusNew','H','OrderwfStatusNewH','撤单',1000,'','','fanzhifang','2014-01-14 11:19:07'),
	(3400,'OrderwfStatusNew','K','OrderwfStatusNewK','传媒价格待审',1000,'','','fanzhifang','2014-01-14 11:19:45'),
	(3401,'OrderwfStatusNew','L','OrderwfStatusNewL','传媒客户邮件确认待审',1000,'','','fanzhifang','2014-01-14 11:20:01'),
	(3402,'OrderwfStatusNew','M','OrderwfStatusNewM','传媒库存待审',1000,'','','fanzhifang','2014-01-14 11:20:15'),
	(3403,'OrderwfStatusNew','N','OrderwfStatusNewN','财务待审',1000,'','','fanzhifang','2014-01-14 11:20:25'),
	(3407,'OrderwfStatusNew','E','OrderwfStatusNewE','签订后撤单完成',1000,'','','fanzhifang','2014-02-20 16:05:45'),
	(3408,'OrderwfStatusNew','A','OrderwfStatusNewA','预定订单',1000,'','','fanzhifang','2014-02-20 16:06:01'),
	(3416,'SaleType','C','','配送',1000,'1','','',''),
	(3437,'SaleType','O','','自动补量',1000,'1','','',''),
	(3438,'AdverTemplate','fcIndex.vm','','首页浮层广告',1000,'fcIndex.vm','5bd82ed533563624fe4bc55bf20e2523','',''),
	(3446,'MaterialType','13','','f4v',1000,'','','',''),
	(3447,'AdverTemplate','newFcIndex.vm','','新首页浮层模版',1000,'newFcIndex.vm','8d29cd47be9a6f7babb6b449e5b44696','',''),
	(3448,'CPMType','45','','45秒',1000,'','','',''),
	(3449,'CPMType','60','','60秒',1000,'','','',''),
	(3450,'AdverTemplate','JSRolling1940.vm','','第一通栏广州定向模版',1000,'JSRolling1940.vm','330f3716f501cbb3b96523a7d9c441d1','',''),
	(3451,'AdverTemplate','cm1940.vm','','首页一通PIP广州定向',1000,'cm1940.vm','000af1aeaff2fe4bda041d8def83a66f','',''),
	(3452,'AdverTemplate','cm1941.vm','','首页二通PIP定向模版',1000,'cm1941.vm','c3a83e2b71d36bee012951997c28bbee','',''),
	(3453,'AdverTemplate','JSRolling1941.vm','','首页二通PIP广州定向',1000,'JSRolling1941.vm','b8073e110a0b67f807bf9d6cb5c3e059','',''),
	(3454,'AdverTemplate','desl_wzl1896.vm','','桌面新闻文字链广州定向',0,'desl_wzl1896.vm','','',''),
	(3455,'AdverTemplate','cm1460.vm','','电影首页四通定向模版',1000,'cm1460.vm','4e21818cd0d696e0d649da8f47bc2243','',''),
	(3456,'AdverTemplate','JSRolling1460.vm','','电影首页四通广州定向',1000,'JSRolling1460.vm','67995b1fc04ac940291955b8a2eeb286','',''),
	(3457,'AdverTemplate','cm1464.vm','','电视剧首页四通定向模版',1000,'cm1464.vm','dc99ce969efb10e54a791aee0a4882aa','',''),
	(3458,'AdverTemplate','JSRolling1464.vm','','电视剧首页四通广州定向',1000,'JSRolling1464.vm','ed039c39ac89c655ebd519c0b79bb8eb','',''),
	(3459,'AdverTemplate','cm1918.vm','','动漫首页四通定向模版',1000,'cm1918.vm','b1b0f124841cfa69d0cbfa127a33704f','',''),
	(3460,'AdverTemplate','动漫首页四通广州定向','','动漫首页四通广州定向',1000,'JSRolling1918.vm','7bf0889fb27cfda79d909d9d373a4025','',''),
	(3461,'AdverTemplate','cm1358.vm','','综艺首页四通定向模版',1000,'cm1358.vm','4dc42d485c793606119b8f08fc5cf140','',''),
	(3462,'AdverTemplate','JSRolling1358.vm','','综艺首页四通广州定向',1000,'JSRolling1358.vm','30fe7ddd01ea868b02e9bb302de88ff9','',''),
	(3463,'AdverTemplate','cm1223.vm','','纪录片首页四通定向模版',1000,'cm1223.vm','3e70413badaa1f618b782f3d503cc4c7','',''),
	(3464,'AdverTemplate','JSRolling1223.vm','','纪录片首页四通广州定向',1000,'JSRolling1223.vm','947a8f73e8ee31f97b9a402569c2b103','',''),
	(3465,'AreaNo','1634','','莱芜',0,'S_山东_SHANDONG_C','S_山东_SHANDONG_C','',''),
	(3466,'AdverTemplate','ipad_rolling4.vm','','ipad新版轮播图',1000,'ipad_rolling4.vm','b95e3ec83ba8335f58967c8fe31fac37','',''),
	(3479,'AdverTemplate','index_wzl_point.vm','','桌面新闻广州定向文字链',1000,'index_wzl_point.vm','87e16ccd2e7d1e528fa2b052eb591958','',''),
	(3480,'AdverTemplate','cm1896.vm','','桌面新闻文字链控制',1000,'cm1896.vm','605ff2ab681740084b1c804f27c2f4e5','',''),
	(3481,'AreaNo','3795','','宜春',0,'','J_江西_JIANGXI_C','',''),
	(3482,'AdverTemplate','whtvideo.vm','','万花筒种子视频',1000,'whtvideo.vm','dd5e872893491ff9b8fda1ccb20a7c03','',''),
	(3485,'AdverTemplate','FLV_test.vm','','测试多素材贴片',1000,'FLV_test.vm','','',''),
	(3487,'AdverTemplate','JSRollingAutoShowAll','','JS通栏-所有类型-自动展示',1000,'JSRollingAutoShowAllType.vm','a4e189e6fa27e5196a8baf8d767b137d','',''),
	(3489,'AdverTemplate','cookiemapping.vm','','cookieMapping对接',1000,'cookiemapping.vm','0dfcb7f3761971f91795739306a0d2aa','',''),
	(3491,'AreaNo','72752','','湘西土家族苗族自治州',0,'','','',''),
	(3492,'AreaNo_S','HUNAN','','湖南',0,'湖南省','H','',''),
	(3493,'AreaNo_S','HUBEI','','湖北',0,'湖北省','H','',''),
	(3494,'AreaNo_S','GUANGDONG','','广东',0,'广东省','G','',''),
	(3495,'AreaNo_S','GUANGXI','','广西',0,'广西壮族自治区','G','',''),
	(3496,'AreaNo_S','HEILONGJIANG','','黑龙江',0,'黑龙江省','H','',''),
	(3497,'AreaNo_S','HAINAN','','海南',0,'海南省','H','',''),
	(3498,'AreaNo_S','SHANDONG','','山东',0,'山东省','S','',''),
	(3499,'AreaNo_S','SHANXI','','山西',0,'山西省','S','',''),
	(3500,'AreaNo_S','NEIMENGGU','','内蒙古',0,'内蒙古自治区','N','',''),
	(3501,'AreaNo_S','SICHUAN','','四川',0,'四川省','S','',''),
	(3502,'AreaNo_S','XINJIANG','','新疆',0,'新疆维吾尔自治区','X','',''),
	(3503,'AreaNo_S','ZHEJIANG','','浙江',0,'浙江省','Z','',''),
	(3504,'AreaNo_S','YUNNAN','','云南',0,'云南省','Y','',''),
	(3505,'AreaNo_S','FUJIAN','','福建',0,'福建省','F','',''),
	(3506,'AreaNo_S','JILIN','','吉林',0,'吉林省','J','',''),
	(3507,'AreaNo_S','HENAN','','河南',0,'河南省','H','',''),
	(3508,'AreaNo_S','JIANGXI','','江西',0,'江西省','J','',''),
	(3509,'AreaNo_S','NINGXIA','','宁夏',0,'宁夏回族自治区','N','',''),
	(3510,'AreaNo_S','GANSU','','甘肃',0,'甘肃省','G','',''),
	(3511,'AreaNo_S','LIAONING','','辽宁',0,'辽宁省','L','',''),
	(3512,'AreaNo_S','JIANGSU','','江苏',0,'江苏省','J','',''),
	(3513,'AreaNo_S','GUIZHOU','','贵州',0,'贵州省','G','',''),
	(3514,'AreaNo_S','QINHAI','','青海',0,'青海省','Q','',''),
	(3515,'AreaNo_S','HEBEI','','河北',0,'河北省','H','',''),
	(3516,'AreaNo_S','ANHUI','','安徽',0,'安徽省','A','',''),
	(3517,'AreaNo_S','SHANXI3','','陕西',0,'陕西省','S','',''),
	(3518,'AreaNo_S','XIZANG','','西藏',0,'西藏自治区','X','',''),
	(3519,'AreaNo','1156230900','AreaNo1156230900','七台河市',1,'','H_黑龙江_HEILONGJIANG_C','',''),
	(3521,'AreaNo','1156520200','AreaNo1156520200','六盘水市',1,'','G_贵州_GUIZHOU_C','',''),
	(3522,'AreaNo','2857','','毕节地区',1,'','G_贵州_GUIZHOU_C','',''),
	(3523,'SaleType','P','','第三方补量',1000,'1','','',''),
	(3524,'AreaNo','1156520400','AreaNo1156520400','安顺市',1,'','G_贵州_GUIZHOU_C','',''),
	(3538,'AdverTemplate','YP.vm','','影片互动广告',1000,'YP.vm','55f5f2def0f8245656f32a13bbaa1365','',''),
	(3547,'AdType','E','','CPM--按天售卖',1001,'E','','',''),
	(3550,'AdverTemplate','Welcome.vm','','迅雷影音欢迎页',1000,'Welcome.vm','7baf89c780e55422ab64fcc87eb7ed49','',''),
	(3551,'AdverTemplate','FocusImage.vm','','片库影音焦点图',1000,'FocusImage.vm','fd23392758460a5ae51b6cb07e9557a6','',''),
	(3554,'AdverTemplate','labelPlayer.vm','','长视频播放页推广标签',1000,'labelPlayer.vm','','',''),
	(3555,'CPMType','90','','90秒',1000,'','','',''),
	(3556,'AdverTemplate','vast3.vm','','Vast3.0模板',0,'vast3.vm','','',''),
	(3560,'AreaNo_S','fsf','','对对2对',3,'2','对对对','',''),
	(3561,'CustomStatus','test','','测试',2,'D','订单','',''),
	(3566,'AreaNo','1156350400','AreaNo1156350400','三明市',1,'','F_福建_FUJIAN_C','',''),
	(3567,'FileCharset','A','','GBK',1000,'GBK','re','',''),
	(3568,'FileCharset','B','','UTF8',1000,'UTF8','re','',''),
	(3570,'CreateExtType','A','CreateExtTypeA','js',1,'js','js','',''),
	(3571,'CreateExtType','B','CreateExtTypeB','htm',2,'htm','htm','',''),
	(3572,'CreateExtType','C','','xml',3,'xml','xml ---','jinyangyang','2015-11-16 15:59:55'),
	(3573,'CreateExtType','D','CreateExtTypeD','txt',4,'txt','txt','',''),
	(3574,'IllegalContract','GivePerSale','IllegalContractGivePerSale','配送/销售 &gt; 1.20',1000,'1.2','see','',''),
	(3575,'IllegalContract','PlanType','IllegalContractPlanType','存在赔偿,测试,补偿或补量类型排期',1000,'B,D,I,J','see','',''),
	(3576,'IllegalContract','Discount','IllegalContractDiscount','存在折扣低于40%的排期',1000,'0.4','see','',''),
	(3577,'IllegalContract','OrderAmt','IllegalContractOrderAmt','合同金额小于10元',1000,'10','see','',''),
	(3578,'IllegalContract','OrderamtPerSys','IllegalContractOrderamtPerSys','合同金额与系统折算金额差值高于合同金额5%',1000,'0.05','see','',''),
	(3579,'OrderplanLevel','1','OrderplanLevel1','特殊订单',1,'pt','特殊订单','',''),
	(3580,'OrderplanLevel','2','','特殊订单补量',2,'ORDER','特殊订单补量','jinyangyang','2015-11-16 21:01:08'),
	(3581,'OrderplanLevel','3','OrderplanLevel3','品牌高优先级',3,'RANDOM','品牌高优先级','',''),
	(3582,'OrderplanLevel','4','OrderplanLevel4','品牌高优先级补量',4,'PT+ORDER','品牌高优先级补量','',''),
	(3583,'OrderplanLevel','5','OrderplanLevel5','品牌地域定向',5,'PT+ORDER','品牌地域定向','',''),
	(3584,'OrderplanLevel','6','OrderplanLevel6','品牌地域定向补量',6,'PT+ORDER','品牌地域定向补量','',''),
	(3585,'OrderplanLevel','7','OrderplanLevel7','品牌正常',7,'PT+ORDER','品牌正常','',''),
	(3586,'OrderplanLevel','8','OrderplanLevel8','品牌正常补量',8,'PT+ORDER','品牌正常补量','',''),
	(3587,'OrderplanLevel','9','OrderplanLevel9','品牌余量',9,'PT+ORDER','品牌余量','',''),
	(3588,'OrderplanLevel','10','OrderplanLevel10','优先级10',10,'PT+ORDER','优先级10','',''),
	(3589,'OrderplanLevel','11','OrderplanLevel11','网游高优先级',11,'PT+ORDER','网游高优先级','',''),
	(3590,'OrderplanLevel','12','OrderplanLevel12','网游网服',12,'PT+ORDER','网游网服','',''),
	(3591,'OrderplanLevel','13','OrderplanLevel13','网游网服余量',13,'PT+ORDER','网游网服余量','',''),
	(3592,'OrderplanLevel','14','OrderplanLevel14','内部默认',14,'PT+ORDER','内部默认','',''),
	(3593,'OrderplanLevel','15','OrderplanLevel15','优先级15',15,'PT+ORDER','优先级15','',''),
	(3594,'OrderplanLevel','16','OrderplanLevel16','优先级16',16,'PT+ORDER','优先级16','',''),
	(3595,'OrderplanLevel','17','OrderplanLevel17','优先级17',17,'PT+ORDER','优先级17','',''),
	(3596,'OrderplanLevel','18','OrderplanLevel18','优先级18',18,'PT+ORDER','优先级18','',''),
	(3597,'OrderplanLevel','19','OrderplanLevel19','优先级19',19,'PT+ORDER','优先级19','',''),
	(3598,'OrderplanLevel','20','OrderplanLevel20','优先级20',20,'PT+ORDER','优先级20','',''),
	(3599,'OrderplanLevel','21','OrderplanLevel21','优先级21',21,'PT+ORDER','优先级21','',''),
	(3600,'OrderplanLevel','22','OrderplanLevel22','优先级22',22,'RANDOM','优先级22','',''),
	(3601,'Platform2DealidPage','DealAndLine','Platform2DealidPageDealAndLine','需要dealid和campaingid',1,'101',NULL,'jinyangyang1','2016-03-17 10:19:17'),
	(3602,'Platform2DealidPage','NoDealId','Platform2DealidPageNoDealId','不需要dealid',2,'008, 210,201',NULL,'jinyangyang1','2016-03-17 10:19:58');

/*!40000 ALTER TABLE `libfun_libclassd` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_libclassm
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_libclassm`;

CREATE TABLE `libfun_libclassm` (
  `SeqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `ClassNo` varchar(20) NOT NULL DEFAULT '',
  `ClassName` varchar(40) NOT NULL DEFAULT '',
  `Remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SeqId`),
  KEY `libclassm_idx1` (`ClassNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `libfun_libclassm` WRITE;
/*!40000 ALTER TABLE `libfun_libclassm` DISABLE KEYS */;

INSERT INTO `libfun_libclassm` (`SeqId`, `ClassNo`, `ClassName`, `Remark`)
VALUES
	(3,'PlatformStatus','平台状态',''),
	(8,'PositionType','广告位类型','A：通栏；B：按钮'),
	(9,'AdType','广告类型','A：常规广告；B：贴片广告；C：CPM'),
	(12,'MaterialType','素材类型','1：gif；2：jpg'),
	(14,'PositionStatus','广告位状态',' A：正常；B：测试；C：暂停；D：失效'),
	(19,'CustomStatus','客户状态','N：正常，C：关闭'),
	(22,'AutoIncrement','自增长数据',''),
	(25,'SaleType','销售类型',''),
	(28,'AreaNo','地区编号',''),
	(31,'MaterialCheckStatus','素材审核状态',''),
	(35,'AdverTemplate','广告模板',''),
	(53,'OrderTradeType','订单行业类型',''),
	(56,'CPMType','CPM时长类型',''),
	(74,'StatItem','统计项',''),
	(81,'CPMPlayType','CPM播放类型',''),
	(98,'OrderplanLevel','排期等级',''),
	(107,'PositionLimitCpm','广告位默认CPM量',''),
	(108,'AreaNo_S','地域编号 省份',''),
	(127,'IPTable','ip库配置',''),
	(189,'OrderwfStatusNew','新订单流程状态',''),
	(202,'FileCharset','广告位字符集','广告位字符集'),
	(203,'CreateExtType','文件格式','生成文件格式'),
	(204,'IllegalContract','非正常订单判断条件','必须'),
	(205,'Platform2DealidPage','平台和对应的delaid页面','平台和对应的delaid页面');

/*!40000 ALTER TABLE `libfun_libclassm` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_libconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_libconfig`;

CREATE TABLE `libfun_libconfig` (
  `SeqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `ConfigNo` varchar(30) NOT NULL DEFAULT '',
  `ConfigName` varchar(40) NOT NULL DEFAULT '',
  `ConfigValue` varchar(100) NOT NULL DEFAULT '',
  `Remark` varchar(255) DEFAULT '',
  `EditBy` varchar(30) DEFAULT '',
  `EditTime` varchar(19) DEFAULT '',
  PRIMARY KEY (`SeqId`),
  KEY `libconfig_idx1` (`ConfigNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `libfun_libconfig` WRITE;
/*!40000 ALTER TABLE `libfun_libconfig` DISABLE KEYS */;

INSERT INTO `libfun_libconfig` (`SeqId`, `ConfigNo`, `ConfigName`, `ConfigValue`, `Remark`, `EditBy`, `EditTime`)
VALUES
	(62,'Version','框架的数据库版本','4.0.0','此值用于存储框架数据库版本号，用于升级之用。勿手动修改它！','lixin','2013-08-28 09:36:49'),
	(65,'VerifyCode','后台是否使用验证码登录','1','','',''),
	(94,'OrderbyTime','订单播放严格按照优先级的时间','23:00:00','格式不要弄错','lixin','2014-12-16 14:52:06'),
	(96,'PositionViewPath','广告位预览文件上传路径','/usr/local/htdocs/xlcmadmin/upload/positionview','','yaoboquan','2011-09-22 18:19:47'),
	(97,'LimitCpm','设置cpm量为0时后台默认提供的cpm配置','500000','1000=1CPM','yaoboquan','2011-10-15 12:50:33'),
	(109,'excludeCities','排除的城市','10','','jinyangyang','2012-12-26 18:43:28'),
	(110,'ExcludeCityPositions','可以排除地区的广告位','922,1183,656','','jinyangyang','2012-12-20 18:04:26'),
	(111,'DEFAULT_MAX_POST_SIZE','DEFAULT_MAX_POST_SIZE','51200','上传文件最大限制 单位kb','',''),
	(112,'qualification_not_pass','资质审核不通过','亲爱的${userLogNo}，你帐号下的${advertisers}资质审核未通过，请根据备注信息再次上传正确的资质。','userLogNo： 账号名称 advertisers：广告主名称','',''),
	(113,'material_not_pass','物料审核不通过','亲爱的${userLogNo},您的物料${materialName}审核被拒绝，您可以先取消之前的物料，再上传正确的物料，并再次提交审核。','materialName： 物料名称','',''),
	(114,'recharge_message','充值消息','亲爱的${userLogNo}，您的充值金额已到账，充值金额为￥${money}，您可到“财务管理”内查看。','money : 金额数','',''),
	(115,'refund_message','退款消息','亲爱的${userLogNo}，您的退款金额已到账，退款金额为￥${money}，您可到合作银行卡帐号内查看。','','','');

/*!40000 ALTER TABLE `libfun_libconfig` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_menus
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_menus`;

CREATE TABLE `libfun_menus` (
  `SeqId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `MenuNo` varchar(20) DEFAULT '',
  `MenuName` varchar(30) NOT NULL DEFAULT '',
  `PMenuNo` varchar(20) NOT NULL DEFAULT '',
  `MenuUrl` text NOT NULL,
  `DisplayOrder` int(11) NOT NULL DEFAULT '1000',
  `InUse` smallint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`SeqId`),
  KEY `menus_idx1` (`MenuNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `libfun_menus` WRITE;
/*!40000 ALTER TABLE `libfun_menus` DISABLE KEYS */;

INSERT INTO `libfun_menus` (`SeqId`, `MenuNo`, `MenuName`, `PMenuNo`, `MenuUrl`, `DisplayOrder`, `InUse`)
VALUES
	(1,'0','FOXDSP','-1','/',-5,1),
	(555,'555','系统配置','0','#',-3,1),
	(559,'559','账号设置','559','#',2,1),
	(560,'560','用户管理','555','/jf/libfun/user',-8,1),
	(561,'561','系统配置维护','555','/jf/libfun/libconfig',-8,1),
	(562,'562','系统数组维护','555','/jf/libfun/array',-8,1),
	(563,'563','角色管理','555','/jf/libfun/role',-9,1),
	(564,'564','权限管理','555','/jf/libfun/privilege',-7,1),
	(565,'565','菜单管理','555','/jf/libfun/menu',0,1),
	(570,'570','我的账号','559','/jf/libfun/user/account',0,1),
	(633,'599','消息管理','555','/jf/messageList',2,1),
	(634,'600', '系统日志', '555', '/jf/libfun/syslog', 3, 1);

/*!40000 ALTER TABLE `libfun_menus` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_notify_message
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_notify_message`;

CREATE TABLE `libfun_notify_message` (
  `seqid` bigint(20) NOT NULL AUTO_INCREMENT,
  `receiver_userlogno` varchar(30) NOT NULL DEFAULT '' COMMENT '接收者',
  `sender_userlogno` varchar(30) NOT NULL DEFAULT '' COMMENT '发送者',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `message_content` varchar(600) NOT NULL DEFAULT '' COMMENT '内容',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否置顶（0：否，1：是）',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型（0：系统消息，1：审核消息，2：账号消息）',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态（0：未读，1：已读，2：已删除）',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`seqid`),
  KEY `receiver_idx` (`receiver_userlogno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息表';

LOCK TABLES `libfun_notify_message` WRITE;
/*!40000 ALTER TABLE `libfun_notify_message` DISABLE KEYS */;


/*!40000 ALTER TABLE `libfun_notify_message` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_notify_send
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_notify_send`;

CREATE TABLE `libfun_notify_send` (
  `seqid` bigint(20) NOT NULL AUTO_INCREMENT,
  `receiver_userlogno` text NOT NULL COMMENT '接收者(多个账号用逗号分割)',
  `sender_userlogno` varchar(30) NOT NULL DEFAULT '' COMMENT '发送者',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '发送标题',
  `send_content` varchar(600) NOT NULL DEFAULT '' COMMENT '发送内容',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否置顶（0：否，1：是）',
  `send_time` datetime DEFAULT NULL COMMENT '定时发送时间（如果为空，表示即时发送）',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发送结果（0：未发送，1：已发送）',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `edit_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`seqid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发送信息表';

LOCK TABLES `libfun_notify_send` WRITE;
/*!40000 ALTER TABLE `libfun_notify_send` DISABLE KEYS */;


/*!40000 ALTER TABLE `libfun_notify_send` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_privilege
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_privilege`;

CREATE TABLE `libfun_privilege` (
  `seqid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `value` varchar(100) NOT NULL DEFAULT '',
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`seqid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `libfun_privilege` WRITE;
/*!40000 ALTER TABLE `libfun_privilege` DISABLE KEYS */;

INSERT INTO `libfun_privilege` (`seqid`, `type`, `name`, `value`, `remark`)
VALUES
	(2916,1,'foxdsp管理系统','0',NULL),
	(2917,1,'菜单管理','1',''),
	(2918,1,'系统配置','366',''),
	(2919,1,'系统配置维护','367',''),
	(2920,1,'系统数组维护','368',''),
	(2921,1,'用户管理','369',''),
	(2922,1,'角色管理','370',''),
	(2923,1,'权限管理','371',''),
	(2924,1,'基础配置','372',''),
	(3028,2,'foxdsp','/jf/orderInfo',''),
	(3029,2,'foxdsp','/jf/orderInfo/query',''),
	(3030,2,'foxdsp','/jf/orderInfo/genernalInfo','');

/*!40000 ALTER TABLE `libfun_privilege` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_role`;

CREATE TABLE `libfun_role` (
  `seqid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `no` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`seqid`,`no`),
  UNIQUE KEY `seqid` (`seqid`),
  KEY `NewIndex1` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;



# Dump of table libfun_roleprivilege
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_roleprivilege`;

CREATE TABLE `libfun_roleprivilege` (
  `seqid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `roleno` varchar(20) NOT NULL DEFAULT '',
  `privilegeid` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`seqid`,`roleno`,`privilegeid`),
  KEY `FK_roleprivilege` (`privilegeid`),
  KEY `FK_roleprivilege1` (`roleno`),
  CONSTRAINT `FK_roleprivilege` FOREIGN KEY (`privilegeid`) REFERENCES `libfun_privilege` (`seqid`),
  CONSTRAINT `FK_roleprivilege1` FOREIGN KEY (`roleno`) REFERENCES `libfun_role` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table libfun_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_users`;

CREATE TABLE `libfun_users` (
  `SeqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserLogNo` varchar(30) NOT NULL DEFAULT '',
  `UserPassword` varchar(50) NOT NULL DEFAULT '',
  `SuperMan` smallint(6) NOT NULL DEFAULT '1',
  `TrueName` varchar(10) NOT NULL DEFAULT '',
  `BindIp` varchar(100) DEFAULT '',
  `InUse` smallint(6) NOT NULL DEFAULT '1',
  `Tel` varchar(60) DEFAULT '',
  `Email` varchar(512) NOT NULL DEFAULT '',
  `CopartnerNo` varchar(20) DEFAULT '',
  PRIMARY KEY (`SeqId`,`UserLogNo`),
  KEY `users_idx1` (`UserLogNo`),
  KEY `users_idx3` (`InUse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `libfun_users` WRITE;
/*!40000 ALTER TABLE `libfun_users` DISABLE KEYS */;

INSERT INTO `libfun_users` (`SeqId`, `UserLogNo`, `UserPassword`, `SuperMan`, `TrueName`, `BindIp`, `InUse`, `Tel`, `Email`, `CopartnerNo`)
VALUES
	(3307,'jinyangyang','b59c67bf196a4758191e42f76670ceba',1,'金阳阳','',1,'','jyydfad@qq.com','000619');

/*!40000 ALTER TABLE `libfun_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_usersext
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_usersext`;

CREATE TABLE `libfun_usersext` (
  `seqid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` bigint(20) unsigned DEFAULT NULL,
  `daily` bit(1) DEFAULT NULL,
  `weekly` bit(1) DEFAULT NULL,
  `activityOver` bit(1) DEFAULT NULL,
  PRIMARY KEY (`seqid`),
  UNIQUE KEY `unique_userID` (`usersId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `libfun_usersext` WRITE;
/*!40000 ALTER TABLE `libfun_usersext` DISABLE KEYS */;

INSERT INTO `libfun_usersext` (`seqid`, `usersId`, `daily`, `weekly`, `activityOver`)
VALUES
	(2,3307,NULL,NULL,NULL);

/*!40000 ALTER TABLE `libfun_usersext` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table libfun_usersrole
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_usersrole`;

CREATE TABLE `libfun_usersrole` (
  `seqid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL DEFAULT '',
  `roleno` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`seqid`,`username`,`roleno`),
  KEY `FK_usersrole` (`username`),
  KEY `FK_usersrole2` (`roleno`),
  CONSTRAINT `FK_usersrole` FOREIGN KEY (`username`) REFERENCES `libfun_users` (`UserLogNo`),
  CONSTRAINT `FK_usersrole2` FOREIGN KEY (`roleno`) REFERENCES `libfun_role` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;



# Dump of table libfun_v_users_ext
# ------------------------------------------------------------

DROP TABLE IF EXISTS `libfun_v_users_ext`;

CREATE TABLE `libfun_v_users_ext` (
  `seqid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` bigint(20) unsigned DEFAULT NULL,
  `daily` bit(1) DEFAULT NULL,
  `weekly` bit(1) DEFAULT NULL,
  `activityOver` bit(1) DEFAULT NULL,
  PRIMARY KEY (`seqid`),
  UNIQUE KEY `unique_userID` (`usersId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `libfun_syslog` (
  `seqid` bigint(20) NOT NULL AUTO_INCREMENT,
  `visit_time` datetime NOT NULL COMMENT '访问时间',
  `method` varchar(4) NOT NULL DEFAULT '' COMMENT '请求方法',
  `ip` varchar(128) DEFAULT NULL COMMENT 'ip地址',
  `url` text NOT NULL COMMENT '请求url',
  `userlogno` varchar(30) NOT NULL DEFAULT '' COMMENT '用户',
  `time` bigint(20) NOT NULL COMMENT '耗时',
  PRIMARY KEY (`seqid`),
  KEY `user_idx` (`userlogno`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统日志表';


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
