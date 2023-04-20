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

class MessageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Message message;
	
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
		message = em.find(Message.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		message=null;
	}

	@Test
	void test() {
		assertNotNull(message);
		assertEquals("Hello", message.getBody());
	}
	@Test
	void test_Message_has_sender() {
		assertNotNull(message);
		assertEquals("admin", message.getSender().getUsername());
	}
	@Test
	void test_Message_has_receiver() {
		assertNotNull(message);
		assertEquals("TheMuffinMan", message.getReceiver().getUsername());
	}


}
