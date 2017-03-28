ALTER TABLE `mailing_tbl`
ADD COLUMN `mbf_user_id`  int NOT NULL DEFAULT 0 AFTER `clickaction_id`;

