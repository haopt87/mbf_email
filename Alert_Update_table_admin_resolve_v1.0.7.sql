CREATE TABLE `NewTable` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`send_email`  varchar(150) NULL ,
`reply_email`  varchar(150) NULL ,
`backup_type`  varchar(150) NULL ,
`backup_time`  varchar(150) NULL ,
`deleted`  int NOT NULL DEFAULT 0 ,
PRIMARY KEY (`id`)
)
;

