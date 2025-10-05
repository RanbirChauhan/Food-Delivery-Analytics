CREATE DATABASE foodstreetdb;

USE foodstreetdb;

-- HOSTEL
CREATE TABLE `hostel` (
  `hostel_id` INT NOT NULL,
  `hostel_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`hostel_id`)
);

-- STUDENT 
CREATE TABLE `student` (
  `roll_no` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL,
  `hostel_id` INT NOT NULL,
  `room_no` VARCHAR(4) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `ph_number` VARCHAR(12) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`roll_no`),
  INDEX `hostel_id_idx` (`hostel_id` ASC),
  CONSTRAINT `student_hostel_fk`
    FOREIGN KEY (`hostel_id`)
    REFERENCES `hostel` (`hostel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- STALL
CREATE TABLE `stall` (
  `stall_id` INT NOT NULL,
  `stall_name` VARCHAR(45) NOT NULL,
  `min_order_amount` INT NOT NULL,
  `opening_time` TIMESTAMP NOT NULL,
  `closing_time` TIMESTAMP NOT NULL,
  `ph_number` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`stall_id`)
);

-- ITEMS
CREATE TABLE `items` (
  `item_name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `section` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`item_name`)
);

-- MENU
CREATE TABLE `menu` (
  `stall_id` INT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `cost` INT NOT NULL,
  `available` BINARY NOT NULL,
  PRIMARY KEY (`stall_id`, `item_name`),
  INDEX `item_name_idx` (`item_name` ASC),
  CONSTRAINT `menu_stall_fk`
    FOREIGN KEY (`stall_id`)
    REFERENCES `stall` (`stall_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menu_item_fk`
    FOREIGN KEY (`item_name`)
    REFERENCES `items` (`item_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- PAYMENT MODE
CREATE TABLE `payment_mode` (
  `payment_name` VARCHAR(45) NOT NULL,
  `payment_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_name`)
);

-- HAS (Junction Table) 
CREATE TABLE `has` (
  `roll_no` VARCHAR(20) NOT NULL,
  `payment_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`roll_no`, `payment_name`),
  INDEX `payment_name_idx` (`payment_name` ASC),
  CONSTRAINT `has_student_fk`
    FOREIGN KEY (`roll_no`)
    REFERENCES `student` (`roll_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `has_payment_fk`
    FOREIGN KEY (`payment_name`)
    REFERENCES `payment_mode` (`payment_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- DELIVERY BOY
CREATE TABLE `delivery_boy` (
  `boy_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL,
  `ph_number` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`boy_id`)
);

