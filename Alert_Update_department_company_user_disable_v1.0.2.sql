ALTER TABLE `admin_tbl`
ADD COLUMN `disabled`  int(11) NOT NULL DEFAULT 0 AFTER `department_id`;

ALTER TABLE `mbf_department_tbl`
ADD COLUMN `disabled`  int(11) NOT NULL DEFAULT 0 AFTER `deleted`;

ALTER TABLE `mbf_company_tbl`
ADD COLUMN `disabled`  int(11) NOT NULL DEFAULT 0 AFTER `deleted`;

