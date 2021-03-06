/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : openemm

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-03-05 00:25:33
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `actop_activate_doi_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_activate_doi_tbl`;
CREATE TABLE `actop_activate_doi_tbl` (
  `action_operation_id` int(11) NOT NULL,
  `for_all_lists` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_activate_doi_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `actop_execute_script_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_execute_script_tbl`;
CREATE TABLE `actop_execute_script_tbl` (
  `script` longtext COLLATE utf8_unicode_ci NOT NULL,
  `action_operation_id` int(11) NOT NULL,
  PRIMARY KEY (`action_operation_id`),
  KEY `IDX_AO1_AO` (`action_operation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_execute_script_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `actop_get_archive_list_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_get_archive_list_tbl`;
CREATE TABLE `actop_get_archive_list_tbl` (
  `campaign_id` int(11) NOT NULL,
  `action_operation_id` int(11) NOT NULL,
  PRIMARY KEY (`action_operation_id`),
  KEY `IDX_AO7_AO` (`action_operation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_get_archive_list_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `actop_get_customer_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_get_customer_tbl`;
CREATE TABLE `actop_get_customer_tbl` (
  `load_always` tinyint(1) NOT NULL,
  `action_operation_id` int(11) NOT NULL,
  PRIMARY KEY (`action_operation_id`),
  KEY `IDX_AO3_AO` (`action_operation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_get_customer_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `actop_send_mailing_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_send_mailing_tbl`;
CREATE TABLE `actop_send_mailing_tbl` (
  `mailing_id` int(11) NOT NULL,
  `delay_minutes` int(11) NOT NULL,
  `action_operation_id` int(11) NOT NULL,
  PRIMARY KEY (`action_operation_id`),
  KEY `IDX_AO5_AO` (`action_operation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_send_mailing_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `actop_service_mail_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_service_mail_tbl`;
CREATE TABLE `actop_service_mail_tbl` (
  `text_mail` text COLLATE utf8_unicode_ci NOT NULL,
  `subject_line` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `to_addr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mailtype` int(11) NOT NULL,
  `html_mail` text COLLATE utf8_unicode_ci NOT NULL,
  `action_operation_id` int(11) NOT NULL,
  PRIMARY KEY (`action_operation_id`),
  KEY `IDX_AO6_AO` (`action_operation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_service_mail_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `actop_subscribe_customer_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_subscribe_customer_tbl`;
CREATE TABLE `actop_subscribe_customer_tbl` (
  `double_check` tinyint(1) NOT NULL,
  `key_column` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `double_opt_in` tinyint(1) NOT NULL,
  `action_operation_id` int(11) NOT NULL,
  PRIMARY KEY (`action_operation_id`),
  KEY `IDX_AO4_AO` (`action_operation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_subscribe_customer_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `actop_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_tbl`;
CREATE TABLE `actop_tbl` (
  `action_operation_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`action_operation_id`),
  KEY `IDX_AO_A` (`action_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `actop_update_customer_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `actop_update_customer_tbl`;
CREATE TABLE `actop_update_customer_tbl` (
  `column_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `column_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `update_type` int(11) NOT NULL,
  `update_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action_operation_id` int(11) NOT NULL,
  PRIMARY KEY (`action_operation_id`),
  KEY `IDX_AO2_AO` (`action_operation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of actop_update_customer_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_group_permission_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `admin_group_permission_tbl`;
CREATE TABLE `admin_group_permission_tbl` (
  `admin_group_id` int(11) NOT NULL DEFAULT '4',
  `security_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  UNIQUE KEY `unique_admin_group_idx` (`admin_group_id`,`security_token`),
  KEY `admin_group_idx` (`admin_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of admin_group_permission_tbl
-- ----------------------------
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.ActivateDoubleOptIn');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.ExecuteScript');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.GetArchiveList');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.GetArchiveMailing');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.GetCustomer');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.SendMailing');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.ServiceMail');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.SubscribeCustomer');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.UnsubscribeCustomer');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'action.op.UpdateCustomer');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'actions.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'actions.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'actions.set_usage');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'actions.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'admin.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'admin.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'admin.new');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'admin.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'adminlog.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'blacklist');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'campaign.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'campaign.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'campaign.new');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'campaign.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'campaign.stat');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'charset.use.gb2312');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'charset.use.iso_8859_1');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'charset.use.iso_8859_15');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'charset.use.utf_8');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'cms.central_content_management');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'cms.mailing_content_management');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'company_mng.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'department_mng.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'forms.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'forms.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'forms.view');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.add');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.add_update');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.blacklist');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.bounce');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.doublechecking');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.null_values');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.only_update');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.remove_status');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'import.mode.unsubscribe');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.attachments.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.components.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.components.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.content.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.copy');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.default_action');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.graphics_upload');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.new');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.send.admin');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.send.admin.options');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.send.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.send.test');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.send.world');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.show.charsets');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailing.show.types');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailinglist.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailinglist.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailinglist.new');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailinglist.recipients.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailinglist.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailloop.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'mailloop.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'pluginmanager.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'profileField.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.column.select');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.create');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.export.auto');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.import.auto');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.list');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.new');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'recipient.view');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'settings.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'stats.clean');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'stats.domains');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'stats.ip');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'stats.mailing');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'stats.rdir');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'targets.advancedRules.recipients');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'targets.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'targets.createml');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'targets.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'targets.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'template.change');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'template.components.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'template.delete');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'template.new');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'template.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'update.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'use_charset_iso_8859_1');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'userlog.show');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'wizard.export');
INSERT INTO `admin_group_permission_tbl` VALUES ('4', 'wizard.import');

-- ----------------------------
-- Table structure for `admin_group_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `admin_group_tbl`;
CREATE TABLE `admin_group_tbl` (
  `admin_group_id` int(11) NOT NULL DEFAULT '0',
  `company_id` int(11) NOT NULL DEFAULT '0',
  `shortname` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`admin_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of admin_group_tbl
-- ----------------------------
INSERT INTO `admin_group_tbl` VALUES ('4', '1', 'Standard', 'Standard');
INSERT INTO `admin_group_tbl` VALUES ('0', '0', 'Dummy', 'Dummy');