-- ORDER
CREATE TABLE `orders` (
  `order_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `roll_no` VARCHAR(20) NOT NULL,
  `stall_id` INT NOT NULL,
  `boy_id` INT NOT NULL,
  `delivery_charge` INT NOT NULL,
  `payment_name` VARCHAR(45) NOT NULL,
  `transaction_id` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`order_id`),
  INDEX `roll_no_idx` (`roll_no` ASC),
  INDEX `stall_id_idx` (`stall_id` ASC),
  INDEX `boy_id_idx` (`boy_id` ASC),
  INDEX `payment_name_idx` (`payment_name` ASC),
  FOREIGN KEY (`roll_no`)
    REFERENCES `student` (`roll_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`stall_id`)
    REFERENCES `stall` (`stall_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`boy_id`)
    REFERENCES `delivery_boy` (`boy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`payment_name`)
    REFERENCES `payment_mode` (`payment_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- ORDERED ITEMS
CREATE TABLE `ordered_items` (
  `order_id` INT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`order_id`, `item_name`),
  INDEX `item_name_idx` (`item_name` ASC),
  FOREIGN KEY (`order_id`)
    REFERENCES `orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`item_name`)
    REFERENCES `items` (`item_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- ORDER STATUS
CREATE TABLE `order_status` (
  `order_id` INT NOT NULL,
  `time` TIMESTAMP NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_id`, `time`),
  FOREIGN KEY (`order_id`)
    REFERENCES `orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('1', '1K MEGA HOSTEL');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('2', '1.8K ULTRA MEGA HOSTEL');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('3', 'RAMAN HALL');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('4', 'BOSE HALL');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('5', 'KALAM HALL');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('6', 'LH');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('7', 'ISH');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('8', '13TH BLOCK LH');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('9', 'POST OFFICE LH');
INSERT INTO `foodstreetdb`.`hostel` (`hostel_id`, `hostel_name`) VALUES ('10', 'BHABHA HALL');


INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22MEB0A01', 'Pradeep', 'Kumar', '1', '1519', 'pradeepkumar', 'pradeep.01', '9390750383', 'balivadadeep@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22MEB0B01', 'Manoj', 'Anumolu', '1', '1507', 'manojanumolu', 'manoj.09', '9390750384', 'manoj@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22CSB0A02', 'Abhishek', 'Chinta', '1', '1019', 'abhishekchinta', 'abhishek.16', '9390750345', 'abhishek@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22ECB0A23', 'Ram', 'Narayan', '2', '2445', 'ramnarayan', 'ram.17', '9390750346', 'ram@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22MMB0A24', 'Saketh', 'Varma', '2', '1018', 'sakethvarma', 'saketh.23', '9390750387', 'saketh@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('23MEB0A24', 'Akhil', 'Reddy', '2', '1318', 'akhilreddy', 'akhil.50', '9390750388', 'akhil@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22BTB0A24', 'Manish', '3', '1000', 'manishguggi', 'manish.24', '9390750389', 'manish@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('23CEB0A24', 'Rishikesh', 'Vangari', '3', '1319', 'rishikeshv', 'rishikesh.72', '9390750380', 'rishikesh@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22EEB0A24', 'Nithin', 'Balaji', '4', '1506', 'nithindhodda', 'nithin.72', '9390750381', 'nithin@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22CHB0A24', 'Rajesh', '4', '2032', 'rajeshvenkata', 'rajesh.74', '9390750382', 'rajesh@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22CSB0C34', 'Vishnu', 'Panthati', '5', '1111', 'vishnupatel', 'vishnu.10', '9390750390', 'vishnu@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22ECB0C44', 'Sowmya', 'Latha', '6', '1010', 'sowmyalatha', 'sowmya.01', '9390750391', 'sowmya@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('23ECB0A23', 'Harika', 'Sri', '6', '1010', 'harikasri', 'harika.01', '9390750392', 'harika@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22MEB0A45', 'Harshitha', '6', '1011', 'challaharshitha', 'harshitha.01', '9390750393', 'harshitha@gmail.com');
INSERT INTO `foodstreetdb`.`student` (`roll_no`, `first_name`, `last_name`, `hostel_id`, `room_no`, `user_name`, `password`, `ph_number`, `email`) VALUES ('22CSB0C24', 'Geetha', 'Sri', '6', '1011', 'geethasrijakka', 'geetha.01', '9390750394', 'geetha@gmail.com');

INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('IDLI', 'VEG', 'BREAKFAST');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VADA', 'VEG', 'BREAKFAST');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('POORI', 'VEG', 'BREAKFAST');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('BONDA', 'VEG', 'BREAKFAST');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('DOSA', 'VEG', 'BREAKFAST');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VEG 65', 'VEG', 'STARTERS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN 65', 'NON VEG', 'STARTERS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHILLI CHICKEN', 'NON VEG', 'STARTERS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VEG FRIED RICE', 'VEG', 'RICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('EGG FRIED RICE', 'EGG', 'RICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN FRIED RICE', 'NON VEG', 'RICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VEG NOODLES', 'VEG', 'NOODLES');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('EGG NOODLES', 'EGG', 'NOODLES');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN NOODLES', 'NON VEG', 'NOODLES');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN BIRYANI', 'NON VEG', 'BIRYANI');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('GRAPE JUICE', 'FRUITS', 'JUICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('SAPOTA JUICE', 'FRUITS', 'JUICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('APPLE JUICE', 'FRUITS', 'JUICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('MANGO JUICE', 'FRUITS', 'JUICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('PINEAPPLE JUICE', 'FRUITS', 'JUICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('STRAWBERRY MILKSHAKE', 'FRUITS', 'MILKSHAKE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('BANANA MILKSHAKE', 'FRUITS', 'MILKSHAKE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('AVACODA MILKSHAKE', 'FRUITS', 'MILKSHAKE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CARROT JUICE', 'VEGETABLE', 'JUICE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('KIWI MILKSHAKE', 'FRUITS', 'MILKSHAKE');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('SINGLE ALOO ROLL', 'VEG', 'ROLLS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('DOUBLE ALOO ROLL', 'VEG', 'ROLLS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('SINGLE EGG ROLL', 'EGG', 'ROLLS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('DOUBLE EGG ROLL', 'EGG', 'ROLLS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN ROLL', 'NON VEG', 'ROLLS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN MOMO', 'NON VEG', 'MOMO');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('EGG BIRYANI', 'EGG', 'BIRYANI');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VEG BIRYANI', 'VEG', 'BIRYANI');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('SHAWARMA', 'VEG', 'SHAWARMA');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('SAMOSA', 'VEG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VEG PUFF', 'VEG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('EGG PUFF', 'EGG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN PUFF', 'NON VEG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('PANNER PUFF', 'VEG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VEG SANDWICH', 'VEG', 'SANDWICH');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('EGG SANDWICH', 'EGG', 'SANDWICH');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN SANDWICH', 'NON VEG', 'SANDWICH');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VEG PIZZA', 'VEG', 'PIZZA');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('VEG BURGER', 'VEG', 'BURGER');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('CHICKEN BURGER', 'NON VEG', 'BURGER');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('PINEAPPLE CAKE', 'VEG', 'CAKES');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('BUTTERSCOTCH', 'VEG', 'CAKES');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('BLACK FOREST', 'VEG', 'CAKES');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('STRAWBERRY', 'VEG', 'CAKES');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('RED VELVET', 'VEG', 'CAKES');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('MIRCHI BAJJI', 'VEG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('ALU BAJJI', 'VEG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('EGG BAJJI', 'EGG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('ALU BONDA', 'VEG', 'SNACKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('THUMBSUP MINI', 'VEG', 'SOFT DRINKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('THUMBSUP LARGE', 'VEG', 'SOFT DRINKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('MAZZA MINI', 'VEG', 'SOFT DRINKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('SPRITE MINI', 'VEG', 'SOFT DRINKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('SPRITE LARGE', 'VEG', 'SOFT DRINKS');
INSERT INTO `foodstreetdb`.`items` (`item_name`, `type`, `section`) VALUES ('MAZZA LARGE', 'VEG', 'SOFT DRINKS');

INSERT INTO `foodstreetdb`.`stall` (`stall_id`, `stall_name`, `min_order_amount`, `opening_time`, `closing_time`, `ph_number`) VALUES 
(1, 'South Indian Stall', 50, '2025-07-20 07:00:00', '2025-07-20 22:00:00', '9876543210'),
(2, 'Juice & Milkshake Corner', 40, '2025-07-20 09:00:00', '2025-07-20 21:00:00', '9876543211'),
(3, 'Rolls & Momos Hub', 60, '2025-07-20 11:00:00', '2025-07-20 23:00:00', '9876543212'),
(4, 'Bakery & Fast Food', 70, '2025-07-20 08:00:00', '2025-07-20 22:30:00', '9876543213'),
(5, 'Beverage Counter', 20, '2025-07-20 10:00:00', '2025-07-20 20:00:00', '9876543214'),
(7, 'Snacks & Bajji Stall', 30, '2025-07-20 15:00:00', '2025-07-20 20:00:00', '9876543215'),
(10, 'Bakery Express', 50, '2025-07-20 09:00:00', '2025-07-20 21:00:00', '9876543216'),
(11, 'Rice & Noodles Point', 80, '2025-07-20 12:00:00', '2025-07-20 22:00:00', '9876543217');


INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'IDLI', '30', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'VADA', '30', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'POORI', '30', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'BONDA', '30', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'DOSA', '30', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'VEG 65', '50', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'CHICKEN 65', '70', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'CHILLI CHICKEN', '70', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'VEG FRIED RICE', '50', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'EGG FRIED RICE', '60', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'CHICKEN FRIED RICE', '70', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'CHICKEN BIRYANI', '80', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'VEG NOODLES', '50', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'EGG NOODLES', '60', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('1', 'CHICKEN NOODLES', '70', 0);

INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'GRAPE JUICE', '45', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'SAPOTA JUICE', '45', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'APPLE JUICE', '45', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'MANGO JUICE', '45', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'PINEAPPLE JUICE', '45', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'STRAWBERRY MILKSHAKE', '45', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'KIWI MILKSHAKE', '45', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'CARROT JUICE', '45', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('2', 'AVACODA MILKSHAKE', '60', 0);

INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'SINGLE ALOO ROLL', '30', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'DOUBLE ALOO ROLL', '35', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'SINGLE EGG ROLL', '35', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'DOUBLE EGG ROLL', '45', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'CHICKEN ROLL', '55', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'CHICKEN MOMO', '90', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'CHICKEN BIRYANI', '100', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'EGG BIRYANI', '80', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('3', 'VEG BIRYANI', '70', 0);

INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'SAMOSA', '10', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'VEG PUFF', '15', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'EGG PUFF', '15', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'CHICKEN PUFF', '18', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'PANNER PUFF', '20', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'CHICKEN ROLL', '50', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'VEG SANDWICH', '30', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'EGG SANDWICH', '35', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'CHICKEN SANDWICH', '40', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'VEG PIZZA', '100', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'VEG BURGER', '40', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'CHICKEN BURGER', '60', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'STRAWBERRY MILKSHAKE', '50', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'PINEAPPLE CAKE', '450', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'BUTTERSCOTCH', '450', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'BLACK FOREST', '550', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'STRAWBERRY', '450', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('4', 'RED VELVET', '750', 1);

INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('5', 'THUMBSUP MINI', '20', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('5', 'THUMBSUP LARGE', '40', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('5', 'SPRITE MINI', '20', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('5', 'SPRITE LARGE', '40', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('5', 'MAZZA MINI', '20', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('5', 'MAZZA LARGE', '40', 0);

INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('7', 'MIRCHI BAJJI', '30', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('7', 'ALU BAJJI', '30', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('7', 'ALU BONDA', '30', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('7', 'SAMOSA', '30', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('7', 'EGG BAJJI', '40', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('7', 'MAZZA MINI', '20', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('7', 'THUMBSUP MINI', '20', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('7', 'SPRITE MINI', '20', 0);

INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'SAMOSA', '15', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'VEG PUFF', '16', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'EGG PUFF', '21', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'CHICKEN PUFF', '25', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'CHICKEN BURGER', '60', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'VEG SANDWICH', '35', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'MANGO JUICE', '40', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'PINEAPPLE JUICE', '40', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('10', 'APPLE JUICE', '40', 1);

INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('11', 'VEG FRIED RICE', '50', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('11', 'EGG FRIED RICE', '60', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('11', 'CHICKEN FRIED RICE', '70', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('11', 'VEG NOODLES', '50', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('11', 'EGG NOODLES', '60', 0);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('11', 'CHICKEN NOODLES', '70', 1);
INSERT INTO `foodstreetdb`.`menu` (`stall_id`, `item_name`, `cost`, `available`) VALUES ('11', 'CHICKEN BIRYANI', '110', 1);



INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('GOOGLE PAY', 'UPI');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('PHONE PE', 'UPI');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('PAYTM', 'UPI');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('PAYTM WALLET', 'WALLET');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('FREECHARGE', 'WALLET');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('MOBIQWIK', 'WALLET');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('SLICE', 'PAY LATER');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('JUPITER', 'PAY LATER');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('AMAZON PAY LATER', 'PAY LATER');
INSERT INTO `foodstreetdb`.`payment_mode` (`payment_name`, `payment_type`) VALUES ('CASH ON DELIVERY', 'CASH ON DELIVERY');


INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MEB0A01', 'PAYTM');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MEB0A01', 'SLICE');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MEB0A01', 'PHONE PE');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MEB0A01', 'CASH ON DELIVERY');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CSB0A02', 'CASH ON DELIVERY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CSB0A02', 'PHONE PE');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22ECB0A23', 'GOOGLE PAY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22ECB0A23', 'SLICE');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22ECB0A23', 'CASH ON DELIVERY');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MMB0A24', 'CASH ON DELIVERY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MMB0A24', 'SLICE');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MMB0A24', 'PAYTM');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MMB0A24', 'PHONE PE');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('23MEB0A24', 'CASH ON DELIVERY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('23MEB0A24', 'GOOGLE PAY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('23MEB0A24', 'PAYTM');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22BTB0A24', 'CASH ON DELIVERY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22BTB0A24', 'PHONE PE');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('23CEB0A24', 'CASH ON DELIVERY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('23CEB0A24', 'PAYTM');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22EEB0A24', 'CASH ON DELIVERY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22EEB0A24', 'AMAZON PAY LATER');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CHB0A24', 'CASH ON DELIVERY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CHB0A24', 'FREECHARGE');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CSB0C34', 'CASH ON DELIVERY');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CSB0C34', 'SLICE');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CSB0C34', 'PHONE PE');
INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CSB0C34', 'MOBIQWIK');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22ECB0C44', 'CASH ON DELIVERY');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('23ECB0A23', 'CASH ON DELIVERY');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22MEB0A45', 'CASH ON DELIVERY');

INSERT INTO `foodstreetdb`.`has` (`roll_no`, `payment_name`) VALUES ('22CSB0C24', 'CASH ON DELIVERY');



INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `last_name`, `ph_number`) VALUES ('1000', 'Srikanth', 'Reddy', '9492621670');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `last_name`, `ph_number`) VALUES ('1002', 'Vamsi', 'Krishna', '9492621671');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `last_name`, `ph_number`) VALUES ('1003', 'Manideep ', 'Reddy', '9492621672');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `ph_number`) VALUES ('1004', 'Nikhil', '9492621673');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `last_name`, `ph_number`) VALUES ('1005', 'Uday', 'Kiran', '9492621674');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `last_name`, `ph_number`) VALUES ('1006', 'Aman ', 'Raj', '9492621675');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `last_name`, `ph_number`) VALUES ('1007', 'Animesh', 'Kumar', '9492621676');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `ph_number`) VALUES ('1008', 'Amit', '9492621677');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `ph_number`) VALUES ('1009', 'Srihari', '9492621678');
INSERT INTO `foodstreetdb`.`delivery_boy` (`boy_id`, `first_name`, `last_name`, `ph_number`) VALUES ('1001', 'Vinay', 'Shankar', '9492621679');


INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`, `Description`) 
VALUES ('123456789', '2023-07-28', '22MEB0A01', '1', '1001', '5', 'PAYTM', 'ABCD123450', 'GIVE MORE CHUTNEY');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`) 
VALUES ('123456788', '2023-07-28', '22CSB0A02', '1', '1001', '5', 'PHONE PE', 'ABCD123451');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`, `Description`) 
VALUES ('123456787', '2023-07-28', '22MMB0A24', '3', '1003', '5', 'SLICE', 'ABCD123452', 'ADD MORE SAUSE');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`) 
VALUES ('123456786', '2023-07-24', '22ECB0A23', '3', '1003', '5', 'GOOGLE PAY', 'ABCD123453');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`, `Description`) 
VALUES ('123456785', '2023-07-24', '23MEB0A24', '11', '1000', '5', 'PAYTM', 'ABCD123454', 'LESS SPICE');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`) 
VALUES ('123456784', '2023-07-20', '22BTB0A24', '11', '1000', '5', 'PAYTM', 'ABCD123455');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`, `Description`) 
VALUES ('123456783', '2023-07-20', '22EEB0A24', '11', '1000', '5', 'CASH ON DELIVERY', 'ABCD123456', 'MORE SPICE');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`, `Description`) 
VALUES ('123456782', '2023-07-15', '22CHB0A24', '7', '1007', '5', 'CASH ON DELIVERY', 'ABCD123457', 'ADD CHILLIES');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`) 
VALUES ('123456781', '2023-07-10', '22CSB0C34', '2', '1002', '5', 'CASH ON DELIVERY', 'ABCD123458');

