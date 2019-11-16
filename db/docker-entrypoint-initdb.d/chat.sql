CREATE DATABASE IF NOT EXISTS chat;

CREATE TABLE `users` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `image` VARCHAR(256) NOT NULL DEFAULT '',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `rooms` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `messages` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `user_id` INT(16) NOT NULL,
  `room_id` INT(16) NOT NULL,
  `text` VARCHAR(256) NOT NULL,
  `send_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users_rooms` (
  `id` INT(16) AUTO_INCREMENT NOT NULL,
  `user_id` INT(16) NOT NULL,
  `room_id` INT(16) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`name`, `image`)
VALUES ('user1', 'a'),
       ('user2', 'a'),
       ('user3', 'a'),
       ('user4', 'a'),
       ('user5', 'a');

INSERT INTO `rooms` (`name`)
VALUES ('room for user1'),
       ('room for user2'),
       ('room for user3'),
       ('room for user4'),
       ('room for user5');

INSERT INTO `messages` (`user_id`, `room_id`, `text`)
VALUES (1, 1, 'Hello user2'),
       (2, 1, 'Hello user1'),
       (1, 1, 'Hello user2 2'),
       (2, 1, 'Hello user1 2'),
       (3, 2, 'Hey'),
       (3, 2, 'Hey hey'),
       (3, 2, 'Hello'),
       (4, 2, 'Whats?'),
       (3, 2, 'No'),
       (4, 2, 'Whats?'),
       (5, 2, 'Whats?'),
       (3, 2, 'Haha');

INSERT INTO `users_rooms` (`user_id`, `room_id`)
VALUES (1, 1),
       (2, 1),
       (2, 2),
       (3, 2),
       (4, 2),
       (5, 3),
       (3, 3),
       (2, 3);

