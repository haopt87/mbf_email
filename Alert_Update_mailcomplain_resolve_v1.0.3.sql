ALTER TABLE `mbf_complain_email_tbl`
MODIFY COLUMN `other_information`  varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `email_address`;

ALTER TABLE `mbf_complain_email_tbl`
ADD COLUMN `resolve_information`  varchar(10000) NULL AFTER `other_information`;

ALTER TABLE `mbf_complain_email_tbl`
ADD COLUMN `creation_date`  timestamp NULL ON UPDATE CURRENT_TIMESTAMP AFTER `deleted`;

ALTER TABLE `mbf_complain_email_tbl`
ADD COLUMN `resolve_date`  timestamp NULL ON UPDATE CURRENT_TIMESTAMP AFTER `creation_date`;
