ALTER TABLE `admin_tbl`
ADD COLUMN `com_id`  int(11) NOT NULL DEFAULT 0 AFTER `default_import_profile_id`,
ADD COLUMN `department_id`  int(11) NOT NULL DEFAULT 0 AFTER `com_id`;