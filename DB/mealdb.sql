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
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (7, 'Braised Chipotle Sweet Potatoes', 'This super-easy weeknight dinner shows once and for all that braising isn\'t just for meat! Spicy, tender sweet potatoes simmer in a delicious sauce with stewed carrot pieces and slightly crisp kale. Perfect for vegans and carnivores alike, it\'s served with a sprinkle of crisp radish sticks and cilantro for a fresh finish.', 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2021/02/03/FNK_BraisedChipotleSweetPotatoes_H.jpg.rend.hgtvcom.966.725.suffix/1612402075644.jpeg', 'Arrange an oven rack in the lower third of the oven and preheat to 350 degrees F.\nHeat a large braiser or Dutch oven over medium heat. Add the cumin seeds and toast, stirring occasionally, until very fragrant, about 1 minute. Add the olive oil, carrots and onions and cook, stirring frequently, until the carrots soften and the onions start to become translucent, 3 to 4 minutes. Add the sweet potatoes and 1 teaspoon salt and toss together so that everything is coated with the oil and seeds. Cook until the sweet potatoes start to soften slightly on the edges, about 5 minutes.\nStir in the kale and 1 teaspoon salt and let wilt slightly, another 2 minutes. While the kale is cooking, stir the orange juice, tomato paste, brown sugar and chipotle into the vegetable broth. Add the adobo sauce, if using. Pour the mixture into the pot. Stir and toss all the vegetables with the broth mixture and bring the mixture to a boil. Taste for seasoning and add more salt if desired.  \nCover with a lid and bake 30 minutes. Remove the lid, stir and bake, uncovered, until the potatoes are very tender and saucy, about 30 minutes more. Serve on a bed of brown rice if desired, topped with radish and cilantro.', 1, 1, 25, 60, 3, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (8, 'Cauliflower Parmesan', 'This delicious, hearty cauliflower parm doesn\'t skimp on the flavor and will satisfy everyone, from vegetarians to the most die-hard carnivore. Serve with pasta for a stick-to-your-ribs dinner without the meat.', 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2018/9/26/0/FNK_Cauliflower-Parmesan_H2_s4x3.jpg.rend.hgtvcom.966.725.suffix/1537973100194.jpeg', 'Preheat the oven to 400 degrees F and line a plate with paper towels.\nPull off the leaves from the base of the cauliflower and cut off the stem, but do not cut out the core. Slice the cauliflower into 1-inch thick slices, aiming for about 3 nice \"steaks\" from the center. The rest will break into smaller florets, and that is okay.\nMix the flour with 1 teaspoon salt in a shallow bowl or pie plate. Put the eggs in another shallow bowl and panko in a third shallow bowl. \nAdd 1/4 inch olive oil to a large skillet and heat over medium-high heat until shimmering.\nWorking with the larger pieces first, add the cauliflower to the flour and turn to coat. Shake off the excess, then dip in the egg to coat. Let the excess egg drip off, then coat thoroughly in the panko. Fry the cauliflower in batches to avoid overcrowding, turning once, until golden brown on both sides, 6 to 8 minutes total. Transfer to the lined plate to drain and sprinkle with salt. Repeat with the remaining smaller pieces of cauliflower (leave out any tiny crumbly pieces). \nSpread 1 cup marinara sauce on the bottom of a 9-by-13-inch baking dish. Arrange the fried cauliflower on top, then spoon 1 cup of the sauce on top of the cauliflower. Arrange the mozzarella over the sauce, then spoon the remaining 1/2 cup marinara over the top. Sprinkle with the Parmesan and bake until bubbling and lightly browned in spots, about 35 minutes. Sprinkle with the basil and serve.', 1, 1, 30, 60, 3, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (9, 'Cauliflower and Chickpea Tacos', 'These roasted cauliflower and chickpea tacos are bursting with flavor. With a vegetarian base, the strong flavors of fresh jalapeño and a spice blend, and the creaminess of avocado and lime crema, these tacos have it all.', 'https://www.twopeasandtheirpod.com/wp-content/uploads/2018/06/Roasted-Cauliflower-and-Chickpea-Tacos41236.jpg', 'Heat the tortillas. Before assembling the tacos, heat the tortillas in a pan, or directly over a flame. Warming them up makes them more malleable, so they’re less likely to tear or fall apart. It also increases the corn flavor. \nUse a perfectly ripe avocado. Picking the right avocado can make a huge difference. An unripe avocado can ruin the texture of these tacos, while also not being very flavorful. Pick an avocado that doesn’t feel mushy, but is soft when you squeeze it. \nMake the crema ahead of time. The further in advance you make the lime crema, the longer the flavors will have to meld together. Making it a few hours in advance, or even the day before, can really increase the intensity of the flavors.', 1, 1, 20, 20, 4, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (10, 'Mushroom Lentil Loaf with Garlic Cauliflower', 'Can’t get enough of making nutritious yet flavorful vegan meals? Here’s another recipe you can add to your list! Try this mushroom lentil loaf—a perfect replacement for your meat as your protein source in your diet. This time, you’ll be having a savory and delectable dish that you can eat as sides to brown rice, quinoa, or your cauliflower rice.', 'https://www.peasofmind.com/wp-content/uploads/2022/08/vegan-lentil-loaf.jpg', 'Prepare your lentils by washing them with cold water in a strainer.\nBring your 4 cups of water or vegetable broth to a boil, and add the bay leaf, and the lentils, allowing them for a few minutes to cook or until lentils are tender.\nRemove from the heat, drain the excess water and set it aside. Don’t forget to take out the bay leaf too.\nSauté the vegetables. In a medium pan, heat 1 tablespoon of olive oil. Add the garlic and onions until translucent and the aroma emerges. \nAdd the chopped carrots and mushrooms, and stir for about 5-6 minutes until slightly cooked.\nSprinkle the smoked paprika, thyme, salt and pepper and cook for an additional 1-2 minutes until fragrant.\n', 1, 1, 10, 25, 4, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (11, 'Crispy and Spicy Cauliflower Recipe', '\nMaple Roasted Cauliflower\nVegan and Gluten-Free Baked Crispy Cauliflower Poppers\nHemp Seed-Crusted Whole Roasted Cauliflower with Green Tahini...\nBest Crispy BBQ Roasted Cauliflower\nCauliflower Steak Marbella with Roasted Chickpeas\nVegan Mashed Cauliflower with Roasted Garlic\nCrispy Maple Roasted Brussels Sprouts\nVegan Cauliflower Chickpea Shawarma Bowls\nCrispy Oven Roasted Cauliflower\nBy Elaine Gordon · Published: Sep 23, 2020 · Modified: Feb 15, 2022\n\nJUMP TO RECIPE\nVG\nGF\nP\nNF\nSF\nE\nThis is the easiest weeknight side dish ever! Cauliflower florets are tossed with a bit of oil, some simple spices, and roasted in the oven. Crispy Oven Roasted Cauliflower has the perfect bite on the outside with a tender, flavorful middle that isn\'t mushy at all. There are so many ways to enjoy this roasted veggie side, and they\'re all delicious!', 'https://rachlmansfield.com/wp-content/uploads/2019/02/6C4725A1-7E71-4379-AC99-7BC4950E914C-768x1024.jpg', 'In a large bowl, beat the eggs and toss in the cauliflower florets to coat well. Shake off any excess egg coating and place the florets on a plate. \nSprinkle the florets evenly with almond flour and chili powder (if using). \nFill a deep frying pan or wok with canola oil to a depth of 2 inches; heat to 350ºF. \nFry the florets in batches for about 2 minutes each, placing them on paper towels to soak up excess oil. Transfer to a serving plate. \nTo serve, drizzle cauliflower with fish sauce and lime juice and top with chopped scallions.', 1, 1, 15, 20, 5, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (12, 'Deviled Eggs Delight', 'I got this recipe online somewhere. It is really good and very Atkins friendly!', 'https://img.sndimg.com/food/image/upload/f_auto,c_thumb,q_55,w_200,ar_3:2/v1/img/recipes/10/26/94/picMfApAe.jpg', 'Split eggs lengthwise, take out yolk.\nMix yolk with remaining ingredients except paprika.\nFill eggs with mixture and sprinkle paprika on top.', 1, 1, 15, 20, 5, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (13, 'Easy Cheeseburger Pie', 'This easy cheeseburger pie is perfect for a low-stress dinner any day of the week! ', 'https://carnivore.diet/wp-content/uploads/elementor/thumbs/Easy-Cheeseburger-Pie-pin-1-e1661371985253-ptr1ufq58n1amuwk2px4ag6mzbychdhqe7qielgrxc.jpg', 'Preheat the oven to 350°F (175°C) and grease a 9-inch round pie plate or 8×8-inch baking dish.\nLightly brown the meat in cooking fat over medium-high heat in a heavy-bottomed skillet or cast iron. Transfer to pie plate once cooked.\nAdd a little more fat to the skillet and brown the onions until translucent, about 5-7 minutes. Stir frequently.\nWhile the onions cook, whisk the eggs. Add herbs, salt and pepper.\nPour over the beef so it sinks into the meat. Shake the dish gently if needed.\nArrange the onions in an even layer over the eggs and meat.\nTop the whole pie with cheese.\nBake for 20 minutes, until cheese is melted and bubbly.\nAllow the cheeseburger pie to rest for 5 minutes before slicing.', 1, 1, 30, 30, 2, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (14, 'Carnivore Meatballs With Beef Heart', 'You can easily double this recipe and use a larger pan, keep in mind it will take longer to cook.', 'https://carnivore.diet/wp-content/uploads/elementor/thumbs/easy-beef-heart-recipe-PIN-683x1024-1-e1661373923309-ptr391dd5kazn5eillc3iohy82jousdjco1igufsyo.jpeg', 'Mix the two ground meats in a bowl until well combined. Season with salt.\nScoop approximately 2 ounces and roll between the palms of your hands to form a ball shape.\nPlace in a small glass baking dish.\nBake in a preheated oven at 350*F (175*C) for 20 minutes.\nJuices will run onto the baking dish once meat is cooked through. Serve meatballs warm with this “sauce” spooned over.', 1, 1, 30, 60, 2, NULL, NULL);
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (15, 'Spicy Chicken Cheesy Muffins', 'You have never had muffins like these – guaranteed!', 'https://carnivore.diet/wp-content/uploads/2022/08/chicken_muffins-e1661371671379.jpeg', 'Preheat oven to 350 degrees.\nCombine all ingredients in a bowl with a spoon. Or if you want a less chunky muffin, mix in a food processor or in a stand mixer with the paddle attachment.\nDivide batter into 8 lined cupcake cups.\nBake for 20-22 minutes or until center is set.', 1, 1, 20, 60, 2, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_plan`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (1, 'Carnivore', 'Only Eat Meat', 1, 1, NULL, NULL, 1, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (2, 'Carnivore', 'Only Eat Meat', 1, 1, NULL, NULL, 2, 1);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (3, 'Easy Fun and Fast For Vegetarians', 'Try out this meal plan if you are looking for a great way to maintain a vegetarian diet without the stress of difficult planning!', 1, 1, NULL, NULL, 3, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (4, 'Vegan Meals By Vinnie', 'Check out these meals that I\'ve designed to help you with your vegan lifestyle.', 1, 1, NULL, NULL, 4, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (5, 'All the Way Vegan', 'A meal plan only for hardcore vegans!', 1, 1, NULL, NULL, 4, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (6, 'Beginner Vegan Meal Plan', 'A great way to start out your vegan journey', 1, 1, NULL, NULL, 4, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (7, 'Hardcore Vegetarians', 'If you are about the vegetarian lifestyle this meal plan is for you. ', 1, 1, NULL, NULL, 3, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (8, 'Meat Lovers', 'Do You love Meat? Checkout out this meal plan', 1, 1, NULL, NULL, 2, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (9, 'Atkins For Everyone', 'Beginners guide to the Atkins Diet', 1, 1, NULL, NULL, 5, NULL);
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `created_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (10, 'Advanced Atkins ', 'You think you can handle the Atkins?', 1, 1, NULL, NULL, 5, NULL);

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
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (1, 'Sausage', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (2, 'Pork Sausage', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (3, 'Bacon', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (4, 'From Frozen Burger', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (5, 'Romaine Lettuce', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (6, 'Croutons', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (7, 'Skinless Chicken Breast', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (8, 'American Cheese', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (9, 'BBQ Sauce', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (10, 'Spaghetti Squash', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (11, 'Kosher Salt', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (12, 'Maple Syrup', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (13, 'Tomato Paste', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (14, 'Slider Buns', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (15, 'Cauliflower', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (16, 'Puff Pastry', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (17, 'Eggs', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (18, 'Baking Soda', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (19, 'Salt', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (20, 'Garlic', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (21, 'Black Pepper', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (22, 'Ground Beef', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (23, 'Beef Heart', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (24, 'Onion', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (25, 'Mayonnaise', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (26, 'Sweet Potatoes', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (27, 'White Potatoes', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (28, 'Mushroom', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (29, 'Parmesan Cheese', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (30, 'Lentil Beans', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (31, 'Chic Peas', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (32, 'Cheddar Cheese', NULL);
INSERT INTO `grocery_item` (`id`, `name`, `created_at`) VALUES (33, 'Flour', NULL);

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
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (7, 26);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (8, 15);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (8, 29);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (9, 15);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (9, 31);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (9, 19);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (9, 20);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (9, 21);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (10, 28);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (10, 30);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (10, 31);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (10, 33);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (11, 15);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (11, 20);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (11, 19);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (12, 17);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (12, 19);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (12, 21);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (13, 19);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (13, 20);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (13, 21);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (13, 22);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (13, 8);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (14, 22);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (14, 23);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (14, 19);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (14, 20);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (14, 21);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (15, 19);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (15, 21);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (15, 32);
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (15, 33);

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
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (3, 7);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (3, 8);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (4, 9);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (4, 10);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (5, 9);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (5, 10);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (6, 9);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (6, 10);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (7, 7);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (7, 8);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (7, 5);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (7, 6);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (8, 15);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (8, 14);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (8, 13);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (8, 2);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (9, 11);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (9, 12);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (10, 11);
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (10, 12);

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
INSERT INTO `diet` (`id`, `name`) VALUES (3, 'Vegan');
INSERT INTO `diet` (`id`, `name`) VALUES (4, 'Atkins');

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
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (2, 6);
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (2, 7);
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (3, 4);
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (3, 5);
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (1, 8);
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (4, 9);
INSERT INTO `meal_plan_has_diet` (`diet_id`, `meal_plan_id`) VALUES (4, 10);

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

