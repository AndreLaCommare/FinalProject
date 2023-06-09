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

class DietTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Diet diet;
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
		diet = em.find(Diet.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		diet=null;
	}

	@Test
	void test() {
		assertNotNull(diet);
		assertEquals("Carnivore", diet.getName());
	}
	
	@Test
	void test_Diet_has_MealPlans() {
		assertNotNull(diet);
		assertFalse(diet.getMealPlansWithDiets().isEmpty());
	}
	@Test
	void test_Diet_has_Meals() {
		assertNotNull(diet);
		assertFalse(diet.getMealsWithDiets().isEmpty());
	}

}
