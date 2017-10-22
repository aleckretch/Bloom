USE bloom_server;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS food;
DROP TABLE IF EXISTS user_table;
DROP TABLE IF EXISTS restaurant;
DROP TABLE IF EXISTS restaurant_table;

CREATE TABLE `restaurant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `performance` decimal(11,2) NOT NULL,
  `service_rating` decimal(11,2) NOT NULL,
  `number_of_visits` int(11) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='';


CREATE TABLE `food` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `rating` int(11) NOT NULL,
  `number_of_orders` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL UNIQUE,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `food_restaurant_id_fk_idx` (`restaurant_id`),
  CONSTRAINT `restaurant_id_fk` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='';

CREATE TABLE `restaurant_table` (
  `id` int(11) NOT NULL,
  `total_bill` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='';


CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `food_id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`),
    KEY `order_table_id_fk_idx` (`table_id`),
    KEY `order_food_id_fk` (`food_id`),
  CONSTRAINT `food_id_fk` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `restaurant_table_id_fk` FOREIGN KEY (`table_id`) REFERENCES `restaurant_table` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='';

CREATE TABLE `user_table` (
  `id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone_number` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_table_id_fk_idx` (`table_id`),
  CONSTRAINT `user_table_id_fk` FOREIGN KEY (`table_id`) REFERENCES `restaurant_table` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='';
