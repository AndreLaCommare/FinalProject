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

class PlanReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private PlanReview planReview;
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
		PlanReviewId id = new PlanReviewId();
		id.setMealPlanId(1);
		id.setUserId(2);
		planReview = em.find(PlanReview.class, id);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		planReview=null;
	}

	@Test
	void test() {
		assertNotNull(planReview);
		assertEquals("Very good", planReview.getComment());
	}
	@Test
	void test_PlanReview_has_user() {
		assertNotNull(planReview);
		assertEquals("TheMuffinMan", planReview.getUser().getUsername());
	}

}
