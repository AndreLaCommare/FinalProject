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

class MealReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private MealReview mealReview;
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
		MealReviewId id = new MealReviewId();
		id.setMealId(1);
		id.setUserId(2);
		mealReview = em.find(MealReview.class, id);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		mealReview=null;
	}

	@Test
	void test() {
		assertNotNull(mealReview);
		assertEquals("This meal is tasty", mealReview.getComment());
	}
	@Test
	void test_MealReview_has_User() {
		assertNotNull(mealReview);
		assertEquals("TheMuffinMan", mealReview.getUser().getUsername());
	}
	

}
