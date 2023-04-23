package com.skilldistillery.meals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User findByUsername(String username);
	
	User findById(int userId);
}