INSERT INTO `foodstreetdb`.`orders` (`order_id`, `order_date`, `roll_no`, `stall_id`, `boy_id`, `delivery_charge`, `payment_name`, `transaction_id`, `Description`) 
VALUES ('123456780', '2023-07-01', '22MEB0A45', '2', '1002', '5', 'CASH ON DELIVERY', 'ABCD123459', 'GIVE STRAWS');


INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456780', 'AVACODA MILKSHAKE', '2');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456780', 'MANGO JUICE', '1');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456781', 'APPLE JUICE', '3');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456782', 'ALU BAJJI', '2');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456782', 'SAMOSA', '2');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456783', 'CHICKEN BIRYANI', '1');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456784', 'CHICKEN BIRYANI', '1');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456785', 'CHICKEN FRIED RICE', '2');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456786', 'CHICKEN MOMO', '1');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456786', 'CHICKEN BIRYANI', '1');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456787', 'CHICKEN ROLL', '2');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456788', 'IDLI', '2');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456788', 'VADA', '2');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456789', 'VEG 65', '1');
INSERT INTO `foodstreetdb`.`ordered_items` (`order_id`, `item_name`, `quantity`) VALUES ('123456789', 'VEG FRIED RICE', '1');


INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456783', '2024-07-20 10:00:00', 'PLACED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456783', '2024-07-20 10:08:00', 'ACCEPTED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456783', '2024-07-20 10:20:00', 'PICKED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456783', '2024-07-20 10:40:00', 'DELIVERED');

INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456784', '2024-07-20 11:00:00', 'PLACED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456784', '2024-07-20 11:05:00', 'ACCEPTED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456784', '2024-07-20 11:15:00', 'PICKED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456784', '2024-07-20 11:30:00', 'DELIVERED');

INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456785', '2024-07-24 09:30:00', 'PLACED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456785', '2024-07-24 09:40:00', 'ACCEPTED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456785', '2024-07-24 09:50:00', 'PICKED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456785', '2024-07-24 10:05:00', 'DELIVERED');

INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456786', '2024-07-24 13:00:00', 'PLACED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456786', '2024-07-24 13:05:00', 'ACCEPTED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456786', '2024-07-24 13:15:00', 'PICKED');

INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456787', '2024-07-28 18:00:00', 'PLACED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456787', '2024-07-28 18:10:00', 'ACCEPTED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456787', '2024-07-28 18:25:00', 'PICKED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456787', '2024-07-28 18:45:00', 'DELIVERED');

INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456788', '2024-07-28 19:00:00', 'PLACED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456788', '2024-07-28 19:05:00', 'ACCEPTED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456788', '2024-07-28 19:20:00', 'PICKED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456788', '2024-07-28 19:40:00', 'DELIVERED');

INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456789', '2024-07-28 20:00:00', 'PLACED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456789', '2024-07-28 20:10:00', 'ACCEPTED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456789', '2024-07-28 20:20:00', 'PICKED');
INSERT INTO `foodstreetdb`.`order_status` (`order_id`, `time`, `status`) VALUES ('123456789', '2024-07-28 20:45:00', 'DELIVERED');


