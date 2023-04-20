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

class MealCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private MealComment mealComment;
	
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
		mealComment = em.find(MealComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		mealComment=null;
	}

	@Test
	void test() {
		assertNotNull(mealComment);
		assertEquals("TheMuffinMan", mealComment.getUser().getUsername());
	}
	@Test
	void test_MealComment_has_User() {
		assertNotNull(mealComment);
		assertEquals("That's a spicy sausage", mealComment.getComment());
	}

}
