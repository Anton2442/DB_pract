CREATE TABLE `customers` (
	`ctr_number` varchar(6) NOT NULL,
	`email` varchar(50) NOT NULL UNIQUE,
	`first_name` varchar(20) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`phone_number` varchar(11) NOT NULL,
	`current_balance` DECIMAL(6,2) NOT NULL,
	`loyalty_card_number` varchar(6) UNIQUE,
	`tem_id` varchar(4),
	`sre_id` varchar(4),
	PRIMARY KEY (`ctr_number`)
);

CREATE TABLE `customers_addresses` (
	`cas_id` varchar(8) NOT NULL,
	`city` varchar(15) NOT NULL,
	`postal_code` varchar(7) NOT NULL,
	`ctr_number` varchar(6) NOT NULL,
	PRIMARY KEY (`cas_id`)
);

CREATE TABLE `teams` (
	`tem_id` varchar(4) NOT NULL,
	`name` varchar(20) NOT NULL,
	`number_of_players` DECIMAL(2,0) NOT NULL,
	`discount` DECIMAL(2,0),
	PRIMARY KEY (`tem_id`)
);

CREATE TABLE `sales_representative` (
	`sre_id` varchar(4) NOT NULL,
	`email` varchar(50) NOT NULL UNIQUE,
	`first_name` varchar(20) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`phone_number` varchar(11) NOT NULL,
	`commision_rate` DECIMAL(2) NOT NULL,
	`supervisor_id` varchar(4) NOT NULL,
	PRIMARY KEY (`sre_id`)
);

CREATE TABLE `sales_representative_address` (
	`sre_id` varchar(4) NOT NULL,
	`city` varchar(15) NOT NULL,
	`postal_code` varchar(7) NOT NULL,
	PRIMARY KEY (`sre_id`)
);

CREATE TABLE `orders` (
	`ord_id` varchar(9) NOT NULL,
	`ord_date` DATE NOT NULL,
	`ord_time` TIME NOT NULL,
	`ctr_number` varchar(6) NOT NULL,
	PRIMARY KEY (`ord_id`)
);

CREATE TABLE `ordered_items` (
	`quantity_ordered` DECIMAL(3) NOT NULL,
	`quantity_shipped` DECIMAL(3) NOT NULL,
	`ord_id` varchar(9) NOT NULL,
	`itm_number` varchar(10) NOT NULL,
	PRIMARY KEY (`ord_id`,`itm_number`)
);

CREATE TABLE `items` (
	`itm_number` varchar(10) NOT NULL,
	`name` varchar(20) NOT NULL,
	`description` varchar(50) NOT NULL,
	`category` varchar(25) NOT NULL,
	`color` varchar(15),
	`razmer` char(4),
	`ilt_id` varchar(11) NOT NULL,
	PRIMARY KEY (`itm_number`,`ilt_id`)
);

CREATE TABLE `inventory_list` (
	`ilt_id` varchar(11) NOT NULL,
	`cost` DECIMAL(7,2) NOT NULL,
	`units` DECIMAL(4) NOT NULL,
	PRIMARY KEY (`ilt_id`)
);

CREATE TABLE `price_history` (
	`phy_start_date` DATE NOT NULL,
	`phy_start_time` TIME NOT NULL,
	`price` DECIMAL(7,2) NOT NULL,
	`end_date` DATE,
	`end_time` TIMESTAMP,
	`itm_number` varchar(10) NOT NULL,
	PRIMARY KEY (`phy_start_date`,`phy_start_time`,`itm_number`)
);

ALTER TABLE `customers` ADD CONSTRAINT `customers_fk0` FOREIGN KEY (`tem_id`) REFERENCES `teams`(`tem_id`);

ALTER TABLE `customers` ADD CONSTRAINT `customers_fk1` FOREIGN KEY (`sre_id`) REFERENCES `sales_representative`(`sre_id`);

ALTER TABLE `customers_addresses` ADD CONSTRAINT `customers_addresses_fk0` FOREIGN KEY (`ctr_number`) REFERENCES `customers`(`ctr_number`);

ALTER TABLE `sales_representative` ADD CONSTRAINT `sales_representative_fk0` FOREIGN KEY (`supervisor_id`) REFERENCES `sales_representative`(`sre_id`);

ALTER TABLE `sales_representative_address` ADD CONSTRAINT `sales_representative_address_fk0` FOREIGN KEY (`sre_id`) REFERENCES `sales_representative`(`sre_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk0` FOREIGN KEY (`ctr_number`) REFERENCES `customers`(`ctr_number`);

ALTER TABLE `ordered_items` ADD CONSTRAINT `ordered_items_fk0` FOREIGN KEY (`ord_id`) REFERENCES `orders`(`ord_id`);

ALTER TABLE `ordered_items` ADD CONSTRAINT `ordered_items_fk1` FOREIGN KEY (`itm_number`) REFERENCES `items`(`itm_number`);

ALTER TABLE `items` ADD CONSTRAINT `items_fk0` FOREIGN KEY (`ilt_id`) REFERENCES `inventory_list`(`ilt_id`);

ALTER TABLE `price_history` ADD CONSTRAINT `price_history_fk0` FOREIGN KEY (`itm_number`) REFERENCES `items`(`itm_number`);











