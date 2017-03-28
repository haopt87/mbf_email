ALTER TABLE `mailing_backend_log_tbl`
ADD COLUMN `mbf_user_id`  int(10) NULL DEFAULT 0 AFTER `status_id`;

