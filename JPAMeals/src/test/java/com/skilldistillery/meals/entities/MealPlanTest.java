package com.skilldistillery.meals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;


import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;



class MealPlanTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private MealPlan mealPlan;
	
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
		mealPlan = em.find(MealPlan.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		mealPlan=null;
	}

	@Test
	void test_mealPlan_entity_mapping() {
		assertNotNull(mealPlan);
		assertEquals("Carnivore", mealPlan.getTitle());
		assertEquals("Only Eat Meat", mealPlan.getDescription());
	}

}
