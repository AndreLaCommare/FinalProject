package com.skilldistillery.meals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.GroceryItem;
import com.skilldistillery.meals.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User findByUsername(String username);

	List<GroceryItem> findByGroceries(String username);

	User findById(int userId);
}
