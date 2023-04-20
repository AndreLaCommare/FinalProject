package com.skilldistillery.meals.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.GroceryItem;

public interface GroceryItemRepository extends JpaRepository<GroceryItem, Integer> {
	GroceryItem queryById(int groceryId);
	GroceryItem findByIdAndUsersWithGroceries_Username(int groceryId, String username);
	Set<GroceryItem> findByUsersWithGroceries_Username(String username);
}
	
