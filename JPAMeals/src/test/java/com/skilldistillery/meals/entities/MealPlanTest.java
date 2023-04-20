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
	@Test
	void test_mealPlan_has_Users_with_Fav() {
		assertNotNull(mealPlan);
		assertEquals("TheMuffinMan", mealPlan.getUsersWithFavMealPlans().get(0).getUsername());
	}
	@Test
	void test_mealPlan_has_creator() {
		assertNotNull(mealPlan);
		assertEquals("admin", mealPlan.getPlanCreator().getUsername());
	}
	
	@Test
	void test_MealPlan_has_List_of_Diets() {
		assertNotNull(mealPlan);
		assertFalse( mealPlan.getDiets().isEmpty());
	}
	@Test
	void test_MealPlan_has_List_of_Comment() {
		assertNotNull(mealPlan);
		assertFalse( mealPlan.getDiets().isEmpty());
	}
	@Test
	void test_MealPlan_has_List_of_reviews() {
		assertNotNull(mealPlan);
		assertFalse( mealPlan.getPlanReviews().isEmpty());
	}
	@Test
	void test_MealPlan_has_List_of_meals() {
		assertNotNull(mealPlan);
		assertFalse( mealPlan.getMeals().isEmpty());
	}
	@Test
	void test_MealPlan_has_List_of_copies() {
		assertNotNull(mealPlan);
		assertFalse( mealPlan.getMyCopies().isEmpty());
	}
	
	@Test
	void test_MealPlan_copiedPlan_as_parent() {
		mealPlan = em.find(MealPlan.class, 2);
		assertNotNull(mealPlan);
		assertNotNull(mealPlan.getCopiedFromPlan());
		assertEquals(1 ,mealPlan.getCopiedFromPlan().getId());
		
	}

}
