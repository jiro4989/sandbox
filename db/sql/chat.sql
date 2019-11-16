CREATE DATABASE IF NOT EXISTS chat;

CREATE TABLE `user` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `gender` INT(16) NOT NULL,
  `email` VARCHAR(256) NOT NULL,
  `address` VARCHAR(256) NOT NULL,
  `phone_number` VARCHAR(256) NOT NULL DEFAULT '',
  `icon` VARCHAR(256) NOT NULL DEFAULT '',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` INT(16) NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `my_list` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `user_id` INT(16) NOT NULL,
  `target_user_id` INT(16) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` INT(16) NOT NULL DEFAULT 0,
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `chat` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `message` VARCHAR(256) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` INT(16) NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
)

CREATE TABLE `room` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `chat_id` INT(16) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` INT(16) NOT NULL DEFAULT 0,
  FOREIGN KEY (`chat`) REFERENCES `chat` (`id`),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `chat_link` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `chat_id` INT(16) NOT NULL,
  `from_user_id` INT(16) NOT NULL,
  `to_room_id` INT(16) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` INT(16) NOT NULL DEFAULT 0,
  FOREIGN KEY (`chat`) REFERENCES `chat` (`id`),
  FOREIGN KEY (`from_user_id`) REFERENCES `user` (`id`),
  FOREIGN KEY (`to_room_id`) REFERENCES `room` (`id`),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user` (`name`, `gender`, `email`, `address`, `phone_number`, `icon`)
VALUES ('man1', 0, 'test1@email.com', 'xxx', '000-111-222', ''),
       ('women1', 1, 'test2@email.com', 'xxx', '000-111-333', ''),
       ('women2', 1, 'test3@email.com', 'xxx', '000-111-333', ''),
       ('women3', 1, 'test4@email.com', 'xxx', '000-111-333', '');

INSERT INTO `my_list` (`user_id`, `target_user_id`)
VALUES (0, 1),
       (0, 2),
       (0, 3);

