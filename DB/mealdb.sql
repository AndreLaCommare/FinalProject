-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mealdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mealdb` ;

-- -----------------------------------------------------
-- Schema mealdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mealdb` DEFAULT CHARACTER SET utf8 ;
USE `mealdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `role` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `about_me` TEXT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal` ;

CREATE TABLE IF NOT EXISTS `meal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(1000) NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `instructions` TEXT NULL,
  `enabled` TINYINT NOT NULL,
  `public` TINYINT NOT NULL,
  `prep_time` INT NULL,
  `cook_time` INT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meal_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_meal_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_plan` ;

CREATE TABLE IF NOT EXISTS `meal_plan` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(2000) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `public` TINYINT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  `copied_from_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meal_plan_user1_idx` (`user_id` ASC),
  INDEX `fk_meal_plan_meal_plan1_idx` (`copied_from_id` ASC),
  CONSTRAINT `fk_meal_plan_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_plan_meal_plan1`
    FOREIGN KEY (`copied_from_id`)
    REFERENCES `meal_plan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_review` ;

CREATE TABLE IF NOT EXISTS `meal_review` (
  `user_id` INT NOT NULL,
  `meal_id` INT NOT NULL,
  `comment` VARCHAR(250) NULL,
  `stars` INT(1) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  INDEX `fk_review_meal1_idx` (`meal_id` ASC),
  PRIMARY KEY (`user_id`, `meal_id`),
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_meal1`
    FOREIGN KEY (`meal_id`)
    REFERENCES `meal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grocery_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_item` ;

CREATE TABLE IF NOT EXISTS `grocery_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal_has_grocery_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_has_grocery_item` ;

CREATE TABLE IF NOT EXISTS `meal_has_grocery_item` (
  `meal_id` INT NOT NULL,
  `grocery_item_id` INT NOT NULL,
  PRIMARY KEY (`meal_id`, `grocery_item_id`),
  INDEX `fk_meal_has_grocery_item_grocery_item1_idx` (`grocery_item_id` ASC),
  INDEX `fk_meal_has_grocery_item_meal1_idx` (`meal_id` ASC),
  CONSTRAINT `fk_meal_has_grocery_item_meal1`
    FOREIGN KEY (`meal_id`)
    REFERENCES `meal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_has_grocery_item_grocery_item1`
    FOREIGN KEY (`grocery_item_id`)
    REFERENCES `grocery_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal_plan_has_meal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_plan_has_meal` ;

CREATE TABLE IF NOT EXISTS `meal_plan_has_meal` (
  `meal_plan_id` INT NOT NULL,
  `meal_id` INT NOT NULL,
  PRIMARY KEY (`meal_plan_id`, `meal_id`),
  INDEX `fk_meal_plan_has_meal_meal1_idx` (`meal_id` ASC),
  INDEX `fk_meal_plan_has_meal_meal_plan1_idx` (`meal_plan_id` ASC),
  CONSTRAINT `fk_meal_plan_has_meal_meal_plan1`
    FOREIGN KEY (`meal_plan_id`)
    REFERENCES `meal_plan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_plan_has_meal_meal1`
    FOREIGN KEY (`meal_id`)
    REFERENCES `meal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `body` VARCHAR(1000) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` VARCHAR(45) NULL,
  `enabled` TINYINT NOT NULL,
  `sender_id` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user1_idx` (`sender_id` ASC),
  INDEX `fk_message_user2_idx` (`receiver_id` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_favorite_meal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_favorite_meal` ;

CREATE TABLE IF NOT EXISTS `user_has_favorite_meal` (
  `user_id` INT NOT NULL,
  `meal_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `meal_id`),
  INDEX `fk_user_has_meal_meal1_idx` (`meal_id` ASC),
  INDEX `fk_user_has_meal_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_meal_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_meal_meal1`
    FOREIGN KEY (`meal_id`)
    REFERENCES `meal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_favorite_meal_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_favorite_meal_plan` ;

CREATE TABLE IF NOT EXISTS `user_has_favorite_meal_plan` (
  `meal_plan_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`meal_plan_id`, `user_id`),
  INDEX `fk_meal_plan_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_meal_plan_has_user_meal_plan1_idx` (`meal_plan_id` ASC),
  CONSTRAINT `fk_meal_plan_has_user_meal_plan1`
    FOREIGN KEY (`meal_plan_id`)
    REFERENCES `meal_plan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_plan_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diet` ;

CREATE TABLE IF NOT EXISTS `diet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_grocery_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_grocery_list` ;

CREATE TABLE IF NOT EXISTS `user_grocery_list` (
  `user_id` INT NOT NULL,
  `grocery_item_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `grocery_item_id`),
  INDEX `fk_user_has_grocery_item_grocery_item1_idx` (`grocery_item_id` ASC),
  INDEX `fk_user_has_grocery_item_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_grocery_item_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_grocery_item_grocery_item1`
    FOREIGN KEY (`grocery_item_id`)
    REFERENCES `grocery_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal_plan_has_diet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_plan_has_diet` ;

CREATE TABLE IF NOT EXISTS `meal_plan_has_diet` (
  `diet_id` INT NOT NULL,
  `meal_plan_id` INT NOT NULL,
  PRIMARY KEY (`diet_id`, `meal_plan_id`),
  INDEX `fk_diet_has_meal_plan_meal_plan1_idx` (`meal_plan_id` ASC),
  INDEX `fk_diet_has_meal_plan_diet1_idx` (`diet_id` ASC),
  CONSTRAINT `fk_diet_has_meal_plan_diet1`
    FOREIGN KEY (`diet_id`)
    REFERENCES `diet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diet_has_meal_plan_meal_plan1`
    FOREIGN KEY (`meal_plan_id`)
    REFERENCES `meal_plan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal_has_diet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_has_diet` ;

CREATE TABLE IF NOT EXISTS `meal_has_diet` (
  `diet_id` INT NOT NULL,
  `meal_id` INT NOT NULL,
  PRIMARY KEY (`diet_id`, `meal_id`),
  INDEX `fk_diet_has_meal_meal1_idx` (`meal_id` ASC),
  INDEX `fk_diet_has_meal_diet1_idx` (`diet_id` ASC),
  CONSTRAINT `fk_diet_has_meal_diet1`
    FOREIGN KEY (`diet_id`)
    REFERENCES `diet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diet_has_meal_meal1`
    FOREIGN KEY (`meal_id`)
    REFERENCES `meal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plan_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `plan_comment` ;

CREATE TABLE IF NOT EXISTS `plan_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(500) NULL,
  `enabled` TINYINT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `meal_plan_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_plan_comment_meal_plan1_idx` (`meal_plan_id` ASC),
  INDEX `fk_plan_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_plan_comment_meal_plan1`
    FOREIGN KEY (`meal_plan_id`)
    REFERENCES `meal_plan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_comment` ;

CREATE TABLE IF NOT EXISTS `meal_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(500) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `user_id` INT NOT NULL,
  `meal_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_plan_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_plan_comment_copy1_meal1_idx` (`meal_id` ASC),
  CONSTRAINT `fk_plan_comment_user10`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_comment_copy1_meal1`
    FOREIGN KEY (`meal_id`)
    REFERENCES `meal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plan_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `plan_review` ;

CREATE TABLE IF NOT EXISTS `plan_review` (
  `user_id` INT NOT NULL,
  `meal_plan_id` INT NOT NULL,
  `comment` VARCHAR(250) NULL,
  `stars` INT(1) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`user_id`, `meal_plan_id`),
  INDEX `fk_review_copy1_meal_plan1_idx` (`meal_plan_id` ASC),
  CONSTRAINT `fk_review_user10`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_copy1_meal_plan1`
    FOREIGN KEY (`meal_plan_id`)
    REFERENCES `meal_plan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS mealuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'mealuser'@'localhost' IDENTIFIED BY 'mealuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'mealuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `created_at`, `updated_at`, `about_me`, `first_name`, `last_name`, `image_url`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'ADMIN', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `created_at`, `updated_at`, `about_me`, `first_name`, `last_name`, `image_url`) VALUES (2, 'TheMuffinMan', '$2a$10$WC4HS0N8DLo0DDhvRkyESuZylBcxJ63.URpT4Rv2LDjzVWKlYn.Je', 1, 'standard', 'IknowTheMuffinMan@drewyLane.com', NULL, NULL, NULL, 'Muffin', 'Man', 'https://ralphpeterson.com/wp-content/uploads/2019/05/placard-mobile-muffin-book2-680x675.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `created_at`, `updated_at`, `about_me`, `first_name`, `last_name`, `image_url`) VALUES (3, 'VeggieVicky', '$2a$10$1McKb4rlVEQSm1vdIH6rvudkiXqGPlzNG/Bpaono1OYmPgGlgcLvi', 1, 'standard', 'animals@animals.com', NULL, NULL, NULL, 'Vicky', 'Vickerson', 'https://www.curlynikki.com/wp-content/uploads/2017/07/woman_eating_veggies_caro_page-bg_28467.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `created_at`, `updated_at`, `about_me`, `first_name`, `last_name`, `image_url`) VALUES (4, 'VeganVinny', '$2a$10$KnAcNLMP657mhlv2649aluOtVT5kyWRxEEMNNJ/efC6zixG4oOYya', 1, 'standard', 'veganvinny@vegan.com', NULL, NULL, NULL, 'Vinny', 'Ventura', 'https://www.pixword.net/image-VEGETARIAN_2200.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `created_at`, `updated_at`, `about_me`, `first_name`, `last_name`, `image_url`) VALUES (5, 'AndyAtkins', '$2a$10$meaN1Fg8jPQlfmpPDXQMGOr6oT.2zMhBdZXg3ZfwAegGSU3oM8cn2', 1, 'standard', 'NoCarbs@gmail.com', NULL, NULL, NULL, 'Andy', 'Anderson', 'https://www.decisionmarketing.co.uk/wp-content/uploads/2011/08/atkins_diet.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (1, 'Pan-Fried Sausage', 'A great meal for anyone on a carnivore diet', 'https://www.creolecontessa.com/wp-content/uploads/2012/11/cc4-027.jpg', 'Set stove top to medium-high cook on each side for 5 minutes', 1, 1, 2, 10, 2, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (2, 'Bacon and Sausage Breakfast', 'Try this meaty breakfast out for your carnivore diet ', 'https://www.ritzlunch.ca/wp-content/uploads/2017/06/Breakfast-Sausage-and-Bacon.jpg', 'Set stove top to high and cook sausage on each side for 5 minutes. Do the same for the bacon.', 1, 1, 2, 20, 2, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (3, 'Grilled Beef Burger with American Cheese', 'Standard style beef burger but only with the patty and cheese!', 'https://dg72su02pp5a9.cloudfront.net/wp-content/uploads/2018/05/mcdonaldsketo.jpg', 'Pan fry on high for 3 minutes each side. Then add cheese and melt for 2 minutes.', 1, 1, 2, 7, 2, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (4, 'Chicken Ceasar Salad', 'A classic ', 'https://2.bp.blogspot.com/-rBQyPCnJKwQ/W6YYBs_oAyI/AAAAAAACEpg/pra_Ah-J3NUGiUOLkTQX4GbMPwsTRNieACLcBGAs/s1600/DSCN1612.JPG', 'Pan sear chicken until cooked fully through and no pink remains. While chicken is cooking prep salad with romaine lettuce, croutons, and parmesan cheese.', 1, 0, 5, 10, 3, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (5, 'BBQ Spaghetti Squash Sliders', 'Who needs meat to make a delicious slider? These vegetarian squash sliders are sweet, tangy and messy. If you can\'t find mini slider buns, slice hot dog buns into thirds.', 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2018/6/12/0/FNK_BBQ-Squash-Slider-H_s4x3.jpg.rend.hgtvcom.966.725.suffix/1528838919928.jpeg', 'Preheat Oven to 350. Cut Sqush in half length wise cook for 45 minutes. Combine together maple syrup, tomato paste, vinegar, and BBQ sauce boil for 15 minutes. Combine all ingredients together, and slice hot dog buns in thrids to add mixture to. Serve a tasty treat. ', 1, 1, 5, 90, 3, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (6, 'Whole Cauliflower Wellington', 'Herb-butter roasted cauliflower gets a golden puff pastry blanket — the perfect main dish for vegetarians or cauliflower lovers.', 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2018/6/12/0/FNK_Cauliflower-Wellington-H_s4x3.jpg.rend.hgtvcom.966.725.suffix/1528838918836.jpeg', 'Preheat the oven to 400 degrees F. Line a baking with parchment.\nCombine the parsley, thyme, 1/2 teaspoon salt and a few grinds of pepper in to a food processor and process until finely chopped. Add the butter and process until well combined and the butter is very green. Clean out the food processor. \nCarefully remove the leaves and any small inner leave from the bottom of the cauliflower and trim the stem so it is 1/2-inch-long. Brush the cauliflower with 2 tablespoons of the herb butter and sprinkle with 1/2 teaspoon salt and a few grinds of pepper. Transfer to the prepared baking sheet and bake until a paring knife can easily be inserted and removed from stalk and the cauliflower has turned a light golden brown, 25 to 30 minutes. \nMeanwhile, pulse the mushrooms in a food processor until a paste. Melt 2 tablespoons of the herb butter in a large nonstick skillet over medium-high heat. Add the mushroom paste, 1 teaspoon salt and a few grinds of pepper and cook, stirring occasionally, until all the moisture has evaporated, about 10 minutes. Let cool slightly, about 10 minutes. \nPlace 1 puff pastry sheet on top of the other. Roll out to a 14-by-14-inch square with a 3-inch-wide border all the way around that is considerably thinner than the middle. Round the corners so you have a 13-inch circle. Brush the puff pastry with the Dijon, then spread the mushroom mixture over top. Turn the cauliflower upside down on top of and in the middle of the puff pastry circle. Melt the remaining herb butter in the microwave in 30 second intervals. Pour the butter in between the stalks of the florets. Fold the puff pastry around the cauliflower so that the whole thing is enclosed. Turn the cauliflower right side up, place it back onto the prepared baking sheet and brush with the egg. Sprinkle with 1/2 teaspoon salt and bake until the puff pastry is a deep golden brown and a paring knife can be easily inserted, twisted and removed from the stem of the cauliflower, 55 to 60 minutes. Let cool for 10 minutes before serving. Slice through the middle then into wedges. \n', 1, 1, 40, 40, 3, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_plan`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (1, 'Carnivore', 'Only Eat Meat', 1, 1, NULL, NULL, 1, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (2, 'Carnivore', 'Only Eat Meat', 1, 1, NULL, NULL, 2, 1);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (3, 'Easy Fun and Fast For Vegetarians', 'Try out this meal plan if you are looking for a great way to maintain a vegetarian diet without the stress of difficult planning!', 1, 1, NULL, NULL, 3, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_review` (`user_id`, `meal_id`, `comment`, `stars`, `enabled`, `created_at`, `updated_at`) VALUES (2, 1, 'This meal is tasty', 5, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `grocery_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (1, 'andouille sausage', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (2, 'Jimmy Dean All Natural Pork Sausage', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (3, 'Hormel Black Label Original Bacon', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (4, 'From Frozen Bubba Burger', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (5, 'Romaine Lettuce', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (6, 'Meijer Croutons', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (7, 'Perdue Skinless Chicken Breast', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (8, 'Kraft American Cheese', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (9, 'BBQ Sauce', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (10, 'Spaghetti Squash', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (11, 'Kosher Salt', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (12, 'Maple Syrup', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (13, 'Tomato Paste', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (14, 'Slider Buns', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (15, 'Large Cauliflower', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (16, 'Puff Pastry', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (17, 'Egg', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_has_grocery_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (1, 1);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (2, 2);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (2, 3);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (3, 4);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (3, 8);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (4, 5);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (4, 6);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (4, 7);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (5, 9);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (5, 10);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (5, 11);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (5, 12);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (5, 13);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (5, 14);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (6, 15);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (6, 16);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (6, 17);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_plan_has_meal`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (1, 1);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (1, 2);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (1, 3);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (3, 5);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (3, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `message`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `message` (`id`, `body`, `created_at`, `updated_at`, `enabled`, `sender_id`, `receiver_id`) VALUES (1, 'Hello', NULL, NULL, 1, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_favorite_meal`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `user_has_favorite_meal` (`user_id`, `meal_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_favorite_meal_plan`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `user_has_favorite_meal_plan` (`meal_plan_id`, `user_id`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `diet`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `diet` (`id`, `name`) VALUES (1, 'Carnivore');
INSERT INTO `diet` (`id`, `name`) VALUES (2, 'Vegetarian');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_grocery_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `user_grocery_list` (`user_id`, `grocery_item_id`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_plan_has_diet`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (1, 1);
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (2, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_has_diet`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_has_diet` (`diet_id`, `meal_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `plan_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `plan_comment` (`id`, `comment`, `enabled`, `created_at`, `updated_at`, `meal_plan_id`, `user_id`) VALUES (1, 'Where are the vegetables?', 1, NULL, NULL, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_comment` (`id`, `comment`, `created_at`, `updated_at`, `enabled`, `user_id`, `meal_id`) VALUES (1, 'That\'s a spicy sausage', NULL, NULL, 1, 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `plan_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `plan_review` (`user_id`, `meal_plan_id`, `comment`, `stars`, `enabled`, `created_at`, `updated_at`) VALUES (2, 1, 'Very good', 5, 1, NULL, NULL);

COMMIT;

