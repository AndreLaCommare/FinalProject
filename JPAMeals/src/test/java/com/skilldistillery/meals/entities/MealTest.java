package com.skilldistillery.meals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.fail;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.User;

class MealTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Meal meal;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAMeals");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em =emf.createEntityManager();
		meal = em.find(Meal.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		meal=null;
	}

	@Test
	void test() {
		assertNotNull(meal);
		assertEquals("Pan-Fried Sausage", meal.getName());
	}
	@Test
	void test_Meal_has_User() {
		assertNotNull(meal);
		assertEquals("TheMuffinMan", meal.getUser().getUsername());
	}
	@Test
	void test_Meal_has_List_of_Users_who_Fav() {
		assertNotNull(meal);
		assertEquals("admin", meal.getUsersWithFavMeals().get(0).getUsername());
	}
	@Test
	void test_Meal_has_List_of_Diets() {
		assertNotNull(meal);
		assertFalse( meal.getDiets().isEmpty());
	}
	@Test
	void test_Meal_has_List_of_MealPlans() {
		assertNotNull(meal);
		assertFalse(meal.getDiets().isEmpty());
	}
	@Test
	void test_Meal_has_List_of_reviews() {
		assertNotNull(meal);
		assertFalse(meal.getReviews().isEmpty());
	}
	@Test
	void test_Meal_has_List_of_groceries() {
		assertNotNull(meal);
		assertFalse(meal.getGroceryItems().isEmpty());
	}
	@Test
	void test_Meal_has_List_of_comments() {
		assertNotNull(meal);
		assertFalse(meal.getComments().isEmpty());
	}

}