-- ----------------------------
-- Table structure for `admin_permission_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission_tbl`;
CREATE TABLE `admin_permission_tbl` (
  `admin_id` int(11) NOT NULL DEFAULT '0',
  `security_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  UNIQUE KEY `admin_permission_unique_idx` (`admin_id`,`security_token`),
  KEY `admin_idx` (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of admin_permission_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_pref_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `admin_pref_tbl`;
CREATE TABLE `admin_pref_tbl` (
  `admin_id` int(11) DEFAULT '0',
  `pref` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `val` varchar(5) COLLATE utf8_unicode_ci DEFAULT '0',
  KEY `admin_id` (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of admin_pref_tbl
-- ----------------------------
INSERT INTO `admin_pref_tbl` VALUES ('3', 'mailing.contentblocks', '0');
INSERT INTO `admin_pref_tbl` VALUES ('3', 'listsize', '20');
INSERT INTO `admin_pref_tbl` VALUES ('3', 'mailing.settings', '0');
INSERT INTO `admin_pref_tbl` VALUES ('9', 'listsize', '20');
INSERT INTO `admin_pref_tbl` VALUES ('9', 'mailing.contentblocks', '0');
INSERT INTO `admin_pref_tbl` VALUES ('10', 'mailing.contentblocks', '0');
INSERT INTO `admin_pref_tbl` VALUES ('10', 'listsize', '20');
INSERT INTO `admin_pref_tbl` VALUES ('10', 'mailing.settings', '0');
INSERT INTO `admin_pref_tbl` VALUES ('11', 'mailing.contentblocks', '0');
INSERT INTO `admin_pref_tbl` VALUES ('11', 'listsize', '20');
INSERT INTO `admin_pref_tbl` VALUES ('11', 'mailing.settings', '0');
INSERT INTO `admin_pref_tbl` VALUES ('12', 'mailing.contentblocks', '0');
INSERT INTO `admin_pref_tbl` VALUES ('12', 'listsize', '20');
INSERT INTO `admin_pref_tbl` VALUES ('12', 'mailing.settings', '0');
INSERT INTO `admin_pref_tbl` VALUES ('13', 'listsize', '20');
INSERT INTO `admin_pref_tbl` VALUES ('13', 'mailing.contentblocks', '0');
INSERT INTO `admin_pref_tbl` VALUES ('14', 'listsize', '20');
INSERT INTO `admin_pref_tbl` VALUES ('14', 'mailing.contentblocks', '0');
INSERT INTO `admin_pref_tbl` VALUES ('9', 'mailing.settings', '0');
INSERT INTO `admin_pref_tbl` VALUES ('14', 'mailing.settings', '0');
INSERT INTO `admin_pref_tbl` VALUES ('13', 'mailing.settings', '0');

-- ----------------------------
-- Table structure for `admin_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `admin_tbl`;
CREATE TABLE `admin_tbl` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `company_id` int(11) NOT NULL DEFAULT '0',
  `fullname` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `admin_country` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `admin_lang` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `admin_lang_variant` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `admin_timezone` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `layout_id` int(11) NOT NULL DEFAULT '0',
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pwd_change` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `admin_group_id` int(11) NOT NULL DEFAULT '0',
  `pwd_hash` varbinary(200) NOT NULL DEFAULT '',
  `default_import_profile_id` int(11) NOT NULL DEFAULT '0',
  `com_id` int(11) NOT NULL DEFAULT '0',
  `department_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of admin_tbl
-- ----------------------------
INSERT INTO `admin_tbl` VALUES ('1', 'admin', '1', 'Administrator', '2017-03-04 19:02:37', 'US', 'en', '', 'Asia/Saigon', '0', '2014-11-16 21:55:52', '2014-11-16 21:55:52', '4', 0x9BD796996FCDF40AD3D86025C03F2C9E, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('2', 'trungns', '1', 'Nguyen Sy Trung', '2017-03-04 19:02:37', 'US', 'en', '', 'Europe/Berlin', '0', '2017-01-17 15:42:59', '2017-01-17 15:42:59', '0', 0x404183875D679DB7BF716B9A71D70FCD, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('3', 'Campaign_Admin', '1', 'Campaign_Admin', '2017-03-04 19:02:36', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-02-02 14:33:43', '2017-02-02 14:33:43', '0', 0xFD8A542E2F16B71D5E95BA26871F58EC, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('4', 'Reporter', '1', 'Reporter', '2017-03-04 19:02:36', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-02-02 14:36:03', '2017-02-02 14:36:03', '0', 0xFD8A542E2F16B71D5E95BA26871F58EC, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('5', 'u_level_1', '1', 'U Lever 1', '2017-03-04 19:02:36', 'US', 'en', '', 'Asia/Saigon', '0', '2017-02-02 19:13:07', '2017-02-02 19:13:07', '0', 0xCEEA23519F6F86AD67E9F798BF8002CB, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('6', 'u_level_11', '1', 'U lever 1', '2017-03-04 19:02:36', 'US', 'en', '', 'Pacific/Apia', '0', '2017-02-02 19:14:46', '2017-02-02 19:14:46', '0', 0xCEEA23519F6F86AD67E9F798BF8002CB, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('7', 'nganpt', '1', 'Phạm Thị Ngân', '2017-03-04 19:02:36', 'US', 'en', '', 'Asia/Saigon', '0', '2017-02-13 10:48:07', '2017-02-22 10:01:14', '0', 0x8A32D12366DF463A477FFE2D290DD772, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('8', 'ngochan', '1', 'fsdgasg', '2017-03-04 19:02:35', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-02-22 11:46:57', '2017-02-22 11:46:57', '0', 0xEA5CC7BBF0EA610F007F6DA57E34BA8C, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('9', 'admin1212', '1', 'aabbcc', '2017-03-04 23:20:21', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-03-04 19:51:52', '2017-03-04 23:20:11', '0', 0x4AF29B04ABA82D265B7A0A5CF14EB657, '0', '1', '2');
INSERT INTO `admin_tbl` VALUES ('10', 'adminhanoi', '1', 'ha noi 1', '2017-03-04 22:35:43', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-03-04 22:35:43', '2017-03-04 22:35:41', '0', 0xC030437F6E8E94D244BC602606DF5235, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('11', 'adminsaigon', '1', 'saigon', '2017-03-04 22:39:19', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-03-04 22:39:19', '2017-03-04 22:38:25', '0', 0xC030437F6E8E94D244BC602606DF5235, '0', '0', '0');
INSERT INTO `admin_tbl` VALUES ('12', 'test1212', '1', 'test1212', '2017-03-04 22:57:47', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-03-04 22:57:47', '2017-03-04 22:57:26', '0', 0xF8D53E6F9C407B59FEC1E9A59045A227, '0', '1', '2');
INSERT INTO `admin_tbl` VALUES ('13', 'testxxbb', '1', 'testxxbb', '2017-03-04 23:58:08', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-03-04 23:08:27', '2017-03-04 23:58:02', '0', 0x30A9D2D1657C89E3A15E6B0A00DC0C70, '0', '2', '39');
INSERT INTO `admin_tbl` VALUES ('14', 'testtest', '1', 'testtest', '2017-03-04 23:21:13', 'DE', 'de', '', 'Europe/Berlin', '0', '2017-03-04 23:12:40', '2017-03-04 23:21:07', '0', 0x4AF29B04ABA82D265B7A0A5CF14EB657, '0', '1', '2');

-- ----------------------------
-- Table structure for `auto_export_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `auto_export_tbl`;
CREATE TABLE `auto_export_tbl` (
  `auto_export_id` int(11) NOT NULL AUTO_INCREMENT,
  `export_profile_id` int(10) unsigned NOT NULL,
  `shortname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_path` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `file_server` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `one_time` int(1) NOT NULL,
  `executed` int(1) NOT NULL,
  `company_id` int(11) unsigned NOT NULL,
  `admin_id` int(11) NOT NULL,
  `active` int(1) NOT NULL DEFAULT '0',
  `auto_activation_date` timestamp NULL DEFAULT NULL,
  `allow_unknown_hostkeys` int(11) DEFAULT NULL,
  PRIMARY KEY (`auto_export_id`),
  KEY `company_id` (`company_id`),
  KEY `admin_id` (`admin_id`),
  KEY `export_profile_id` (`export_profile_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auto_export_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `auto_export_time_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `auto_export_time_tbl`;
CREATE TABLE `auto_export_time_tbl` (
  `auto_export_id` int(11) NOT NULL,
  `export_day_of_week` int(1) NOT NULL,
  `export_hour` int(2) NOT NULL,
  `company_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`auto_export_id`,`export_day_of_week`),
  KEY `company_id` (`company_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auto_export_time_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `auto_import_mlist_bind_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `auto_import_mlist_bind_tbl`;
CREATE TABLE `auto_import_mlist_bind_tbl` (
  `auto_import_id` int(11) NOT NULL,
  `mailinglist_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`auto_import_id`,`mailinglist_id`),
  KEY `company_id` (`company_id`),
  KEY `mailinglist_id` (`mailinglist_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auto_import_mlist_bind_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `auto_import_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `auto_import_tbl`;
CREATE TABLE `auto_import_tbl` (
  `auto_import_id` int(11) NOT NULL AUTO_INCREMENT,
  `import_profile_id` int(11) NOT NULL,
  `shortname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `file_path` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `file_server` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `one_time` int(1) NOT NULL,
  `auto_resume` int(1) NOT NULL,
  `executed` int(1) NOT NULL,
  `company_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `active` int(1) NOT NULL DEFAULT '0',
  `auto_activation_date` timestamp NULL DEFAULT NULL,
  `allow_unknown_hostkeys` int(11) DEFAULT NULL,
  PRIMARY KEY (`auto_import_id`),
  KEY `company_id` (`company_id`),
  KEY `admin_id` (`admin_id`),
  KEY `import_profile_id` (`import_profile_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auto_import_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `auto_import_time_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `auto_import_time_tbl`;
CREATE TABLE `auto_import_time_tbl` (
  `auto_import_id` int(11) NOT NULL,
  `import_day_of_week` int(1) NOT NULL,
  `import_hour` int(2) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`auto_import_id`,`import_day_of_week`),
  KEY `company_id` (`company_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auto_import_time_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `auto_import_used_files_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `auto_import_used_files_tbl`;
CREATE TABLE `auto_import_used_files_tbl` (
  `auto_import_used_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `auto_import_id` int(11) NOT NULL,
  `file_size` int(15) NOT NULL,
  `file_date` datetime NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`auto_import_used_file_id`),
  KEY `company_id` (`company_id`),
  KEY `auto_import_id` (`auto_import_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auto_import_used_files_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `bounce_collect_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `bounce_collect_tbl`;
CREATE TABLE `bounce_collect_tbl` (
  `mailtrack_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `mailing_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`mailtrack_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of bounce_collect_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `bounce_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `bounce_tbl`;
CREATE TABLE `bounce_tbl` (
  `bounce_id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) DEFAULT NULL,
  `customer_id` int(10) DEFAULT NULL,
  `detail` int(10) DEFAULT NULL,
  `mailing_id` int(10) DEFAULT NULL,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dsn` int(10) DEFAULT NULL,
  PRIMARY KEY (`bounce_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of bounce_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `campaign_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `campaign_tbl`;
CREATE TABLE `campaign_tbl` (
  `campaign_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT '0',
  `shortname` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`campaign_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of campaign_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `click_stat_colors_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `click_stat_colors_tbl`;
CREATE TABLE `click_stat_colors_tbl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `range_start` int(10) NOT NULL,
  `range_end` int(10) NOT NULL,
  `color` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of click_stat_colors_tbl
-- ----------------------------
INSERT INTO `click_stat_colors_tbl` VALUES ('1', '1', '0', '1', 'F4F9FF');
INSERT INTO `click_stat_colors_tbl` VALUES ('2', '1', '1', '2', 'D5E6FF');
INSERT INTO `click_stat_colors_tbl` VALUES ('3', '1', '2', '3', 'E1F7E1');
INSERT INTO `click_stat_colors_tbl` VALUES ('4', '1', '3', '5', 'FEFECC');
INSERT INTO `click_stat_colors_tbl` VALUES ('5', '1', '5', '10', 'FFE4BA');
INSERT INTO `click_stat_colors_tbl` VALUES ('6', '1', '10', '100', 'FFCBC3');

-- ----------------------------
-- Table structure for `company_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `company_tbl`;
CREATE TABLE `company_tbl` (
  `company_id` int(11) NOT NULL DEFAULT '0',
  `shortname` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `status` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_company_id` int(11) NOT NULL DEFAULT '0',
  `xor_key` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `notification_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `rdir_domain` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mailloop_domain` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mailtracking` int(11) unsigned NOT NULL DEFAULT '0',
  `max_login_fails` int(3) NOT NULL DEFAULT '3',
  `login_block_time` int(5) NOT NULL DEFAULT '300',
  `uid_version` int(2) DEFAULT NULL,
  `max_recipients` int(11) DEFAULT '10000',
  PRIMARY KEY (`company_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of company_tbl
-- ----------------------------
INSERT INTO `company_tbl` VALUES ('1', 'Agnitas Admin', 'Agnitas', 'active', '2014-11-16 21:55:52', '1', '', '2014-11-16 21:55:52', '', 'http://localhost:8080', '', '1', '3', '300', null, '10000');

-- ----------------------------
-- Table structure for `component_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `component_tbl`;
CREATE TABLE `component_tbl` (
  `component_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mailing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `emmblock` longtext COLLATE utf8_unicode_ci,
  `binblock` longblob,
  `comptype` int(10) unsigned NOT NULL DEFAULT '0',
  `target_id` int(10) unsigned NOT NULL DEFAULT '0',
  `mtype` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `compname` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url_id` int(1) unsigned NOT NULL DEFAULT '0',
  `description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`component_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of component_tbl
-- ----------------------------
INSERT INTO `component_tbl` VALUES ('1', '1', '1', '**********************************************************************\r\n[agnDYN name=\"0.1.1 Header-Text\"/]\r\n**********************************************************************\r\n[agnDYN name=\"0.2 date\"/]\r\n\r\n[agnTITLE type=1],\r\n\r\n[agnDYN name=\"0.3 Intro-text\"/]\r\n[agnDYN name=\"0.4 Greeting\"/]\r\n\r\n----------------------------------------------------------------------[agnDYN name=\"1.0 Headline ****\"]\r\n\r\n[agnDVALUE name=\"1.0 Headline ****\"]\r\n\r\n[agnDYN name=\"1.1 Sub-headline\"][agnDVALUE name=\"1.1 Sub-headline\"/]\r\n[/agnDYN name=\"1.1 Sub-headline\"][agnDYN name=\"1.2 Content\"/][agnDYN name=\"1.3 Link-URL\"]\r\n\r\n[agnDYN name=\"1.4 Link-Text\"/]\r\n[agnDVALUE name=\"1.3 Link-URL\"][/agnDYN name=\"1.3 Link-URL\"]\r\n\r\n----------------------------------------------------------------------[/agnDYN name=\"1.0 Headline ****\"][agnDYN name=\"2.0 Headline ****\"]\r\n\r\n[agnDVALUE name=\"2.0 Headline ****\"]\r\n\r\n[agnDYN name=\"2.1 Sub-headline\"][agnDVALUE name=\"2.1 Sub-headline\"/]\r\n[/agnDYN name=\"2.1 Sub-headline\"][agnDYN name=\"2.2 Content\"/][agnDYN name=\"2.3 Link-URL\"]\r\n\r\n[agnDYN name=\"2.4 Link-Text\"/]\r\n[agnDVALUE name=\"2.3 Link-URL\"][/agnDYN name=\"2.3 Link-URL\"]\r\n\r\n----------------------------------------------------------------------[/agnDYN name=\"2.0 Headline ****\"][agnDYN name=\"3.0 Headline ****\"]\r\n\r\n[agnDVALUE name=\"3.0 Headline ****\"]\r\n\r\n[agnDYN name=\"3.1 Sub-headline\"][agnDVALUE name=\"3.1 Sub-headline\"/]\r\n[/agnDYN name=\"3.1 Sub-headline\"][agnDYN name=\"3.2 Content\"/][agnDYN name=\"3.3 Link-URL\"]\r\n\r\n[agnDYN name=\"3.4 Link-Text\"/]\r\n[agnDVALUE name=\"3.3 Link-URL\"][/agnDYN name=\"3.3 Link-URL\"]\r\n\r\n----------------------------------------------------------------------[/agnDYN name=\"3.0 Headline ****\"]\r\n\r\nImpressum\r\n\r\nSie möchten Ihre Daten ändern?\r\n[agnDYN name=\"9.0 change-profil-URL\"/]\r\n\r\nUm den Newsletter abzubestellen, klicken Sie bitte hier:\r\n[agnDYN name=\"9.1 unsubscribe-URL\"/]\r\n\r\n[agnDYN name=\"9.2 imprint\"/]', null, '0', '0', 'text/plain', 'agnText', '0', null);
INSERT INTO `component_tbl` VALUES ('2', '1', '1', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table bgcolor=\"#808080\" width=\"684\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr>\r\n    <td>[agnDYN name=\"0.1 Header-image\"]\r\n    	<table width=\"680\" border=\"0\"  bgcolor=\"#FFFFFF\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n            <tr>\r\n              <td><img src=\"[agnDVALUE name=\"0.1 Header-image\"]\" width=\"680\" height=\"80\" alt=\"[agnDYN name=\"0.1.1 Header-Text\"/]\" border=\"0\"></td>\r\n            </tr>\r\n        </table>[/agnDYN name=\"0.1 Header-image\"]\r\n        <table width=\"680\" border=\"0\" bgcolor=\"#FFFFFF\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td><td align=\"right\"><div style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 10px;\">[agnDYN name=\"0.2 date\"/]</div></td><td width=\"10\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td>\r\n              <table width=\"660\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                 <tr><td><p><b>[agnTITLE type=1],</b></p><p>[agnDYN name=\"0.3 Intro-text\"/]</p><p>[agnDYN name=\"0.4 Greeting\"/]</p></td></tr>\r\n                 <tr><td><hr noshade></td></tr>\r\n              </table>[agnDYN name=\"1.0 Headline ****\"]\r\n              <table width=\"660\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n                 <tr>[agnDYN name=\"1.5 Image-URL\"]<td>[agnDYN name=\"1.3 Link-URL\"]<a href=\"[agnDVALUE name=\"1.3 Link-URL\"]\">[/agnDYN name=\"1.3 Link-URL\"]<img src=\"[agnDVALUE name=\"1.5 Image-URL\"]\" alt=\"Picture_1\">[agnDYN name=\"1.3 Link-URL\"]</a><!-- [agnDVALUE name=\"1.3 Link-URL\"] -->[/agnDYN name=\"1.3 Link-URL\"]</td>[/agnDYN name=\"1.5 Image-URL\"]\r\n                     <td valign=\"top\" align=\"left\"><h1>[agnDVALUE name=\"1.0 Headline ****\"]</h1>\r\n                     <p>[agnDYN name=\"1.1 Sub-headline\"]<b>[agnDVALUE name=\"1.1 Sub-headline\"/]</b><br>[/agnDYN name=\"1.1 Sub-headline\"][agnDYN name=\"1.2 Content\"/]</p>[agnDYN name=\"1.3 Link-URL\"]\r\n                     <p><a href=\"[agnDVALUE name=\"1.3 Link-URL\"]\">[agnDYN name=\"1.4 Link-Text\"/]</a></p>[/agnDYN name=\"1.3 Link-URL\"]</td>\r\n                     [agnDYN name=\"1.7 Image-URL-1\"]<td>[agnDYN name=\"1.6 Link-URL\"]<a href=\"[agnDVALUE name=\"1.6 Link-URL\"]\">[/agnDYN name=\"1.6 Link-URL\"]<img src=\"[agnDVALUE name=\"1.7 Image-URL-1\"]\" alt=\"Picture_2\">[agnDYN name=\"1.6 Link-URL\"]</a><!-- [agnDVALUE name=\"1.6 Link-URL\"] -->[/agnDYN name=\"1.6 Link-URL\"]</td>[/agnDYN name=\"1.7 Image-URL-1\"]\r\n                 <tr><td colspan=\"3\"><hr noshade></td></tr>\r\n              </table>[/agnDYN name=\"1.0 Headline ****\"][agnDYN name=\"2.0 Headline ****\"]\r\n              <table width=\"660\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n                 <tr>[agnDYN name=\"2.5 Image-URL\"]<td>[agnDYN name=\"2.3 Link-URL\"]<a href=\"[agnDVALUE name=\"2.3 Link-URL\"]\">[/agnDYN name=\"2.3 Link-URL\"]<img src=\"[agnDVALUE name=\"2.5 Image-URL\"]\" alt=\"Picture_1\">[agnDYN name=\"2.3 Link-URL\"]</a><!-- [agnDVALUE name=\"2.3 Link-URL\"] -->[/agnDYN name=\"2.3 Link-URL\"]</td>[/agnDYN name=\"2.5 Image-URL\"]\r\n                     <td valign=\"top\" align=\"left\"><h1>[agnDVALUE name=\"2.0 Headline ****\"]</h1>\r\n                     <p>[agnDYN name=\"2.1 Sub-headline\"]<b>[agnDVALUE name=\"2.1 Sub-headline\"/]</b><br>[/agnDYN name=\"2.1 Sub-headline\"][agnDYN name=\"2.2 Content\"/]</p>[agnDYN name=\"2.3 Link-URL\"]\r\n                     <p><a href=\"[agnDVALUE name=\"2.3 Link-URL\"]\">[agnDYN name=\"2.4 Link-Text\"/]</a></p>[/agnDYN name=\"2.3 Link-URL\"]</td>\r\n                     [agnDYN name=\"2.7 Image-URL-1\"]<td>[agnDYN name=\"2.6 Link-URL\"]<a href=\"[agnDVALUE name=\"2.6 Link-URL\"]\">[/agnDYN name=\"2.6 Link-URL\"]<img src=\"[agnDVALUE name=\"2.7 Image-URL-1\"]\" alt=\"Picture_2\">[agnDYN name=\"2.6 Link-URL\"]</a><!-- [agnDVALUE name=\"2.6 Link-URL\"] -->[/agnDYN name=\"2.6 Link-URL\"]</td>[/agnDYN name=\"2.7 Image-URL-1\"]\r\n                 <tr><td colspan=\"3\"><hr noshade></td></tr>\r\n              </table>[/agnDYN name=\"2.0 Headline ****\"][agnDYN name=\"3.0 Headline ****\"]\r\n              <table width=\"660\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n                 <tr>[agnDYN name=\"3.5 Image-URL\"]<td>[agnDYN name=\"3.3 Link-URL\"]<a href=\"[agnDVALUE name=\"3.3 Link-URL\"]\">[/agnDYN name=\"3.3 Link-URL\"]<img src=\"[agnDVALUE name=\"3.5 Image-URL\"]\" alt=\"Picture_1\">[agnDYN name=\"3.3 Link-URL\"]</a><!-- [agnDVALUE name=\"3.3 Link-URL\"] -->[/agnDYN name=\"3.3 Link-URL\"]</td>[/agnDYN name=\"3.5 Image-URL\"]\r\n                     <td valign=\"top\" align=\"left\"><h1>[agnDVALUE name=\"3.0 Headline ****\"]</h1>\r\n                     <p>[agnDYN name=\"3.1 Sub-headline\"]<b>[agnDVALUE name=\"3.1 Sub-headline\"/]</b><br>[/agnDYN name=\"3.1 Sub-headline\"][agnDYN name=\"3.2 Content\"/]</p>[agnDYN name=\"3.3 Link-URL\"]\r\n                     <p><a href=\"[agnDVALUE name=\"3.3 Link-URL\"]\">[agnDYN name=\"3.4 Link-Text\"/]</a></p>[/agnDYN name=\"3.3 Link-URL\"]</td>\r\n                     [agnDYN name=\"3.7 Image-URL-1\"]<td>[agnDYN name=\"3.6 Link-URL\"]<a href=\"[agnDVALUE name=\"3.6 Link-URL\"]\">[/agnDYN name=\"3.6 Link-URL\"]<img src=\"[agnDVALUE name=\"3.7 Image-URL-1\"]\" alt=\"Picture_2\">[agnDYN name=\"3.6 Link-URL\"]</a><!-- [agnDVALUE name=\"3.6 Link-URL\"] -->[/agnDYN name=\"3.6 Link-URL\"]</td>[/agnDYN name=\"3.7 Image-URL-1\"]\r\n                 <tr><td colspan=\"3\"><hr noshade></td></tr>\r\n              </table>[/agnDYN name=\"3.0 Headline ****\"]\r\n              <table width=\"660\" bgcolor=\"#D3D3D3\" border=\"0\" cellspacing=\"0\" cellpadding=\"5\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n                 <tr><td><h1>Impressum</h1>\r\n                 	 <p>Sie m&ouml;chten Ihre Daten &auml;ndern?<br><a href=\"[agnDYN name=\"9.0 change-profil-URL\"/]\">Newsletter-Profil &auml;ndern</a></p>\r\n                 	 <p>Um den Newsletter abzubestellen, klicken Sie bitte hier:<br><a href=\"[agnDYN name=\"9.1 unsubscribe-URL\"/]\">Newsletter abbestellen</a></p>\r\n                         <p>[agnDYN name=\"9.2 imprint\"/]</p></td></tr>\r\n              </table>              \r\n              </td>\r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\"><img src=\"[agnIMAGE name=\"clear.gif\"]\" width=\"8\" height=\"8\"></td>\r\n            </tr>            \r\n        </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, '0', '0', 'text/html', 'agnHtml', '0', null);
INSERT INTO `component_tbl` VALUES ('3', '1', '1', 'R0lGODdhAQABAIgAAP///wAAACwAAAAAAQABAAACAkQBADs=', 0x47494638376101000100880000FFFFFF0000002C00000000010001000002024401003B, '5', '0', 'image/gif', 'clear.gif', '0', null);
INSERT INTO `component_tbl` VALUES ('4', '1', '1', '/9j/4AAQSkZJRgABAQEAYABgAAD/4QBmRXhpZgAASUkqAAgAAAAEABoBBQABAAAAPgAAABsBBQAB\r\nAAAARgAAACgBAwABAAAAAgAAADEBAgAQAAAATgAAAAAAAABgAAAAAQAAAGAAAAABAAAAUGFpbnQu\r\nTkVUIHYzLjIyAP/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\r\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\r\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAFACqAMBIgACEQEDEQH/xAAf\r\nAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0BAgMABBEF\r\nEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4OTpDREVGR0hJ\r\nSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3\r\nuLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEB\r\nAAAAAAAAAQIDBAUGBwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIy\r\ngQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNk\r\nZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfI\r\nycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP3v+D/wf+Kf/BU74p/t\r\njfF/4v8A7Y37YfwK+E3wK/bD+PP7HnwF+Av7Hnx58Vfs0aJpWifs0eKv+FeeLvif8T/F3w7+weNP\r\niT45+JXjSw13VrCw1bXf+EY8HeGP7MsLDTLi/uHfSfoP/hzT8Pv+kgX/AAWG/wDFnn7Tv/zVUf8A\r\nBGn/AJJ9/wAFAv8AtMN/wU9/9ad8VV+wjsqKzuyoiKWd3IVVVQSzMxICqoBJJIAAJJxQB+Pf/Dmn\r\n4ff9JAv+Cw3/AIs8/ad/+aqj/hzT8Pv+kgX/AAWG/wDFnn7Tv/zVV9P/ABP/AOCin7NHw6mvNO0G\r\n/wDif8fvEFi08N14e/ZT+B/xh/ahvrK+hwradqt38C/BPjvSNFv0naK3uLPVtSs7uyknia8ggjcP\r\nX5h/HH/g4Z+EXwFaa9+LP7LP7aPwF8HwypG3xD+Pn7H37TPgTwmqMWYTyzX/AML7CZIpoyhiVPNn\r\nRhIJISRsAB9O/wDDmn4ff9JAv+Cw3/izz9p3/wCaqj/hzT8Pv+kgX/BYb/xZ5+07/wDNVXBfs+/8\r\nFkPh1+1P4dl8Wfs/eM/gr8VtFsmt/wC14vDOoa4uvaF9pMn2eHxJ4Z1HVLTxN4WubtYZWtIfEOia\r\nfNcIjTQwzRAk/XHhz9u6BpVj8XeApYoC0Qa78OaolxKi9JmXTtTjtkkbPzxKdUiH/LN348wgHgn/\r\nAA5p+H3/AEkC/wCCw3/izz9p3/5qqP8AhzT8Pv8ApIF/wWG/8WeftO//ADVV+nHw8+MXw9+KELN4\r\nS1+C5vYkMlzot4psdatYw5QySafPiSWAEKTc2hubZd8avMsjbK9OoA/Hn/hzT8Pv+kgX/BYb/wAW\r\neftO/wDzVV4N8XfgZ8W/+CYPxE/ZK+NXwT/bJ/bD+N/ww+LH7X/7PP7J/wC0B8Bv2x/j74q/aX8N\r\na/4P/af+Iek/CLQfiH8OPE/xEXUfG3w2+IHwz8ZeIvDviJIdB1+Lw54q0O31PSdX0xTJK+ofv/X5\r\nRf8ABXb/AJJR+xt/2ld/4Jb/APraXwloA/V2iiigAooooAKKKKACiiigAooooAKKKKACiiigAooo\r\noAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiig\r\nAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAC\r\niiigAooooA/Hn/gjT/yT7/goF/2mG/4Ke/8ArTviqv2BngguoJra5hiuLa4ikguLeeNJoJ4JkMcs\r\nM0UgaOWKWNmSSN1ZHRirAqSK/H7/AII0/wDJPv8AgoF/2mG/4Ke/+tO+Kq/YagBqqqKqIqoiKFRF\r\nAVVVQAqqoACqoAAAAAAAAxVPVI9Mm03UYtaSxl0eWxu49Wj1Rbd9Nk0x7eRb9NRS7BtXsXtTKt2t\r\nyDbtbmQTAxlqvV+O/wDwVj+O+t+FvDngz4H+GdRuNNbxzbX3ibxxPaXD291deF7OdtL0fQGaKXc+\r\nl65qY1W61aN44vO/sGxtVlmtLnUrZvf4YyCvxNnmAyWhUVF4upL2tdpS9hh6MJVsRWUHKHPKFKEn\r\nCnzRc58sLq9zxeIc7w/DuT43N8TTnVp4SEOWjTajOtWrVYUKNJSlpFSq1I887SdOmp1FCfLyv+ar\r\n/gq//wAE7/gT4Q/ax+H/AO2H/wAEY/ih8Pf2ff2h9M8UXcPxw8AaPaeI9B/Zq8X6dJE1zNrHh5PC\r\nXhvWNAX+2bqwt9I8ceCPDekXXw68aWOqW3iWxu/D/ijRtVm8TfsP8NvEuqeMfh/4O8Ua5YadpWu6\r\n1oNlc6/pWj6jPq2k6Z4hhDWXiDT9K1O7sdLvtQ0qz1u1v7fS9Qv9J0m91HTo7W/uNLsWuvs0f5u1\r\n9m/s/eItAs/At5Yar4g8N6Re2/ifUZEj1rxHoujTy2FxpuimAxW2p3tm8sKXceoH7RGJNzyNE7KI\r\nY1H67xz4V5XkHDcMfkv9p4zMcPisNTxHtJKv9Yo1oyp1JQw9GjF03Gt7OpFwcuSDnGfPdTh+VcGe\r\nJeY51xA8FnMsvwmCxOGryw0aVKVKNLE0YxqxjPEVsRK0J0IV3KVRyUqyhCmqfOor6e0bWdV8ParY\r\na3ol/c6Zq2mXMd3YX9pIY57aeM/K6NyGVgWSWJw0U0TPDMjxO6N+zvwB+LafF7wNDq90sEPiLSpx\r\npXiO1gQxRC+SFJYr63iZnMdrqELebEod1SZLmBW/ckD+dHxx+1h+yt8MtcPhn4iftO/s6+B/EYtL\r\ne/bQvFXxx+F+haulldmQWt0+n6j4pt7pILjypDBI0QWVULIWXBr9WP8AgnP4qtPHVjqvj7wHrFl4\r\n0+D/AI68Ovf+GPiH4Sv7XxH8PPFF/wCHPEdzoFyfDvi/R3vfD2tT6ffLr2lXo0vVJzbXum6hZXSf\r\nabGVLb8FnCdKc6dSEqdSEnCcJxcJwnF2lGcZJSjKLTTi0mmrNXP2ynUhVhGpSnCpTmuaE6clOEov\r\nZxlFuMk+6bR+o1flF/wV2/5JR+xt/wBpXf8Aglv/AOtpfCWv1dr8ov8Agrt/ySj9jb/tK7/wS3/9\r\nbS+EtSWfq7RRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRR\r\nRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFF\r\nABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAfjz/AMEaf+Sff8FA\r\nv+0w3/BT3/1p3xVX7DV+PP8AwRp/5J9/wUC/7TDf8FPf/WnfFVfsNQB+Sf8AwVk8B6V+0X8DvF/7\r\nIHxEW8j+Dvx08K6EPFt34duX0nxjBdeEfiBo3jGxbQtdkjvLKwaPVPDOgtMJtLvy9ubqIrF58ci/\r\niR+y/wD8E1v2eP2SfAms/Dv4X6h8S7/w9rni288aXZ8Z+K7DXNQi1m/0fQ9DuhbXlr4f0ox2b2Ph\r\n7TdttJHKI51mlR1891r+n39q/wCFF38RfAkGraFZveeJ/B0819ZW0ChrjUNKuxFHrFjCgUtLOqwW\r\n1/bx7gWNnLDEry3CqfyFruy7M8wynFRxuWYyvgcVCM4Rr4eo6dRQqLlnC63jJbxd07J2uk1yYzAY\r\nLMaP1fH4TD43D88ajoYqjTr0XON+WUqVSMoScbtx5ovldmrNJr5A+L3wl8LeCvB0HiDRH1IXbeJt\r\nL0eRLy6W4ia3vtL1+9d1CwxFZEl0mEA/MCsj9MDPzNX6I/F7R7/XPhn41s9G0X/hIfEEGg3uqeG9\r\nGjntLO61TxBo8f8AamlaRZ6hqE0FhptxrtzaLoJ1G9kFrZ2+qXE8/wC7QkfJn/BAf9pL9j7/AIKC\r\nfEP4qaD8R9J1/wCHX7VPwD8YTTWX7MXxHv8AS4zq3hPTLe3tLrxuLC50yxv/ABRqfhTxlHqmi+Kv\r\nCcSQjwTPY6He+I7XULfxNZR2X9A8H+K2X5fwtiJcRZhi8fnmGxWJ9jhpqpVxONoyjSnh3HEOn7Cn\r\nTVSc6UnUqOpTVOdRU5x5Yv8ADOL/AA2zHMeJabyDL8Fg8qr4bC+2q0vY4TCYOqnVp1W8PFxlUk40\r\no1JRwtGo25xdRQc+eX6JfCf/AIIUf8E7f2lfhh4C+MH7ZH7Knh74pfGzxX4eivLzxBrHjP4teHb+\r\nz8Jz3t7eeDtGn07wp4/8PaTHLa6Hd213PjSbW7hub+e0uzPNam4l/Zf9m/8AZt+CX7IvwY8G/s9f\r\ns6eBLP4Z/Bv4fLrq+DvA+n6r4g1qy0JfE3iXWPGGurb6j4p1fXNbmXUfEviDWdWlF3qdwI7i/mSA\r\nRQCOFPcaK/Ac3zOvnOaY/NcSoqvj8VWxVSMUlGDqzco042SvGnHlpxbXM1FOTcm2/wBvyrAQyvLM\r\nvy2nP2kMBgsNg1UcVB1fq9GFJ1XBOSjKq4upJc0rSk9XuFflF/wV2/5JR+xt/wBpXf8Aglv/AOtp\r\nfCWv1dr8ov8Agrt/ySj9jb/tK7/wS3/9bS+Etecd5+rtFFFABRRRQAV+Ov8AwV3/AGtf2sv2UIf2\r\nJL39kXwpa/Erxb8TP2ptW8N+Pvg82m6Pdaz8Zfhb4E/Z2+N/xr8X/DTwfqeq288vh7xz4ls/hkLb\r\nwZqumSQXjeJhpVhKLuwvLzT7v9iq/P79sb4CfE34vftAf8E2fHvgTRrTVPDP7Of7XHiv4sfFi9uN\r\nY0vTZdC8Eap+yn+0T8LbLUrOz1C6t7rW7iTxp8QfC2mtp2kRXl/HBfS6hJAtjZXc8IB4Trf7e958\r\nUf2n/wDgkGf2c/Hthqv7NH7cvhT9rrxf4ygbRNCvNQ8Q2Xwv+B2heMvBOmXV/c299q/hDxB4L8Y3\r\nWq6d4r0XStRsru31yw1Hw7r6zNp8ltH6h8OP+CqH7N/xN8beB9D0jwt8e9E+GPxZ8eyfCz4K/tOe\r\nL/hBrfhv9mz4z/EZtS1fSdK8KfDz4hXtydRvH8WahoOr23gLxFrvhnQPBnxCmtIYvBHiXX5dV0VN\r\nS/P/AMVf8Ep/jX4Q/wCCq/wR+Lnwbu9Itv8Agn3q0H7ZnxK8f+B9M1i08OeKf2eP2hv2nfgfd/Db\r\n4ka38Oov7SsNWufBPxq1238NeOF0jwzHdy+CviV/wm+uwpoGka7b+Z4l+zN/wTB+MHgHQP2S/wBm\r\n/wAdfsTajLF+zl8VvhZN42/aP8a/8FDf2i/Hn7L/AIm+Hf7P3ie08ReCPiP8H/2ZNG/aY0vxBovx\r\nf8QXHhTwnrnhfwN4y+Dei/Cr4ZeMneaU+IfD+nQWJAP2Ul/4KZfsrWfgn9lbxzrGveLtBtP2xP2g\r\n7v8AZf8AhBoOseDdUtfFkfxi0zxd4w+Huu6B4z0FDNceFrHw74/8Fal4K1zXLp59KsfEOoaBam5e\r\nDWbS5ah8Sf8Agpp+z74C8U+Ifh54f8OfGT40/FPR/jL4q+A+jfC34J/D9fGXjTx18QPh58M/BHxY\r\n+KUPg6O91rQtBm0T4WeFviF4Zh8e6/r+veHtN0jxDdv4dgmvtVRLeX8s/jX/AMErf2kPiF8af+Ch\r\ndxpumaSPhHB4R+K/x6/4J5Xsfi3w9B4ii/bM/aD1/wDZ++O/j2S6SeaG98F6f4Y/aH/Zb0W90/Wd\r\ncns9NuNI+NPiv7HM0Eepm27zxN+wB8XpP2S/2RtH+MP7JPgv9qP4mD4ofHL9pb9rLSvhx8YJfgR+\r\n1D8MP2h/2mL3xR8Sde8SfsrftA6D8Ufg/wCG9MTwL4x8Yaj8NPGSXnxB0e38eeB9D8JXmmS3DaUy\r\nOAfWNx+31qHxZ/aA/wCCbOn/AAUu/GHhD4a/tAfG39sf4R/Hr4d/E/4at4P+Iel+Jv2efgL8Ttdu\r\nPBXiLSvFGmSa34W1rwd8T/BcL3N74Y1JtL1+0gVrTV9b8P38Ms/o/wAOP+CqH7N/xN8beB9D0jwt\r\n8e9E+GPxZ8eyfCz4K/tOeL/hBrfhv9mz4z/EZtS1fSdK8KfDz4hXtydRvH8WahoOr23gLxFrvhnQ\r\nPBnxCmtIYvBHiXX5dV0VNS+EvhH+xF+3H4j8S/sSah+0JqXjnWvCXwt/aG/b38QSv8QfjboPxP8A\r\njp8Bv2bPjt+y745+E/wc8E/ED4v2F9aar8XfiVY+N/EupXbeJvDWqeMrzwzo2vaHo83iy9sfCcep\r\nJ8//ALM3/BMH4weAdA/ZL/Zv8dfsTajLF+zl8VvhZN42/aP8a/8ABQ39ovx5+y/4m+Hf7P3ie08R\r\neCPiP8H/ANmTRv2mNL8QaL8X/EFx4U8J654X8DeMvg3ovwq+GXjJ3mlPiHw/p0FiQD0+f/gtN8cY\r\nvgb+1B8VE/Z28Vpq/wAJ/wDgq98MP2I/B+k3nwr8QRWkXwh8cfF/4Z/DfUBrcCeOhd3vxw0vSdS8\r\nUNf2cd3a6FpvxA8Z/C/Rn0q60vVZIF/RP4g/8FVfgH8Pde8WaRL8L/2ovGel/CLRvDOs/tMeNPhx\r\n8CPEHjXwh+ykPEvgzSPiJJo3x3vtJvH1Kw8UeE/AmuaX4t8feF/h7pPxD17wRoN3Hf8AiKwsYWUn\r\n85vGn7DX7ZVr8If+Cgvws0D4JWXii88Rf8FZPhP/AMFH/gFrtp8Uvh1pml/HTwbaftF/Av4z+J/h\r\nfbQ6xrlnqPw48YeF9F+FWoaRdav4+tdM0DVNU1KJtEnv7S2E915/44/4J7ftD6H42/bG1qL9if4n\r\nftAan+2f4vv/ANoXwBqtl/wUq+K/wN+FXwW+Inxg+G/hDwz4++B37UXw1+H37Q3wyg8UeC/hn4v0\r\nC/uB40+B3hf4q3/xC+Hl3beGrP8AsI2Gk6Xo4B+yfir/AIKNfAXRP2ivA37L/hHQPjD8avid478M\r\nfBv4iW83wN+G2o/EnwV4Z+Efxw8QeJPDXhL4z+NPG+k3aeHvDnwpsdS8Ob/EHi65vJLa00/WtJ1P\r\nTYdWsY9bn0at/wAFKPj38Tf2cvgB4F8e/CfWbTQvE2uftcfsT/CfUb280fS9cim8EfGf9q34SfC3\r\n4g6atnq9reWsVxq3gvxXrem22oxRLf6XPcx6hp09tfW1vPH43+y7+xR45+Cn7WPxY1u+8N6R4Y+B\r\nWo/8E4/2E/2TPBGo/Dzxl4j0+O08R/s/aj+0fp/jPQvCEuq+MNb+MHh3S/DXh/x94Nbwn4r8R+Jb\r\n7xRLHdQz/wDCW6r4j0zUtRXhf22v2CvHenfsnX/hD9lw/H39on4iW37UH7FfxyPgj48ftZ/ED4mX\r\n+p6H+zn+0x8O/ix4m0rwb4t/aU+I+t6F4HudQ8MeH9a82Gz1LSLXXL+HS1v1vJrKwWIA/Uv43fGz\r\n4Y/s5fCnxp8bPjJ4ot/Bvw1+H+lx6t4n8QT2eo6k9tFc31ppOm2VhpOj2moaxrWs61rOoadomg6H\r\no9hfavretajYaVplndX15bwSfJ3wt/4KTfAjx34r8c+AviH4S+OH7LXjrwH8IfEf7Ql34T/an+GF\r\n58KdR8QfAbwddpYeMPiz4Vvo9S8Q6Bq/hvwddz2MXjLSm1i18a+DxqujzeKPCukQarYS3HzD+0jp\r\nP7dP7dX7P3xD+El3+xpe/sqeOPB2ufBX4/fB7xP8Tf2ivg9498B/ET4o/s9fHz4YfGPw/wDCDxba\r\n/BvV/FXibQfDnxCg8GX+h6v4muNLn0/Rrac3b299OkNlP4l+1t+z5+0L+3w/j74m/tNfDG7/AOCf\r\n3wR+B37BH7cfwmh1vxV8TvAHxU+I2s+OP2ofh54M0fxX8QIoPgfrnjrw/o/wi+D3hX4cXuptLf6t\r\nbfEPxtqmpRW9v4N0bT7SdrkA+5fg/wD8FTfgN8X/AIkfBL4ZD4YftQ/C3Uv2lk8R6l+z34i+NHwH\r\n8R/DrwZ8XvCHhT4Y698XNa8ceG/EOpXM8WlaJbeDtCW7/sjxpB4V8cl9b0GZvCCaZey6jaxfDj/g\r\nq1+zT8TPF3gHTNK8MfH3w/8ACz4wePofhX8Ef2nPG3wa8Q+FP2cfjP8AEm+1bUtD0Lwj4A8d6lKm\r\nsTXHi/VdH1Ox8B674j8K+HfCHj25toYPBviLXJ9T0ePUPzHvPi1+0B+0z8fP+CSvwN+N/wAKPhV8\r\nI9E8R6J+0ndx+N/hP+0F4X+NM/xY0bUP+CfHxv8Ah0PjV8FrPwlo8Fx4a+BTSeNN+ma98Rn0LxNe\r\na94o8DaNB4eElnql2/qujfs1ft4fEf8AZt/Yj/4J4fFH9nPwz4J8GfsufFD9kO6+K37W2lfGTwLf\r\nfDfx78Lv2HvHngbxt4Lv/g38OLTUNf8AjGnj/wCMDfCvwhp2p6H8SfBnhLw74ITW/Ed3/wAJHrbW\r\nGm2t0AfoT/wUs/az8QfsjfATwn4h8Ga/8OfBXjj4w/HD4Y/APwt8SvjBKY/hV8JF8d3mpat42+L3\r\nj1DqeiRX2i/DH4X+FfHfjS20i61zRrHW9b0bSNHv9St7O+nLfBPgf9vD9oHRf2Vf29Piz8GP2jPh\r\nH/wUkl/Z1+FNn4w+HWqWXwq1f4SfHrwn8Tbj/hLR4o8MfF/9nnwlo+gz+IPhTovh3RdO+JXw38S+\r\nGdP8KeKviNo2n+MvCmgN40u7ew8T2P3l/wAFJv2XPGn7Tfwl+D+pfDPSfDfiz4m/su/tSfBH9rzw\r\nF8OPGOpW+g+F/i1rHwW1XVH1P4Xap4outL1qDwpceMvCXiLxJp3h7xDdaZcaXY+Kv7CXX3s/Dk+r\r\n39r+dH7Sv7Df7Wv7eLfti/G3Wfg14d/Zs8R/En9mX4Dfs3/Db9m74ufE7wr4sj+N9v8ABv8AaRsf\r\n2lfG2oftAeIfgXqPjTwZ4X8J/EjS7e4/Z78M2Ok+J/iDq8Hg7xF431vxVZ6Rp2o2vhi7ALf7N3/B\r\nRr4geG/E/wC1Fqk/7Wnw5/4Kcfs2/Av9gHVv2z/Efx2+Enw88GfDZ/hz8SfD0mt6rZfs/wB9q/w2\r\nutZ8CXT/ABU8B6H4i8XeFtD1u3PxK+Hv/CFaxaeM21pNVsXtvZPhl8a/28/gl4+/YS8bftQ/GPwL\r\n8Yvhx+3rfz+APGvwq8PfBjQPhM37Mfxs8UfAnxb8fPhv4f8Ahb4rn8VSa/4z8FSSfD/xb8Jdas/i\r\nteaz4y1XWbzwr4psL/RYl13Q04HW/wBjH46/tm/G3xl4y8Xfsy6b/wAE7vhrP/wT3/ac/Yp16OLx\r\nt8JPH3xF+MmqftMWXg7TtG87w98D/EPiP4fw/CL9n9fDOueI/Cd14n13R/HWr+KvE8Vrp/hvQdAk\r\n1wS9l4N+Hn7efxl8X/sI+Hf2gv2Zbf4a+Bv2BbjWfi/8S/F0Xxi+E/xKm/ap+OvgT4C/ED4C/CfT\r\n/gTYx69ceI/D/hnXbv4h+Ifivq3iD45t8LNb0bUbfwt4anS+nGseIrIA+2/hT/wUT/Zn+NeufAzw\r\nf8Odc8Ua94++O8vxUXTvh0PC15aeOvhjD8Ebu90f4qXfxz8PXcsVz8JLfwh4rtIPBE3/AAlTW0+t\r\neMNW0fRfDMGtSXyyp+OX7OH/AAUw/ae8cfHH9mKy179oX4Y/En40fHv9qz4kfAz9oT/glv4d+F3h\r\njQfiX+xV8MPB0vxGl1/4k694xtdYufinZXvwa0rw14C1Lxt4m+KNufh/8VD4zubT4bWulXmp+Ere\r\nT3f9lj9iP9sz4C/tRav+2x4m8PfDfUfiD/wUK/4SPQf26/hr4Atfh1pF7+yvb2aanffs0+JPg542\r\nlbw5N8QbP4W6TLJ4P/aVtYNdvtV+LvjrXj8YfC+n69qGgw2V75J8J/2HP2rrD4SfsC/sb3n7Gnw2\r\n+EV/+xt+0Z8EPiZ4+/bx8PfFL4a3/h/x1oXwL8Wr4r8X+P8A4S+GVv8AxZ8fNU+KX7U9rBqGg/EX\r\nR/jF4R8O6Dpj/EHxtc6pr2vw2+kPKAerfFP9sD9tiy+Cn7S//BSPwT8VPB2mfs3fst/HH43eFNP/\r\nAGTL/wCC9o1v8ZvgF+zP8ZNW+DHxg8f698ade1HT/HnhL4iazN4Q+I/jPwJqXh2zT4e6DZaB4Z0v\r\nxL4a8Rpd+INRh+2Pi9/wVN+APwl+IPxu+HEHw7/aT+LWsfszReGNY/aK1T4JfBXWPiJ4c+DfgXxj\r\n8N/DHxU8O/EfxNq9lf2i6z4Z1Pwj4jubu10rwJD4v8fXB8JeM7m38FTaVoZ1K5+E/iN+yn+3HN8C\r\nf2rv+CaPhL4JaZqvwJ/aY+Pnxk1vwn+2Ld/FnwPe+D/hp+zd+1T8Wda+M3xp8NeNfhB4n1//AIWv\r\nq3xT8HXPjT4keA/B+geD/DN38PPE1trPhTxJd+LfDBt9e0yNmlfEf9qvwr+23/wWR+Gn7M/7KWi/\r\nHb/hK/F37M2k+HPEsnxS+Hfws8P/AA08da3+wr8F9A02X4tL4pu7DxTqPwphsIbHVLdvhZpnjvxZ\r\npsul+ItPtfBkcmuWWoMAfpd4z/4KQfsl/DuTxhL42+Ib+HNC8Nfs06B+1xoPi6/0yY+E/it8DPEN\r\nxHp9p4j+EGsW7zp471iHW9Q8MeHZvB1jFD4sudc8c+BrLStH1H/hKdLlm+x/BviRfGXhHwt4uXQv\r\nEnhhPFPh7RvESeG/GWkyaB4u0BNa0631FNG8U6DLJNNoniHTVuRZ6zpE8j3GmajDcWU586BwP5xf\r\niR/wSY/ae8f+Bv2OPgVoet+DfB/hf/gkn+zf8ENY/ZL+KWu2fg3xcf2of21fBWh+EBqVr8QfC+oW\r\n+r6t4O/Ze0ux+Hdp4T1fQLqTwx4t1nxN44g8Y2H9oRfCzwne3X9Efwv8QeM/Ffw58EeJPiN4Bufh\r\nZ4/1vwvo2o+NPhxd6/oHiuXwV4oubGF9d8OJ4n8LX2paB4htdM1I3NtY61pt15Op2SW949tYzzS2\r\nNuAd3RRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUU\r\nUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAfjz/wRp/5J9/wUC/7TDf8FPf/\r\nAFp3xVX7DV+PP/BGn/kn3/BQL/tMN/wU9/8AWnfFVfrhpmv6FrUuoQaPrWk6tPpNx9j1SHTNRs7+\r\nXTbshiLXUI7WaV7O4IRz5FyscuFb5flOADWr5L+MP7JvhP4i3l34i8N3n/CIeKbrdLdGOD7RoWrX\r\nLPua4vbJSk1pdSjKSXdhIsbH99NY3E5eR/rSigD8evEX7Ivxr0KWQWehWHiW2RiEu9C1eyYOv70h\r\nvsmpyabfBgkQLKLZxuljjRpHLBfx/wD2rv8AghFpP7SHxO0n9orwR4c+Nn7Lf7VXhzUbbW9E/aE/\r\nZ/vH8I+LJ9esEjg07WPElnbtDFquqWFsr28Ov6ReeGvF08Bgsr7xLd6ZZ22nx/2C1803H7Y/7Ltp\r\nPPa3Xxw8B211bTSW9zbXGqNDPbzwu0c0E8MkKyRTRSK0ckciq8bqysoYEV3YLLMyzJ1I5dl2OzB0\r\nVF1VgsJiMU6Sm2oOoqFOo4KbjJRcrczi0r2Zz4jGYTCcn1rFYfDe05uT6xXpUefltzcntJR5uXmj\r\nzWvbmV7XR+MHwA+C/wDwcNfDaxsPDGo/tu/s+/G/w5YRpaWvir9pj9juztfGVvYBttqmoz/Cj9on\r\n4Z6h4ivre0cedqeqNeajeXFsh1K7kuJ7iVv1O+GfwV/bc1Bra/8A2iv2zvD88sUpefwt+zB+z74R\r\n+FPhvUYSdrWeqa38ZNY/aI8ZmznhZkd/DWr+EdatpgtxZa7AwVE+odJ+Lnw11zxevgDS/GOjXHjV\r\n9AtPFCeF2mkttak8P31pZX1rqkdjdxQTSW8lrqFpMditJGryCWNGt7hYiX4u/DSDxV4p8DS+MtFH\r\ni/wT4cm8X+KvDgnd9W0Twzb22nXk2s3lokbSCyS21bTZd8QkZhewKql22hPLMyjN03l+NVSOHWLl\r\nB4SuprCSnGnHFOLp8yw8qko01Wa9m5yjFS5mkP6zhuVz+sUOVVZUXL2tPlVaN+ak3zWVWNnzU2+Z\r\nWd0rM7+2t47S2t7WJp3itoIreNrm5ub25aOGNY0a4vLyWe8u52VQZbm6nmuZ5C0s8skru7flT/wV\r\n2/5JR+xt/wBpXf8Aglv/AOtpfCWv0f0H4p/DvxR4Hu/iV4d8Y6FrXgOws9Y1C98UadeJc6VaWnh9\r\nbh9ZmuJowXiGnR2s8lwjoJFiQSBGR42b8uf+ConjTwr8QvgJ+xL4w8E69p3ibwxq/wDwVd/4Jh/2\r\nZrelTfaLC9/s/wDbh+F+l3vkTYXf9m1Cyu7SXgbZreRf4c1FXBY2hGtKvhMVRjh8QsJXlVw9WnGh\r\ni3Gc1haznCKp4hxp1JKjNxqctOcuW0JNVCtRqez5K1KftqbrUuSpCXtaK5L1adm+emvaU71I3iva\r\nQ196N/2EooorlNQooooAKKKKACiiigAooooAKKKKACiiigAooooAKinghuYZra5hiuLe4ikgngnj\r\nSWGeGVDHLDNFIGSSKRGZJI3VkdGKsCCRUtFAHg3wp/ZX/Zh+A+va54q+B37OPwG+DPifxNZtp3iT\r\nxH8KfhB8Pvh3r3iDT2vE1FrHXNY8IeHtH1DVrNtQjjv2tr+4uITeRpdFPPVXHvNFFABRRRQAUUUU\r\nAFFFFABXK6L4E8D+G/EfjLxh4d8G+FNB8W/EW80XUfiD4p0Xw9pGl+I/HeoeHNEtPDPh6+8Za3Y2\r\ncGp+J7zQfDdhY+H9Fudbur6fS9EsrTSbF4LC2ht06qigAooooAKKKKACiiigAooooAKKKKACiiig\r\nAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAC\r\niiigAooooAKKKKACiiigD+R/xF4b/aH8W/8ABIj/AILM6F+zJD8Rr74h3n/BXX/goA3iDRfg7JdR\r\nfFvxJ8GoP26ref48+Gvhs1iPt03ivXfg5H420+zsNOI1TVrae80jSRJql/ZxSc34K0r/AIJ5eL/2\r\n0f8Agmhc/wDBD34VXPw++JngP4uSTftmeKPhF8Jvir8IvBXhv9iIfDnxMPiV4I/a41nxXoHhrTPE\r\nvxI8Q+Lf+ELt/h7afEC48S/ESDxrpN/ex31lqJ068uv0F+Bnxd+In/BMH4t/tk/BL41fslftf/Fj\r\n4YfG/wDbD+Pv7Y/wG/aA/ZP/AGefiH+0/wCENf8ADX7S/ipfiJ4n+HHxD0H4RaT4i8Z/DP4gfDbx\r\ntqOv6DCniLw7b6H4q8ORaZq+k6nIVeXUPqL/AIe7fCj/AKM2/wCCrv8A4q3/AG0v/nS0AfiL/wAE\r\n3fhL/wAFcPjH8Bv2bf2vPEf7T3jLwv8ADuzHxt8YfGLVfiH+2b+0H8WvHXxj+Huhj4x+DbbwF/wy\r\n74w+Beh/Dn4S+Io9bsPDN7pPj7Qvjtq2seH7bw9Dr2nWt5qWsyWGm+Ff8E9v2p/H/jD9kzxT4p+N\r\nf7avxvuf2uD+w3+0F4q+HHgmy/bP/a8+IPi7xL8ZdH/Z3+K+v6pN8TPg346+Bnw6+GHwy8S+ENK0\r\n1vGnhLT/AAZ8SviMun+MtBtJdP12C+07S4da/ov/AOHu3wo/6M2/4Ku/+Kt/20v/AJ0tH/D3b4Uf\r\n9Gbf8FXf/FW/7aX/AM6WgD8ev2W/2if+CnHgX49/8EZf2Xv2sNW+JHjzwV8UNZ174u6T+1/4V1zX\r\ndM8O/tB/BrxJ+xd8S/Glv8Ef2q/D/wDabz2Pxt+D3xf1T4fW9tqWsG50L4oadb6DrtoLbxHF4ktt\r\nW/Vj9mP4p+Gvh74XsbHxj8Ybvw1Z2nxA8fapf/DtP2e/EniF7jS7/wAc67fQCXx5p3h3VXvP7bs5\r\notRt7+yl/wBCsru1sY4ibQyS9b/w92+FH/Rm3/BV3/xVv+2l/wDOlo/4e7fCj/ozb/gq7/4q3/bS\r\n/wDnS17GW5pHA4fGYadCdWGLq4Sq5U6tCnOEsJ9Z5VbEYPG0pxn9YbknSUk4RtKzkn8/m+QxzXHZ\r\nZjZV4Q/s2GMiqFSjWqUq8sVUwNWLquhjMJJwpSwK5qMnOlXVTlrRdOMoVOX+J+ga7q/7RPxk/aJ+\r\nEH26/wDF3we8DfAX4jeC9MtZb/S7P4g/D+48Pa1dfEfwY9kYEnuRqnhKbSLpbRLGXVbS8Gk2MFtD\r\nd6rDHLR8FfCnxp8Pfj58Vtd8ei4v/HXxG/YR+Jvj/wCJutWyXsnh+Px/4o+Jc0knh3SJpg9tZ23h\r\n3w3pmh6FZ6bDMVFtpBvIlMU5c9t/w92+FH/Rm3/BV3/xVv8Atpf/ADpaP+Hu3wo/6M2/4Ku/+Kt/\r\n20v/AJ0tfQR43xccu/s2OCoezll1PLJ15TviZYWjRw8KNH2qpJqhDEUq2NlR1jPE4jnk7UqaXhQ4\r\nHjGWIm8zm/rGa4vN3RjhKccJRxeLqV+epQoqs6kaqw1WGDVSeIqWoUnGnGmq1WMvLvg/8D/ic3g3\r\n4X/ArQXuIP2ff2gPAfgX4r/FjVL/AFHV49R8HS+ELPRYPjH8PtJmEhj0S48fa5c+GfMVmtrmyF14\r\nlsRbvaWF19i+ffjRp9/pf/BOX/gmxY6nZXenX0H/AAVd/wCCe/n2d9bTWl1D5v8AwUj8NzR+bb3C\r\nRzR+ZDJHKm9BvjdHXKspP2n/AMPdvhR/0Zt/wVd/8Vb/ALaX/wA6WvmH46/HX4m/8FLPib+yL8Bf\r\ngL+yL+2H8Lvh98Lv2w/2b/2svj/8f/2sv2b/AIjfsx+AvCvgL9mP4jab8XtM8C+BdM+L2m+FvF/x\r\nJ+I/xJ8X+FvD/ha0tPC3h++0nwvpN9f69r1/FbRKqY57xlis9wOIwFbCUaEMRmlDNqlSnO9Spi6N\r\nPM8O6tV+zh7WtWwmNwuHq1pWco5bRkop1JKPdkPCccir4Osswq4xYPL8bl1ONahGEo0sZWyzEuFO\r\ncKjVPD0cRgMTVo0HCbh9fqU41VSoU4P9+6KKK+NPrwooooAKKKKACiiigAooooAKKKKACiiigAoo\r\nooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii\r\ngAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA\r\nCiiigAooooA//9k=', 0xFFD8FFE000104A46494600010101006000600000FFE1006645786966000049492A000800000004001A010500010000003E0000001B010500010000004600000028010300010000000200000031010200100000004E00000000000000600000000100000060000000010000005061696E742E4E45542076332E323200FFDB00430001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101FFDB00430101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101FFC0001108005002A803012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FDEFF83FF07FE29FFC153BE29FED8DF17FE2FF00ED8DFB61FC0AF84DF02BF6C3F8F3FB1E7C05F80BFB1E7C79F157ECD1A2695A27ECD1E2AFF8579E2EF89FF13FC5DF0EFEC1E34F893E39F895E34B0D7756B0B0D5B5DFF8463C1DE18FECCB0B0D32E2FEE1DF49FA0FFE1CD3F0FBFE9205FF000586FF00C59E7ED3BFFCD551FF000469FF00927DFF000502FF00B4C37FC14F7FF5A77C555FB08ECA8ACEECA888A59DDC85555504B3331202AA8049248000249C5007E3DFFC39A7E1F7FD240BFE0B0DFF008B3CFDA77FF9AAA3FE1CD3F0FBFE9205FF000586FF00C59E7ED3BFFCD557D3FF0013FF00E0A29FB347C3A9AF34ED06FF00E27FC7EF1058B4F0DD787BF653F81FF187F6A1BEB2BE870ADA76AB77F02FC13E3BD2345BF49DA2B7B8B3D5B52B3BBB292789AF2082370F5F987F1C7FE0E19F845F015A6BDF8B3FB2CFEDA3F017C1F0CA91B7C43F8F9FB1F7ED33E04F09AA316613CB35FF00C2FB099229A3286254F36746120921246C001F4EFF00C39A7E1F7FD240BFE0B0DFF8B3CFDA77FF009AAA3FE1CD3F0FBFE9205FF0586FFC59E7ED3BFF00CD55705FB3EFFC1643E1D7ED4FE1D97C59FB3F78CFE0AFC56D16C9ADFF00B5E2F0CEA1AE2EBDA17DA4C9F6787C49E19D4754B4F13785AE6ED6195AD21F10E89A7CD7088D3430CD1024FD71E1CFDBBA069563F17780A58A02D106BBF0E6A89712A2F499974ED4E3B6491B3F3C4A754887FCB377E3CC201E09FF000E69F87DFF004902FF0082C37FE2CF3F69DFFE6AA8FF008734FC3EFF00A4817FC161BFF1679FB4EFFF003555FA71F0F3E317C3DF8A10B3784B5F82E6F624325CE8B78A6C75AB58C3943249A7CF89258010A4DCDA1B9B65DF1ABCCB236CAF4EA00FC79FF8734FC3EFFA4817FC161BFF001679FB4EFF00F3555E0DF177E067C5BFF8260FC44FD92BE357C13FDB27F6C3F8DFF0C3E2C7ED7FFB3CFEC9FF00B407C06FDB1FE3EF8ABF697F0D6BFE0FFDA7FE21E93F08B41F887F0E3C4FF111751F1B7C36F881F0CFC65E22F0EF88921D075F8BC39E2AD0EDF53D2757D314C92BEA1FBFF5F945FF000576FF009251FB1B7FDA577FE096FF00FADA5F096803F5768A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00FC79FF8234FFC93EFF82817FDA61BFE0A7BFF00AD3BE2AAFD819E082EA09ADAE618AE2DAE22920B8B79E349A09E0990C72C33452068E58A58D99248DD591D18AB02A48AFC7EFF008234FF00C93EFF0082817FDA61BFE0A7BFFAD3BE2AAFD86A006AAAA2AA22AA22285445015555400AAAA000AAA0000000000003154F548F4C9B4DD462D692C65D1E5B1BB8F568F545B77D364D31EDE45BF4D452EC1B57B17B532ADDADC836ED6E641303196ABD5F8EFF00F0563F8EFADF85BC39E0CF81FE19D46E34D6F1CDB5F789BC713DA5C3DBDD5D785ECE76D2F47D019A29773E97AE6A6355BAD5A378E2F3BFB06C6D5659AD2E752B66F7F86320AFC4D9E60325A1515178BA92F6B5DA52F6187A30956C4565072873CA14A1270A7CD1739F2C2EAF73C5E21CEF0FC3B93E3737C4D39D5A784843968D36A33AD5AB55850A3494A5A454AAD48F3CED274E9A9D4509F2F2BFE6ABFE0ABFFF0004EFF813E10FDAC7E1FF00ED87FF000463F8A1F0F7F67DFDA1F4CF145DC3F1C3C01A3DA788F41FD9ABC5FA749135CCDAC78793C25E1BD63405FED9BAB0B7D23C71E08F0DE9175F0EBC6963AA5B7896C6EFC3FE28D1B559BC4DFB0FF0DBC4BAA78C7E1FF83BC51AE5869DA56BBAD6836573AFE95A3EA33EADA4E99E218435978834FD2B53BBB1D2EFB50D2ACF5BB5BFB7D2F50BFD2749BDD474E8ED6FEE34BB16BAFB347F9BB5F66FECFDE22D02CFC0B7961AAF883C37A45EDBF89F519123D6BC47A2E8D3CB6171A6E8A60315B6A77B66F2C29771EA07ED1189373C8D13B2886351FAEF1CF85795E41C370C7E4BFDA78CCC70F8AC353C47B492AFF58A35A32A75250C3D1A3174DC6B7B3A917072E4839C67CF75387E55C19E25E639D7103C16732CBF0982C4E1ABCB0D1A54A54A34B134631AB18CF115B112B4274215DCA551C94AB28429AA7CEA2BE9ED1B59D57C3DAAD86B7A25FDCE99AB699731DDD85FDA48639EDA78CFCAE8DC86560592589C345344CF0CC8F13BA37ECEFC01F8B69F17BC0D0EAF74B043E22D2A71A5788ED60431442F9214962BEB78999CC76BA842DE6C4A1DD5264B9815BF7240FE747C71FB587ECADF0CB5C3E19F889FB4EFECEBE07F118B4B7BF6D0BC55F1C7E17E85ABA595D9905ADD3E9FA8F8A6DEE920B8F2A43048D1059550B2165C1AFD58FF008273F8AAD3C7563AAF8FBC07AC5978D3E0FF008EBC3AF7FE18F887E12BFB5F11FC3CF145FF00873C4773A05C9F0EF8BF477BDF0F6B53E9F7CBAF6957A34BD52736D7BA6EA165749F69B1952DBF059C274A73A75212A75212709C271709C271769467192528CA2D34E2D269AB3573F6CA75215611A94A70A94E6B9A13A725384A2F671945B8C93EE9B47EA357E517FC15DBFE4947EC6DFF00695DFF00825BFF00EB697C25AFD5DAFCA2FF0082BB7FC928FD8DBFED2BBFF04B7FFD6D2F84B5259FABB4514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145007E3CFF00C11A7FE49F7FC140BFED30DFF053DFFD69DF1557EC357E3CFF00C11A7FE49F7FC140BFED30DFF053DFFD69DF1557EC35007E49FF00C1593C07A57ED17F03BC5FFB207C445BC8FE0EFC74F0AE843C5B77E1DB97D27C6305D7847E2068DE31B16D0B5D923BCB2B068F54F0CE82D309B4BBF2F6E6EA22B179F1C8BF891FB2FF00FC135BF678FD927C09ACFC3BF85FA87C4BBFF0F6B9E2DBCF1A5D9F19F8AEC35CD422D66FF47D0F43BA16D796BE1FD28C766F63E1ED376DB491CA239D66951D7CF75AFE9F7F6AFF0085177F117C0906ADA159BDE789FC1D3CD7D656D0286B8D434ABB1147AC58C2814B4B3AAC16D7F6F1EE058D9CB0C4AF2DC2A9FC85AEECBB33CC329C5471B96632BE071508CE11AF87A8E9D450A8B9670BADE325BC5DD3B276BA4D726330182CC68FD5F1F84C3E370FCF1A8E862A8D3AF45CE37E594A9548CA1271BB71E68BE5766ACD26BE40F8BDF097C2DE0AF0741E20D11F52176DE26D2F47912F2E96E226B7BED2F5FBD7750B0C4564497498403F302B23F4C0CFCCD5FA23F17B47BFD73E19F8D6CF46D17FE121F1041A0DEEA9E1BD1A39ED2CEEB54F1068F1FF006A695A459EA1A84D05869B71AEDCDA2E82751BD905AD9DBEA9713CFF00BB4247C99FF0407FDA4BF63EFF0082827C43F8A9A0FC47D275FF00875FB54FC03F184D3597ECC5F11EFF004B8CEADE13D32DEDED2EBC6E2C2E74CB1BFF00146A7E14F1947AA68BE2AF09C4908F04CF63A1DEF88ED750B7F13594765FD03C1FE2B65F97F0B6225C459862F1F9E61B1589F63869AA957138DA328D29E1DC710E9FB0A74D549CE949D4A8EA5354E751539C7962FF000CE2FF000DB31CC78969BC832FC160F2AAF86C2FB6AB4BD8E130983AA9D5A755BC3C5C65524E34A35251C2D1A8DB9C5D45073E797E897C27FF0082147FC13B7F695F861E02F8C1FB647ECA9E1EF8A5F1B3C57E1E8AF2F3C41AC78CFE2D7876FECFC273DEDEDE783B469F4EF0A78FFC3DA4C72DAE87776D773E349B5BB86E6FE7B4BB33CD6A6E25FD97FD9BFF0066DF825FB22FC18F06FECF5FB3A7812CFE19FC1BF87CBAEAF83BC0FA7EABE20D6ACB425F13789758F186BAB6FA8F8A757D735B99751F12F88359D5A5177A9DC08EE2FE648045008E14F71A2BF01CDF33AF9CE698FCD712A2ABE3F155B15523149460EACDCA34E364AF1A71E5A716D733514E4DC9B6FF006FCAB010CAF2CCBF2DA73F690C060B0D83551C541D5FABD1852755C13928CAAB8BA925CD2B4A4F57B857E517FC15DBFE4947EC6DFF00695DFF00825BFF00EB697C25AFD5DAFCA2FF0082BB7FC928FD8DBFED2BBFF04B7FFD6D2F84B5E71DE7EAED14514005145140057E3AFF00C15DFF006B5FDACBF65087F624BDFD917C296BF12BC5BF133F6A6D5BC37E3EF83CDA6E8F75ACFC65F85BE04FD9DBE37FC6BF17FC34F07EA7AADBCF2F87BC73E25B3F8642DBC19AAE9924178DE261A5584A2EEC2F2F34FBBFD8AAFCFEFDB1BE027C4DF8BDFB407FC1367C7BE04D1AD354F0CFECE7FB5C78AFE2C7C58BDB8D634BD365D0BC11AA7ECA7FB44FC2DB2D4ACECF50BAB7BAD6EE24F1A7C41F0B69ADA769115E5FC705F4BA84902D8D95DCF080784EB7FB7BDE7C51FDA7FF00E09067F673F1ED86ABFB347EDCBE14FDAEBC5FE3281B44D0AF350F10D97C2FF81DA178CBC13A65D5FDCDBDF6AFE10F10782FC6375AAE9DE2BD174AD46CAEEDF5CB0D47C3BAFACCDA7C96D1FA87C38FF82A87ECDFF137C6DE07D0F48F0B7C7BD13E18FC59F1EC9F0B3E0AFED39E2FF841ADF86FF66CF8CFF119B52D5F49D2BC29F0F3E215EDC9D46F1FC59A8683ABDB780BC45AEF86740F067C429AD218BC11E25D7E5D57454D4BF3FF00C55FF04A7F8D7E10FF0082ABFC11F8B9F06EEF48B6FF00827DEAD07ED99F12BC7FE07D3358B4F0E78A7F678FDA1BF69DF81F77F0DBE246B7F0EA2FED2B0D5AE7C13F1AB5DB7F0D78E1748F0CC7772F82BE257FC26FAEC29A0691AEDBF99E25FB337FC1307E30780740FD92FF0066FF001D7EC4DA8CB17ECE5F15BE164DE36FDA3FC6BFF050DFDA2FC79FB2FF0089BE1DFECFDE27B4F117823E23FC1FFD99346FDA634BF1068BF17FC4171E14F09EB9E17F0378CBE0DE8BF0ABE1978C9DE694F887C3FA74162403F6525FF82997ECAD67E09FD95BC73AC6BDE2ED06D3F6C4FDA0EEFF0065FF00841A0EB1E0DD52D7C591FC62D33C5DE30F87BAEE81E33D050CD71E16B1F0EF8FFC15A9782B5CD72E9E7D2AC7C43A86816A6E5E0D66D2E5A87C49FF00829A7ECFBE02F14F887E1E787FC39F193E34FC53D1FE32F8ABE03E8DF0B7E09FC3F5F1978D3C75F103E1E7C33F047C58F8A50F83A3BDD6B42D066D13E16785BE2178661F1EEBFAFEBDE1ED3748F10DDBF87609AFB5544B797F2CFE35FF00C12B7F690F885F1A7FE0A1771A6E99A48F84707847E2BFC7AFF82795EC7E2DF0F41E228BF6CCFDA0F5FF00D9FBE3BF8F64BA49E686F7C17A7F863F687FD96F45BDD3F59D727B3D36E348F8D3E2BFB1CCD047A99B6EF3C4DFB007C5E93F64BFD91B47F8C3FB24F82FF6A3F8983E287C72FDA5BF6B2D2BE1C7C6097E047ED43F0C3F687FDA62F7C51F1275EF127ECADFB40E83F147E0FF0086F4C4F02F8C7C61A8FC34F1925E7C41D1EDFC79E07D0FC2579A64B70DA5323807D6371FB7D6A1F167F680FF00826CE9FF00052EFC61E10F86BFB407C6DFDB1FE11FC7AF877F13FE1AB783FE21E97E26FD9E7E02FC4ED76E3C15E22D2BC51A649ADF85B5AF077C4FF05C2F737BE18D49B4BD7ED2056B4D5F5BF0FDFC32CFE8FF000E3FE0AA1FB37FC4DF1B781F43D23C2DF1EF44F863F167C7B27C2CF82BFB4E78BFE106B7E1BFD9B3E33FC466D4B57D274AF0A7C3CF8857B72751BC7F166A1A0EAF6DE02F116BBE19D03C19F10A6B4862F0478975F9755D15352F84BE11FEC45FB71F88FC4BFB126A1FB426A5E39D6BC25F0B7F686FDBDFC412BFC41F8DBA0FC4FF008E9F01BF66CF8EDFB2EF8E7E13FC1CF04FC40F8BF617D69AAFC5DF89563E37F12EA576DE26F0D6A9E32BCF0CE8DAF687A3CDE2CBDB1F09C7A927CFFF00B337FC1307E30780740FD92FF66FF1D7EC4DA8CB17ECE5F15BE164DE36FDA3FC6BFF00050DFDA2FC79FB2FF89BE1DFECFDE27B4F117823E23FC1FF00D99346FDA634BF1068BF17FC4171E14F09EB9E17F0378CBE0DE8BF0ABE1978C9DE694F887C3FA74162403D3E7FF82D37C718BE06FED41F1513F676F15A6AFF0009FF00E0ABDF0C3F623F07E9379F0AFC4115A45F087C71F17FE19FC37D406B70278E85DDEFC70D2F49D4BC50D7F671DDDAE85A6FC40F19FC2FD19F4ABAD2F559205FD13F883FF0555F807F0F75EF166912FC2FFDA8BC67A5FC22D1BC33ACFED31E34F871F023C41E35F087ECA43C4BE0CD23E2249A37C77BED26F1F52B0F14784FC09AE697E2DF1F785FE1EE93F10F5EF04683771DFF0088AC2C616527F39BC69FB0D7ED956BF087FE0A0BF0B340F82565E28BCF117FC1593E13FF00C147FE016BB69F14BE1D699A5FC74F06DA7ED17F02FE33F89FE17DB43AC6B967A8FC38F18785F45F855A869175ABF8FAD74CD0354D535289B449EFED2D84F75E7FE38FF827B7ED0FA1F8DBF6C6D6A2FD89FE277ED01A9FED9FE2FBFF00DA17C01AAD97FC14ABE2BFC0DF855F05BE227C60F86FE10F0CF8FBE077ED45F0D7E1F7ED0DF0CA0F14782FE19F8BF40BFB81E34F81DE17F8AB7FF10BE1E5DDB786ACFF00B08D8693A5E8E01FB27E2AFF00828D7C05D13F68AF037ECBFE11D03E30FC6AF89DE3BF0C7C1BF8896F37C0DF86DA8FC49F057867E11FC70F107893C35E12F8CFE34F1BE93769E1EF0E7C29B1D4BC39BFC41E2EB9BC92DAD34FD6B49D4F4D8756B18F5B9F46ADFF000528F8F7F137F672F801E05F1EFC27D66D342F136B9FB5C7EC4FF09F51BDBCD1F4BD7229BC11F19FF6ADF849F0B7E20E9AB67ABDADE5AC571AB782FC57ADE9B6DA8C512DFE973DCC7A869D3DB5F5B5BCF1F8DFECBBFB1478E7E0A7ED63F1635BBEF0DE91E18F815A8FFC138FF613FD933C11A8FC3CF19788F4F8ED3C47FB3F6A3FB47E9FE33D0BC212EABE30D6FE3078774BF0D787FC7DE0D6F09F8AFC47E25BEF144B1DD433FF00C25BAAF88F4CD4B515E17F6DAFD82BC77A77EC9D7FE10FD970FC7DFDA27E225B7ED41FB15FC723E08F8F1FB59FC40F8997FA9E87FB39FED31F0EFE2C789B4AF06F8B7F694F88FADE85E07B9D43C31E1FD6BCD86CF52D22D75CBF874B5BF5BC9ACAC16200FD4BF8DDF1B3E18FECE5F0A7C69F1B3E3278A2DFC1BF0D7E1FE971EADE27F104F67A8EA4F6D15CDF5A693A6D958693A3DA6A1AC6B5ACEB5ACEA1A7689A0E87A3D85F6AFADEB5A8D8695A659DD5F5E5BC127C9DF0B7FE0A4DF023C77E2BF1CF80BE21F84BE387ECB5E3AF01FC21F11FED0977E13FDA9FE185E7C29D47C41F01BC1D76961E30F8B3E15BE8F52F10E81ABF86FC1D773D8C5E32D29B58B5F1AF83C6ABA3CDE28F0AE9106AB612DC7CC3FB48E93FB74FEDD5FB3F7C43F84977FB1A5EFECA9E38F076B9F057E3F7C1EF13FC4DFDA2BE0F78F7C07F113E28FECF5F1F3E187C63F0FF00C20F16DAFC1BD5FC55E26D07C39F10A0F065FE87ABF89AE34B9F4FD1ADA7376F6F7D3A43653F897ED6DFB3E7ED0BFB7C3F8FBE26FED35F0C6EFF00E09FDF047E077EC11FB71FC26875BF157C4EF007C54F88DACF8E3F6A1F879E0CD1FC57F102283E07EB9E3AF0FE8FF08BE0F7857E1C5EEA6D2DFEAD6DF10FC6DAA6A515BDBF83746D3ED276B900FB97E0FF00FC1537E037C5FF00891F04BE190F861FB50FC2DD4BF6964F11EA5FB3DF88BE347C07F11FC3AF067C5EF087853E18EBDF1735AF1C786FC43A95CCF1695A25B783B425BBFEC8F1A41E15F1C97D6F4199BC209A65ECBA8DAC5F0E3FE0AB5FB34FC4CF1778074CD2BC31F1F7C3FF000B3E3078FA1F857F047F69CF1B7C1AF10F853F671F8CFF00126FB56D4B43D0BC23E00F1DEA52A6B135C78BF55D1F53B1F01EBBE23F0AF877C21E3DB9B6860F06F88B5C9F53D1E3D43F31EF3E2D7ED01FB4CFC7CFF824AFC0DF8DFF000A3E157C23D13C47A27ED27771F8DFE13FED05E17F8D33FC58D1B50FF827C7C6FF008743E357C16B3F0968F05C786BE05349E34DFA66BDF119F42F135E6BDE28F0368D078784967AA5DBFAAE8DFB357EDE1F11FF0066DFD88FFE09E1F147F673F0CF827C19FB2E7C50FD90EEBE2B7ED6DA57C64F02DF7C37F1EFC2EFD87BC79E06F1B782EFFE0DFC38B4D435FF008C69E3FF008C0DF0AFC21A76A7A1FC49F06784BC3BE084D6FC4777FF00091EB6D61A6DADD007E84FFC14B3F6B3F107EC8DF013C27E21F066BFF0E7C15E38F8C3F1C3E18FC03F0B7C4AF8C1298FE157C245F1DDE6A5AB78DBE2F78F50EA7A2457DA2FC31F85FE15F1DF8D2DB48BAD7346B1D6F5BD1B48D1EFF52B7B3BE9CB7C13E07FDBC3F681D17F655FDBD3E2CFC18FDA33E11FFC14925FD9D7E14D9F8C3E1D6A965F0AB57F849F1EBC27F136E3FE12D1E28F0C7C5FFD9E7C25A3E833F883E14E8BE1DD174EF895F0DFC4BE19D3FC29E2AF88DA369FE32F0A680DE34BBB7B0F13D8FDE5FF000526FD973C69FB4DFC25F83FA97C33D27C37E2CF89BFB2EFED49F047F6BCF017C38F18EA56FA0F85FE2D6B1F05B55D51F53F85DAA78A2EB4BD6A0F0A5C78CBC25E22F1269DE1EF10DD69971A5D8F8ABFB0975F7B3F0E4FABDFDAFE747ED2BFB0DFED6BFB78B7ED8BF1B759F835E1DFD9B3C47F127F665F80DFB37FC36FD9BBE2E7C4EF0AF8B23F8DF6FF0006FF00691B1FDA57C6DA87ED01E21F817A8F8D3C19E17F09FC48D2EDEE3F67BF0CD8E93E27F883ABC1E0EF1178DF5BF1559E91A76A36BE18BB00B7FB377FC146BE20786FC4FF00B516A93FED69F0E7FE0A71FB36FC0BFD80756FDB3FC47F1DBE127C3CF067C367F873F127C3D26B7AAD97ECFF007DABFC36BAD67C0974FF00153C07A1F88BC5DE16D0F5BB73F12BE1EFFC215AC5A78CDB5A4D56C5EDBD93E197C6BFDBCFE0978FBF612F1B7ED43F18FC0BF18BE1C7EDEB7F3F803C6BF0ABC3DF06340F84CDFB31FC6CF147C09F16FC7CF86FE1FF0085BE2B9FC5526BFE33F054927C3FF16FC25D6ACFE2B5E6B3E32D5759BCF0AF8A6C2FF458975DD0D381D6FF00631F8EBFB66FC6DF1978CBC5DFB32E9BFF0004EEF86B3FFC13DFF69CFD8A75E8E2F1B7C24F1F7C45F8C9AA7ED3165E0ED3B46F3BC3DF03FC43E23F87F0FC22FD9FD7C33AE788FC2775E27D7747F1D6AFE2AF13C56BA7F86F41D024D704BD97837E1E7EDE7F197C5FFB08F877F682FD996DFE1AF81BF605B8D67E2FFC4BF1745F18BE13FC4A9BF6A9F8EBE04F80BF103E02FC27D3FE04D8C7AF5C788FC3FE19D76EFE21F887E2BEADE20F8E6DF0B35BD1B51B7F0B786A74BE9C6B1E22B200FB6FE14FFC144FF667F8D7AE7C0CF07FC39D73C51AF78FBE3BCBF15174EF8743C2D7969E3AF8630FC11BBBDD1FE2A5DFC73F0F5DCB15CFC24B7F0878AED20F044DFF0009535B4FAD78C356D1F45F0CC1AD497CB2A7E397ECE1FF000530FDA7BC71F1C7F662B2D7BF685F863F127E347C7BFDAB3E247C0CFDA13FE096FE1DF85DE18D07E25FEC55F0C3C1D2FC46975FF893AF78C6D758B9F8A7657BF06B4AF0D780B52F1B789BE28DB9F87FF150F8CEE6D3E1B5AE9579A9F84ADE4F77FD963F623FDB33E02FED45ABFEDB1E26F0F7C37D47E20FFC142BFE123D07F6EBF86BE00B5F875A45EFECAF6F669A9DF7ECD3E24F839E3695BC3937C41B3F85BA4CB2783FF695B5835DBED57E2EF8EB5E3F187C2FA7EBDA86830D95EF927C27FD873F6AEB0F849FB02FEC6F79FB1A7C36F8457FFB1B7ED19F043E2678FBF6F1F0F7C52F86B7FE1FF1D685F02FC5ABE2BF17F8FF00E12F8656FF00C59F1F354F8A5FB53DAC1A8683F11747F8C5E11F0EE83A63FC41F1B5CEA9AF6BF0DBE90F2807AB7C53FDB03F6D8B2F829FB4BFFC148FC13F153C1DA67ECDDFB2DFC71F8DDE14D3FF0064CBFF0082F68D6FF19BE017ECCFF19356F831F183C7FAF7C69D7B51D3FC79E12F889ACCDE10F88FE33F026A5E1DB34F87BA0D9681E19D2FC4BE1AF11A5DF8835187ED8F8BDFF054DF803F097E20FC6EF87107C3BFDA4FE2D6B1FB3345E18D63F68AD53E097C15D63E227873E0DF817C63F0DFC31F153C3BF11FC4DABD95FDA2EB3E19D4FC23E23B9BBB5D2BC090F8BFC7D707C25E33B9B7F054DA5686752B9F84FE237ECA7FB71CDF027F6AEFF8268F84BE09699AAFC09FDA63E3E7C64D6FC27FB62DDFC59F03DEF83FE1A7ECDDFB54FC59D6BE337C69F0D78D7E10789F5FFF0085AFAB7C53F075CF8D3E24780FC1FA0783FC3377F0F3C4D6DACF853C4977E2DF0C1B7D7B4C8D9A57C47FDAAFC2BFB6DFFC1647E1A7ECCFFB2968BF1DBFE12BF177ECCDA4F873C4B27C52F877F0B3C3FF000D3C75ADFEC2BF05F40D365F8B4BE29BBB0F14EA3F0A61B086C754B76F859A678EFC59A6CBA5F88B4FB5F064726B965A83007E9778CFFE0A41FB25FC3B93C612F8DBE21BF87342F0D7ECD3A07ED71A0F8BAFF4C98F84FE2B7C0CF10DC47A7DA788FE106B16EF3A78EF58875BD43C31E1D9BC1D63143E2CB9D73C73E06B2D2B47D47FE129D2E59BEC7F06F8917C65E11F0B78B9742F1278613C53E1ED1BC449E1BF196932681E2ED0135AD3ADF514D1BC53A0CB24D3689E21D356E459EB3A44F23DC699A8C3716539F3A0703F9C5F891FF0498FDA7BC7FE06FD8E3E05687ADF837C1FE17FF8249FECDFF04358FD92FE296BB67E0DF171FDA87F6D5F05687E101A95AFC41F0BEA16FABEADE0EFD97B4BB1F87769E13D5F40BA93C31E2DD67C4DE3883C6361FDA117C2CF09DEDD7F447F0BFC41E33F15FC39F047893E237806E7E1678FF5BF0BE8DA8F8D3E1C5DEBFA078AE5F0578A2E6C617D77C389E27F0B5F6A5A07886D74CD48DCDB58EB5A6DD793A9D925BDE3DB58CF34B636E01DDD145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451401F8F3FF0469FF927DFF0502FFB4C37FC14F7FF005A77C555FB0D5F8F3FF0469FF927DFF0502FFB4C37FC14F7FF005A77C555FAE1A66BFA16B52EA1068FAD693AB4FA4DC7D8F54874CD46CEFE5D36EC8622D7508ED6695ECEE08473E45CAC72E15BE5F94E0035ABE4BF8C3FB26F84FE22DE5DF88BC3779FF08878A6EB74B746383ED1A16AD72CFB9AE2F6C94A4D697528CA49776122C6C7F7D358DC4E5E47FAD28A00FC7AF117EC8BF1AF42964167A1587896D91884BBD0B57B260EBFBD21BEC9A9C9A6DF0609102CA2D9C6E9638D1A472C17F1FF00F6AEFF008211693FB487C4ED27F68AF047873E367ECB7FB55787351B6D6F44FDA13F67FBC7F08F8B27D7AC123834ED63C49676ED0C5AAEA9616CAF6F0EBFA45E786BC5D3C060B2BEF12DDE99676DA7C7FD82D7CD371FB63FECBB693CF6B75F1C3C076D756D3496F736D71AA3433DBCF0BB473413C3242B24534522B4724722ABC6EACACA18115DD82CB332CC9D48E5D9763B3074545D5582C262314E929B6A0EA2A14EA3829B8C945CADCCE2D2BD99CF88C661309C9F5AC561F0DED39B93EB15E951E7E5B73727B49479B979A3CD6BDB995ED747E307C00F82FF00F070D7C36B1B0F0C6A3FB6EFECFBF1BFC39611A5A5AF8ABF698FD8EECED7C656F601B6DAA6A33FC28FDA27E19EA1E22BEB7B471E76A7AA35E6A379716C8752BB92E27B895BF53BE19FC15FDB73506B6BFF00DA2BF6CEF0FCF2C52979FC2DFB307ECFBE11F853E1BD461276B59EA9ADFC64D63F688F199B39E166477F0D6AFE11D6ADA60B7165AEC0C1513EA1D27E2E7C35D73C5EBE00D2FC63A35C78D5F40B4F142785DA692DB5A93C3F7D69657D6BAA4763771413496F25AEA16931D8AD246AF2096346B7B858897E2EFC3483C55E29F034BE32D1478BFC13E1C9BC5FE2AF0E09DDF56D13C336F6DA75E4DACDE5A246D20B24B6D5B4D977C4246617B02AA976DA13CB3328CDD3797E35548E1D62E50784AEA6B0929C69C714E2E9F32C3CAA4A34D566BD9B9CA3152E6690FEB386E573FAC50E5556545CBDAD3E555A37E6A4DF359558D9F3536F9959DD2B33BFB6B78ED2DADED6269DE2B6822B78DAE6E6E6F6E5A386358D1AE2F2F259EF2EE7655065B9BA9E6B99E42D2CF2C92BBBB7E54FFC15DBFE4947EC6DFF00695DFF00825BFF00EB697C25AFD1FD07E29FC3BF14781EEFE257877C63A16B5E03B0B3D6350BDF1469D78973A55A5A787D6E1F599AE268C178869D1DACF25C23A09162412046478D9BF2E7FE0A89E34F0AFC42F809FB12F8C3C13AF69DE26F0C6AFF00F055DFF8261FF666B7A54DF68B0BDFECFF00DB87E17E977BE44D85DFF66D42CAEED25E06D9ADE45FE1CD455C1636846B4ABE131546387C42C257955C3D5A71A18B719CD616B39C22A9E21C69D492A3371A9CB4E72E5B424D542B51A9ECF92B529FB6A6EB52E4A9097B5A2B92F569D9BE7A6BDA53BD48DE2BDA435F7A37FD84A28A2B94D428A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A002A29E086E619ADAE618AE2DEE229209E09E349619E1950C72C3345206492291199248DD591D18AB0209152D1401E0DF0A7F657FD987E03EBDAE78ABE077ECE3F01BE0CF89FC4D66DA77893C47F0A7E107C3EF877AF78834F6BC4D45AC75CD63C21E1ED1F50D5ACDB508E3BF6B6BFB8B884DE4697453CF5571EF3451400514514005145140051451400572BA2F813C0FE1BF11F8CBC61E1DF06F85341F16FC45BCD1751F883E29D17C3DA4697E23F1DEA1E1CD12D3C33E1EBEF196B7636706A7E27BCD07C376163E1FD16E75BBABE9F4BD12CAD349B1782C2DA1B74EAA8A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00FE47FC45E1BFDA1FC5BFF000488FF0082CCE85FB3243F11AFBE21DE7FC15D7FE0A00DE20D17E0EC97517C5BF127C1A83F6EAB79FE3CF86BE1B3588FB74DE2BD77E0E47E36D3ECEC34E2354D5ADA7BCD2349126A97F67149CDF82B4AFF00827978BFF6D1FF0082685CFF00C10F7E155CFC3EF899E03F8B924DFB6678A3E117C26F8ABF08BC15E1BFD8887C39F130F895E08FDAE359F15E81E1AD33C4BF123C43E2DFF842EDFE1EDA7C40B8F12FC4483C6BA4DFDEC77D65A89D3AF2EBF417E067C5DF889FF04C1F8B7FB64FC12F8D5FB257ED7FF163E187C6FF00DB0FE3EFED8FF01BF680FD93FF00679F887FB4FF008435FF000D7ED2FE2A5F889E27F871F10F41F845A4F88BC67F0CFE207C36F1B6A3AFE830A788BC3B6FA1F8ABC391699ABE93A9C855E5D43EA2FF0087BB7C28FF00A336FF0082AEFF00E2ADFF006D2FFE74B401F88BFF0004DDF84BFF000570F8C7F01BF66DFDAF3C47FB4F78CBC2FF000EECC7C6DF187C62D57E21FED9BFB41FC5AF1D7C63F87BA18F8C7E0DB6F017FC32EF8C3E05E87F0E7E12F88A3D6EC3C337BA4F8FB42F8EDAB6B1E1FB6F0F43AF69D6B79A96B325869BE15FF04F6FDA9FC7FE30FD933C53E29F8D7FB6AFC6FB9FDAE0FEC37FB4178ABE1C7826CBF6CFFDAF3E20F8BBC4BF19747FD9DFE2BEBFAA4DF133E0DF8EBE067C3AF861F0CBC4BE10D2B4D6F1A784B4FF00067C4AF88CBA7F8CB41B4974FD760BED3B4B875AFE8BFF00E1EEDF0A3FE8CDBFE0ABBFF8AB7FDB4BFF009D2D1FF0F76F851FF466DFF055DFFC55BFEDA5FF00CE96803F1EBF65BFDA27FE0A71E05F8F7FF0465FD97BF6B0D5BE2478F3C15F14359D7BE2EE93FB5FF8575CD774CF0EFED07F06BC49FB177C4BF1A5BFC11FDAAFC3FF00DA6F3D8FC6DF83DF17F54F87D6F6DA96B06E742F8A1A75BE83AEDA0B6F11C5E24B6D5BF563F663F8A7E1AF87BE17B1B1F18FC61BBF0D59DA7C40F1F6A97FF0ED3F67BF127885EE34BBFF001CEBB7D0097C79A77877557BCFEDBB39A2D46DEFECA5FF0042B2BBB5B18E226D0C92F5BFF0F76F851FF466DFF055DFFC55BFEDA5FF00CE968FF87BB7C28FFA336FF82AEFFE2ADFF6D2FF00E74B5EC65B9A470387C661A74275618BAB84AAE54EAD0A7384B09F59E556C460F1B4A719FD61B92749493846D2B3927F3F9BE431CD71D9663655E10FECD86322A854A35AA52AF2C554C0D58BAAE863309270A52C0AE6A3273A55D54E5AD174E32854E5FE27E81AEEAFFB44FC64FDA27E107DBAFF00C5DF07BC0DF017E23782F4CB596FF4BB3F883F0FEE3C3DAD5D7C47F063D918127B91AA784A6D22E96D12C65D56D2F06936305B4377AAC31CB47C15F0A7C69F0F7E3E7C56D77C7A2E2FFC75F11BF611F89BE3FF0089BAD5B25EC9E1F8FC7FE28F89734927877489A60F6D676DE1DF0DE99A1E8567A6C331516DA41BC894C53973DB7FC3DDBE147FD19B7FC1577FF156FF00B697FF003A5A3FE1EEDF0A3FE8CDBFE0ABBFF8AB7FDB4BFF009D2D7D0478DF171CBBFB36382A1ECE59753CB275E53BE26585A3470F0A347DAAA49AA10C452AD8D951D633C4E239E4ED4A9A5E14381E3196226F339BFAC66B8BCDDD18E129C70947178BA95F9EA50A2AB3A91AAB0D56183552788A96A149C69C69AAD5632F2EF83FF03FE2737837E17FC0AD05EE20FD9F7F680F01F817E2BFC58D52FF0051D5E3D47C1D2F842CF4583E31FC3ED2661218F44B8F1F6B973E19F3159ADAE6C85D7896C45BBDA585D7D8BE7DF8D1A7DFE97FF04E5FF826C58EA76577A75F41FF00055DFF00827BF9F677D6D35A5D43E6FF00C148FC37347E6DBDC247347E6432472A6F41BE37475CAB293F69FF00C3DDBE147FD19B7FC1577FF156FF00B697FF003A5AF987E3AFC75F89BFF052CF89BFB22FC05F80BFB22FED87F0BBE1F7C2EFDB0FF66FFDACBE3FFC7FFDACBF66FF0088DFB31F80BC2BE02FD98FE2369BF17B4CF02F8174CF8BDA6F85BC5FF127E23FC49F17F85BC3FE16B4B4F0B787EFB49F0BE937D7FAF6BD7F15B44AA98E7BC658ACF70388C056C251A10C46694336A9529CEF52A62E8D3CCF0EEAD57ECE1ED6B56C26370B87AB5A56728E5B464A29D4928F7643C271C8ABE0EB2CC2AE3160F2FC6E5D4E35A846128D2C656CB312E14E70A8D53C3D1C460313568D0709B87D7EA538D554A85383FDFBA28A2BE34FAF0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803FFFD9, '5', '0', 'image/jpeg', 'logo.jpg', '0', null);
INSERT INTO `component_tbl` VALUES ('5', '2', '1', '**********************************************************************\r\n[agnDYN name=\"0.1.1 Header-Text\"/]\r\n**********************************************************************\r\n[agnDYN name=\"0.2 date\"/]\r\n\r\n[agnTITLE type=1],\r\n\r\n[agnDYN name=\"0.3 Intro-text\"/]\r\n[agnDYN name=\"0.4 Greeting\"/]\r\n\r\n----------------------------------------------------------------------[agnDYN name=\"1.0 Headline ****\"]\r\n\r\n[agnDVALUE name=\"1.0 Headline ****\"]\r\n\r\n[agnDYN name=\"1.1 Sub-headline\"][agnDVALUE name=\"1.1 Sub-headline\"/]\r\n[/agnDYN name=\"1.1 Sub-headline\"][agnDYN name=\"1.2 Content\"/][agnDYN name=\"1.3 Link-URL\"]\r\n\r\n[agnDYN name=\"1.4 Link-Text\"/]\r\n[agnDVALUE name=\"1.3 Link-URL\"][/agnDYN name=\"1.3 Link-URL\"]\r\n\r\n----------------------------------------------------------------------[/agnDYN name=\"1.0 Headline ****\"][agnDYN name=\"2.0 Headline ****\"]\r\n\r\n[agnDVALUE name=\"2.0 Headline ****\"]\r\n\r\n[agnDYN name=\"2.1 Sub-headline\"][agnDVALUE name=\"2.1 Sub-headline\"/]\r\n[/agnDYN name=\"2.1 Sub-headline\"][agnDYN name=\"2.2 Content\"/][agnDYN name=\"2.3 Link-URL\"]\r\n\r\n[agnDYN name=\"2.4 Link-Text\"/]\r\n[agnDVALUE name=\"2.3 Link-URL\"][/agnDYN name=\"2.3 Link-URL\"]\r\n\r\n----------------------------------------------------------------------[/agnDYN name=\"2.0 Headline ****\"][agnDYN name=\"3.0 Headline ****\"]\r\n\r\n[agnDVALUE name=\"3.0 Headline ****\"]\r\n\r\n[agnDYN name=\"3.1 Sub-headline\"][agnDVALUE name=\"3.1 Sub-headline\"/]\r\n[/agnDYN name=\"3.1 Sub-headline\"][agnDYN name=\"3.2 Content\"/][agnDYN name=\"3.3 Link-URL\"]\r\n\r\n[agnDYN name=\"3.4 Link-Text\"/]\r\n[agnDVALUE name=\"3.3 Link-URL\"][/agnDYN name=\"3.3 Link-URL\"]\r\n\r\n----------------------------------------------------------------------[/agnDYN name=\"3.0 Headline ****\"]\r\n\r\nImprint\r\n\r\nYou want to change your profile-data?\r\n[agnDYN name=\"9.0 change-profil-URL\"/]\r\n\r\nPlease click her to unsubscribe:\r\n[agnDYN name=\"9.1 unsubscribe-URL\"/]\r\n\r\n[agnDYN name=\"9.2 imprint\"/]', null, '0', '0', 'text/plain', 'agnText', '0', null);
INSERT INTO `component_tbl` VALUES ('6', '2', '1', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table bgcolor=\"#808080\" width=\"684\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr>\r\n    <td>[agnDYN name=\"0.1 Header-image\"]\r\n    	<table width=\"680\" border=\"0\"  bgcolor=\"#FFFFFF\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n            <tr>\r\n              <td><img src=\"[agnDVALUE name=\"0.1 Header-image\"]\" width=\"680\" height=\"80\" alt=\"[agnDYN name=\"0.1.1 Header-Text\"/]\" border=\"0\"></td>\r\n            </tr>\r\n        </table>[/agnDYN name=\"0.1 Header-image\"]\r\n        <table width=\"680\" border=\"0\" bgcolor=\"#FFFFFF\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td><td align=\"right\"><div style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 10px;\">[agnDYN name=\"0.2 date\"/]</div></td><td width=\"10\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td>\r\n              <table width=\"660\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                 <tr><td><p><b>[agnTITLE type=1],</b></p><p>[agnDYN name=\"0.3 Intro-text\"/]</p><p>[agnDYN name=\"0.4 Greeting\"/]</p></td></tr>\r\n                 <tr><td><hr noshade></td></tr>\r\n              </table>[agnDYN name=\"1.0 Headline ****\"]\r\n              <table width=\"660\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n                 <tr>[agnDYN name=\"1.5 Image-URL\"]<td>[agnDYN name=\"1.3 Link-URL\"]<a href=\"[agnDVALUE name=\"1.3 Link-URL\"]\">[/agnDYN name=\"1.3 Link-URL\"]<img src=\"[agnDVALUE name=\"1.5 Image-URL\"]\" alt=\"Picture_1\">[agnDYN name=\"1.3 Link-URL\"]</a><!-- [agnDVALUE name=\"1.3 Link-URL\"] -->[/agnDYN name=\"1.3 Link-URL\"]</td>[/agnDYN name=\"1.5 Image-URL\"]\r\n                     <td valign=\"top\" align=\"left\"><h1>[agnDVALUE name=\"1.0 Headline ****\"]</h1>\r\n                     <p>[agnDYN name=\"1.1 Sub-headline\"]<b>[agnDVALUE name=\"1.1 Sub-headline\"/]</b><br>[/agnDYN name=\"1.1 Sub-headline\"][agnDYN name=\"1.2 Content\"/]</p>[agnDYN name=\"1.3 Link-URL\"]\r\n                     <p><a href=\"[agnDVALUE name=\"1.3 Link-URL\"]\">[agnDYN name=\"1.4 Link-Text\"/]</a></p>[/agnDYN name=\"1.3 Link-URL\"]</td>\r\n                     [agnDYN name=\"1.7 Image-URL-1\"]<td>[agnDYN name=\"1.6 Link-URL\"]<a href=\"[agnDVALUE name=\"1.6 Link-URL\"]\">[/agnDYN name=\"1.6 Link-URL\"]<img src=\"[agnDVALUE name=\"1.7 Image-URL-1\"]\" alt=\"Picture_2\">[agnDYN name=\"1.6 Link-URL\"]</a><!-- [agnDVALUE name=\"1.6 Link-URL\"] -->[/agnDYN name=\"1.6 Link-URL\"]</td>[/agnDYN name=\"1.7 Image-URL-1\"]\r\n                 <tr><td colspan=\"3\"><hr noshade></td></tr>\r\n              </table>[/agnDYN name=\"1.0 Headline ****\"][agnDYN name=\"2.0 Headline ****\"]\r\n              <table width=\"660\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n                 <tr>[agnDYN name=\"2.5 Image-URL\"]<td>[agnDYN name=\"2.3 Link-URL\"]<a href=\"[agnDVALUE name=\"2.3 Link-URL\"]\">[/agnDYN name=\"2.3 Link-URL\"]<img src=\"[agnDVALUE name=\"2.5 Image-URL\"]\" alt=\"Picture_1\">[agnDYN name=\"2.3 Link-URL\"]</a><!-- [agnDVALUE name=\"2.3 Link-URL\"] -->[/agnDYN name=\"2.3 Link-URL\"]</td>[/agnDYN name=\"2.5 Image-URL\"]\r\n                     <td valign=\"top\" align=\"left\"><h1>[agnDVALUE name=\"2.0 Headline ****\"]</h1>\r\n                     <p>[agnDYN name=\"2.1 Sub-headline\"]<b>[agnDVALUE name=\"2.1 Sub-headline\"/]</b><br>[/agnDYN name=\"2.1 Sub-headline\"][agnDYN name=\"2.2 Content\"/]</p>[agnDYN name=\"2.3 Link-URL\"]\r\n                     <p><a href=\"[agnDVALUE name=\"2.3 Link-URL\"]\">[agnDYN name=\"2.4 Link-Text\"/]</a></p>[/agnDYN name=\"2.3 Link-URL\"]</td>\r\n                     [agnDYN name=\"2.7 Image-URL-1\"]<td>[agnDYN name=\"2.6 Link-URL\"]<a href=\"[agnDVALUE name=\"2.6 Link-URL\"]\">[/agnDYN name=\"2.6 Link-URL\"]<img src=\"[agnDVALUE name=\"2.7 Image-URL-1\"]\" alt=\"Picture_2\">[agnDYN name=\"2.6 Link-URL\"]</a><!-- [agnDVALUE name=\"2.6 Link-URL\"] -->[/agnDYN name=\"2.6 Link-URL\"]</td>[/agnDYN name=\"2.7 Image-URL-1\"]\r\n                 <tr><td colspan=\"3\"><hr noshade></td></tr>\r\n              </table>[/agnDYN name=\"2.0 Headline ****\"][agnDYN name=\"3.0 Headline ****\"]\r\n              <table width=\"660\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n                 <tr>[agnDYN name=\"3.5 Image-URL\"]<td>[agnDYN name=\"3.3 Link-URL\"]<a href=\"[agnDVALUE name=\"3.3 Link-URL\"]\">[/agnDYN name=\"3.3 Link-URL\"]<img src=\"[agnDVALUE name=\"3.5 Image-URL\"]\" alt=\"Picture_1\">[agnDYN name=\"3.3 Link-URL\"]</a><!-- [agnDVALUE name=\"3.3 Link-URL\"] -->[/agnDYN name=\"3.3 Link-URL\"]</td>[/agnDYN name=\"3.5 Image-URL\"]\r\n                     <td valign=\"top\" align=\"left\"><h1>[agnDVALUE name=\"3.0 Headline ****\"]</h1>\r\n                     <p>[agnDYN name=\"3.1 Sub-headline\"]<b>[agnDVALUE name=\"3.1 Sub-headline\"/]</b><br>[/agnDYN name=\"3.1 Sub-headline\"][agnDYN name=\"3.2 Content\"/]</p>[agnDYN name=\"3.3 Link-URL\"]\r\n                     <p><a href=\"[agnDVALUE name=\"3.3 Link-URL\"]\">[agnDYN name=\"3.4 Link-Text\"/]</a></p>[/agnDYN name=\"3.3 Link-URL\"]</td>\r\n                     [agnDYN name=\"3.7 Image-URL-1\"]<td>[agnDYN name=\"3.6 Link-URL\"]<a href=\"[agnDVALUE name=\"3.6 Link-URL\"]\">[/agnDYN name=\"3.6 Link-URL\"]<img src=\"[agnDVALUE name=\"3.7 Image-URL-1\"]\" alt=\"Picture_2\">[agnDYN name=\"3.6 Link-URL\"]</a><!-- [agnDVALUE name=\"3.6 Link-URL\"] -->[/agnDYN name=\"3.6 Link-URL\"]</td>[/agnDYN name=\"3.7 Image-URL-1\"]\r\n                 <tr><td colspan=\"3\"><hr noshade></td></tr>\r\n              </table>[/agnDYN name=\"3.0 Headline ****\"]\r\n              <table width=\"660\" bgcolor=\"#D3D3D3\" border=\"0\" cellspacing=\"0\" cellpadding=\"5\" style=\"font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;\">\r\n                 <tr><td><h1>Imprint</h1>\r\n                 	 <p>You want do change your profile-data?<br><a href=\"[agnDYN name=\"9.0 change-profil-URL\"/]\">change profile</a></p>\r\n                 	 <p>Please click her to unsubscribe:<br><a href=\"[agnDYN name=\"9.1 unsubscribe-URL\"/]\">unsubscribe newsletter</a></p>\r\n                         <p>[agnDYN name=\"9.2 imprint\"/]</p></td></tr>\r\n              </table>              \r\n              </td>\r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\"><img src=\"[agnIMAGE name=\"clear.gif\"]\" width=\"8\" height=\"8\"></td>\r\n            </tr>            \r\n        </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, '0', '0', 'text/html', 'agnHtml', '0', null);
INSERT INTO `component_tbl` VALUES ('7', '2', '1', 'R0lGODdhAQABAIgAAP///wAAACwAAAAAAQABAAACAkQBADs=', 0x47494638376101000100880000FFFFFF0000002C00000000010001000002024401003B, '5', '0', 'image/gif', 'clear.gif', '0', null);
INSERT INTO `component_tbl` VALUES ('8', '2', '1', '/9j/4AAQSkZJRgABAQEAYABgAAD/4QBmRXhpZgAASUkqAAgAAAAEABoBBQABAAAAPgAAABsBBQAB\r\nAAAARgAAACgBAwABAAAAAgAAADEBAgAQAAAATgAAAAAAAABgAAAAAQAAAGAAAAABAAAAUGFpbnQu\r\nTkVUIHYzLjIyAP/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\r\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\r\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAFACqAMBIgACEQEDEQH/xAAf\r\nAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0BAgMABBEF\r\nEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4OTpDREVGR0hJ\r\nSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3\r\nuLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEB\r\nAAAAAAAAAQIDBAUGBwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIy\r\ngQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNk\r\nZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfI\r\nycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP3v+D/wf+Kf/BU74p/t\r\njfF/4v8A7Y37YfwK+E3wK/bD+PP7HnwF+Av7Hnx58Vfs0aJpWifs0eKv+FeeLvif8T/F3w7+weNP\r\niT45+JXjSw13VrCw1bXf+EY8HeGP7MsLDTLi/uHfSfoP/hzT8Pv+kgX/AAWG/wDFnn7Tv/zVUf8A\r\nBGn/AJJ9/wAFAv8AtMN/wU9/9ad8VV+wjsqKzuyoiKWd3IVVVQSzMxICqoBJJIAAJJxQB+Pf/Dmn\r\n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\r\n+FPhvUYSdrWeqa38ZNY/aI8ZmznhZkd/DWr+EdatpgtxZa7AwVE+odJ+Lnw11zxevgDS/GOjXHjV\r\n9AtPFCeF2mkttak8P31pZX1rqkdjdxQTSW8lrqFpMditJGryCWNGt7hYiX4u/DSDxV4p8DS+MtFH\r\ni/wT4cm8X+KvDgnd9W0Twzb22nXk2s3lokbSCyS21bTZd8QkZhewKql22hPLMyjN03l+NVSOHWLl\r\nB4SuprCSnGnHFOLp8yw8qko01Wa9m5yjFS5mkP6zhuVz+sUOVVZUXL2tPlVaN+ak3zWVWNnzU2+Z\r\nWd0rM7+2t47S2t7WJp3itoIreNrm5ub25aOGNY0a4vLyWe8u52VQZbm6nmuZ5C0s8skru7flT/wV\r\n2/5JR+xt/wBpXf8Aglv/AOtpfCWv0f0H4p/DvxR4Hu/iV4d8Y6FrXgOws9Y1C98UadeJc6VaWnh9\r\nbh9ZmuJowXiGnR2s8lwjoJFiQSBGR42b8uf+ConjTwr8QvgJ+xL4w8E69p3ibwxq/wDwVd/4Jh/2\r\nZrelTfaLC9/s/wDbh+F+l3vkTYXf9m1Cyu7SXgbZreRf4c1FXBY2hGtKvhMVRjh8QsJXlVw9WnGh\r\ni3Gc1haznCKp4hxp1JKjNxqctOcuW0JNVCtRqez5K1KftqbrUuSpCXtaK5L1adm+emvaU71I3iva\r\nQ196N/2EooorlNQooooAKKKKACiiigAooooAKKKKACiiigAooooAKinghuYZra5hiuLe4ikgngnj\r\nSWGeGVDHLDNFIGSSKRGZJI3VkdGKsCCRUtFAHg3wp/ZX/Zh+A+va54q+B37OPwG+DPifxNZtp3iT\r\nxH8KfhB8Pvh3r3iDT2vE1FrHXNY8IeHtH1DVrNtQjjv2tr+4uITeRpdFPPVXHvNFFABRRRQAUUUU\r\nAFFFFABXK6L4E8D+G/EfjLxh4d8G+FNB8W/EW80XUfiD4p0Xw9pGl+I/HeoeHNEtPDPh6+8Za3Y2\r\ncGp+J7zQfDdhY+H9Fudbur6fS9EsrTSbF4LC2ht06qigAooooAKKKKACiiigAooooAKKKKACiiig\r\nAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAC\r\niiigAooooAKKKKACiiigD+R/xF4b/aH8W/8ABIj/AILM6F+zJD8Rr74h3n/BXX/goA3iDRfg7JdR\r\nfFvxJ8GoP26ref48+Gvhs1iPt03ivXfg5H420+zsNOI1TVrae80jSRJql/ZxSc34K0r/AIJ5eL/2\r\n0f8Agmhc/wDBD34VXPw++JngP4uSTftmeKPhF8Jvir8IvBXhv9iIfDnxMPiV4I/a41nxXoHhrTPE\r\nvxI8Q+Lf+ELt/h7afEC48S/ESDxrpN/ex31lqJ068uv0F+Bnxd+In/BMH4t/tk/BL41fslftf/Fj\r\n4YfG/wDbD+Pv7Y/wG/aA/ZP/AGefiH+0/wCENf8ADX7S/ipfiJ4n+HHxD0H4RaT4i8Z/DP4gfDbx\r\ntqOv6DCniLw7b6H4q8ORaZq+k6nIVeXUPqL/AIe7fCj/AKM2/wCCrv8A4q3/AG0v/nS0AfiL/wAE\r\n3fhL/wAFcPjH8Bv2bf2vPEf7T3jLwv8ADuzHxt8YfGLVfiH+2b+0H8WvHXxj+Huhj4x+DbbwF/wy\r\n74w+Beh/Dn4S+Io9bsPDN7pPj7Qvjtq2seH7bw9Dr2nWt5qWsyWGm+Ff8E9v2p/H/jD9kzxT4p+N\r\nf7avxvuf2uD+w3+0F4q+HHgmy/bP/a8+IPi7xL8ZdH/Z3+K+v6pN8TPg346+Bnw6+GHwy8S+ENK0\r\n1vGnhLT/AAZ8SviMun+MtBtJdP12C+07S4da/ov/AOHu3wo/6M2/4Ku/+Kt/20v/AJ0tH/D3b4Uf\r\n9Gbf8FXf/FW/7aX/AM6WgD8ev2W/2if+CnHgX49/8EZf2Xv2sNW+JHjzwV8UNZ174u6T+1/4V1zX\r\ndM8O/tB/BrxJ+xd8S/Glv8Ef2q/D/wDabz2Pxt+D3xf1T4fW9tqWsG50L4oadb6DrtoLbxHF4ktt\r\nW/Vj9mP4p+Gvh74XsbHxj8Ybvw1Z2nxA8fapf/DtP2e/EniF7jS7/wAc67fQCXx5p3h3VXvP7bs5\r\notRt7+yl/wBCsru1sY4ibQyS9b/w92+FH/Rm3/BV3/xVv+2l/wDOlo/4e7fCj/ozb/gq7/4q3/bS\r\n/wDnS17GW5pHA4fGYadCdWGLq4Sq5U6tCnOEsJ9Z5VbEYPG0pxn9YbknSUk4RtKzkn8/m+QxzXHZ\r\nZjZV4Q/s2GMiqFSjWqUq8sVUwNWLquhjMJJwpSwK5qMnOlXVTlrRdOMoVOX+J+ga7q/7RPxk/aJ+\r\nEH26/wDF3we8DfAX4jeC9MtZb/S7P4g/D+48Pa1dfEfwY9kYEnuRqnhKbSLpbRLGXVbS8Gk2MFtD\r\nd6rDHLR8FfCnxp8Pfj58Vtd8ei4v/HXxG/YR+Jvj/wCJutWyXsnh+Px/4o+Jc0knh3SJpg9tZ23h\r\n3w3pmh6FZ6bDMVFtpBvIlMU5c9t/w92+FH/Rm3/BV3/xVv8Atpf/ADpaP+Hu3wo/6M2/4Ku/+Kt/\r\n20v/AJ0tfQR43xccu/s2OCoezll1PLJ15TviZYWjRw8KNH2qpJqhDEUq2NlR1jPE4jnk7UqaXhQ4\r\nHjGWIm8zm/rGa4vN3RjhKccJRxeLqV+epQoqs6kaqw1WGDVSeIqWoUnGnGmq1WMvLvg/8D/ic3g3\r\n4X/ArQXuIP2ff2gPAfgX4r/FjVL/AFHV49R8HS+ELPRYPjH8PtJmEhj0S48fa5c+GfMVmtrmyF14\r\nlsRbvaWF19i+ffjRp9/pf/BOX/gmxY6nZXenX0H/AAVd/wCCe/n2d9bTWl1D5v8AwUj8NzR+bb3C\r\nRzR+ZDJHKm9BvjdHXKspP2n/AMPdvhR/0Zt/wVd/8Vb/ALaX/wA6WvmH46/HX4m/8FLPib+yL8Bf\r\ngL+yL+2H8Lvh98Lv2w/2b/2svj/8f/2sv2b/AIjfsx+AvCvgL9mP4jab8XtM8C+BdM+L2m+FvF/x\r\nJ+I/xJ8X+FvD/ha0tPC3h++0nwvpN9f69r1/FbRKqY57xlis9wOIwFbCUaEMRmlDNqlSnO9Spi6N\r\nPM8O6tV+zh7WtWwmNwuHq1pWco5bRkop1JKPdkPCccir4Osswq4xYPL8bl1ONahGEo0sZWyzEuFO\r\ncKjVPD0cRgMTVo0HCbh9fqU41VSoU4P9+6KKK+NPrwooooAKKKKACiiigAooooAKKKKACiiigAoo\r\nooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii\r\ngAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA\r\nCiiigAooooA//9k=', 0xFFD8FFE000104A46494600010101006000600000FFE1006645786966000049492A000800000004001A010500010000003E0000001B010500010000004600000028010300010000000200000031010200100000004E00000000000000600000000100000060000000010000005061696E742E4E45542076332E323200FFDB00430001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101FFDB00430101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101FFC0001108005002A803012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FDEFF83FF07FE29FFC153BE29FED8DF17FE2FF00ED8DFB61FC0AF84DF02BF6C3F8F3FB1E7C05F80BFB1E7C79F157ECD1A2695A27ECD1E2AFF8579E2EF89FF13FC5DF0EFEC1E34F893E39F895E34B0D7756B0B0D5B5DFF8463C1DE18FECCB0B0D32E2FEE1DF49FA0FFE1CD3F0FBFE9205FF000586FF00C59E7ED3BFFCD551FF000469FF00927DFF000502FF00B4C37FC14F7FF5A77C555FB08ECA8ACEECA888A59DDC85555504B3331202AA8049248000249C5007E3DFFC39A7E1F7FD240BFE0B0DFF008B3CFDA77FF9AAA3FE1CD3F0FBFE9205FF000586FF00C59E7ED3BFFCD557D3FF0013FF00E0A29FB347C3A9AF34ED06FF00E27FC7EF1058B4F0DD787BF653F81FF187F6A1BEB2BE870ADA76AB77F02FC13E3BD2345BF49DA2B7B8B3D5B52B3BBB292789AF2082370F5F987F1C7FE0E19F845F015A6BDF8B3FB2CFEDA3F017C1F0CA91B7C43F8F9FB1F7ED33E04F09AA316613CB35FF00C2FB099229A3286254F36746120921246C001F4EFF00C39A7E1F7FD240BFE0B0DFF8B3CFDA77FF009AAA3FE1CD3F0FBFE9205FF0586FFC59E7ED3BFF00CD55705FB3EFFC1643E1D7ED4FE1D97C59FB3F78CFE0AFC56D16C9ADFF00B5E2F0CEA1AE2EBDA17DA4C9F6787C49E19D4754B4F13785AE6ED6195AD21F10E89A7CD7088D3430CD1024FD71E1CFDBBA069563F17780A58A02D106BBF0E6A89712A2F499974ED4E3B6491B3F3C4A754887FCB377E3CC201E09FF000E69F87DFF004902FF0082C37FE2CF3F69DFFE6AA8FF008734FC3EFF00A4817FC161BFF1679FB4EFFF003555FA71F0F3E317C3DF8A10B3784B5F82E6F624325CE8B78A6C75AB58C3943249A7CF89258010A4DCDA1B9B65DF1ABCCB236CAF4EA00FC79FF8734FC3EFFA4817FC161BFF001679FB4EFF00F3555E0DF177E067C5BFF8260FC44FD92BE357C13FDB27F6C3F8DFF0C3E2C7ED7FFB3CFEC9FF00B407C06FDB1FE3EF8ABF697F0D6BFE0FFDA7FE21E93F08B41F887F0E3C4FF111751F1B7C36F881F0CFC65E22F0EF88921D075F8BC39E2AD0EDF53D2757D314C92BEA1FBFF5F945FF000576FF009251FB1B7FDA577FE096FF00FADA5F096803F5768A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00FC79FF8234FFC93EFF82817FDA61BFE0A7BFF00AD3BE2AAFD819E082EA09ADAE618AE2DAE22920B8B79E349A09E0990C72C33452068E58A58D99248DD591D18AB02A48AFC7EFF008234FF00C93EFF0082817FDA61BFE0A7BFFAD3BE2AAFD86A006AAAA2AA22AA22285445015555400AAAA000AAA0000000000003154F548F4C9B4DD462D692C65D1E5B1BB8F568F545B77D364D31EDE45BF4D452EC1B57B17B532ADDADC836ED6E641303196ABD5F8EFF00F0563F8EFADF85BC39E0CF81FE19D46E34D6F1CDB5F789BC713DA5C3DBDD5D785ECE76D2F47D019A29773E97AE6A6355BAD5A378E2F3BFB06C6D5659AD2E752B66F7F86320AFC4D9E60325A1515178BA92F6B5DA52F6187A30956C4565072873CA14A1270A7CD1739F2C2EAF73C5E21CEF0FC3B93E3737C4D39D5A784843968D36A33AD5AB55850A3494A5A454AAD48F3CED274E9A9D4509F2F2BFE6ABFE0ABFFF0004EFF813E10FDAC7E1FF00ED87FF000463F8A1F0F7F67DFDA1F4CF145DC3F1C3C01A3DA788F41FD9ABC5FA749135CCDAC78793C25E1BD63405FED9BAB0B7D23C71E08F0DE9175F0EBC6963AA5B7896C6EFC3FE28D1B559BC4DFB0FF0DBC4BAA78C7E1FF83BC51AE5869DA56BBAD6836573AFE95A3EA33EADA4E99E218435978834FD2B53BBB1D2EFB50D2ACF5BB5BFB7D2F50BFD2749BDD474E8ED6FEE34BB16BAFB347F9BB5F66FECFDE22D02CFC0B7961AAF883C37A45EDBF89F519123D6BC47A2E8D3CB6171A6E8A60315B6A77B66F2C29771EA07ED1189373C8D13B2886351FAEF1CF85795E41C370C7E4BFDA78CCC70F8AC353C47B492AFF58A35A32A75250C3D1A3174DC6B7B3A917072E4839C67CF75387E55C19E25E639D7103C16732CBF0982C4E1ABCB0D1A54A54A34B134631AB18CF115B112B4274215DCA551C94AB28429AA7CEA2BE9ED1B59D57C3DAAD86B7A25FDCE99AB699731DDD85FDA48639EDA78CFCAE8DC86560592589C345344CF0CC8F13BA37ECEFC01F8B69F17BC0D0EAF74B043E22D2A71A5788ED60431442F9214962BEB78999CC76BA842DE6C4A1DD5264B9815BF7240FE747C71FB587ECADF0CB5C3E19F889FB4EFECEBE07F118B4B7BF6D0BC55F1C7E17E85ABA595D9905ADD3E9FA8F8A6DEE920B8F2A43048D1059550B2165C1AFD58FF008273F8AAD3C7563AAF8FBC07AC5978D3E0FF008EBC3AF7FE18F887E12BFB5F11FC3CF145FF00873C4773A05C9F0EF8BF477BDF0F6B53E9F7CBAF6957A34BD52736D7BA6EA165749F69B1952DBF059C274A73A75212A75212709C271709C271769467192528CA2D34E2D269AB3573F6CA75215611A94A70A94E6B9A13A725384A2F671945B8C93EE9B47EA357E517FC15DBFE4947EC6DFF00695DFF00825BFF00EB697C25AFD5DAFCA2FF0082BB7FC928FD8DBFED2BBFF04B7FFD6D2F84B5259FABB4514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145007E3CFF00C11A7FE49F7FC140BFED30DFF053DFFD69DF1557EC357E3CFF00C11A7FE49F7FC140BFED30DFF053DFFD69DF1557EC35007E49FF00C1593C07A57ED17F03BC5FFB207C445BC8FE0EFC74F0AE843C5B77E1DB97D27C6305D7847E2068DE31B16D0B5D923BCB2B068F54F0CE82D309B4BBF2F6E6EA22B179F1C8BF891FB2FF00FC135BF678FD927C09ACFC3BF85FA87C4BBFF0F6B9E2DBCF1A5D9F19F8AEC35CD422D66FF47D0F43BA16D796BE1FD28C766F63E1ED376DB491CA239D66951D7CF75AFE9F7F6AFF0085177F117C0906ADA159BDE789FC1D3CD7D656D0286B8D434ABB1147AC58C2814B4B3AAC16D7F6F1EE058D9CB0C4AF2DC2A9FC85AEECBB33CC329C5471B96632BE071508CE11AF87A8E9D450A8B9670BADE325BC5DD3B276BA4D726330182CC68FD5F1F84C3E370FCF1A8E862A8D3AF45CE37E594A9548CA1271BB71E68BE5766ACD26BE40F8BDF097C2DE0AF0741E20D11F52176DE26D2F47912F2E96E226B7BED2F5FBD7750B0C4564497498403F302B23F4C0CFCCD5FA23F17B47BFD73E19F8D6CF46D17FE121F1041A0DEEA9E1BD1A39ED2CEEB54F1068F1FF006A695A459EA1A84D05869B71AEDCDA2E82751BD905AD9DBEA9713CFF00BB4247C99FF0407FDA4BF63EFF0082827C43F8A9A0FC47D275FF00875FB54FC03F184D3597ECC5F11EFF004B8CEADE13D32DEDED2EBC6E2C2E74CB1BFF00146A7E14F1947AA68BE2AF09C4908F04CF63A1DEF88ED750B7F13594765FD03C1FE2B65F97F0B6225C459862F1F9E61B1589F63869AA957138DA328D29E1DC710E9FB0A74D549CE949D4A8EA5354E751539C7962FF000CE2FF000DB31CC78969BC832FC160F2AAF86C2FB6AB4BD8E130983AA9D5A755BC3C5C65524E34A35251C2D1A8DB9C5D45073E797E897C27FF0082147FC13B7F695F861E02F8C1FB647ECA9E1EF8A5F1B3C57E1E8AF2F3C41AC78CFE2D7876FECFC273DEDEDE783B469F4EF0A78FFC3DA4C72DAE87776D773E349B5BB86E6FE7B4BB33CD6A6E25FD97FD9BFF0066DF825FB22FC18F06FECF5FB3A7812CFE19FC1BF87CBAEAF83BC0FA7EABE20D6ACB425F13789758F186BAB6FA8F8A757D735B99751F12F88359D5A5177A9DC08EE2FE648045008E14F71A2BF01CDF33AF9CE698FCD712A2ABE3F155B15523149460EACDCA34E364AF1A71E5A716D733514E4DC9B6FF006FCAB010CAF2CCBF2DA73F690C060B0D83551C541D5FABD1852755C13928CAAB8BA925CD2B4A4F57B857E517FC15DBFE4947EC6DFF00695DFF00825BFF00EB697C25AFD5DAFCA2FF0082BB7FC928FD8DBFED2BBFF04B7FFD6D2F84B5E71DE7EAED14514005145140057E3AFF00C15DFF006B5FDACBF65087F624BDFD917C296BF12BC5BF133F6A6D5BC37E3EF83CDA6E8F75ACFC65F85BE04FD9DBE37FC6BF17FC34F07EA7AADBCF2F87BC73E25B3F8642DBC19AAE9924178DE261A5584A2EEC2F2F34FBBFD8AAFCFEFDB1BE027C4DF8BDFB407FC1367C7BE04D1AD354F0CFECE7FB5C78AFE2C7C58BDB8D634BD365D0BC11AA7ECA7FB44FC2DB2D4ACECF50BAB7BAD6EE24F1A7C41F0B69ADA769115E5FC705F4BA84902D8D95DCF080784EB7FB7BDE7C51FDA7FF00E09067F673F1ED86ABFB347EDCBE14FDAEBC5FE3281B44D0AF350F10D97C2FF81DA178CBC13A65D5FDCDBDF6AFE10F10782FC6375AAE9DE2BD174AD46CAEEDF5CB0D47C3BAFACCDA7C96D1FA87C38FF82A87ECDFF137C6DE07D0F48F0B7C7BD13E18FC59F1EC9F0B3E0AFED39E2FF841ADF86FF66CF8CFF119B52D5F49D2BC29F0F3E215EDC9D46F1FC59A8683ABDB780BC45AEF86740F067C429AD218BC11E25D7E5D57454D4BF3FF00C55FF04A7F8D7E10FF0082ABFC11F8B9F06EEF48B6FF00827DEAD07ED99F12BC7FE07D3358B4F0E78A7F678FDA1BF69DF81F77F0DBE246B7F0EA2FED2B0D5AE7C13F1AB5DB7F0D78E1748F0CC7772F82BE257FC26FAEC29A0691AEDBF99E25FB337FC1307E30780740FD92FF0066FF001D7EC4DA8CB17ECE5F15BE164DE36FDA3FC6BFF050DFDA2FC79FB2FF0089BE1DFECFDE27B4F117823E23FC1FFD99346FDA634BF1068BF17FC4171E14F09EB9E17F0378CBE0DE8BF0ABE1978C9DE694F887C3FA74162403F6525FF82997ECAD67E09FD95BC73AC6BDE2ED06D3F6C4FDA0EEFF0065FF00841A0EB1E0DD52D7C591FC62D33C5DE30F87BAEE81E33D050CD71E16B1F0EF8FFC15A9782B5CD72E9E7D2AC7C43A86816A6E5E0D66D2E5A87C49FF00829A7ECFBE02F14F887E1E787FC39F193E34FC53D1FE32F8ABE03E8DF0B7E09FC3F5F1978D3C75F103E1E7C33F047C58F8A50F83A3BDD6B42D066D13E16785BE2178661F1EEBFAFEBDE1ED3748F10DDBF87609AFB5544B797F2CFE35FF00C12B7F690F885F1A7FE0A1771A6E99A48F84707847E2BFC7AFF82795EC7E2DF0F41E228BF6CCFDA0F5FF00D9FBE3BF8F64BA49E686F7C17A7F863F687FD96F45BDD3F59D727B3D36E348F8D3E2BFB1CCD047A99B6EF3C4DFB007C5E93F64BFD91B47F8C3FB24F82FF6A3F8983E287C72FDA5BF6B2D2BE1C7C6097E047ED43F0C3F687FDA62F7C51F1275EF127ECADFB40E83F147E0FF0086F4C4F02F8C7C61A8FC34F1925E7C41D1EDFC79E07D0FC2579A64B70DA5323807D6371FB7D6A1F167F680FF00826CE9FF00052EFC61E10F86BFB407C6DFDB1FE11FC7AF877F13FE1AB783FE21E97E26FD9E7E02FC4ED76E3C15E22D2BC51A649ADF85B5AF077C4FF05C2F737BE18D49B4BD7ED2056B4D5F5BF0FDFC32CFE8FF000E3FE0AA1FB37FC4DF1B781F43D23C2DF1EF44F863F167C7B27C2CF82BFB4E78BFE106B7E1BFD9B3E33FC466D4B57D274AF0A7C3CF8857B72751BC7F166A1A0EAF6DE02F116BBE19D03C19F10A6B4862F0478975F9755D15352F84BE11FEC45FB71F88FC4BFB126A1FB426A5E39D6BC25F0B7F686FDBDFC412BFC41F8DBA0FC4FF008E9F01BF66CF8EDFB2EF8E7E13FC1CF04FC40F8BF617D69AAFC5DF89563E37F12EA576DE26F0D6A9E32BCF0CE8DAF687A3CDE2CBDB1F09C7A927CFFF00B337FC1307E30780740FD92FF66FF1D7EC4DA8CB17ECE5F15BE164DE36FDA3FC6BFF00050DFDA2FC79FB2FF89BE1DFECFDE27B4F117823E23FC1FF00D99346FDA634BF1068BF17FC4171E14F09EB9E17F0378CBE0DE8BF0ABE1978C9DE694F887C3FA74162403D3E7FF82D37C718BE06FED41F1513F676F15A6AFF0009FF00E0ABDF0C3F623F07E9379F0AFC4115A45F087C71F17FE19FC37D406B70278E85DDEFC70D2F49D4BC50D7F671DDDAE85A6FC40F19FC2FD19F4ABAD2F559205FD13F883FF0555F807F0F75EF166912FC2FFDA8BC67A5FC22D1BC33ACFED31E34F871F023C41E35F087ECA43C4BE0CD23E2249A37C77BED26F1F52B0F14784FC09AE697E2DF1F785FE1EE93F10F5EF04683771DFF0088AC2C616527F39BC69FB0D7ED956BF087FE0A0BF0B340F82565E28BCF117FC1593E13FF00C147FE016BB69F14BE1D699A5FC74F06DA7ED17F02FE33F89FE17DB43AC6B967A8FC38F18785F45F855A869175ABF8FAD74CD0354D535289B449EFED2D84F75E7FE38FF827B7ED0FA1F8DBF6C6D6A2FD89FE277ED01A9FED9FE2FBFF00DA17C01AAD97FC14ABE2BFC0DF855F05BE227C60F86FE10F0CF8FBE077ED45F0D7E1F7ED0DF0CA0F14782FE19F8BF40BFB81E34F81DE17F8AB7FF10BE1E5DDB786ACFF00B08D8693A5E8E01FB27E2AFF00828D7C05D13F68AF037ECBFE11D03E30FC6AF89DE3BF0C7C1BF8896F37C0DF86DA8FC49F057867E11FC70F107893C35E12F8CFE34F1BE93769E1EF0E7C29B1D4BC39BFC41E2EB9BC92DAD34FD6B49D4F4D8756B18F5B9F46ADFF000528F8F7F137F672F801E05F1EFC27D66D342F136B9FB5C7EC4FF09F51BDBCD1F4BD7229BC11F19FF6ADF849F0B7E20E9AB67ABDADE5AC571AB782FC57ADE9B6DA8C512DFE973DCC7A869D3DB5F5B5BCF1F8DFECBBFB1478E7E0A7ED63F1635BBEF0DE91E18F815A8FFC138FF613FD933C11A8FC3CF19788F4F8ED3C47FB3F6A3FB47E9FE33D0BC212EABE30D6FE3078774BF0D787FC7DE0D6F09F8AFC47E25BEF144B1DD433FF00C25BAAF88F4CD4B515E17F6DAFD82BC77A77EC9D7FE10FD970FC7DFDA27E225B7ED41FB15FC723E08F8F1FB59FC40F8997FA9E87FB39FED31F0EFE2C789B4AF06F8B7F694F88FADE85E07B9D43C31E1FD6BCD86CF52D22D75CBF874B5BF5BC9ACAC16200FD4BF8DDF1B3E18FECE5F0A7C69F1B3E3278A2DFC1BF0D7E1FE971EADE27F104F67A8EA4F6D15CDF5A693A6D958693A3DA6A1AC6B5ACEB5ACEA1A7689A0E87A3D85F6AFADEB5A8D8695A659DD5F5E5BC127C9DF0B7FE0A4DF023C77E2BF1CF80BE21F84BE387ECB5E3AF01FC21F11FED0977E13FDA9FE185E7C29D47C41F01BC1D76961E30F8B3E15BE8F52F10E81ABF86FC1D773D8C5E32D29B58B5F1AF83C6ABA3CDE28F0AE9106AB612DC7CC3FB48E93FB74FEDD5FB3F7C43F84977FB1A5EFECA9E38F076B9F057E3F7C1EF13FC4DFDA2BE0F78F7C07F113E28FECF5F1F3E187C63F0FF00C20F16DAFC1BD5FC55E26D07C39F10A0F065FE87ABF89AE34B9F4FD1ADA7376F6F7D3A43653F897ED6DFB3E7ED0BFB7C3F8FBE26FED35F0C6EFF00E09FDF047E077EC11FB71FC26875BF157C4EF007C54F88DACF8E3F6A1F879E0CD1FC57F102283E07EB9E3AF0FE8FF08BE0F7857E1C5EEA6D2DFEAD6DF10FC6DAA6A515BDBF83746D3ED276B900FB97E0FF00FC1537E037C5FF00891F04BE190F861FB50FC2DD4BF6964F11EA5FB3DF88BE347C07F11FC3AF067C5EF087853E18EBDF1735AF1C786FC43A95CCF1695A25B783B425BBFEC8F1A41E15F1C97D6F4199BC209A65ECBA8DAC5F0E3FE0AB5FB34FC4CF1778074CD2BC31F1F7C3FF000B3E3078FA1F857F047F69CF1B7C1AF10F853F671F8CFF00126FB56D4B43D0BC23E00F1DEA52A6B135C78BF55D1F53B1F01EBBE23F0AF877C21E3DB9B6860F06F88B5C9F53D1E3D43F31EF3E2D7ED01FB4CFC7CFF824AFC0DF8DFF000A3E157C23D13C47A27ED27771F8DFE13FED05E17F8D33FC58D1B50FF827C7C6FF008743E357C16B3F0968F05C786BE05349E34DFA66BDF119F42F135E6BDE28F0368D078784967AA5DBFAAE8DFB357EDE1F11FF0066DFD88FFE09E1F147F673F0CF827C19FB2E7C50FD90EEBE2B7ED6DA57C64F02DF7C37F1EFC2EFD87BC79E06F1B782EFFE0DFC38B4D435FF008C69E3FF008C0DF0AFC21A76A7A1FC49F06784BC3BE084D6FC4777FF00091EB6D61A6DADD007E84FFC14B3F6B3F107EC8DF013C27E21F066BFF0E7C15E38F8C3F1C3E18FC03F0B7C4AF8C1298FE157C245F1DDE6A5AB78DBE2F78F50EA7A2457DA2FC31F85FE15F1DF8D2DB48BAD7346B1D6F5BD1B48D1EFF52B7B3BE9CB7C13E07FDBC3F681D17F655FDBD3E2CFC18FDA33E11FFC14925FD9D7E14D9F8C3E1D6A965F0AB57F849F1EBC27F136E3FE12D1E28F0C7C5FFD9E7C25A3E833F883E14E8BE1DD174EF895F0DFC4BE19D3FC29E2AF88DA369FE32F0A680DE34BBB7B0F13D8FDE5FF000526FD973C69FB4DFC25F83FA97C33D27C37E2CF89BFB2EFED49F047F6BCF017C38F18EA56FA0F85FE2D6B1F05B55D51F53F85DAA78A2EB4BD6A0F0A5C78CBC25E22F1269DE1EF10DD69971A5D8F8ABFB0975F7B3F0E4FABDFDAFE747ED2BFB0DFED6BFB78B7ED8BF1B759F835E1DFD9B3C47F127F665F80DFB37FC36FD9BBE2E7C4EF0AF8B23F8DF6FF0006FF00691B1FDA57C6DA87ED01E21F817A8F8D3C19E17F09FC48D2EDEE3F67BF0CD8E93E27F883ABC1E0EF1178DF5BF1559E91A76A36BE18BB00B7FB377FC146BE20786FC4FF00B516A93FED69F0E7FE0A71FB36FC0BFD80756FDB3FC47F1DBE127C3CF067C367F873F127C3D26B7AAD97ECFF007DABFC36BAD67C0974FF00153C07A1F88BC5DE16D0F5BB73F12BE1EFFC215AC5A78CDB5A4D56C5EDBD93E197C6BFDBCFE0978FBF612F1B7ED43F18FC0BF18BE1C7EDEB7F3F803C6BF0ABC3DF06340F84CDFB31FC6CF147C09F16FC7CF86FE1FF0085BE2B9FC5526BFE33F054927C3FF16FC25D6ACFE2B5E6B3E32D5759BCF0AF8A6C2FF458975DD0D381D6FF00631F8EBFB66FC6DF1978CBC5DFB32E9BFF0004EEF86B3FFC13DFF69CFD8A75E8E2F1B7C24F1F7C45F8C9AA7ED3165E0ED3B46F3BC3DF03FC43E23F87F0FC22FD9FD7C33AE788FC2775E27D7747F1D6AFE2AF13C56BA7F86F41D024D704BD97837E1E7EDE7F197C5FFB08F877F682FD996DFE1AF81BF605B8D67E2FFC4BF1745F18BE13FC4A9BF6A9F8EBE04F80BF103E02FC27D3FE04D8C7AF5C788FC3FE19D76EFE21F887E2BEADE20F8E6DF0B35BD1B51B7F0B786A74BE9C6B1E22B200FB6FE14FFC144FF667F8D7AE7C0CF07FC39D73C51AF78FBE3BCBF15174EF8743C2D7969E3AF8630FC11BBBDD1FE2A5DFC73F0F5DCB15CFC24B7F0878AED20F044DFF0009535B4FAD78C356D1F45F0CC1AD497CB2A7E397ECE1FF000530FDA7BC71F1C7F662B2D7BF685F863F127E347C7BFDAB3E247C0CFDA13FE096FE1DF85DE18D07E25FEC55F0C3C1D2FC46975FF893AF78C6D758B9F8A7657BF06B4AF0D780B52F1B789BE28DB9F87FF150F8CEE6D3E1B5AE9579A9F84ADE4F77FD963F623FDB33E02FED45ABFEDB1E26F0F7C37D47E20FFC142BFE123D07F6EBF86BE00B5F875A45EFECAF6F669A9DF7ECD3E24F839E3695BC3937C41B3F85BA4CB2783FF695B5835DBED57E2EF8EB5E3F187C2FA7EBDA86830D95EF927C27FD873F6AEB0F849FB02FEC6F79FB1A7C36F8457FFB1B7ED19F043E2678FBF6F1F0F7C52F86B7FE1FF1D685F02FC5ABE2BF17F8FF00E12F8656FF00C59F1F354F8A5FB53DAC1A8683F11747F8C5E11F0EE83A63FC41F1B5CEA9AF6BF0DBE90F2807AB7C53FDB03F6D8B2F829FB4BFFC148FC13F153C1DA67ECDDFB2DFC71F8DDE14D3FF0064CBFF0082F68D6FF19BE017ECCFF19356F831F183C7FAF7C69D7B51D3FC79E12F889ACCDE10F88FE33F026A5E1DB34F87BA0D9681E19D2FC4BE1AF11A5DF8835187ED8F8BDFF054DF803F097E20FC6EF87107C3BFDA4FE2D6B1FB3345E18D63F68AD53E097C15D63E227873E0DF817C63F0DFC31F153C3BF11FC4DABD95FDA2EB3E19D4FC23E23B9BBB5D2BC090F8BFC7D707C25E33B9B7F054DA5686752B9F84FE237ECA7FB71CDF027F6AEFF8268F84BE09699AAFC09FDA63E3E7C64D6FC27FB62DDFC59F03DEF83FE1A7ECDDFB54FC59D6BE337C69F0D78D7E10789F5FFF0085AFAB7C53F075CF8D3E24780FC1FA0783FC3377F0F3C4D6DACF853C4977E2DF0C1B7D7B4C8D9A57C47FDAAFC2BFB6DFFC1647E1A7ECCFFB2968BF1DBFE12BF177ECCDA4F873C4B27C52F877F0B3C3FF000D3C75ADFEC2BF05F40D365F8B4BE29BBB0F14EA3F0A61B086C754B76F859A678EFC59A6CBA5F88B4FB5F064726B965A83007E9778CFFE0A41FB25FC3B93C612F8DBE21BF87342F0D7ECD3A07ED71A0F8BAFF4C98F84FE2B7C0CF10DC47A7DA788FE106B16EF3A78EF58875BD43C31E1D9BC1D63143E2CB9D73C73E06B2D2B47D47FE129D2E59BEC7F06F8917C65E11F0B78B9742F1278613C53E1ED1BC449E1BF196932681E2ED0135AD3ADF514D1BC53A0CB24D3689E21D356E459EB3A44F23DC699A8C3716539F3A0703F9C5F891FF0498FDA7BC7FE06FD8E3E05687ADF837C1FE17FF8249FECDFF04358FD92FE296BB67E0DF171FDA87F6D5F05687E101A95AFC41F0BEA16FABEADE0EFD97B4BB1F87769E13D5F40BA93C31E2DD67C4DE3883C6361FDA117C2CF09DEDD7F447F0BFC41E33F15FC39F047893E237806E7E1678FF5BF0BE8DA8F8D3E1C5DEBFA078AE5F0578A2E6C617D77C389E27F0B5F6A5A07886D74CD48DCDB58EB5A6DD793A9D925BDE3DB58CF34B636E01DDD145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451401F8F3FF0469FF927DFF0502FFB4C37FC14F7FF005A77C555FB0D5F8F3FF0469FF927DFF0502FFB4C37FC14F7FF005A77C555FAE1A66BFA16B52EA1068FAD693AB4FA4DC7D8F54874CD46CEFE5D36EC8622D7508ED6695ECEE08473E45CAC72E15BE5F94E0035ABE4BF8C3FB26F84FE22DE5DF88BC3779FF08878A6EB74B746383ED1A16AD72CFB9AE2F6C94A4D697528CA49776122C6C7F7D358DC4E5E47FAD28A00FC7AF117EC8BF1AF42964167A1587896D91884BBD0B57B260EBFBD21BEC9A9C9A6DF0609102CA2D9C6E9638D1A472C17F1FF00F6AEFF008211693FB487C4ED27F68AF047873E367ECB7FB55787351B6D6F44FDA13F67FBC7F08F8B27D7AC123834ED63C49676ED0C5AAEA9616CAF6F0EBFA45E786BC5D3C060B2BEF12DDE99676DA7C7FD82D7CD371FB63FECBB693CF6B75F1C3C076D756D3496F736D71AA3433DBCF0BB473413C3242B24534522B4724722ABC6EACACA18115DD82CB332CC9D48E5D9763B3074545D5582C262314E929B6A0EA2A14EA3829B8C945CADCCE2D2BD99CF88C661309C9F5AC561F0DED39B93EB15E951E7E5B73727B49479B979A3CD6BDB995ED747E307C00F82FF00F070D7C36B1B0F0C6A3FB6EFECFBF1BFC39611A5A5AF8ABF698FD8EECED7C656F601B6DAA6A33FC28FDA27E19EA1E22BEB7B471E76A7AA35E6A379716C8752BB92E27B895BF53BE19FC15FDB73506B6BFF00DA2BF6CEF0FCF2C52979FC2DFB307ECFBE11F853E1BD461276B59EA9ADFC64D63F688F199B39E166477F0D6AFE11D6ADA60B7165AEC0C1513EA1D27E2E7C35D73C5EBE00D2FC63A35C78D5F40B4F142785DA692DB5A93C3F7D69657D6BAA4763771413496F25AEA16931D8AD246AF2096346B7B858897E2EFC3483C55E29F034BE32D1478BFC13E1C9BC5FE2AF0E09DDF56D13C336F6DA75E4DACDE5A246D20B24B6D5B4D977C4246617B02AA976DA13CB3328CDD3797E35548E1D62E50784AEA6B0929C69C714E2E9F32C3CAA4A34D566BD9B9CA3152E6690FEB386E573FAC50E5556545CBDAD3E555A37E6A4DF359558D9F3536F9959DD2B33BFB6B78ED2DADED6269DE2B6822B78DAE6E6E6F6E5A386358D1AE2F2F259EF2EE7655065B9BA9E6B99E42D2CF2C92BBBB7E54FFC15DBFE4947EC6DFF00695DFF00825BFF00EB697C25AFD1FD07E29FC3BF14781EEFE257877C63A16B5E03B0B3D6350BDF1469D78973A55A5A787D6E1F599AE268C178869D1DACF25C23A09162412046478D9BF2E7FE0A89E34F0AFC42F809FB12F8C3C13AF69DE26F0C6AFF00F055DFF8261FF666B7A54DF68B0BDFECFF00DB87E17E977BE44D85DFF66D42CAEED25E06D9ADE45FE1CD455C1636846B4ABE131546387C42C257955C3D5A71A18B719CD616B39C22A9E21C69D492A3371A9CB4E72E5B424D542B51A9ECF92B529FB6A6EB52E4A9097B5A2B92F569D9BE7A6BDA53BD48DE2BDA435F7A37FD84A28A2B94D428A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A002A29E086E619ADAE618AE2DEE229209E09E349619E1950C72C3345206492291199248DD591D18AB0209152D1401E0DF0A7F657FD987E03EBDAE78ABE077ECE3F01BE0CF89FC4D66DA77893C47F0A7E107C3EF877AF78834F6BC4D45AC75CD63C21E1ED1F50D5ACDB508E3BF6B6BFB8B884DE4697453CF5571EF3451400514514005145140051451400572BA2F813C0FE1BF11F8CBC61E1DF06F85341F16FC45BCD1751F883E29D17C3DA4697E23F1DEA1E1CD12D3C33E1EBEF196B7636706A7E27BCD07C376163E1FD16E75BBABE9F4BD12CAD349B1782C2DA1B74EAA8A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00FE47FC45E1BFDA1FC5BFF000488FF0082CCE85FB3243F11AFBE21DE7FC15D7FE0A00DE20D17E0EC97517C5BF127C1A83F6EAB79FE3CF86BE1B3588FB74DE2BD77E0E47E36D3ECEC34E2354D5ADA7BCD2349126A97F67149CDF82B4AFF00827978BFF6D1FF0082685CFF00C10F7E155CFC3EF899E03F8B924DFB6678A3E117C26F8ABF08BC15E1BFD8887C39F130F895E08FDAE359F15E81E1AD33C4BF123C43E2DFF842EDFE1EDA7C40B8F12FC4483C6BA4DFDEC77D65A89D3AF2EBF417E067C5DF889FF04C1F8B7FB64FC12F8D5FB257ED7FF163E187C6FF00DB0FE3EFED8FF01BF680FD93FF00679F887FB4FF008435FF000D7ED2FE2A5F889E27F871F10F41F845A4F88BC67F0CFE207C36F1B6A3AFE830A788BC3B6FA1F8ABC391699ABE93A9C855E5D43EA2FF0087BB7C28FF00A336FF0082AEFF00E2ADFF006D2FFE74B401F88BFF0004DDF84BFF000570F8C7F01BF66DFDAF3C47FB4F78CBC2FF000EECC7C6DF187C62D57E21FED9BFB41FC5AF1D7C63F87BA18F8C7E0DB6F017FC32EF8C3E05E87F0E7E12F88A3D6EC3C337BA4F8FB42F8EDAB6B1E1FB6F0F43AF69D6B79A96B325869BE15FF04F6FDA9FC7FE30FD933C53E29F8D7FB6AFC6FB9FDAE0FEC37FB4178ABE1C7826CBF6CFFDAF3E20F8BBC4BF19747FD9DFE2BEBFAA4DF133E0DF8EBE067C3AF861F0CBC4BE10D2B4D6F1A784B4FF00067C4AF88CBA7F8CB41B4974FD760BED3B4B875AFE8BFF00E1EEDF0A3FE8CDBFE0ABBFF8AB7FDB4BFF009D2D1FF0F76F851FF466DFF055DFFC55BFEDA5FF00CE96803F1EBF65BFDA27FE0A71E05F8F7FF0465FD97BF6B0D5BE2478F3C15F14359D7BE2EE93FB5FF8575CD774CF0EFED07F06BC49FB177C4BF1A5BFC11FDAAFC3FF00DA6F3D8FC6DF83DF17F54F87D6F6DA96B06E742F8A1A75BE83AEDA0B6F11C5E24B6D5BF563F663F8A7E1AF87BE17B1B1F18FC61BBF0D59DA7C40F1F6A97FF0ED3F67BF127885EE34BBFF001CEBB7D0097C79A77877557BCFEDBB39A2D46DEFECA5FF0042B2BBB5B18E226D0C92F5BFF0F76F851FF466DFF055DFFC55BFEDA5FF00CE968FF87BB7C28FFA336FF82AEFFE2ADFF6D2FF00E74B5EC65B9A470387C661A74275618BAB84AAE54EAD0A7384B09F59E556C460F1B4A719FD61B92749493846D2B3927F3F9BE431CD71D9663655E10FECD86322A854A35AA52AF2C554C0D58BAAE863309270A52C0AE6A3273A55D54E5AD174E32854E5FE27E81AEEAFFB44FC64FDA27E107DBAFF00C5DF07BC0DF017E23782F4CB596FF4BB3F883F0FEE3C3DAD5D7C47F063D918127B91AA784A6D22E96D12C65D56D2F06936305B4377AAC31CB47C15F0A7C69F0F7E3E7C56D77C7A2E2FFC75F11BF611F89BE3FF0089BAD5B25EC9E1F8FC7FE28F89734927877489A60F6D676DE1DF0DE99A1E8567A6C331516DA41BC894C53973DB7FC3DDBE147FD19B7FC1577FF156FF00B697FF003A5A3FE1EEDF0A3FE8CDBFE0ABBFF8AB7FDB4BFF009D2D7D0478DF171CBBFB36382A1ECE59753CB275E53BE26585A3470F0A347DAAA49AA10C452AD8D951D633C4E239E4ED4A9A5E14381E3196226F339BFAC66B8BCDDD18E129C70947178BA95F9EA50A2AB3A91AAB0D56183552788A96A149C69C69AAD5632F2EF83FF03FE2737837E17FC0AD05EE20FD9F7F680F01F817E2BFC58D52FF0051D5E3D47C1D2F842CF4583E31FC3ED2661218F44B8F1F6B973E19F3159ADAE6C85D7896C45BBDA585D7D8BE7DF8D1A7DFE97FF04E5FF826C58EA76577A75F41FF00055DFF00827BF9F677D6D35A5D43E6FF00C148FC37347E6DBDC247347E6432472A6F41BE37475CAB293F69FF00C3DDBE147FD19B7FC1577FF156FF00B697FF003A5AF987E3AFC75F89BFF052CF89BFB22FC05F80BFB22FED87F0BBE1F7C2EFDB0FF66FFDACBE3FFC7FFDACBF66FF0088DFB31F80BC2BE02FD98FE2369BF17B4CF02F8174CF8BDA6F85BC5FF127E23FC49F17F85BC3FE16B4B4F0B787EFB49F0BE937D7FAF6BD7F15B44AA98E7BC658ACF70388C056C251A10C46694336A9529CEF52A62E8D3CCF0EEAD57ECE1ED6B56C26370B87AB5A56728E5B464A29D4928F7643C271C8ABE0EB2CC2AE3160F2FC6E5D4E35A846128D2C656CB312E14E70A8D53C3D1C460313568D0709B87D7EA538D554A85383FDFBA28A2BE34FAF0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803FFFD9, '5', '0', 'image/jpeg', 'logo.jpg', '0', null);
INSERT INTO `component_tbl` VALUES ('9', '3', '1', '[agnDYN name=\"Text\"/]', null, '0', '0', 'text/plain', 'agnText', '0', null);
INSERT INTO `component_tbl` VALUES ('10', '3', '1', '[agnDYN name=\"HTML-Version\"/]', null, '0', '0', 'text/html', 'agnHtml', '0', null);
INSERT INTO `component_tbl` VALUES ('11', '4', '1', '[agnDYN name=\"Text\"/]', null, '0', '0', 'text/plain', 'agnText', '0', null);
INSERT INTO `component_tbl` VALUES ('12', '4', '1', '[agnDYN name=\"HTML-Version\"/]', null, '0', '0', 'text/html', 'agnHtml', '0', null);
INSERT INTO `component_tbl` VALUES ('13', '5', '1', '[agnDYN name=\"Text\"/]', null, '0', '0', 'text/plain', 'agnText', '0', null);
INSERT INTO `component_tbl` VALUES ('14', '5', '1', '[agnDYN name=\"HTML-Version\"/]', null, '0', '0', 'text/html', 'agnHtml', '0', null);

-- ----------------------------
-- Table structure for `config_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `config_tbl`;
CREATE TABLE `config_tbl` (
  `class` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `classid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of config_tbl
-- ----------------------------
INSERT INTO `config_tbl` VALUES ('linkchecker', '0', 'linktimeout', '20000');
INSERT INTO `config_tbl` VALUES ('linkchecker', '0', 'threadcount', '20');

-- ----------------------------
-- Table structure for `customer_1_binding_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `customer_1_binding_tbl`;
CREATE TABLE `customer_1_binding_tbl` (
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0',
  `mailinglist_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_type` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_status` int(10) unsigned DEFAULT NULL,
  `user_remark` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `exit_mailing_id` int(10) unsigned DEFAULT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
  `mediatype` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `cust_1_bind_un` (`customer_id`,`mailinglist_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of customer_1_binding_tbl
-- ----------------------------
INSERT INTO `customer_1_binding_tbl` VALUES ('1', '1', 'A', '1', '', '2014-11-16 21:55:52', '0', '2014-11-16 21:55:52', '0');
INSERT INTO `customer_1_binding_tbl` VALUES ('2', '1', 'T', '1', '', '2014-11-16 21:55:52', '0', '2014-11-16 21:55:52', '0');
INSERT INTO `customer_1_binding_tbl` VALUES ('3', '1', 'W', '1', '', '2017-02-27 22:17:05', '0', '2017-02-27 22:17:05', '0');
INSERT INTO `customer_1_binding_tbl` VALUES ('3', '5', 'W', '1', '', '2017-02-27 22:17:05', '0', '2017-02-27 22:17:05', '0');
INSERT INTO `customer_1_binding_tbl` VALUES ('4', '1', 'W', '1', '', '2017-02-27 22:17:37', '0', '2017-02-27 22:17:37', '0');
INSERT INTO `customer_1_binding_tbl` VALUES ('4', '5', 'W', '1', '', '2017-02-27 22:17:37', '0', '2017-02-27 22:17:37', '0');

-- ----------------------------
-- Table structure for `customer_1_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `customer_1_tbl`;
CREATE TABLE `customer_1_tbl` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` int(11) NOT NULL DEFAULT '2',
  `mailtype` int(11) DEFAULT '0',
  `firstname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datasource_id` int(11) NOT NULL DEFAULT '0',
  `test1` int(11) DEFAULT '1',
  PRIMARY KEY (`customer_id`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of customer_1_tbl
-- ----------------------------
INSERT INTO `customer_1_tbl` VALUES ('1', 'first.last@domain.org', '0', '1', 'First', 'Last', '2014-11-16 21:55:52', '2014-11-16 21:55:52', null, '0', '1');
INSERT INTO `customer_1_tbl` VALUES ('2', 'no.name@yourdomain.com', '0', '1', 'No', 'Name', '2014-11-16 21:55:52', '2014-11-16 21:55:52', null, '0', '1');
INSERT INTO `customer_1_tbl` VALUES ('3', 'tronghao.it@gmail.com', '0', '1', 'hảo', 'phạm trọng', '2017-02-27 22:17:05', '2017-02-27 22:17:05', 'Giám đốc hảo', '0', '1');
INSERT INTO `customer_1_tbl` VALUES ('4', 'trungnt@gmail.com', '0', '1', 'Trung', 'Nguyễn sỹ', '2017-02-27 22:17:37', '2017-02-27 22:17:37', 'Chủ tịch', '0', '1');

-- ----------------------------
-- Table structure for `customer_field_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `customer_field_tbl`;
CREATE TABLE `customer_field_tbl` (
  `company_id` int(11) NOT NULL DEFAULT '0',
  `col_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `admin_id` int(11) NOT NULL DEFAULT '0',
  `shortname` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mode_edit` int(11) NOT NULL DEFAULT '0',
  `mode_insert` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`company_id`,`col_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of customer_field_tbl
-- ----------------------------
INSERT INTO `customer_field_tbl` VALUES ('1', 'TEST1', '0', 'Test1', 'Test1', '1', '0', '0');

-- ----------------------------
-- Table structure for `cust_ban_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `cust_ban_tbl`;
CREATE TABLE `cust_ban_tbl` (
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`company_id`,`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cust_ban_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `datasource_description_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `datasource_description_tbl`;
CREATE TABLE `datasource_description_tbl` (
  `datasource_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT '0',
  `sourcegroup_id` int(11) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_unicode_ci,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`datasource_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of datasource_description_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `date_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `date_tbl`;
CREATE TABLE `date_tbl` (
  `type` int(11) NOT NULL DEFAULT '0',
  `format` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of date_tbl
-- ----------------------------
INSERT INTO `date_tbl` VALUES ('0', 'd.M.yyyy');
INSERT INTO `date_tbl` VALUES ('1', 'MM/dd/yyyy');
INSERT INTO `date_tbl` VALUES ('2', 'EEEE d MMMM yyyy');
INSERT INTO `date_tbl` VALUES ('3', 'yyyy-MM-dd');
INSERT INTO `date_tbl` VALUES ('6', 'dd/MM/yyyy');
INSERT INTO `date_tbl` VALUES ('7', 'yyyy/MM/dd');
INSERT INTO `date_tbl` VALUES ('8', 'yyyy-MM-dd');

-- ----------------------------
-- Table structure for `doc_mapping_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `doc_mapping_tbl`;
CREATE TABLE `doc_mapping_tbl` (
  `filename` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pagekey` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `doc_mapping$pagekey$unique` (`pagekey`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of doc_mapping_tbl
-- ----------------------------
INSERT INTO `doc_mapping_tbl` VALUES ('what_are_templates_.htm', 'templateList');
INSERT INTO `doc_mapping_tbl` VALUES ('list_existing_mailings.htm', 'mailingList');
INSERT INTO `doc_mapping_tbl` VALUES ('sending_normal_file_attachment.htm', 'attachments');
INSERT INTO `doc_mapping_tbl` VALUES ('creating_a_new_mailing.htm', 'createNewMailing');
INSERT INTO `doc_mapping_tbl` VALUES ('entering_basic_mailing_data.htm', 'newMailingNormal');
INSERT INTO `doc_mapping_tbl` VALUES ('create_new_mailing_using_the_w.htm', 'newMailingWizard');
INSERT INTO `doc_mapping_tbl` VALUES ('inserting_content.htm', 'contentList');
INSERT INTO `doc_mapping_tbl` VALUES ('creating_text_and_html_modules.htm', 'contentView');
INSERT INTO `doc_mapping_tbl` VALUES ('using_graphic_elements.htm', 'pictureComponents');
INSERT INTO `doc_mapping_tbl` VALUES ('create_trackable_and_non-track.htm', 'trackableLinks');
INSERT INTO `doc_mapping_tbl` VALUES ('preview_-_for_in-depth_checkin.htm', 'preview');
INSERT INTO `doc_mapping_tbl` VALUES ('testing_and_sending_a_mailing.htm', 'mailingTestAndSend');
INSERT INTO `doc_mapping_tbl` VALUES ('send_mailing.htm', 'sendMailing');
INSERT INTO `doc_mapping_tbl` VALUES ('mailing_statistics_openemm.htm', 'mailingStatistic');
INSERT INTO `doc_mapping_tbl` VALUES ('heatmap_openemm.htm', 'heatmap');
INSERT INTO `doc_mapping_tbl` VALUES ('show_available_cm_templates.htm', 'cmTemplateList');
INSERT INTO `doc_mapping_tbl` VALUES ('editing_cm_templates.htm', 'cmTemplateView');
INSERT INTO `doc_mapping_tbl` VALUES ('using_cm_templates_in_mailings.htm', 'cmTemplateForMailing');
INSERT INTO `doc_mapping_tbl` VALUES ('show_available_module_types.htm', 'cmModuleTypeList');
INSERT INTO `doc_mapping_tbl` VALUES ('entering_basic_data.htm', 'cmModuleTypeView');
INSERT INTO `doc_mapping_tbl` VALUES ('show_available_content_modules.htm', 'cmContentModuleList');
INSERT INTO `doc_mapping_tbl` VALUES ('entering_basic_data2.htm', 'cmContentModuleView');
INSERT INTO `doc_mapping_tbl` VALUES ('saving_a_content_moduke_and_as.htm', 'cmContentModuleAssign');
INSERT INTO `doc_mapping_tbl` VALUES ('cm_categories.htm', 'cmCategoryList');
INSERT INTO `doc_mapping_tbl` VALUES ('entering_basic_template_data.htm', 'newTemplate');
INSERT INTO `doc_mapping_tbl` VALUES ('display_and_amend_details.htm', 'newTemplateNormal');
INSERT INTO `doc_mapping_tbl` VALUES ('create_a_new_archive.htm', 'newArchive');
INSERT INTO `doc_mapping_tbl` VALUES ('display_and_amend_details.htm', 'archiveView');
INSERT INTO `doc_mapping_tbl` VALUES ('managing_recipients.htm', 'recipientList');
INSERT INTO `doc_mapping_tbl` VALUES ('show_recipient_profile.htm', 'recipientView');
INSERT INTO `doc_mapping_tbl` VALUES ('create_new_recipients.htm', 'newRecipient');
INSERT INTO `doc_mapping_tbl` VALUES ('creating_a_new_import_profile.htm', 'newImportProfile');
INSERT INTO `doc_mapping_tbl` VALUES ('managing_fields.htm', 'manageFields');
INSERT INTO `doc_mapping_tbl` VALUES ('managing_a_profile__deleting_a.htm', 'manageProfile');
INSERT INTO `doc_mapping_tbl` VALUES ('the_import_assistant.htm', 'importStep1');
INSERT INTO `doc_mapping_tbl` VALUES ('assigning_the_csv_columns_to_t.htm', 'importStep2');
INSERT INTO `doc_mapping_tbl` VALUES ('errorhandling.htm', 'importStep3');
INSERT INTO `doc_mapping_tbl` VALUES ('importing_the_csv-file.htm', 'importStep4');
INSERT INTO `doc_mapping_tbl` VALUES ('export_function_for_recipient_.htm', 'export');
INSERT INTO `doc_mapping_tbl` VALUES ('blacklist_-_do_not_mail.htm', 'blacklist');
INSERT INTO `doc_mapping_tbl` VALUES ('types_of_address.htm', 'salutationForms');
INSERT INTO `doc_mapping_tbl` VALUES ('comparing_mailings2.htm', 'compareMailings');
INSERT INTO `doc_mapping_tbl` VALUES ('domain_statistics.htm', 'domainStatistic');
INSERT INTO `doc_mapping_tbl` VALUES ('recipient_statistics_openemm.htm', 'recipientStatistic');
INSERT INTO `doc_mapping_tbl` VALUES ('what_is_a_traget_group_.htm', 'targetGroupList');
INSERT INTO `doc_mapping_tbl` VALUES ('creating_and_managing_target_g.htm', 'targetGroupView');
INSERT INTO `doc_mapping_tbl` VALUES ('modifying_a_mailing_list.htm', 'mailinglists');
INSERT INTO `doc_mapping_tbl` VALUES ('creating_a_mailing_list.htm', 'newMailinglist');
INSERT INTO `doc_mapping_tbl` VALUES ('managing_forms.htm', 'formList');
INSERT INTO `doc_mapping_tbl` VALUES ('this_is_how_forms_work.htm', 'formView');
INSERT INTO `doc_mapping_tbl` VALUES ('using_trackable_links.htm', 'trackableLinkView');
INSERT INTO `doc_mapping_tbl` VALUES ('managing_actions.htm', 'actionList');
INSERT INTO `doc_mapping_tbl` VALUES ('creating_a_new_action.htm', 'newAction');
INSERT INTO `doc_mapping_tbl` VALUES ('managing_profile_fields.htm', 'profileFieldList');
INSERT INTO `doc_mapping_tbl` VALUES ('creating_new_fields.htm', 'newProfileField');
INSERT INTO `doc_mapping_tbl` VALUES ('creating_a_new_user_and_changi.htm', 'newUser');
INSERT INTO `doc_mapping_tbl` VALUES ('assigning_user_rights2.htm', 'userRights');
INSERT INTO `doc_mapping_tbl` VALUES ('bounce-filter.htm', 'bounceFilter');
INSERT INTO `doc_mapping_tbl` VALUES ('user_log.htm', 'userlog');
INSERT INTO `doc_mapping_tbl` VALUES ('automatic_update_of_openemm.htm', 'update');
INSERT INTO `doc_mapping_tbl` VALUES ('feedback_analysis_openemm.htm', 'feedbackAnalysis');
INSERT INTO `doc_mapping_tbl` VALUES ('ip_statistics.htm', 'ipStatistics');
INSERT INTO `doc_mapping_tbl` VALUES ('the_plugins_at_a_glance.htm', 'pluginmanagerList');
INSERT INTO `doc_mapping_tbl` VALUES ('auto-import.htm', 'autoImport');
INSERT INTO `doc_mapping_tbl` VALUES ('auto-export.htm', 'autoExport');

-- ----------------------------
-- Table structure for `dyn_content_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `dyn_content_tbl`;
CREATE TABLE `dyn_content_tbl` (
  `dyn_content_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dyn_name_id` int(10) unsigned NOT NULL DEFAULT '0',
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dyn_content` longtext COLLATE utf8_unicode_ci,
  `dyn_order` int(10) unsigned DEFAULT NULL,
  `target_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`dyn_content_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of dyn_content_tbl
-- ----------------------------
INSERT INTO `dyn_content_tbl` VALUES ('1', '23', '1', '[agnIMAGE name=\"logo.jpg\"]', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('2', '1', '1', 'Firmenname für Textversion', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('3', '2', '1', '[agnDATE]', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('4', '4', '1', 'Ihre<br>\r\nSuper-Firma', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('5', '20', '1', 'http://www.meine-firma.de/form.do?agnCI=1&agnFN=de_profil&agnUID=##AGNUID##', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('6', '21', '1', 'http://www.meine-firma.de/form.do?agnCI=1&agnFN=de_unsubscribe&agnUID=##AGNUID##', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('7', '22', '1', 'Ihre Firma, www.meine-firma.de<br>\r\nTelefon: xxx/12343567 ...<br><br>\r\nVorstand: xxx<br>\r\nRegistergericht ...', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('8', '55', '1', '[agnIMAGE name=\"logo.jpg\"]', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('9', '33', '1', 'name of company for textversion', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('10', '34', '1', '[agnDATE]', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('11', '36', '1', 'your<br>\r\nsuper company', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('12', '52', '1', 'http://www.my-company.de/form.do?agnCI=1&agnFN=en_profil&agnUID=##AGNUID##', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('13', '53', '1', 'http://www.my-company.de/form.do?agnCI=1&agnFN=en_unsubscribe&agnUID=##AGNUID##', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('14', '54', '1', 'Your company, www.my-company.de<br>\r\nFon: xxxx/12343567 ...<br>', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('15', '65', '1', '**********************************************************************\r\n                       Newsletter Anmeldung\r\n**********************************************************************\r\n\r\n[agnTITLE type=2],\r\n\r\nvielen Dank, dass Sie sich für unseren Newsletter interessieren.\r\nUm Ihr Abonnement zu bestätigen, klicken Sie bitte auf folgenden\r\nAktivierungslink:\r\n\r\nhttp://www.meine-firma.de/form.do?agnCI=1&agnFN=de_doi_welcome&agnUID=##AGNUID##\r\n(ACHTUNG: Bitte www.meine-firma.de auf Ihren rdir-Link anpassen\r\nund Link-Messung aktivieren!)\r\n\r\nHaben Sie unseren Newsletter nicht abonniert oder wurden fälschlicher\r\nWeise bei uns angemeldet, müssen Sie nichts weiter unternehmen.\r\n\r\nMit freundlichen Grüßen\r\n\r\nIhr online-Team\r\n\r\n**********************************************************************\r\nImpressum:\r\nFirmenname\r\nStrasse ...', '1', '0');
INSERT INTO `dyn_content_tbl` VALUES ('16', '67', '1', '**********************************************************************\r\n                       newsletter registration\r\n**********************************************************************\r\n\r\n[agnTITLE type=1],\r\n\r\nthank you for your interest in our newsletter. To activate the\r\nabonnement please click the following link:\r\n\r\nhttp://www.my-company.de/form.do?agnCI=1&agnFN=en_doi_welcome&agnUID=##AGNUID##\r\n(WARNING: Please change www.my-company.de to your rdir-link and be\r\nsure that linktracking is activated!)\r\n\r\nGreetings\r\n\r\nyour online-team\r\n\r\n**********************************************************************\r\nImprint:\r\nname of company ...', '1', '0');

-- ----------------------------
-- Table structure for `dyn_name_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `dyn_name_tbl`;
CREATE TABLE `dyn_name_tbl` (
  `dyn_name_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mailing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dyn_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dyn_name_id`),
  KEY `mailing_id` (`mailing_id`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of dyn_name_tbl
-- ----------------------------
INSERT INTO `dyn_name_tbl` VALUES ('1', '1', '1', '0.1.1 Header-Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('2', '1', '1', '0.2 date', '0');
INSERT INTO `dyn_name_tbl` VALUES ('3', '1', '1', '0.3 Intro-text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('4', '1', '1', '0.4 Greeting', '0');
INSERT INTO `dyn_name_tbl` VALUES ('5', '1', '1', '1.0 Headline ****', '0');
INSERT INTO `dyn_name_tbl` VALUES ('6', '1', '1', '1.1 Sub-headline', '0');
INSERT INTO `dyn_name_tbl` VALUES ('7', '1', '1', '1.2 Content', '0');
INSERT INTO `dyn_name_tbl` VALUES ('8', '1', '1', '1.3 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('9', '1', '1', '1.4 Link-Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('10', '1', '1', '2.0 Headline ****', '0');
INSERT INTO `dyn_name_tbl` VALUES ('11', '1', '1', '2.1 Sub-headline', '0');
INSERT INTO `dyn_name_tbl` VALUES ('12', '1', '1', '2.2 Content', '0');
INSERT INTO `dyn_name_tbl` VALUES ('13', '1', '1', '2.3 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('14', '1', '1', '2.4 Link-Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('15', '1', '1', '3.0 Headline ****', '0');
INSERT INTO `dyn_name_tbl` VALUES ('16', '1', '1', '3.1 Sub-headline', '0');
INSERT INTO `dyn_name_tbl` VALUES ('17', '1', '1', '3.2 Content', '0');
INSERT INTO `dyn_name_tbl` VALUES ('18', '1', '1', '3.3 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('19', '1', '1', '3.4 Link-Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('20', '1', '1', '9.0 change-profil-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('21', '1', '1', '9.1 unsubscribe-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('22', '1', '1', '9.2 imprint', '0');
INSERT INTO `dyn_name_tbl` VALUES ('23', '1', '1', '0.1 Header-image', '0');
INSERT INTO `dyn_name_tbl` VALUES ('24', '1', '1', '1.5 Image-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('25', '1', '1', '1.7 Image-URL-1', '0');
INSERT INTO `dyn_name_tbl` VALUES ('26', '1', '1', '1.6 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('27', '1', '1', '2.5 Image-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('28', '1', '1', '2.7 Image-URL-1', '0');
INSERT INTO `dyn_name_tbl` VALUES ('29', '1', '1', '2.6 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('30', '1', '1', '3.5 Image-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('31', '1', '1', '3.7 Image-URL-1', '0');
INSERT INTO `dyn_name_tbl` VALUES ('32', '1', '1', '3.6 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('33', '2', '1', '0.1.1 Header-Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('34', '2', '1', '0.2 date', '0');
INSERT INTO `dyn_name_tbl` VALUES ('35', '2', '1', '0.3 Intro-text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('36', '2', '1', '0.4 Greeting', '0');
INSERT INTO `dyn_name_tbl` VALUES ('37', '2', '1', '1.0 Headline ****', '0');
INSERT INTO `dyn_name_tbl` VALUES ('38', '2', '1', '1.1 Sub-headline', '0');
INSERT INTO `dyn_name_tbl` VALUES ('39', '2', '1', '1.2 Content', '0');
INSERT INTO `dyn_name_tbl` VALUES ('40', '2', '1', '1.3 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('41', '2', '1', '1.4 Link-Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('42', '2', '1', '2.0 Headline ****', '0');
INSERT INTO `dyn_name_tbl` VALUES ('43', '2', '1', '2.1 Sub-headline', '0');
INSERT INTO `dyn_name_tbl` VALUES ('44', '2', '1', '2.2 Content', '0');
INSERT INTO `dyn_name_tbl` VALUES ('45', '2', '1', '2.3 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('46', '2', '1', '2.4 Link-Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('47', '2', '1', '3.0 Headline ****', '0');
INSERT INTO `dyn_name_tbl` VALUES ('48', '2', '1', '3.1 Sub-headline', '0');
INSERT INTO `dyn_name_tbl` VALUES ('49', '2', '1', '3.2 Content', '0');
INSERT INTO `dyn_name_tbl` VALUES ('50', '2', '1', '3.3 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('51', '2', '1', '3.4 Link-Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('52', '2', '1', '9.0 change-profil-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('53', '2', '1', '9.1 unsubscribe-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('54', '2', '1', '9.2 imprint', '0');
INSERT INTO `dyn_name_tbl` VALUES ('55', '2', '1', '0.1 Header-image', '0');
INSERT INTO `dyn_name_tbl` VALUES ('56', '2', '1', '1.5 Image-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('57', '2', '1', '1.7 Image-URL-1', '0');
INSERT INTO `dyn_name_tbl` VALUES ('58', '2', '1', '1.6 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('59', '2', '1', '2.5 Image-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('60', '2', '1', '2.7 Image-URL-1', '0');
INSERT INTO `dyn_name_tbl` VALUES ('61', '2', '1', '2.6 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('62', '2', '1', '3.5 Image-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('63', '2', '1', '3.7 Image-URL-1', '0');
INSERT INTO `dyn_name_tbl` VALUES ('64', '2', '1', '3.6 Link-URL', '0');
INSERT INTO `dyn_name_tbl` VALUES ('65', '3', '1', 'Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('66', '3', '1', 'HTML-Version', '0');
INSERT INTO `dyn_name_tbl` VALUES ('67', '4', '1', 'Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('68', '4', '1', 'HTML-Version', '0');
INSERT INTO `dyn_name_tbl` VALUES ('69', '5', '1', 'Text', '0');
INSERT INTO `dyn_name_tbl` VALUES ('70', '5', '1', 'HTML-Version', '0');

-- ----------------------------
-- Table structure for `dyn_target_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `dyn_target_tbl`;
CREATE TABLE `dyn_target_tbl` (
  `target_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `target_shortname` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `target_description` text COLLATE utf8_unicode_ci,
  `target_sql` text COLLATE utf8_unicode_ci,
  `target_representation` blob,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`target_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of dyn_target_tbl
-- ----------------------------
INSERT INTO `dyn_target_tbl` VALUES ('1', '1', 'Khu vuc ha noi', 'Khu vuc ha noi', '(  ( lower(cust.EMAIL) = lower(\'\'))  )', 0xACED0005737200306F72672E61676E697461732E7461726765742E696D706C2E546172676574526570726573656E746174696F6E496D706CB8F6FC8363F901CD0200014C0008616C6C4E6F6465737400104C6A6176612F7574696C2F4C6973743B7870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200286F72672E61676E697461732E7461726765742E696D706C2E5461726765744E6F6465537472696E67B5918A04DEB6756F02000749000D636861696E4F70657261746F725A0011636C6F7365427261636B657441667465725A00116F70656E427261636B65744265666F726549000F7072696D6172794F70657261746F724C000C7072696D6172794669656C647400124C6A6176612F6C616E672F537472696E673B4C00107072696D6172794669656C645479706571007E00064C000C7072696D61727956616C756571007E0006787000000000000000000001740005454D41494C7400075641524348415274000078, '0', '2017-02-17 23:25:23', '2017-02-17 23:25:23');
INSERT INTO `dyn_target_tbl` VALUES ('2', '1', 'Khach muc tieu 1', 'Khach muc tieu 1', '(  ( lower(cust.EMAIL) = lower(\'\'))  )', 0xACED0005737200306F72672E61676E697461732E7461726765742E696D706C2E546172676574526570726573656E746174696F6E496D706CB8F6FC8363F901CD0200014C0008616C6C4E6F6465737400104C6A6176612F7574696C2F4C6973743B7870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200286F72672E61676E697461732E7461726765742E696D706C2E5461726765744E6F6465537472696E67B5918A04DEB6756F02000749000D636861696E4F70657261746F725A0011636C6F7365427261636B657441667465725A00116F70656E427261636B65744265666F726549000F7072696D6172794F70657261746F724C000C7072696D6172794669656C647400124C6A6176612F6C616E672F537472696E673B4C00107072696D6172794669656C645479706571007E00064C000C7072696D61727956616C756571007E0006787000000000000000000001740005454D41494C7400075641524348415274000078, '1', '2017-02-22 00:40:50', '2017-02-18 17:25:28');
INSERT INTO `dyn_target_tbl` VALUES ('3', '1', 'Khu vuc bac ninh', 'Khu vuc bac ninh', '(  ( lower(cust.EMAIL) = lower(\'\'))  )', 0xACED0005737200306F72672E61676E697461732E7461726765742E696D706C2E546172676574526570726573656E746174696F6E496D706CB8F6FC8363F901CD0200014C0008616C6C4E6F6465737400104C6A6176612F7574696C2F4C6973743B7870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200286F72672E61676E697461732E7461726765742E696D706C2E5461726765744E6F6465537472696E67B5918A04DEB6756F02000749000D636861696E4F70657261746F725A0011636C6F7365427261636B657441667465725A00116F70656E427261636B65744265666F726549000F7072696D6172794F70657261746F724C000C7072696D6172794669656C647400124C6A6176612F6C616E672F537472696E673B4C00107072696D6172794669656C645479706571007E00064C000C7072696D61727956616C756571007E0006787000000000000000000001740005454D41494C7400075641524348415274000078, '0', '2017-02-25 10:16:37', '2017-02-25 10:16:37');
INSERT INTO `dyn_target_tbl` VALUES ('4', '1', 'Copy of Khu vuc bac ninh', 'Khu vuc bac ninh', '(  ( lower(cust.EMAIL) = lower(\'\'))  )', 0xACED0005737200306F72672E61676E697461732E7461726765742E696D706C2E546172676574526570726573656E746174696F6E496D706CB8F6FC8363F901CD0200014C0008616C6C4E6F6465737400104C6A6176612F7574696C2F4C6973743B7870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200286F72672E61676E697461732E7461726765742E696D706C2E5461726765744E6F6465537472696E67B5918A04DEB6756F02000749000D636861696E4F70657261746F725A0011636C6F7365427261636B657441667465725A00116F70656E427261636B65744265666F726549000F7072696D6172794F70657261746F724C000C7072696D6172794669656C647400124C6A6176612F6C616E672F537472696E673B4C00107072696D6172794669656C645479706571007E00064C000C7072696D61727956616C756571007E0006787000000000000000000001740005454D41494C7400075641524348415274000078, '0', '2017-02-25 10:16:41', '2017-02-25 10:16:41');

-- ----------------------------
-- Table structure for `export_predef_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `export_predef_tbl`;
CREATE TABLE `export_predef_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT '0',
  `charset` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ISO-8859-1',
  `column_names` text COLLATE utf8_unicode_ci NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT '0',
  `shortname` text COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `mailinglists` text COLLATE utf8_unicode_ci NOT NULL,
  `mailinglist_id` int(11) NOT NULL DEFAULT '0',
  `delimiter_char` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `separator_char` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `target_id` int(11) NOT NULL DEFAULT '0',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `user_type` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `timestamp_start` timestamp NULL DEFAULT NULL,
  `timestamp_end` timestamp NULL DEFAULT NULL,
  `creation_date_start` timestamp NULL DEFAULT NULL,
  `creation_date_end` timestamp NULL DEFAULT NULL,
  `mailinglist_bind_start` timestamp NULL DEFAULT NULL,
  `mailinglist_bind_end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of export_predef_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `import_column_mapping_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `import_column_mapping_tbl`;
CREATE TABLE `import_column_mapping_tbl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `file_column` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `db_column` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mandatory` tinyint(1) NOT NULL,
  `default_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of import_column_mapping_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `import_gender_mapping_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `import_gender_mapping_tbl`;
CREATE TABLE `import_gender_mapping_tbl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `int_gender` int(10) unsigned NOT NULL,
  `string_gender` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of import_gender_mapping_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `import_log_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `import_log_tbl`;
CREATE TABLE `import_log_tbl` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `imported_lines` int(10) unsigned NOT NULL,
  `datasource_id` int(10) unsigned NOT NULL,
  `statistics` text COLLATE utf8_unicode_ci NOT NULL,
  `profile` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of import_log_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `import_profile_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `import_profile_tbl`;
CREATE TABLE `import_profile_tbl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL,
  `shortname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `column_separator` int(10) unsigned NOT NULL,
  `text_delimiter` int(10) unsigned NOT NULL,
  `file_charset` int(10) unsigned NOT NULL,
  `date_format` int(10) unsigned NOT NULL,
  `import_mode` int(10) unsigned NOT NULL,
  `null_values_action` int(10) unsigned NOT NULL,
  `key_column` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ext_email_check` tinyint(1) NOT NULL,
  `report_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `check_for_duplicates` int(10) unsigned NOT NULL,
  `mail_type` int(10) unsigned NOT NULL,
  `update_all_duplicates` decimal(1,0) DEFAULT '0',
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of import_profile_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `job_queue_parameter_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `job_queue_parameter_tbl`;
CREATE TABLE `job_queue_parameter_tbl` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `parameter_value` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  KEY `job_id` (`job_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of job_queue_parameter_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `job_queue_result_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `job_queue_result_tbl`;
CREATE TABLE `job_queue_result_tbl` (
  `job_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `result` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `duration` int(10) DEFAULT '0',
  `hostname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of job_queue_result_tbl
-- ----------------------------
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-17 23:11:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-17 23:11:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-17 23:11:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-17 23:11:28', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 00:01:06', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 00:01:06', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 01:00:13', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 01:00:13', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 02:00:07', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 02:00:07', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 07:39:27', 'OK', '1', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 07:39:37', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-18 07:39:39', 'OK', '1', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-18 07:39:39', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 08:00:07', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 08:00:07', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 09:00:15', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 09:00:15', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 10:00:15', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 10:00:15', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 11:00:02', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 11:00:03', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 12:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 12:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 13:00:13', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 13:00:13', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 14:00:01', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 14:00:01', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 15:12:01', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 15:12:01', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 16:00:39', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 16:00:39', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 17:00:53', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 17:00:53', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 18:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 18:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 19:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 19:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 20:51:04', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 20:51:04', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 21:00:55', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 21:00:55', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 22:00:05', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 22:00:05', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-18 23:00:37', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-18 23:00:37', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 00:12:12', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 00:12:12', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 03:55:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 03:55:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-19 03:55:28', 'OK', '1', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 08:22:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 08:22:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-19 08:22:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 09:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 09:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 10:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 10:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 11:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 11:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 12:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 12:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 15:48:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 15:48:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 19:03:14', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 19:03:14', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 20:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 20:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 21:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 21:00:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 22:00:30', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 22:00:30', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.42');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-19 23:18:56', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-19 23:18:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-20 00:04:42', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-20 00:04:42', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-20 01:00:19', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-20 01:00:19', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-20 23:23:52', 'OK', '1', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-20 23:23:52', 'OK', '1', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-20 23:23:52', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-20 23:23:53', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 00:00:40', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 00:00:40', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 01:01:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 01:01:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 04:18:17', 'OK', '22', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-21 04:18:35', 'OK', '32', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 04:18:41', 'OK', '4', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-21 04:18:47', 'OK', '4', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 07:16:30', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 07:16:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 08:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 08:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 09:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 09:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 10:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 10:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 11:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 11:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 12:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 12:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 13:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 13:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 14:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 14:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 15:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 15:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 16:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 16:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 17:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 17:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 18:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 18:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 19:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 19:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 20:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 20:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 21:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 21:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 22:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 22:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-21 23:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-21 23:00:29', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-22 00:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-22 00:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-22 01:00:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-22 01:00:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-22 04:04:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-22 04:04:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-22 04:04:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-22 04:04:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-22 07:12:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-22 07:12:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.102');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-22 23:21:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-22 23:21:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-23 00:00:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-23 00:00:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-23 01:00:03', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-23 01:00:04', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-23 21:56:21', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-23 21:56:22', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-23 21:56:22', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-23 21:56:22', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-23 22:00:21', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-23 22:00:21', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-23 23:00:18', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-23 23:00:18', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-24 00:00:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-24 00:00:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-24 01:00:52', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-24 01:00:52', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-24 23:39:28', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-24 23:39:28', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-24 23:39:28', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-24 23:39:28', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.100');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 00:00:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 00:00:27', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 08:30:35', 'OK', '2', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 08:30:38', 'OK', '1', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-25 08:30:41', 'OK', '2', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-25 08:30:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 09:23:18', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 09:23:18', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 10:00:18', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 10:00:18', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 11:01:31', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 11:01:31', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 12:22:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 12:22:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 13:00:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 13:00:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 14:00:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 14:00:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 15:09:56', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 15:09:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 16:00:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 16:00:32', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 17:00:55', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 17:00:55', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 22:12:42', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 22:12:43', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-25 23:00:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-25 23:00:41', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 00:00:39', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 00:00:39', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 01:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 01:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 02:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 02:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 03:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 03:00:39', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-26 03:00:39', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 04:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 04:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-26 04:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 05:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 05:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 06:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 06:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 07:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 07:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 08:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 08:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 09:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 09:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 10:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 10:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.44');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 11:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 11:00:39', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 12:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 12:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 13:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 13:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 14:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 14:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 15:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 15:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 16:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.39');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 16:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.39');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 17:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.39');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 17:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.39');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 18:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.39');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 18:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.1.39');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 22:54:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 22:54:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-26 23:00:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-26 23:00:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-27 00:00:34', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-27 00:00:34', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-27 01:00:30', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-27 01:00:30', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-27 21:21:20', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-27 21:21:20', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-27 21:21:21', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-27 21:21:21', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-27 22:00:09', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-27 22:00:09', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-27 23:00:18', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-27 23:00:18', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-28 00:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-28 00:00:38', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-02-28 23:14:42', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-02-28 23:14:42', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-02-28 23:14:43', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-02-28 23:14:43', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-01 00:11:22', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-01 00:11:22', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-01 01:00:30', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-01 01:00:30', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-01 02:00:34', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-01 02:00:34', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-01 22:52:03', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-01 22:52:03', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-03-01 22:52:04', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-03-01 22:52:04', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-01 23:00:02', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-01 23:00:02', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-02 22:48:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-02 22:48:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-03-02 22:48:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-03-02 22:48:26', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-02 23:00:24', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-02 23:00:25', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 11:44:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 11:44:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('3', '2017-03-04 11:44:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('4', '2017-03-04 11:44:57', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 12:00:06', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 12:00:06', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 13:03:00', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 13:03:00', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 14:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 14:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 15:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 15:00:10', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 16:23:58', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 16:23:58', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 17:05:15', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 17:05:16', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 18:00:19', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 18:00:19', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 19:00:35', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 19:00:35', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 22:21:13', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 22:21:13', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-04 23:00:19', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-04 23:00:19', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('1', '2017-03-05 00:00:50', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');
INSERT INTO `job_queue_result_tbl` VALUES ('2', '2017-03-05 00:00:50', 'OK', '0', 'DESKTOP-5GGPTEH/192.168.0.103');

-- ----------------------------
-- Table structure for `job_queue_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `job_queue_tbl`;
CREATE TABLE `job_queue_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastStart` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `running` int(1) NOT NULL DEFAULT '0',
  `lastResult` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `startAfterError` int(1) NOT NULL DEFAULT '0',
  `lastDuration` int(10) NOT NULL DEFAULT '0',
  `interval` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `nextStart` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hostname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `runClass` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `runOnlyOnHosts` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emailOnError` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of job_queue_tbl
-- ----------------------------
INSERT INTO `job_queue_tbl` VALUES ('1', 'AutoImport', '2014-11-16 21:56:07', '2017-03-05 00:00:50', '0', 'OK', '0', '0', '**00', '2017-03-05 01:00:00', 'DESKTOP-5GGPTEH', 'org.agnitas.emm.core.autoimport.service.AutoImportJobWorker', null, null, '0');
INSERT INTO `job_queue_tbl` VALUES ('2', 'AutoExport', '2014-11-16 21:56:07', '2017-03-05 00:00:50', '0', 'OK', '0', '0', '**00', '2017-03-05 01:00:00', 'DESKTOP-5GGPTEH', 'org.agnitas.emm.core.autoexport.service.AutoExportJobWorker', null, null, '0');
INSERT INTO `job_queue_tbl` VALUES ('3', 'DBCleaner', '2014-11-16 21:56:07', '2017-03-04 11:44:57', '0', 'OK', '0', '0', '0300', '2017-03-05 03:00:00', 'DESKTOP-5GGPTEH', 'org.agnitas.util.quartz.DBCleanerJobWorker', null, null, '0');
INSERT INTO `job_queue_tbl` VALUES ('4', 'LoginTrackTableCleaner', '2014-11-16 21:56:07', '2017-03-04 11:44:57', '0', 'OK', '0', '0', '0400', '2017-03-05 04:00:00', 'DESKTOP-5GGPTEH', 'org.agnitas.util.quartz.LoginTrackTableCleanerJobWorker', null, null, '0');

-- ----------------------------
-- Table structure for `login_track_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `login_track_tbl`;
CREATE TABLE `login_track_tbl` (
  `login_track_id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `login_status` int(11) DEFAULT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`login_track_id`),
  KEY `logtrck$ip_cdate_stat$idx` (`ip_address`,`creation_date`,`login_status`)
) ENGINE=MyISAM AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of login_track_tbl
-- ----------------------------
INSERT INTO `login_track_tbl` VALUES ('1', '0:0:0:0:0:0:0:1', '2017-02-17 23:12:15', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('2', '0:0:0:0:0:0:0:1', '2017-02-17 23:12:25', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('3', '0:0:0:0:0:0:0:1', '2017-02-17 23:12:32', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('4', '0:0:0:0:0:0:0:1', '2017-02-17 23:13:16', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('5', '0:0:0:0:0:0:0:1', '2017-02-17 23:14:46', '20', 'asdfasdf');
INSERT INTO `login_track_tbl` VALUES ('6', '0:0:0:0:0:0:0:1', '2017-02-17 23:14:48', '20', 'asdfasdf');
INSERT INTO `login_track_tbl` VALUES ('7', '0:0:0:0:0:0:0:1', '2017-02-17 23:17:52', '40', 'admin');
INSERT INTO `login_track_tbl` VALUES ('8', '0:0:0:0:0:0:0:1', '2017-02-17 23:18:02', '40', 'admin');
INSERT INTO `login_track_tbl` VALUES ('9', '0:0:0:0:0:0:0:1', '2017-02-17 23:18:17', '40', 'admin');
INSERT INTO `login_track_tbl` VALUES ('10', '0:0:0:0:0:0:0:1', '2017-02-17 23:18:41', '40', 'admin');
INSERT INTO `login_track_tbl` VALUES ('11', '0:0:0:0:0:0:0:1', '2017-02-17 23:20:12', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('12', '0:0:0:0:0:0:0:1', '2017-02-17 23:21:15', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('13', '0:0:0:0:0:0:0:1', '2017-02-17 23:23:37', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('14', '0:0:0:0:0:0:0:1', '2017-02-17 23:32:16', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('15', '0:0:0:0:0:0:0:1', '2017-02-18 00:05:12', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('16', '0:0:0:0:0:0:0:1', '2017-02-18 00:34:42', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('17', '0:0:0:0:0:0:0:1', '2017-02-18 00:49:43', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('18', '0:0:0:0:0:0:0:1', '2017-02-18 01:33:27', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('19', '0:0:0:0:0:0:0:1', '2017-02-18 01:45:56', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('20', '0:0:0:0:0:0:0:1', '2017-02-18 08:52:27', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('21', '0:0:0:0:0:0:0:1', '2017-02-18 10:56:51', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('22', '0:0:0:0:0:0:0:1', '2017-02-18 12:46:27', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('23', '0:0:0:0:0:0:0:1', '2017-02-18 13:08:35', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('24', '0:0:0:0:0:0:0:1', '2017-02-18 15:17:31', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('25', '0:0:0:0:0:0:0:1', '2017-02-18 15:32:43', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('26', '0:0:0:0:0:0:0:1', '2017-02-18 15:52:12', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('27', '0:0:0:0:0:0:0:1', '2017-02-18 15:55:50', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('28', '0:0:0:0:0:0:0:1', '2017-02-18 16:03:57', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('29', '0:0:0:0:0:0:0:1', '2017-02-18 16:15:04', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('30', '0:0:0:0:0:0:0:1', '2017-02-18 17:13:34', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('31', '0:0:0:0:0:0:0:1', '2017-02-18 17:43:13', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('32', '0:0:0:0:0:0:0:1', '2017-02-18 19:20:46', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('33', '0:0:0:0:0:0:0:1', '2017-02-18 20:51:21', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('34', '0:0:0:0:0:0:0:1', '2017-02-18 20:56:15', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('35', '0:0:0:0:0:0:0:1', '2017-02-18 20:59:15', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('36', '0:0:0:0:0:0:0:1', '2017-02-18 23:10:31', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('37', '0:0:0:0:0:0:0:1', '2017-02-19 00:12:40', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('38', '0:0:0:0:0:0:0:1', '2017-02-19 00:16:42', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('39', '0:0:0:0:0:0:0:1', '2017-02-19 00:41:26', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('40', '0:0:0:0:0:0:0:1', '2017-02-19 00:48:54', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('41', '0:0:0:0:0:0:0:1', '2017-02-19 21:41:07', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('42', '0:0:0:0:0:0:0:1', '2017-02-19 21:41:07', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('43', '0:0:0:0:0:0:0:1', '2017-02-19 22:29:06', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('44', '0:0:0:0:0:0:0:1', '2017-02-19 22:33:58', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('45', '0:0:0:0:0:0:0:1', '2017-02-19 22:35:26', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('46', '0:0:0:0:0:0:0:1', '2017-02-19 23:18:57', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('47', '0:0:0:0:0:0:0:1', '2017-02-20 00:04:41', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('48', '0:0:0:0:0:0:0:1', '2017-02-20 01:02:36', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('49', '0:0:0:0:0:0:0:1', '2017-02-20 23:23:55', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('50', '0:0:0:0:0:0:0:1', '2017-02-20 23:38:41', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('51', '0:0:0:0:0:0:0:1', '2017-02-20 23:59:27', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('52', '0:0:0:0:0:0:0:1', '2017-02-21 00:14:44', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('53', '0:0:0:0:0:0:0:1', '2017-02-21 00:33:00', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('54', '0:0:0:0:0:0:0:1', '2017-02-21 00:54:15', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('55', '0:0:0:0:0:0:0:1', '2017-02-21 01:01:36', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('56', '0:0:0:0:0:0:0:1', '2017-02-21 01:06:03', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('57', '0:0:0:0:0:0:0:1', '2017-02-21 22:50:58', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('58', '0:0:0:0:0:0:0:1', '2017-02-21 23:43:23', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('59', '0:0:0:0:0:0:0:1', '2017-02-21 23:51:42', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('60', '0:0:0:0:0:0:0:1', '2017-02-22 00:19:58', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('61', '0:0:0:0:0:0:0:1', '2017-02-22 00:45:30', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('62', '0:0:0:0:0:0:0:1', '2017-02-22 23:25:23', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('63', '0:0:0:0:0:0:0:1', '2017-02-22 23:36:03', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('64', '0:0:0:0:0:0:0:1', '2017-02-22 23:41:36', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('65', '0:0:0:0:0:0:0:1', '2017-02-22 23:56:29', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('66', '0:0:0:0:0:0:0:1', '2017-02-23 00:06:35', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('67', '0:0:0:0:0:0:0:1', '2017-02-23 00:14:19', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('68', '0:0:0:0:0:0:0:1', '2017-02-23 00:21:26', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('69', '0:0:0:0:0:0:0:1', '2017-02-23 00:51:03', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('70', '0:0:0:0:0:0:0:1', '2017-02-23 01:20:06', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('71', '0:0:0:0:0:0:0:1', '2017-02-23 01:27:17', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('72', '0:0:0:0:0:0:0:1', '2017-02-23 01:32:58', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('73', '0:0:0:0:0:0:0:1', '2017-02-23 21:56:41', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('74', '0:0:0:0:0:0:0:1', '2017-02-23 22:06:15', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('75', '0:0:0:0:0:0:0:1', '2017-02-23 22:34:38', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('76', '0:0:0:0:0:0:0:1', '2017-02-23 22:54:27', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('77', '0:0:0:0:0:0:0:1', '2017-02-23 22:58:26', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('78', '0:0:0:0:0:0:0:1', '2017-02-23 23:00:51', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('79', '0:0:0:0:0:0:0:1', '2017-02-23 23:03:27', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('80', '0:0:0:0:0:0:0:1', '2017-02-23 23:07:46', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('81', '0:0:0:0:0:0:0:1', '2017-02-23 23:35:14', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('82', '0:0:0:0:0:0:0:1', '2017-02-23 23:38:23', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('83', '0:0:0:0:0:0:0:1', '2017-02-23 23:40:37', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('84', '0:0:0:0:0:0:0:1', '2017-02-24 00:00:34', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('85', '0:0:0:0:0:0:0:1', '2017-02-24 00:29:22', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('86', '0:0:0:0:0:0:0:1', '2017-02-24 00:49:07', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('87', '0:0:0:0:0:0:0:1', '2017-02-24 00:52:24', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('88', '0:0:0:0:0:0:0:1', '2017-02-24 00:57:58', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('89', '0:0:0:0:0:0:0:1', '2017-02-24 23:40:00', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('90', '0:0:0:0:0:0:0:1', '2017-02-25 00:13:30', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('91', '0:0:0:0:0:0:0:1', '2017-02-25 00:15:01', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('92', '0:0:0:0:0:0:0:1', '2017-02-25 00:17:51', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('93', '0:0:0:0:0:0:0:1', '2017-02-25 00:43:19', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('94', '0:0:0:0:0:0:0:1', '2017-02-25 00:46:28', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('95', '0:0:0:0:0:0:0:1', '2017-02-25 10:14:58', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('96', '0:0:0:0:0:0:0:1', '2017-02-25 10:18:59', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('97', '0:0:0:0:0:0:0:1', '2017-02-25 10:27:28', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('98', '0:0:0:0:0:0:0:1', '2017-02-25 10:57:32', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('99', '0:0:0:0:0:0:0:1', '2017-02-25 11:25:30', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('100', '0:0:0:0:0:0:0:1', '2017-02-25 12:22:34', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('101', '0:0:0:0:0:0:0:1', '2017-02-25 16:34:39', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('102', '0:0:0:0:0:0:0:1', '2017-02-25 17:00:47', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('103', '0:0:0:0:0:0:0:1', '2017-02-25 17:18:42', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('104', '0:0:0:0:0:0:0:1', '2017-02-25 23:12:54', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('105', '0:0:0:0:0:0:0:1', '2017-02-25 23:53:43', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('106', '0:0:0:0:0:0:0:1', '2017-02-26 22:55:02', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('107', '0:0:0:0:0:0:0:1', '2017-02-26 23:11:23', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('108', '0:0:0:0:0:0:0:1', '2017-02-26 23:47:09', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('109', '0:0:0:0:0:0:0:1', '2017-02-26 23:54:18', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('110', '0:0:0:0:0:0:0:1', '2017-02-27 00:17:42', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('111', '0:0:0:0:0:0:0:1', '2017-02-27 00:52:31', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('112', '0:0:0:0:0:0:0:1', '2017-02-27 21:21:20', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('113', '0:0:0:0:0:0:0:1', '2017-02-27 21:37:08', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('114', '0:0:0:0:0:0:0:1', '2017-02-27 22:16:25', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('115', '0:0:0:0:0:0:0:1', '2017-02-27 22:22:43', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('116', '0:0:0:0:0:0:0:1', '2017-02-27 22:46:41', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('117', '0:0:0:0:0:0:0:1', '2017-02-27 23:00:45', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('118', '0:0:0:0:0:0:0:1', '2017-02-27 23:10:37', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('119', '0:0:0:0:0:0:0:1', '2017-02-27 23:30:52', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('120', '0:0:0:0:0:0:0:1', '2017-02-28 23:16:40', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('121', '0:0:0:0:0:0:0:1', '2017-03-01 00:11:55', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('122', '0:0:0:0:0:0:0:1', '2017-03-01 00:14:07', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('123', '0:0:0:0:0:0:0:1', '2017-03-01 00:42:57', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('124', '0:0:0:0:0:0:0:1', '2017-03-01 00:54:22', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('125', '0:0:0:0:0:0:0:1', '2017-03-01 01:22:40', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('126', '0:0:0:0:0:0:0:1', '2017-03-01 22:56:35', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('127', '0:0:0:0:0:0:0:1', '2017-03-01 22:59:03', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('128', '0:0:0:0:0:0:0:1', '2017-03-02 22:48:41', '10', 'anv');
INSERT INTO `login_track_tbl` VALUES ('129', '0:0:0:0:0:0:0:1', '2017-03-02 22:48:49', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('130', '0:0:0:0:0:0:0:1', '2017-03-04 11:46:26', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('131', '0:0:0:0:0:0:0:1', '2017-03-04 11:52:38', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('132', '0:0:0:0:0:0:0:1', '2017-03-04 12:05:05', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('133', '0:0:0:0:0:0:0:1', '2017-03-04 12:08:55', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('134', '0:0:0:0:0:0:0:1', '2017-03-04 12:34:12', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('135', '0:0:0:0:0:0:0:1', '2017-03-04 12:55:29', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('136', '0:0:0:0:0:0:0:1', '2017-03-04 13:03:00', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('137', '0:0:0:0:0:0:0:1', '2017-03-04 13:28:51', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('138', '0:0:0:0:0:0:0:1', '2017-03-04 13:39:12', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('139', '0:0:0:0:0:0:0:1', '2017-03-04 13:56:08', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('140', '0:0:0:0:0:0:0:1', '2017-03-04 16:23:58', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('141', '0:0:0:0:0:0:0:1', '2017-03-04 16:24:00', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('142', '0:0:0:0:0:0:0:1', '2017-03-04 16:24:07', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('143', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:19', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('144', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:20', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('145', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:21', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('146', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:22', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('147', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:22', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('148', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:22', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('149', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:22', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('150', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:22', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('151', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:22', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('152', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:23', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('153', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:23', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('154', '0:0:0:0:0:0:0:1', '2017-03-04 16:25:23', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('155', '0:0:0:0:0:0:0:1', '2017-03-04 16:26:07', '20', 'admin3');
INSERT INTO `login_track_tbl` VALUES ('156', '0:0:0:0:0:0:0:1', '2017-03-04 16:27:31', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('157', '0:0:0:0:0:0:0:1', '2017-03-04 16:31:33', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('158', '0:0:0:0:0:0:0:1', '2017-03-04 16:31:49', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('159', '0:0:0:0:0:0:0:1', '2017-03-04 16:31:55', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('160', '0:0:0:0:0:0:0:1', '2017-03-04 16:32:38', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('161', '0:0:0:0:0:0:0:1', '2017-03-04 16:33:49', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('162', '0:0:0:0:0:0:0:1', '2017-03-04 16:34:41', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('163', '0:0:0:0:0:0:0:1', '2017-03-04 16:44:41', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('164', '0:0:0:0:0:0:0:1', '2017-03-04 16:45:57', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('165', '0:0:0:0:0:0:0:1', '2017-03-04 16:48:20', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('166', '0:0:0:0:0:0:0:1', '2017-03-04 16:52:23', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('167', '0:0:0:0:0:0:0:1', '2017-03-04 16:52:35', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('168', '0:0:0:0:0:0:0:1', '2017-03-04 16:56:06', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('169', '0:0:0:0:0:0:0:1', '2017-03-04 17:05:39', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('170', '0:0:0:0:0:0:0:1', '2017-03-04 17:07:58', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('171', '0:0:0:0:0:0:0:1', '2017-03-04 17:08:35', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('172', '0:0:0:0:0:0:0:1', '2017-03-04 17:13:54', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('173', '0:0:0:0:0:0:0:1', '2017-03-04 17:19:14', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('174', '0:0:0:0:0:0:0:1', '2017-03-04 17:35:14', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('175', '0:0:0:0:0:0:0:1', '2017-03-04 18:30:40', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('176', '0:0:0:0:0:0:0:1', '2017-03-04 18:30:56', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('177', '0:0:0:0:0:0:0:1', '2017-03-04 18:31:34', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('178', '0:0:0:0:0:0:0:1', '2017-03-04 18:55:19', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('179', '0:0:0:0:0:0:0:1', '2017-03-04 18:59:30', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('180', '0:0:0:0:0:0:0:1', '2017-03-04 19:03:05', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('181', '0:0:0:0:0:0:0:1', '2017-03-04 19:05:47', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('182', '0:0:0:0:0:0:0:1', '2017-03-04 19:06:10', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('183', '0:0:0:0:0:0:0:1', '2017-03-04 19:06:51', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('184', '0:0:0:0:0:0:0:1', '2017-03-04 19:09:24', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('185', '0:0:0:0:0:0:0:1', '2017-03-04 19:12:46', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('186', '0:0:0:0:0:0:0:1', '2017-03-04 19:19:49', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('187', '0:0:0:0:0:0:0:1', '2017-03-04 19:22:38', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('188', '0:0:0:0:0:0:0:1', '2017-03-04 19:27:34', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('189', '0:0:0:0:0:0:0:1', '2017-03-04 19:31:49', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('190', '0:0:0:0:0:0:0:1', '2017-03-04 19:35:04', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('191', '0:0:0:0:0:0:0:1', '2017-03-04 19:44:05', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('192', '0:0:0:0:0:0:0:1', '2017-03-04 19:46:53', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('193', '0:0:0:0:0:0:0:1', '2017-03-04 19:51:21', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('194', '0:0:0:0:0:0:0:1', '2017-03-04 22:21:41', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('195', '0:0:0:0:0:0:0:1', '2017-03-04 22:22:18', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('196', '0:0:0:0:0:0:0:1', '2017-03-04 22:29:36', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('197', '0:0:0:0:0:0:0:1', '2017-03-04 22:34:55', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('198', '0:0:0:0:0:0:0:1', '2017-03-04 22:42:53', '10', 'adminsaigon');
INSERT INTO `login_track_tbl` VALUES ('199', '0:0:0:0:0:0:0:1', '2017-03-04 22:43:05', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('200', '0:0:0:0:0:0:0:1', '2017-03-04 22:56:33', '20', 'test11');
INSERT INTO `login_track_tbl` VALUES ('201', '0:0:0:0:0:0:0:1', '2017-03-04 22:56:34', '20', 'test11');
INSERT INTO `login_track_tbl` VALUES ('202', '0:0:0:0:0:0:0:1', '2017-03-04 22:56:37', '20', 'admin');
INSERT INTO `login_track_tbl` VALUES ('203', '0:0:0:0:0:0:0:1', '2017-03-04 22:56:46', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('204', '0:0:0:0:0:0:0:1', '2017-03-04 23:00:34', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('205', '0:0:0:0:0:0:0:1', '2017-03-04 23:07:45', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('206', '0:0:0:0:0:0:0:1', '2017-03-04 23:12:10', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('207', '0:0:0:0:0:0:0:1', '2017-03-04 23:19:24', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('208', '0:0:0:0:0:0:0:1', '2017-03-04 23:38:05', '10', 'admin');
INSERT INTO `login_track_tbl` VALUES ('209', '0:0:0:0:0:0:0:1', '2017-03-04 23:38:06', '10', 'admin');

-- ----------------------------
-- Table structure for `maildrop_status_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `maildrop_status_tbl`;
CREATE TABLE `maildrop_status_tbl` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT '0',
  `status_field` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mailing_id` int(11) NOT NULL DEFAULT '0',
  `senddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `step` int(11) DEFAULT NULL,
  `blocksize` int(11) DEFAULT NULL,
  `gendate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `genstatus` int(1) DEFAULT NULL,
  `genchange` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of maildrop_status_tbl
-- ----------------------------
INSERT INTO `maildrop_status_tbl` VALUES ('1', '1', 'E', '3', '2008-02-12 17:54:32', '0', '0', '2008-02-12 17:54:32', '1', '2008-02-12 17:54:32');
INSERT INTO `maildrop_status_tbl` VALUES ('3', '1', 'E', '4', '2008-02-26 17:53:32', '0', '0', '2008-02-26 17:53:32', '1', '2008-02-26 17:53:33');

-- ----------------------------
-- Table structure for `mailinglist_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mailinglist_tbl`;
CREATE TABLE `mailinglist_tbl` (
  `mailinglist_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `shortname` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` int(1) DEFAULT '0',
  KEY `mailinglist_id` (`mailinglist_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of mailinglist_tbl
-- ----------------------------
INSERT INTO `mailinglist_tbl` VALUES ('1', '1', '', 'mailinglist', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0');
INSERT INTO `mailinglist_tbl` VALUES ('2', '1', 'xxxx', 'xxxx', '2017-02-21 00:25:17', '2017-02-23 01:07:33', '1');
INSERT INTO `mailinglist_tbl` VALUES ('3', '1', 'XXX', 'xxX', '2017-02-23 01:07:42', '2017-02-25 10:16:09', '1');
INSERT INTO `mailinglist_tbl` VALUES ('4', '1', 'NHom 2', 'NHom 2', '2017-02-25 10:15:44', '2017-02-25 10:17:42', '1');
INSERT INTO `mailinglist_tbl` VALUES ('5', '1', 'Mô tả', 'Nhập tên', '2017-02-25 10:17:10', '2017-02-25 10:17:10', '0');
INSERT INTO `mailinglist_tbl` VALUES ('6', '1', 'Mô tả 1', 'Nhập tên 1', '2017-02-25 10:31:51', '2017-02-25 10:31:51', '0');
INSERT INTO `mailinglist_tbl` VALUES ('7', '1', 'Mô tảdd', 'Nhập tên dd', '2017-02-25 10:40:54', '2017-02-25 10:41:06', '0');
INSERT INTO `mailinglist_tbl` VALUES ('8', '1', 'à ', 'xxx ', '2017-02-25 10:48:49', '2017-03-04 11:47:39', '1');

-- ----------------------------
-- Table structure for `mailing_account_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mailing_account_tbl`;
CREATE TABLE `mailing_account_tbl` (
  `mailing_id` int(11) NOT NULL DEFAULT '0',
  `company_id` int(11) NOT NULL DEFAULT '0',
  `mailtype` int(11) NOT NULL DEFAULT '0',
  `no_of_mailings` int(11) NOT NULL DEFAULT '0',
  `no_of_bytes` int(11) NOT NULL DEFAULT '0',
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `maildrop_id` int(11) NOT NULL DEFAULT '0',
  `mailing_account_id` int(11) NOT NULL DEFAULT '0',
  `status_field` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `blocknr` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of mailing_account_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `mailing_backend_log_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mailing_backend_log_tbl`;
CREATE TABLE `mailing_backend_log_tbl` (
  `mailing_id` int(10) DEFAULT NULL,
  `current_mails` int(10) DEFAULT NULL,
  `total_mails` int(10) DEFAULT NULL,
  `change_date` timestamp NULL DEFAULT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
  `status_id` int(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of mailing_backend_log_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `mailing_mt_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mailing_mt_tbl`;
CREATE TABLE `mailing_mt_tbl` (
  `mailing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `param` text COLLATE utf8_unicode_ci NOT NULL,
  `mediatype` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `mailing_id` (`mailing_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of mailing_mt_tbl
-- ----------------------------
INSERT INTO `mailing_mt_tbl` VALUES ('1', 'from=\"Absender anpassen <noreply@openemm.org>\", subject=\"Bitte Betreff einfügen!\", charset=\"ISO-8859-1\", linefeed=\"72\", mailformat=\"2\", reply=\"Absender anpassen <noreply@openemm.org>\", onepixlog=\"bottom\", ', '0');
INSERT INTO `mailing_mt_tbl` VALUES ('2', 'from=\"change sender name <noreply@openemm.org>\", subject=\"insert subject please!\", charset=\"ISO-8859-1\", linefeed=\"72\", mailformat=\"2\", reply=\"change sender name <noreply@openemm.org>\", onepixlog=\"bottom\", ', '0');
INSERT INTO `mailing_mt_tbl` VALUES ('3', 'from=\"change sender name <noreply@openemm.org>\", subject=\"Bitte aktivieren: Ihre Anmeldung zum Newsletter\", charset=\"ISO-8859-1\", linefeed=\"72\", mailformat=\"0\", reply=\"change sender name <noreply@openemm.org>\", onepixlog=\"none\", ', '0');
INSERT INTO `mailing_mt_tbl` VALUES ('4', 'from=\"change sender name <noreply@openemm.org>\", subject=\"please activate: your newsletter subscription\", charset=\"ISO-8859-1\", linefeed=\"72\", mailformat=\"0\", reply=\"change sender name <noreply@openemm.org>\", onepixlog=\"none\", ', '0');
INSERT INTO `mailing_mt_tbl` VALUES ('5', 'from=\"Tets1 <haophamtrong@gmail.com>\", subject=\"Test1\", charset=\"UTF-8\", linefeed=\"72\", mailformat=\"2\", reply=\"Tets1 <haophamtrong@gmail.com>\", onepixlog=\"top\", ', '0');

-- ----------------------------
-- Table structure for `mailing_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mailing_tbl`;
CREATE TABLE `mailing_tbl` (
  `mailing_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `campaign_id` int(11) unsigned NOT NULL DEFAULT '0',
  `shortname` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `mailing_type` int(10) unsigned NOT NULL DEFAULT '0',
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mailtemplate_id` int(10) unsigned DEFAULT '0',
  `is_template` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` int(10) unsigned NOT NULL DEFAULT '0',
  `target_expression` text COLLATE utf8_unicode_ci,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mailinglist_id` int(10) unsigned NOT NULL DEFAULT '0',
  `needs_target` int(10) unsigned NOT NULL DEFAULT '0',
  `archived` int(11) unsigned NOT NULL DEFAULT '0',
  `cms_has_classic_content` int(1) NOT NULL DEFAULT '0',
  `dynamic_template` int(1) NOT NULL DEFAULT '0',
  `openaction_id` int(11) unsigned DEFAULT '0',
  `clickaction_id` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`mailing_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of mailing_tbl
-- ----------------------------
INSERT INTO `mailing_tbl` VALUES ('1', '1', '0', 'de_template', 'created by eMM-Xpress', '0', '2008-02-12 17:30:14', '0', '1', '0', '', '2011-01-28 15:20:02', '1', '0', '0', '1', '0', '0', '0');
INSERT INTO `mailing_tbl` VALUES ('2', '1', '0', 'en_template', 'created by eMM-Xpress', '0', '2008-02-12 17:47:21', '0', '1', '0', '', '2011-01-28 15:20:02', '1', '0', '0', '1', '0', '0', '0');
INSERT INTO `mailing_tbl` VALUES ('3', '1', '0', 'de_doi_mail', 'double-opt-in mail, subscribe link', '1', '2008-02-12 17:54:06', '0', '0', '0', '', '2011-01-28 15:20:02', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `mailing_tbl` VALUES ('4', '1', '0', 'en_doi_mail', 'double-opt-in mail, subscribe link', '1', '2008-02-12 17:57:13', '0', '0', '0', '', '2011-01-28 15:20:02', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `mailing_tbl` VALUES ('5', '1', '0', 'Test1', 'Test1', '0', '2017-02-23 00:07:20', '0', '0', '0', '', '2017-02-23 00:07:20', '1', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `mailloop_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mailloop_tbl`;
CREATE TABLE `mailloop_tbl` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `shortname` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `forward` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `forward_enable` int(10) unsigned NOT NULL DEFAULT '0',
  `ar_enable` int(10) unsigned NOT NULL DEFAULT '0',
  `ar_sender` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ar_subject` text COLLATE utf8_unicode_ci NOT NULL,
  `ar_text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ar_html` longtext COLLATE utf8_unicode_ci NOT NULL,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subscribe_enable` int(1) unsigned NOT NULL DEFAULT '0',
  `mailinglist_id` int(11) unsigned NOT NULL DEFAULT '0',
  `form_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`rid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of mailloop_tbl
-- ----------------------------
INSERT INTO `mailloop_tbl` VALUES ('1', '1', 'Không thành công tháng 1', 'Không thành công tháng 1', '', '0', '0', '', '', '', '', '2017-02-23 01:14:46', '0', '1', '1');

-- ----------------------------
-- Table structure for `mailtrack_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mailtrack_tbl`;
CREATE TABLE `mailtrack_tbl` (
  `mailtrack_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) DEFAULT NULL,
  `mailing_id` int(10) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`mailtrack_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of mailtrack_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `mbf_company_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mbf_company_tbl`;
CREATE TABLE `mbf_company_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(500) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mbf_company_tbl
-- ----------------------------
INSERT INTO `mbf_company_tbl` VALUES ('1', 'Mobifone Hà Nội', 'Mobifone Hà Nội', '0');
INSERT INTO `mbf_company_tbl` VALUES ('2', 'Mobifone Sài Gòn', 'Mobifone Sài Gòn', '0');
INSERT INTO `mbf_company_tbl` VALUES ('3', 'Mobifone Đà Nẵng', 'Mobifone Đà Nẵng', '0');
INSERT INTO `mbf_company_tbl` VALUES ('4', 'Mobifone Cần Thơ', 'Mobifone Cần Thơ', '0');
INSERT INTO `mbf_company_tbl` VALUES ('5', 'Mobifone Huế', 'Mobifone Huế', '0');
INSERT INTO `mbf_company_tbl` VALUES ('7', 'Mobifone Hải Phòng 1', 'Mobifone Hải Phòng 1', '0');
INSERT INTO `mbf_company_tbl` VALUES ('11', 'Mobifone Lào cai', 'Mobifone Lào cai', '0');

-- ----------------------------
-- Table structure for `mbf_department_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `mbf_department_tbl`;
CREATE TABLE `mbf_department_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `department_name` varchar(500) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mbf_department_tbl
-- ----------------------------
INSERT INTO `mbf_department_tbl` VALUES ('2', '1', 'department 1', 'department 1 des', '0');
INSERT INTO `mbf_department_tbl` VALUES ('3', '1', 'department 2', 'department 2', '0');
INSERT INTO `mbf_department_tbl` VALUES ('5', '1', 'Mobifone việt nam', 'Mobifone việt nam', '0');
INSERT INTO `mbf_department_tbl` VALUES ('28', '1', 'depatment 100', 'depatment 100', '0');
INSERT INTO `mbf_department_tbl` VALUES ('29', '1', 'Hải Phòng 1', 'Hải Phòng 1', '0');
INSERT INTO `mbf_department_tbl` VALUES ('30', '2', 'Hải Phòng 1', 'Hải Phòng 1', '0');
INSERT INTO `mbf_department_tbl` VALUES ('31', '3', 'Hải Phòng 12', 'Hải Phòng 12', '0');
INSERT INTO `mbf_department_tbl` VALUES ('32', '3', 'Danang 1', 'Danang 1', '0');
INSERT INTO `mbf_department_tbl` VALUES ('33', '3', 'Danang 1', 'Danang 1', '0');
INSERT INTO `mbf_department_tbl` VALUES ('34', '3', 'dang nang 2', 'da nagn 2', '0');
INSERT INTO `mbf_department_tbl` VALUES ('39', '2', 'abtt2', 'abtt2', '0');
INSERT INTO `mbf_department_tbl` VALUES ('44', '3', 'test12', 'test12', '0');
INSERT INTO `mbf_department_tbl` VALUES ('45', '71', 'tets 1', 'test1', '0');

-- ----------------------------
-- Table structure for `onepixel_log_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `onepixel_log_tbl`;
CREATE TABLE `onepixel_log_tbl` (
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `mailing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0',
  `open_count` int(10) unsigned NOT NULL DEFAULT '1',
  `change_date` timestamp NULL DEFAULT NULL,
  `ip_adr` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of onepixel_log_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `plugins_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `plugins_tbl`;
CREATE TABLE `plugins_tbl` (
  `plugin_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `activate_on_startup` int(1) NOT NULL,
  PRIMARY KEY (`plugin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of plugins_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `rdir_action_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `rdir_action_tbl`;
CREATE TABLE `rdir_action_tbl` (
  `action_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shortname` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `action_type` int(10) unsigned NOT NULL DEFAULT '0',
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `operations` blob,
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`action_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of rdir_action_tbl
-- ----------------------------
INSERT INTO `rdir_action_tbl` VALUES ('1', 'doi_user_confirm', 'step 1/2: confirm user', '1', '1', 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000177040000000A7372002B6F72672E61676E697461732E616374696F6E732E6F70732E4163746976617465446F75626C654F7074496E6C8B81A57A32855A020000787078, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0');
INSERT INTO `rdir_action_tbl` VALUES ('2', 'doi_user_register (de)', 'step 2/2: save user data, send doi-mail', '1', '1', 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000A737200296F72672E61676E697461732E616374696F6E732E6F70732E537562736372696265437573746F6D65722AD691805687516A0200035A000B646F75626C65436865636B5A000B646F75626C654F7074496E4C00096B6579436F6C756D6E7400124C6A6176612F6C616E672F537472696E673B78700101740005656D61696C737200236F72672E61676E697461732E616374696F6E732E6F70732E53656E644D61696C696E6709E1AF9AA34EBEAB02000249000C64656C61794D696E757465734900096D61696C696E6749447870000000000000000378, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0');
INSERT INTO `rdir_action_tbl` VALUES ('3', 'doi_user_register (en)', 'step 2/2: save user data, send doi-mail', '1', '1', 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000A737200296F72672E61676E697461732E616374696F6E732E6F70732E537562736372696265437573746F6D65722AD691805687516A0200035A000B646F75626C65436865636B5A000B646F75626C654F7074496E4C00096B6579436F6C756D6E7400124C6A6176612F6C616E672F537472696E673B78700101740005656D61696C737200236F72672E61676E697461732E616374696F6E732E6F70732E53656E644D61696C696E6709E1AF9AA34EBEAB02000249000C64656C61794D696E757465734900096D61696C696E6749447870000000000000000478, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0');
INSERT INTO `rdir_action_tbl` VALUES ('4', 'user_get_data', 'load data from database', '1', '1', 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000177040000000A737200236F72672E61676E697461732E616374696F6E732E6F70732E476574437573746F6D65729A70BAE4FE18BCD30200015A000A6C6F6164416C7761797378700078, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0');
INSERT INTO `rdir_action_tbl` VALUES ('5', 'user_subscribe', 'subscribe user', '1', '1', 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000177040000000A737200296F72672E61676E697461732E616374696F6E732E6F70732E537562736372696265437573746F6D65722AD691805687516A0200035A000B646F75626C65436865636B5A000B646F75626C654F7074496E4C00096B6579436F6C756D6E7400124C6A6176612F6C616E672F537472696E673B78700100740005656D61696C78, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0');
INSERT INTO `rdir_action_tbl` VALUES ('6', 'user_unsubscribe', 'unsubscribe user', '1', '1', 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000177040000000A7372002B6F72672E61676E697461732E616374696F6E732E6F70732E556E737562736372696265437573746F6D657216BBF6CEE04FB108020000787078, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `rdir_log_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `rdir_log_tbl`;
CREATE TABLE `rdir_log_tbl` (
  `company_id` int(11) NOT NULL DEFAULT '0',
  `customer_id` int(11) NOT NULL DEFAULT '0',
  `mailing_id` int(11) NOT NULL DEFAULT '0',
  `ip_adr` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `url_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of rdir_log_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `rdir_url_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `rdir_url_tbl`;
CREATE TABLE `rdir_url_tbl` (
  `url_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `mailing_id` int(10) unsigned NOT NULL DEFAULT '0',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0',
  `measure_type` int(10) unsigned NOT NULL DEFAULT '0',
  `full_url` text COLLATE utf8_unicode_ci NOT NULL,
  `shortname` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `relevance` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`url_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of rdir_url_tbl
-- ----------------------------
INSERT INTO `rdir_url_tbl` VALUES ('1', '1', '1', '0', '3', 'http://www.meine-firma.de/form.do?agnCI=1&agnFN=de_profil&agnUID=##AGNUID##', null, '0');
INSERT INTO `rdir_url_tbl` VALUES ('2', '1', '1', '0', '3', 'http://www.meine-firma.de/form.do?agnCI=1&agnFN=de_unsubscribe&agnUID=##AGNUID##', null, '0');
INSERT INTO `rdir_url_tbl` VALUES ('3', '1', '2', '0', '3', 'http://www.my-company.de/form.do?agnCI=1&agnFN=en_profil&agnUID=##AGNUID##', null, '0');
INSERT INTO `rdir_url_tbl` VALUES ('4', '1', '2', '0', '3', 'http://www.my-company.de/form.do?agnCI=1&agnFN=en_unsubscribe&agnUID=##AGNUID##', null, '0');
INSERT INTO `rdir_url_tbl` VALUES ('5', '1', '3', '0', '3', 'http://www.meine-firma.de/form.do?agnCI=1&agnFN=de_doi_welcome&agnUID=##AGNUID##', null, '0');
INSERT INTO `rdir_url_tbl` VALUES ('6', '1', '4', '0', '3', 'http://www.my-company.de/form.do?agnCI=1&agnFN=en_doi_welcome&agnUID=##AGNUID##', null, '0');

-- ----------------------------
-- Table structure for `rulebased_sent_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `rulebased_sent_tbl`;
CREATE TABLE `rulebased_sent_tbl` (
  `mailing_id` int(11) DEFAULT NULL,
  `lastsent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of rulebased_sent_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `softbounce_email_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `softbounce_email_tbl`;
CREATE TABLE `softbounce_email_tbl` (
  `email` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `bnccnt` int(11) NOT NULL DEFAULT '0',
  `mailing_id` int(11) NOT NULL DEFAULT '0',
  `creation_date` timestamp NULL DEFAULT NULL,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `company_id` int(11) NOT NULL DEFAULT '0',
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of softbounce_email_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `tag_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `tag_tbl`;
CREATE TABLE `tag_tbl` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tagname` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `selectvalue` text COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `company_id` int(10) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_unicode_ci,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tag_id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tag_tbl
-- ----------------------------
INSERT INTO `tag_tbl` VALUES ('1', 'agnCUSTOMERID', 'cust.customer_id', 'SIMPLE', '0', null, '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('2', 'agnMAILTYPE', 'cust.mailtype', 'SIMPLE', '0', null, '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('3', 'agnIMAGE', '\'[rdir-domain]/image?ci=[company-id]&mi=[mailing-id]&name={name}\'', 'COMPLEX', '0', null, '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('4', 'agnDB', 'cust.{column}', 'COMPLEX', '0', 'Display one Column', '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('5', 'agnTITLE', '\'builtin\'', 'SIMPLE', '0', null, '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('6', 'agnFIRSTNAME', 'cust.firstname', 'SIMPLE', '0', null, '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('7', 'agnLASTNAME', 'cust.lastname', 'SIMPLE', '0', null, '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('8', 'agnEMAIL', 'cust.email', 'SIMPLE', '0', null, '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('9', 'agnDATE', 'date_format(current_timestamp, \'%d.%m.%Y\')', 'SIMPLE', '0', null, '2006-07-10 14:58:25');
INSERT INTO `tag_tbl` VALUES ('10', 'agnIMGLINK', '\'<a href=\"[rdir-domain]/r.html?uid=[agnUID]\"><img src=\"[rdir-domain]/image?ci=[company-id]&mi=[mailing-id]&name={name}\" border=\"0\"></a>\'', 'COMPLEX', '0', null, '2008-06-09 05:00:00');
INSERT INTO `tag_tbl` VALUES ('11', 'agnFORM', '\'[rdir-domain]/form.do?agnCI=1&agnFN={name}&agnUID=##agnUID##\'', 'COMPLEX', '0', 'create a link to a site', '2012-07-31 22:35:24');
INSERT INTO `tag_tbl` VALUES ('12', 'agnPROFILE', '\'[rdir-domain]/form.do?agnCI=1&agnFN=profile&agnUID=##agnUID##\'', 'COMPLEX', '0', 'create a link to an openemm-profile-form', '2012-07-31 22:35:24');
INSERT INTO `tag_tbl` VALUES ('13', 'agnUNSUBSCRIBE', '\'[rdir-domain]/form.do?agnCI=1&agnFN=unsubscribe&agnUID=##agnUID##\'', 'COMPLEX', '0', 'create a link to an openemm-unsubscribe-form', '2012-07-31 22:35:24');
INSERT INTO `tag_tbl` VALUES ('14', 'agnDYN', 'agnDYN textComponent {name}', 'FLOW', '0', 'agnDYN tag works optionally with agnDVALUE', '2014-11-16 21:56:07');
INSERT INTO `tag_tbl` VALUES ('15', 'agnDVALUE', 'agnDVALUE textComponent {name}', 'FLOW', '0', 'agnDVALUE tag works only with agnDYN', '2014-11-16 21:56:07');
INSERT INTO `tag_tbl` VALUES ('16', 'agnALTERCALC', 'trunc(months_between(sysdate, cust.{column})/12, 0) {op} {value}', 'COMPLEX', '0', 'like agnALTER with operator and value', '2014-11-16 21:56:07');
INSERT INTO `tag_tbl` VALUES ('17', 'agnDATEDB_LANG', 'to_char(cust.{column}, \'{format}\', \'nls_date_language = {lang}\')', 'COMPLEX', '0', 'Returns date in column custom formatted in given language', '2014-11-16 21:56:07');
INSERT INTO `tag_tbl` VALUES ('18', 'agnYEARCALC', 'to_char (cust.{field}, \'YYYY\') {op} {value}', 'COMPLEX', '0', 'to calculate with column', '2014-11-16 21:56:07');
INSERT INTO `tag_tbl` VALUES ('19', 'agnYEARCALC_F', 'to_char (cust.{column}, \'{format}\') {op} {value}', 'COMPLEX', '0', 'like agnYEARCALC with formating the date', '2014-11-16 21:56:07');
INSERT INTO `tag_tbl` VALUES ('20', 'agnUID', '', 'SIMPLE', '0', 'agnUID', '2014-11-16 21:56:07');
INSERT INTO `tag_tbl` VALUES ('21', 'agnDVALUE', 'agnDVALUE textComponent {name}', 'FLOW', '0', 'agnDVALUE tag works only with agnDYN', '2017-01-19 22:54:02');
INSERT INTO `tag_tbl` VALUES ('22', 'agnDBV', '\'not available\'', 'COMPLEX', '0', 'Selects a virtual column not existing in DB', '2017-01-19 22:54:02');
INSERT INTO `tag_tbl` VALUES ('23', 'agnTITLEFIRST', 'titlefirst({type}, [company-id], cust.customer_id)', 'COMPLEX', '0', 'shows title - print out firstname', '2017-01-19 22:54:02');
INSERT INTO `tag_tbl` VALUES ('24', 'agnTITLEFULL', 'title2({type}, [company-id], cust.customer_id)', 'COMPLEX', '0', 'shows title - print out title, firstname, lastname', '2017-01-19 22:54:02');
INSERT INTO `tag_tbl` VALUES ('25', 'agnSUBSCRIBERCOUNT', '\'1\'', 'SIMPLE', '0', 'Dummy tag for preview', '2017-01-19 22:54:02');

-- ----------------------------
-- Table structure for `timestamp_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `timestamp_tbl`;
CREATE TABLE `timestamp_tbl` (
  `timestamp_id` int(10) DEFAULT NULL,
  `description` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cur` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prev` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `temp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of timestamp_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `title_gender_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `title_gender_tbl`;
CREATE TABLE `title_gender_tbl` (
  `title_id` int(11) NOT NULL DEFAULT '0',
  `gender` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`title_id`,`gender`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of title_gender_tbl
-- ----------------------------
INSERT INTO `title_gender_tbl` VALUES ('1', '0', 'Mr.');
INSERT INTO `title_gender_tbl` VALUES ('1', '1', 'Ms.');
INSERT INTO `title_gender_tbl` VALUES ('1', '2', 'Company');
INSERT INTO `title_gender_tbl` VALUES ('2', '0', 'Herr');
INSERT INTO `title_gender_tbl` VALUES ('2', '1', 'Frau');
INSERT INTO `title_gender_tbl` VALUES ('2', '2', 'Firma');

-- ----------------------------
-- Table structure for `title_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `title_tbl`;
CREATE TABLE `title_tbl` (
  `company_id` int(11) NOT NULL DEFAULT '0',
  `title_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`title_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of title_tbl
-- ----------------------------
INSERT INTO `title_tbl` VALUES ('1', '1', 'Default');
INSERT INTO `title_tbl` VALUES ('1', '2', 'German Default');

-- ----------------------------
-- Table structure for `userform_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `userform_tbl`;
CREATE TABLE `userform_tbl` (
  `form_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `formname` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `company_id` int(10) unsigned NOT NULL DEFAULT '0',
  `startaction_id` int(10) unsigned NOT NULL DEFAULT '0',
  `endaction_id` int(10) unsigned NOT NULL DEFAULT '0',
  `success_template` longtext COLLATE utf8_unicode_ci NOT NULL,
  `error_template` longtext COLLATE utf8_unicode_ci NOT NULL,
  `success_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `error_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `error_use_url` int(1) unsigned NOT NULL DEFAULT '0',
  `success_use_url` int(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`form_id`),
  KEY `formname` (`formname`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of userform_tbl
-- ----------------------------
INSERT INTO `userform_tbl` VALUES ('1', 'de_doi', 'double-opt-in german 1/3', '1', '0', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 200px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <form action=\"form.do\">\r\n          <input type=\"hidden\" name=\"agnCI\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnFN\" value=\"de_doi_confirm\">\r\n          <input type=\"hidden\" name=\"agnSUBSCRIBE\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnMAILINGLIST\" value=\"1\">          \r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER ANMELDUNG 1/3</h1>\r\n                  <p>vielen Dank f&uuml;r Ihr Interesse an unserem Angebot.<br>\r\n                  Hier k&ouml;nnen Sie sich zum Newsletter registrieren:</p>\r\n                  <table border=0>\r\n                  <tr><td width=\"120\">Anrede:</td>\r\n                      <td><select name=\"GENDER\">\r\n                            <option value=\"2\" selected>unbekannt</option>\r\n                            <option value=\"1\">Frau</option>\r\n                            <option value=\"0\">Herr</option>\r\n                          </select></td></tr>\r\n                  <tr><td>Vorname:</td>\r\n                      <td><input type=\"text\" name=\"FIRSTNAME\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td>Nachname:</td>\r\n                      <td><input type=\"text\" name=\"LASTNAME\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td>E-Mail-Adresse:</td>\r\n                      <td><input type=\"text\" name=\"EMAIL\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td valign=\"top\">Newsletterformat:</td>\r\n                      <td><input type=\"radio\" name=\"MAILTYPE\" value=\"1\" checked>HTML (mit Bildern)<br>\r\n                          <input type=\"radio\" name=\"MAILTYPE\" value=\"0\">Text (Plaintext)</td></tr>\r\n                  <tr><td colspan=\"2\">&nbsp;</td></tr>\r\n                  <tr><td><input type=\"submit\" value=\"Absenden\"></td>\r\n                      <td><input type=\"reset\" value=\"Abbrechen\" onClick=\"javascript:history.back();\"></td></tr>\r\n                  </table>         \r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </form>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER ANMELDUNG FEHLER</h1>\r\n                  <p>Leider ist bei Ihrer Anmeldung ein Fehler aufgetreten.<br>\r\n                  Ihre Daten konnten nicht gespeichert werden, bitte<br>\r\n                  &uuml;berpr&uuml;fen Sie Ihre Eingaben und versuchen es erneut.</p>\r\n                  <p>Vielen Dank f&uuml;r Ihr Verst&auml;ndnis.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('2', 'de_doi_confirm', 'double-opt-in german 2/3', '1', '2', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER ANMELDUNG 2/3</h1>\r\n                  <p>Ihre Daten wurden erfolgreich angenommen.<br><br>\r\n                  Bitte best&auml;tigen Sie Ihr Abonnement in der E-Mail,<br>die wir Ihnen in K&uuml;rze zustellen, um den Bestellprozess abzuschlie&szlig;en.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER ANMELDUNG FEHLER</h1>\r\n                  <p>Leider ist bei Ihrer Anmeldung ein Fehler aufgetreten.<br>\r\n                  Ihre Daten konnten nicht gespeichert werden, bitte<br>\r\n                  &uuml;berpr&uuml;fen Sie Ihre Eingaben und versuchen es erneut.</p>\r\n                  <p>Vielen Dank f&uuml;r Ihr Verst&auml;ndnis.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('3', 'de_doi_welcome', 'double-opt-in german 3/3', '1', '1', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER ANMELDUNG 3/3</h1>\r\n                  <h1>Willkommen</h1>\r\n                  <p>Ihre Anmeldung ist abgeschlossen und wir freuen uns,<br>Sie in unserem Newsletterverteiler begr&uuml;&szlig;en zu d&uuml;rfen.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Profil&auml;nderung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER DATEN &Auml;NDERN FEHLER</h1>\r\n                  <p>Leider konnten Ihre Daten nicht gespeichert werden, bitte<br>\r\n                  &uuml;berpr&uuml;fen Sie Ihre Eingaben und versuchen es erneut.</p>\r\n                  <p>Vielen Dank f&uuml;r Ihr Verst&auml;ndnis.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('4', 'de_profil', 'profile german 1/2', '1', '4', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter Profil&auml;nderung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 200px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <form action=\"form.do\">\r\n          <input type=\"hidden\" name=\"agnCI\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnFN\" value=\"de_profil_confirm\">\r\n          <input type=\"hidden\" name=\"agnUID\" value=\"$!agnUID\">        \r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER DATEN &Auml;NDERN</h1>\r\n                  <p>Sie erhalten unseren Newsletter und m&ouml;chten Ihre Daten &auml;ndern:</p>\r\n                  <table border=0>\r\n                  <tr><td width=\"120\">Anrede:</td>\r\n                      <td><select name=\"GENDER\">\r\n                            <option value=\"2\" #if($!customerData.GENDER == \"2\") selected #end>unbekannt</option>\r\n                            <option value=\"1\" #if($!customerData.GENDER == \"1\") selected #end>Frau</option>\r\n                            <option value=\"0\" #if($!customerData.GENDER == \"0\") selected #end>Herr</option>\r\n                          </select></td></tr>\r\n                  <tr><td>Vorname:</td>\r\n                      <td><input type=\"text\" name=\"FIRSTNAME\" style=\"width: 200px;\" value=\"$!customerData.FIRSTNAME\"></td></tr>\r\n                  <tr><td>Nachname:</td>\r\n                      <td><input type=\"text\" name=\"LASTNAME\" style=\"width: 200px;\" value=\"$!customerData.LASTNAME\"></td></tr>\r\n                  <tr><td>E-Mail-Adresse:</td>\r\n                      <td><input type=\"text\" name=\"EMAIL\" style=\"width: 200px;\" value=\"$!customerData.EMAIL\"></td></tr>\r\n                  <tr><td valign=\"top\">Newsletterformat:</td>\r\n                      <td><input type=\"radio\" name=\"MAILTYPE\" value=\"1\" #if($!customerData.MAILTYPE == \"1\") checked #end>HTML (mit Bildern)<br>\r\n                          <input type=\"radio\" name=\"MAILTYPE\" value=\"0\" #if($!customerData.MAILTYPE == \"0\") checked #end>Text (Plaintext)</td></tr>\r\n                  <tr><td colspan=\"2\">&nbsp;</td></tr>\r\n                  <tr><td><input type=\"submit\" value=\"Speichern\"></td>\r\n                      <td><input type=\"reset\" value=\"Abbrechen\" onClick=\"javascript:history.back();\"></td></tr>\r\n                  </table>         \r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </form>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter Profil&auml;nderung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER DATEN &Auml;NDERN FEHLER</h1>\r\n                  <p>Leider konnten Ihre Daten nicht gespeichert werden, bitte<br>\r\n                  &uuml;berpr&uuml;fen Sie Ihre Eingaben und versuchen es erneut.</p>\r\n                  <p>Vielen Dank f&uuml;r Ihr Verst&auml;ndnis.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('5', 'de_profil_confirm', 'profile german 2/2', '1', '5', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Profil&auml;nderung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER DATEN &Auml;NDERN</h1>\r\n                  <p>Ihre &Auml;nderungen wurden erfolgreich &uuml;bernommen.<br>\r\n                  Ab der n&auml;chsten Ausgabe ber&uuml;cksichitgen wir Ihre &Auml;nderungen.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Profil&auml;nderung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER DATEN &Auml;NDERN FEHLER</h1>\r\n                  <p>Leider konnten Ihre Daten nicht gespeichert werden, bitte<br>\r\n                  &uuml;berpr&uuml;fen Sie Ihre Eingaben und versuchen es erneut.</p>\r\n                  <p>Vielen Dank f&uuml;r Ihr Verst&auml;ndnis.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('6', 'de_soi', 'single-opt-in german 1/2', '1', '0', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 200px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <form action=\"form.do\">\r\n          <input type=\"hidden\" name=\"agnCI\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnFN\" value=\"de_soi_confirm\">\r\n          <input type=\"hidden\" name=\"agnSUBSCRIBE\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnMAILINGLIST\" value=\"1\">          \r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER-ANMELDUNG 1/2</h1>\r\n                  <p>vielen Dank f&uuml;r Ihr Interesse an unserem Angebot.<br>\r\n                  Hier k&ouml;nnen Sie sich zum Newsletter registrieren:</p>\r\n                  <table border=0>\r\n                  <tr><td width=\"120\">Anrede:</td>\r\n                      <td><select name=\"GENDER\">\r\n                            <option value=\"2\" selected>unbekannt</option>\r\n                            <option value=\"1\">Frau</option>\r\n                            <option value=\"0\">Herr</option>\r\n                          </select></td></tr>\r\n                  <tr><td>Vorname:</td>\r\n                      <td><input type=\"text\" name=\"FIRSTNAME\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td>Nachname:</td>\r\n                      <td><input type=\"text\" name=\"LASTNAME\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td>E-Mail-Adresse:</td>\r\n                      <td><input type=\"text\" name=\"EMAIL\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td valign=\"top\">Newsletterformat:</td>\r\n                      <td><input type=\"radio\" name=\"MAILTYPE\" value=\"1\" checked>HTML (mit Bildern)<br>\r\n                          <input type=\"radio\" name=\"MAILTYPE\" value=\"0\">Text (Plaintext)</td></tr>\r\n                  <tr><td colspan=\"2\">&nbsp;</td></tr>\r\n                  <tr><td><input type=\"submit\" value=\"Absenden\"></td>\r\n                      <td><input type=\"reset\" value=\"Abbrechen\" onClick=\"javascript:history.back();\"></td></tr>\r\n                  </table>         \r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </form>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER-ANMELDUNG FEHLER</h1>\r\n                  <p>Leider ist bei Ihrer Anmeldung ein Fehler aufgetreten.<br>\r\n                  Ihre Daten konnten nicht gespeichert werden, bitte<br>\r\n                  &uuml;berpr&uuml;fen Sie Ihre Eingaben und versuchen es erneut.</p>\r\n                  <p>Vielen Dank f&uuml;r Ihr Verst&auml;ndnis.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('7', 'de_soi_confirm', 'single-opt-in german 2/2', '1', '5', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER-ANMELDUNG 2/2</h1>\r\n                  <p>Wir konnten Ihre Anmeldung erfolgreich annehmen.<br>\r\n                  Ab der n&auml;chsten Ausgabe erhalten Sie unseren Newsletter.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Anmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER-ANMELDUNG FEHLER</h1>\r\n                  <p>Leider ist bei Ihrer Anmeldung ein Fehler aufgetreten.<br>\r\n                  Ihre Daten konnten nicht gespeichert werden, bitte<br>\r\n                  &uuml;berpr&uuml;fen Sie Ihre Eingaben und versuchen es erneut.</p>\r\n                  <p>Vielen Dank f&uuml;r Ihr Verst&auml;ndnis.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('8', 'de_unsub_confirm', 'unsubscribe german 2/2', '1', '6', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Abmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER-ABMELDUNG 2/2</h1>\r\n                  <p>Ihre Abmeldung wurde erfolgreich entgegengenommen.<br>\r\n                  Sie erhalten keine weiteren Newsletterausgaben.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Abmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER-ABMELDUNG FEHLER</h1>\r\n                  <p>Leider ist bei Ihrer Abmeldung ein Fehler aufgetreten.<br>\r\n                  Ihre Daten konnten nicht gespeichert werden.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('9', 'de_unsubscribe', 'unsubscribe german 1/2', '1', '0', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Abmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 200px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <form action=\"form.do\">\r\n          <input type=\"hidden\" name=\"agnCI\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnFN\" value=\"de_unsub_confirm\">\r\n          <input type=\"hidden\" name=\"agnUID\" value=\"$!agnUID\">       \r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER-ABMELDUNG 1/2</h1>\r\n                  <p>M&ouml;chten Sie den Newsletter wirklich abbestellen?</p>\r\n                  <table border=0>\r\n                  <tr><td width=\"120\"><input type=\"submit\" value=\" Ja \"></td>\r\n                      <td><input type=\"reset\" value=\" Nein \" onClick=\"javascript:history.back();\"></td></tr>\r\n                  </table>         \r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </form>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>Newsletter-Abmeldung</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER-ABMELDUNG FEHLER</h1>\r\n                  <p>Leider ist bei Ihrer Abmeldung ein Fehler aufgetreten.<br>\r\n                  Ihre Daten konnten nicht gespeichert werden.</p>\r\n                  <p>Mit freundlichen Gr&uuml;&szlig;en<br>\r\n                  Ihr online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('10', 'en_soi', 'single-opt-in english 1/2', '1', '0', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter subscription</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 200px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <form action=\"form.do\">\r\n          <input type=\"hidden\" name=\"agnCI\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnFN\" value=\"en_soi_confirm\">\r\n          <input type=\"hidden\" name=\"agnSUBSCRIBE\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnMAILINGLIST\" value=\"1\">          \r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>SUBSCRIBE NEWSLETTER 1/2</h1>\r\n                  <p>Thank you for your interest!<br>\r\n                  Register here:</p>\r\n                  <table border=0>\r\n                  <tr><td width=\"120\">salutation:</td>\r\n                      <td><select name=\"GENDER\">\r\n                            <option value=\"2\" selected>unknown</option>\r\n                            <option value=\"1\">Ms.</option>\r\n                            <option value=\"0\">Mr.</option>\r\n                          </select></td></tr>\r\n                  <tr><td>firstname:</td>\r\n                      <td><input type=\"text\" name=\"FIRSTNAME\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td>lastname:</td>\r\n                      <td><input type=\"text\" name=\"LASTNAME\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td>eMail:</td>\r\n                      <td><input type=\"text\" name=\"EMAIL\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td valign=\"top\">mail format:</td>\r\n                      <td><input type=\"radio\" name=\"MAILTYPE\" value=\"1\" checked>HTML (includes images)<br>\r\n                          <input type=\"radio\" name=\"MAILTYPE\" value=\"0\">Text (plaintext only)</td></tr>\r\n                  <tr><td colspan=\"2\">&nbsp;</td></tr>\r\n                  <tr><td><input type=\"submit\" value=\"Send\"></td>\r\n                      <td><input type=\"reset\" value=\"Cancel\" onClick=\"javascript:history.back();\"></td></tr>\r\n                  </table>         \r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </form>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter subscription</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER SUBSCRIPTION ERROR</h1>\r\n                  <p>Sorry, an error occurred.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('11', 'en_soi_confirm', 'single-opt-in english 2/2', '1', '5', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter subscription</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER SUBSCRIPTION 2/2</h1>\r\n                  <p>Your newsletter registration was successful.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter subscription</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER SUBSCRIPTION ERROR</h1>\r\n                  <p>Sorry, an error occurred.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('12', 'en_unsubscribe', 'unsubscribe english 1/2', '1', '0', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter unsubscribe</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 200px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <form action=\"form.do\">\r\n          <input type=\"hidden\" name=\"agnCI\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnFN\" value=\"en_unsub_confirm\">\r\n          <input type=\"hidden\" name=\"agnUID\" value=\"$!agnUID\">       \r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>UNSUBSCRIBE NEWSLETTER 1/2</h1>\r\n                  <p>Do you really want to unsubscribe from our newsletter?</p>\r\n                  <table border=0>\r\n                  <tr><td width=\"120\"><input type=\"submit\" value=\" Yes \"></td>\r\n                      <td><input type=\"reset\" value=\" No \" onClick=\"javascript:history.back();\"></td></tr>\r\n                  </table>         \r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </form>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter unsubscription</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>UNSUBSCRIBE ERROR</h1>\r\n                  <p>Sorry, an error occurred.</p>\r\n                  <p>Please try it again.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('13', 'en_unsub_confirm', 'unsubscribe english 2/2', '1', '6', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter unsubscribe</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>UNSUBSCRIBE NEWSLETTER 2/2</h1>\r\n                  <p>Your newsletter unsubscription was successful.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter unsubscription</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>UNSUBSCRIBE ERROR</h1>\r\n                  <p>Sorry, an error occurred.</p>\r\n                  <p>Please try it again.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>\r\n', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('14', 'en_profil', 'profile english 1/2', '1', '4', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter change profile</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 200px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <form action=\"form.do\">\r\n          <input type=\"hidden\" name=\"agnCI\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnFN\" value=\"en_profil_confirm\">\r\n          <input type=\"hidden\" name=\"agnUID\" value=\"$!agnUID\">        \r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>CHANGE DATA</h1>\r\n                  <p>Please change your data here:</p>\r\n                  <table border=0>\r\n                  <tr><td width=\"120\">salutation:</td>\r\n                      <td><select name=\"GENDER\">\r\n                            <option value=\"2\" #if($!customerData.GENDER == \"2\") selected #end>unknown</option>\r\n                            <option value=\"1\" #if($!customerData.GENDER == \"1\") selected #end>Ms.</option>\r\n                            <option value=\"0\" #if($!customerData.GENDER == \"0\") selected #end>Mr.</option>\r\n                          </select></td></tr>\r\n                  <tr><td>firstname:</td>\r\n                      <td><input type=\"text\" name=\"FIRSTNAME\" style=\"width: 200px;\" value=\"$!customerData.FIRSTNAME\"></td></tr>\r\n                  <tr><td>lastname:</td>\r\n                      <td><input type=\"text\" name=\"LASTNAME\" style=\"width: 200px;\" value=\"$!customerData.LASTNAME\"></td></tr>\r\n                  <tr><td>eMail:</td>\r\n                      <td><input type=\"text\" name=\"EMAIL\" style=\"width: 200px;\" value=\"$!customerData.EMAIL\"></td></tr>\r\n                  <tr><td valign=\"top\">eMail format:</td>\r\n                      <td><input type=\"radio\" name=\"MAILTYPE\" value=\"1\" #if($!customerData.MAILTYPE == \"1\") checked #end>HTML<br>\r\n                          <input type=\"radio\" name=\"MAILTYPE\" value=\"0\" #if($!customerData.MAILTYPE == \"0\") checked #end>Text</td></tr>\r\n                  <tr><td colspan=\"2\">&nbsp;</td></tr>\r\n                  <tr><td><input type=\"submit\" value=\"Save\"></td>\r\n                      <td><input type=\"reset\" value=\"Cancel\" onClick=\"javascript:history.back();\"></td></tr>\r\n                  </table>         \r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </form>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter change profile</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>CHANGE DATA</h1>\r\n                  <p>Sorry, your data could not be saved.<br>\r\n                  Please check your settings and try again.</p>\r\n                  <p>&nbsp;</p>\r\n                  <p>Greeting<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('15', 'en_profil_confirm', 'profile english 2/2', '1', '5', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter change profile</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>CHANGE DATA</h1>\r\n                  <p>Your setting have been changed successfully.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter change profile</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>CHANGE DATA</h1>\r\n                  <p>Sorry, your data could not be saved.<br>\r\n                  Please check your settings and try again.</p>\r\n                  <p>&nbsp;</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('16', 'en_doi', 'double-opt-in english 1/3', '1', '0', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter registration</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 200px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <form action=\"form.do\">\r\n          <input type=\"hidden\" name=\"agnCI\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnFN\" value=\"en_doi_confirm\">\r\n          <input type=\"hidden\" name=\"agnSUBSCRIBE\" value=\"1\">\r\n          <input type=\"hidden\" name=\"agnMAILINGLIST\" value=\"1\">          \r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER REGISTRATION 1/3</h1>\r\n                  <p>Subscribe our newsletter here:</p>\r\n                  <table border=0>\r\n                  <tr><td width=\"120\">salutation:</td>\r\n                      <td><select name=\"GENDER\">\r\n                            <option value=\"2\" selected>unknown</option>\r\n                            <option value=\"1\">Ms.</option>\r\n                            <option value=\"0\">Mr.</option>\r\n                          </select></td></tr>\r\n                  <tr><td>firstname:</td>\r\n                      <td><input type=\"text\" name=\"FIRSTNAME\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td>lastname:</td>\r\n                      <td><input type=\"text\" name=\"LASTNAME\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td>eMail:</td>\r\n                      <td><input type=\"text\" name=\"EMAIL\" style=\"width: 200px;\"></td></tr>\r\n                  <tr><td valign=\"top\">eMail format:</td>\r\n                      <td><input type=\"radio\" name=\"MAILTYPE\" value=\"1\" checked>HTML<br>\r\n                          <input type=\"radio\" name=\"MAILTYPE\" value=\"0\">Text</td></tr>\r\n                  <tr><td colspan=\"2\">&nbsp;</td></tr>\r\n                  <tr><td><input type=\"submit\" value=\"Send\"></td>\r\n                      <td><input type=\"reset\" value=\"Cancel\" onClick=\"javascript:history.back();\"></td></tr>\r\n                  </table>         \r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </form>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter registration</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER REGISTRATION ERROR</h1>\r\n                  <p>Sorry, an error occurred.</p>\r\n                  <p>Please try it again.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('17', 'en_doi_confirm', 'double-opt-in english 2/3', '1', '3', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter registration</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER REGISTRATION 2/3</h1>\r\n                  <p>Your data were saved successfully.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter registration</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER REGISTRATION ERROR</h1>\r\n                  <p>Sorry, an error occurred.</p>\r\n                  <p>Please try it again.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('18', 'en_doi_welcome', 'double-opt-in english 3/3', '1', '1', '0', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter registration</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER REGISTRATION 3/3</h1>\r\n                  <h1>Wellcome</h1>\r\n                  <p>Your registration was finished.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<HTML>\r\n<head>\r\n<title>newsletter registration</title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<style type=\"text/css\">\r\n<!--\r\nbody, table { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px; }\r\nh1 { font-family: Tahoma, Helvetica, sans-serif; font-size: 16px; }\r\nselect, input { font-family: Tahoma, Helvetica, sans-serif; font-size: 12px;}      \r\nselect { width: 120px; }\r\n-->\r\n</style>\r\n</head>\r\n\r\n<body bgcolor=\"#C0C0C0\" link=\"#bb2233\" vlink=\"#bb2233\" alink=\"#bb2233\">\r\n<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n  <tr bgcolor=\"#808080\">\r\n    <td bgcolor=\"#808080\">\r\n      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">\r\n        <tr>\r\n          <td>\r\n          <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n            <tr>\r\n              <td width=\"10\">&nbsp;</td>\r\n              <td><h1>NEWSLETTER REGISTRATION ERROR</h1>\r\n                  <p>Sorry, an error occurred.</p>\r\n                  <p>Please try it again.</p>\r\n                  <p>Greetings<br>\r\n                  Your online-Team</p>\r\n                  </td>                                 \r\n              <td width=\"10\">&nbsp;</td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\">&nbsp;</td>\r\n            </tr>            \r\n          </table>\r\n          </td>\r\n        </tr>\r\n      </table>\r\n    </td>\r\n  </tr>\r\n</table>\r\n</body>\r\n</html>', null, null, '0', '0');
INSERT INTO `userform_tbl` VALUES ('19', 'redirection_check', 'check if redirect answer\r\n(see explanation at error-form)', '1', '0', '0', 'database is ok', 'error!\r\n\r\nThis form may be used by a surveillance software like Nagios to check if OpenEMM is alive. To call this form use link\r\n\r\nhttp://your.domain.com/form.do?agnCI=1&agnFN=redirection_check\r\n\r\n(WARNING: Please change www.my-company.de to your rdir-link!)', null, null, '0', '0');

-- ----------------------------
-- Table structure for `userlog_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `userlog_tbl`;
CREATE TABLE `userlog_tbl` (
  `logtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(4000) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of userlog_tbl
-- ----------------------------
INSERT INTO `userlog_tbl` VALUES ('2017-02-17 23:20:12', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-17 23:21:09', 'admin', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-02-17 23:21:15', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-17 23:23:37', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-17 23:24:52', 'admin', 'edit target group, ID = 0', 'Target group Khu vuc ha noi rule added');
INSERT INTO `userlog_tbl` VALUES ('2017-02-17 23:25:18', 'admin', 'edit target group, ID = 0', 'Target group Nhập tên rule added');
INSERT INTO `userlog_tbl` VALUES ('2017-02-17 23:25:23', 'admin', 'create target group, ID =  0', 'Target group Khu vuc ha noi created');
INSERT INTO `userlog_tbl` VALUES ('2017-02-17 23:32:16', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 00:05:12', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 00:34:42', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 00:49:43', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 01:33:27', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 01:43:41', 'admin', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 01:43:44', '', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 01:44:06', '', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 01:45:56', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 08:52:27', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 10:56:51', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 12:46:26', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 13:08:35', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 15:17:31', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 15:32:43', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 15:52:12', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 15:55:50', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 16:03:57', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 16:15:04', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 17:13:34', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 17:25:11', 'admin', 'edit target group, ID = 0', 'Target group Khach muc tieu 1 rule added');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 17:25:28', 'admin', 'create target group, ID =  0', 'Target group Khach muc tieu 1 created');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 17:43:13', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 19:20:46', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 20:51:21', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 20:56:15', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 20:59:15', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-18 23:10:31', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 00:12:40', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 00:16:42', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 00:41:26', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 00:48:54', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 21:41:07', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 21:41:07', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 22:29:06', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 22:33:58', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 22:35:26', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-19 23:18:57', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-20 00:04:41', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-20 01:02:36', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-20 23:23:55', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-20 23:24:25', 'admin', 'do load target group, ID = 2', 'Target group Khach muc tieu 1 loaded');
INSERT INTO `userlog_tbl` VALUES ('2017-02-20 23:38:41', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-20 23:39:06', 'admin', 'do load mailinglist', 'mailinglist');
INSERT INTO `userlog_tbl` VALUES ('2017-02-20 23:59:27', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 00:14:44', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 00:25:17', 'admin', 'create mailinglist', 'xxxx');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 00:25:22', 'admin', 'do load mailinglist', 'xxxx');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 00:33:00', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 00:54:15', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 01:01:36', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 01:06:03', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 01:07:36', 'admin', 'do load mailinglist', 'xxxx');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 22:50:58', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 23:43:23', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-21 23:51:42', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 00:19:58', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 00:36:47', 'admin', 'do load target group, ID = 2', 'Target group Khach muc tieu 1 loaded');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 00:40:48', 'admin', 'do load target group, ID = 2', 'Target group Khach muc tieu 1 loaded');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 00:40:49', 'admin', 'delete target group, ID =  2', 'Target group Khach muc tieu 1 deleted');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 00:45:30', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 23:25:23', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 23:36:03', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 23:41:36', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-22 23:56:29', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 00:06:35', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 00:07:21', 'admin', 'create', 'mailing Test1(5)');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 00:07:21', 'admin', 'do load', 'mailing Test1(5)');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 00:07:30', 'admin', 'do load', 'mailing Test1(5)');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 00:14:19', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 00:14:23', 'admin', 'do load', 'mailing Test1(5)');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 00:21:26', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 00:51:03', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:07:26', 'admin', 'do load mailinglist', 'xxxx');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:07:33', 'admin', 'delete mailinglist', 'xxxx');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:07:42', 'admin', 'create mailinglist', 'xxX');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:12:27', 'admin', 'do load mailinglist', 'xxX');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:14:46', 'admin', 'create bounce filter', 'Không thành công tháng 1');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:20:06', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:27:17', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:29:12', 'admin', 'create profile field Test1', 'Profile field Test1 created');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 01:32:58', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 21:56:41', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 22:06:15', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 22:34:38', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 22:54:27', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 22:58:26', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 23:00:51', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 23:03:27', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 23:07:46', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 23:35:14', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 23:38:23', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-23 23:40:37', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-24 00:00:34', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-24 00:29:22', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-24 00:49:07', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-24 00:52:24', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-24 00:57:58', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-24 01:03:12', 'admin', 'do export', 'Export started at: 2017/02/24 01-03-12. Number of profiles: 2. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 1');
INSERT INTO `userlog_tbl` VALUES ('2017-02-24 23:40:00', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 00:13:30', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 00:15:01', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 00:17:51', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 00:18:51', 'admin', 'do load bounce filter', 'Không thành công tháng 1');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 00:43:19', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 00:46:28', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:14:58', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:15:44', 'admin', 'create mailinglist', 'NHom 2');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:15:57', 'admin', 'edit mailinglist', 'NHom 2');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:16:00', 'admin', 'edit mailinglist', 'NHom 2');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:16:07', 'admin', 'do load mailinglist', 'xxX');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:16:09', 'admin', 'delete mailinglist', 'xxX');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:16:34', 'admin', 'edit target group, ID = 0', 'Target group Khu vuc bac ninh rule added');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:16:37', 'admin', 'create target group, ID =  0', 'Target group Khu vuc bac ninh created');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:16:41', 'admin', 'do load target group, ID = 3', 'Target group Khu vuc bac ninh loaded');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:16:41', 'admin', 'create target group, ID =  0', 'Target group Copy of Khu vuc bac ninh created');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:16:41', 'admin', 'create target group, ID =  4', 'Create copy of target group Khu vuc bac ninh');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:17:10', 'admin', 'create mailinglist', 'Nhập tên');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:17:30', 'admin', 'do load mailinglist', 'mailinglist');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:17:39', 'admin', 'do load mailinglist', 'NHom 2');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:17:42', 'admin', 'delete mailinglist', 'NHom 2');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:17:44', 'admin', 'do load mailinglist', 'Nhập tên');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:18:59', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:19:03', 'admin', 'do load mailinglist', 'mailinglist');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:27:28', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:27:41', 'admin', 'do load mailinglist', 'mailinglist');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:31:51', 'admin', 'create mailinglist', 'Nhập tên 1');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:40:54', 'admin', 'create mailinglist', 'Nhập tên dd');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:40:57', 'admin', 'edit mailinglist', 'Nhập tên dd');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:40:59', 'admin', 'edit mailinglist', 'Nhập tên dd');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:41:02', 'admin', 'edit mailinglist', 'Nhập tên dd');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:41:04', 'admin', 'edit mailinglist', 'Nhập tên dd');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:41:05', 'admin', 'edit mailinglist', 'Nhập tên dd');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:41:06', 'admin', 'edit mailinglist', 'Nhập tên dd');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:48:49', 'admin', 'create mailinglist', 'xxx ');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 10:57:32', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 11:25:30', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 12:22:34', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 16:34:39', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 17:00:47', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 17:18:42', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 23:12:54', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-25 23:53:43', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-26 22:55:02', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-26 23:11:23', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-26 23:47:08', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-26 23:54:18', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 00:17:42', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 00:52:31', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 21:21:20', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 21:21:52', 'admin', 'do export', 'Export started at: 2017/02/27 21-21-52. Number of profiles: 2. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 3');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 21:23:20', 'admin', 'do export', 'Export started at: 2017/02/27 21-23-20. Number of profiles: 2. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 6');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 21:34:00', 'admin', 'do export', 'Export started at: 2017/02/27 21-32-58. Number of profiles: 2. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 9');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 21:37:08', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 21:37:34', 'admin', 'do export', 'Export started at: 2017/02/27 21-37-27. Number of profiles: 2. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 8');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 21:46:03', 'admin', 'do export', 'Export started at: 2017/02/27 21-43-14. Number of profiles: 2. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:16:25', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:17:05', 'admin', 'create recipient, ID = 3', 'Recipient hảo phạm trọng created');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:17:37', 'admin', 'create recipient, ID = 4', 'Recipient Trung Nguyễn sỹ created');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:18:26', 'admin', 'do export', 'Export started at: 2017/02/27 22-17-53. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 9');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:22:43', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:24:06', 'admin', 'do export', 'Export started at: 2017/02/27 22-23-01. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 9');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:31:08', 'admin', 'do export', 'Export started at: 2017/02/27 22-30-44. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 9');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:32:07', 'admin', 'do export', 'Export started at: 2017/02/27 22-32-02. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 9');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:46:41', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 22:48:11', 'admin', 'do export', 'Export started at: 2017/02/27 22-46-56. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:00:45', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:01:29', 'admin', 'do export', 'Export started at: 2017/02/27 23-01-26. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:07:19', 'admin', 'do export', 'Export started at: 2017/02/27 23-07-13. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:10:37', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:11:00', 'admin', 'do export', 'Export started at: 2017/02/27 23-10-58. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:21:22', 'admin', 'do export', 'Export started at: 2017/02/27 23-21-19. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:24:17', 'admin', 'do export', 'Export started at: 2017/02/27 23-23-39. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 8');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:29:42', 'admin', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:30:49', '', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-02-27 23:30:52', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-28 00:03:23', 'admin', 'do export', 'Export started at: 2017/02/28 00-00-08. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 8');
INSERT INTO `userlog_tbl` VALUES ('2017-02-28 00:06:49', 'admin', 'do export', 'Export started at: 2017/02/28 00-06-47. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 8');
INSERT INTO `userlog_tbl` VALUES ('2017-02-28 00:10:33', 'admin', 'do export', 'Export started at: 2017/02/28 00-06-58. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 8');
INSERT INTO `userlog_tbl` VALUES ('2017-02-28 23:16:40', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-02-28 23:17:37', 'admin', 'do export', 'Export started at: 2017/02/28 23-17-21. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-02-28 23:33:54', 'admin', 'do export', 'Export started at: 2017/02/28 23-32-14. Number of profiles: 4. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 6');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:11:55', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:14:07', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:14:31', 'admin', 'do export', 'Export started at: 2017/03/01 00-14-24. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:17:46', 'admin', 'do export', 'Export started at: 2017/03/01 00-17-18. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:19:41', 'admin', 'do export', 'Export started at: 2017/03/01 00-19-22. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:23:38', 'admin', 'do export', 'Export started at: 2017/03/01 00-21-07. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:38:15', 'admin', 'do export', 'Export started at: 2017/03/01 00-37-09. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:38:43', 'admin', 'do export', 'Export started at: 2017/03/01 00-38-35. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:42:57', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:44:41', 'admin', 'do export', 'Export started at: 2017/03/01 00-43-21. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 7');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:54:22', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:55:12', 'admin', 'do export', 'Export started at: 2017/03/01 00-54-44. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 6');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 00:59:54', 'admin', 'do export', 'Export started at: 2017/03/01 00-59-11. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 8');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 01:02:38', 'admin', 'do export', 'Export started at: 2017/03/01 01-01-03. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 2');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 01:05:36', 'admin', 'do export', 'Export started at: 2017/03/01 01-05-18. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 4');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 01:14:33', 'admin', 'do export', 'Export started at: 2017/03/01 01-13-58. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 5');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 01:15:52', 'admin', 'do export', 'Export started at: 2017/03/01 01-15-48. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 5');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 01:21:24', 'admin', 'do export', 'Export started at: 2017/03/01 01-21-15. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 5');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 01:22:40', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 01:23:17', 'admin', 'do export', 'Export started at: 2017/03/01 01-23-06. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 11');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 01:29:32', 'admin', 'do export', 'Export started at: 2017/03/01 01-29-28. Number of profiles: 0. Export parameters: mailing list: All, target group: All, recipient type: All, recipient status: All, number of selected columns: 7');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 22:56:35', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 22:59:03', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-01 23:13:33', 'admin', 'create user anv', 'User created, ID = 3');
INSERT INTO `userlog_tbl` VALUES ('2017-03-02 22:48:41', 'anv', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-02 22:48:49', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 11:46:26', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 11:47:15', 'admin', 'do load mailinglist', 'xxx ');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 11:47:38', 'admin', 'do load mailinglist', 'xxx ');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 11:47:39', 'admin', 'delete mailinglist', 'xxx ');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 11:52:38', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 12:05:05', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 12:08:55', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 12:34:12', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 12:55:29', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 13:03:00', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 13:28:51', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 13:39:12', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 13:56:08', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 18:55:19', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 18:59:00', 'admin', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 18:59:30', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:02:57', 'admin', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:02:58', '', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:03:05', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:05:43', 'admin', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:09:24', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:12:46', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:19:43', '', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:19:49', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:22:38', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:27:31', '', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:27:34', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:31:47', 'admin', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:31:49', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:34:59', '', 'login_logout', 'Log out');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:35:04', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:44:05', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:46:53', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:51:21', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 19:51:53', 'admin', 'create user admin1212', 'User created, ID = 9');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 22:29:36', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 22:34:55', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 22:35:44', 'admin', 'create user adminhanoi', 'User created, ID = 10');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 22:39:20', 'admin', 'create user adminsaigon', 'User created, ID = 11');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 22:42:53', 'adminsaigon', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 22:43:05', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 22:56:46', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 22:57:49', 'admin', 'create user test1212', 'User created, ID = 12');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:00:34', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:07:45', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:08:27', 'admin', 'create user testxxbb', 'User created, ID = 13');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:12:10', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:12:41', 'admin', 'create user testtest', 'User created, ID = 14');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:14:39', 'testtest', 'edit user testtest', 'Password changed');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:17:20', 'testtest', 'edit user testtest', 'Password changed');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:19:24', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:20:11', 'admin1212', 'edit user admin1212', 'Password changed');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:21:07', 'testtest', 'edit user testtest', 'Password changed');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:24:59', 'admin', 'do load', 'mailing Test1(5)');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:25:05', 'admin', 'do load', 'mailing Test1(5)');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:38:05', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:38:06', 'admin', 'login_logout', 'Log in');
INSERT INTO `userlog_tbl` VALUES ('2017-03-04 23:58:02', 'testxxbb', 'edit user testxxbb', 'Password changed');

-- ----------------------------
-- Table structure for `webservice_user_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `webservice_user_tbl`;
CREATE TABLE `webservice_user_tbl` (
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT '1',
  `default_data_source_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of webservice_user_tbl
-- ----------------------------

-- ----------------------------
-- Table structure for `ws_admin_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `ws_admin_tbl`;
CREATE TABLE `ws_admin_tbl` (
  `ws_admin_id` int(22) NOT NULL DEFAULT '0',
  `username` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ws_admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ws_admin_tbl
-- ----------------------------
