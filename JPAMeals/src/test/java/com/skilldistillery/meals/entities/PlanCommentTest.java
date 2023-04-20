package com.skilldistillery.meals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.meals.entities.PlanComment;

class PlanCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private PlanComment planComment;
	
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
		planComment = em.find(PlanComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		planComment=null;
	}

	@Test
	void test() {
		assertNotNull(planComment);
		assertEquals("Where are the vegetables?", planComment.getComment());
	}
	@Test
	void test_planComment_has_user() {
		assertNotNull(planComment);
		assertEquals("TheMuffinMan", planComment.getUser().getUsername());
	}

}
