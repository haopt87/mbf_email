ALTER TABLE `admin_tbl`
ADD COLUMN `num_send_speed`  int(11) NOT NULL DEFAULT 0 AFTER `disabled`,
ADD COLUMN `num_send_by_day`  int(11) NOT NULL DEFAULT 0 AFTER `num_send_speed`,
ADD COLUMN `num_reply_by_day`  int(11) NOT NULL DEFAULT 0 AFTER `num_send_by_day`,
ADD COLUMN `num_send_by_month`  int(11) NOT NULL DEFAULT 0 AFTER `num_reply_by_day`,
ADD COLUMN `num_extend_ten_percent`  int(11) NOT NULL DEFAULT 0 AFTER `num_send_by_month`,
ADD COLUMN `num_bound_by_month`  int(11) NOT NULL DEFAULT 0 AFTER `num_extend_ten_percent`;

