package com.skilldistillery.meals.entities;

import static org.junit.jupiter.api.Assertions.*;


import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.meals.entities.User;

class UserTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;
	
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
		user = em.find(User.class, 2);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user=null;
	}

	@Test
	void test() {
		assertNotNull(user);
		assertEquals("TheMuffinMan", user.getUsername());
	}
	@Test
	void test_User_MealComments_List() {
		
		assertNotNull(user);
		assertNotNull(user.getMealComments());
		assertFalse(user.getMealComments().isEmpty());
	}
	@Test
	void test_User_has_Groceries() {
		
		assertNotNull(user);
		assertNotNull(user.getGroceries());
		assertFalse(user.getGroceries().isEmpty());
	}
	@Test
	void test_User_has_Reviews() {
		
		assertNotNull(user);
		assertNotNull(user.getMealReviews());
		assertFalse(user.getMealReviews().isEmpty());
	}
	@Test
	void test_User_has_Meals() {
		
		assertNotNull(user);
		assertNotNull(user.getUserMeals());
		assertFalse(user.getUserMeals().isEmpty());
	}
	@Test
	void test_User_has_Fav_Meals() {
		user = em.find(User.class, 1);
		assertNotNull(user);
		assertNotNull(user.getFavoriteMeals());
		assertFalse(user.getFavoriteMeals().isEmpty());
	}
	@Test
	void test_User_has_Fav_Meal_Plans() {
		
		assertNotNull(user);
		assertNotNull(user.getFavoriteMealPlans());
		assertFalse(user.getFavoriteMealPlans().isEmpty());
	}
	@Test
	void test_User_has_reviewed_Meal_Plans() {
		
		assertNotNull(user);
		assertNotNull(user.getPlanReviews());
		assertFalse(user.getPlanReviews().isEmpty());
	}
	@Test
	void test_User_has_created_Meal_Plans() {
		user = em.find(User.class, 1);
		assertNotNull(user);
		assertNotNull(user.getUserMealPlans());
		assertFalse(user.getUserMealPlans().isEmpty());
	}
	@Test
	void test_User_PlanComments_List() {
		
		assertNotNull(user);
		assertNotNull(user.getPlanComments());
		assertFalse(user.getPlanComments().isEmpty());
	}
	@Test
	void test_User_has_Sent_Messages() {
		user = em.find(User.class, 1);
		assertNotNull(user);
		assertNotNull(user.getSentMessages());
		assertFalse(user.getSentMessages().isEmpty());
	}
	@Test
	void test_User_has_Received_Messages() {
		
		assertNotNull(user);
		assertNotNull(user.getReceivedMessages());
		assertFalse(user.getReceivedMessages().isEmpty());
	}
	

}
