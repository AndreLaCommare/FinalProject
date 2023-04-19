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
  `create_at` DATETIME NULL,
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
  `name` VARCHAR(45) NULL,
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
  `enabled` TINYINT NULL,
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
  `enabled` TINYINT NULL,
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
  `enabled` TINYINT NULL,
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
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `created_at`, `updated_at`, `about_me`, `first_name`, `last_name`, `image_url`) VALUES (2, 'TheMuffinMan', '$2a$10$WC4HS0N8DLo0DDhvRkyESuZylBcxJ63.URpT4Rv2LDjzVWKlYn.Je', 1, 'standard', 'IknowTheMuffinMan@drewyLane.com', NULL, NULL, NULL, 'Muffin', 'Man', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal` (`id`, `name`, `description`, `image_url`, `instructions`, `enabled`, `public`, `prep_time`, `cook_time`, `user_id`, `created_at`, `updated_at`) VALUES (1, 'Pan-Fried Sausage', 'A great meal for anyone on a carnivore diet', NULL, 'Set stove top to medium-high cook on each side for 5 minutes', 1, 1, 2, 10, 2, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_plan`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_plan` (`id`, `title`, `description`, `enabled`, `public`, `create_at`, `updated_at`, `user_id`, `copied_from_id`) VALUES (1, 'Carnivore', 'Only Eat Meat', 1, 1, NULL, NULL, 1, NULL);

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_has_grocery_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_has_grocery_item` (`meal_id`, `grocery_item_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_plan_has_meal`
-- -----------------------------------------------------
START TRANSACTION;
USE `mealdb`;
INSERT INTO `meal_plan_has_meal` (`meal_plan_id`, `meal_id`) VALUES (1, 1);

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
INSERT INTO `diet` (`id`, `name`) VALUES (1, 'carnivore');

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
INSERT INTO `plan_comment` (`id`, `comment`, `enabled`, `created_at`, `updated_at`, `meal_plan_id`, `user_id`) VALUES (1, 'Where are the vegetables', 1, NULL, NULL, 1, 2);

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

