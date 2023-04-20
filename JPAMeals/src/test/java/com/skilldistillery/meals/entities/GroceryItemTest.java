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

class GroceryItemTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private GroceryItem groceryItem;

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
		groceryItem = em.find(GroceryItem.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		groceryItem=null;
	}

	@Test
	void test() {
		assertNotNull(groceryItem);
		assertEquals("andouille sausage", groceryItem.getName());
	}
	@Test
	void test_groceryItem_has_Users() {
		assertNotNull(groceryItem);
		assertEquals("TheMuffinMan", groceryItem.getUsersWithGroceries().get(0).getUsername());
	}
	
	

}
